import 'package:clink_mobile_app/core/common/domain/entities/amount.dart';
import 'package:clink_mobile_app/core/common/domain/misc/user_info_manager.dart';
import 'package:clink_mobile_app/core/common/domain/misc/uuid_gen.dart';
import 'package:clink_mobile_app/core/common/domain/repositories/key_value_local_storage.dart';
import 'package:clink_mobile_app/core/feature_registration/service_locator.dart';
import 'package:clink_mobile_app/features/net_worth_tracker/domain/entities/add_update_item_instruction.dart';
import 'package:clink_mobile_app/features/net_worth_tracker/domain/entities/fi_type.dart';
import 'package:clink_mobile_app/features/net_worth_tracker/domain/entities/financial_item.dart';
import 'package:clink_mobile_app/features/net_worth_tracker/domain/entities/holdings.dart';
import 'package:clink_mobile_app/features/net_worth_tracker/domain/entities/net_worth_entry.dart';
import 'package:clink_mobile_app/features/net_worth_tracker/domain/repositories/net_worth_repo.dart';
import 'package:clink_mobile_app/features/net_worth_tracker/presentation/state_management/n_worth_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'onboarding_state.dart';

final onboardingManProv =
    StateNotifierProvider<OnboardingManager, OnboardingState>(
  (ref) => OnboardingManager(
    kVLocalStorage: sl.get<KeyValueLocalStorage>(),
    netWorthRepo: sl.get<NetWorthRepo>(),
    uuidGen: sl.get<UUIDGen>(),
    userManager: ref.read(userManProv.notifier),
    nWorthManager: ref.read(nWorthManagerProv.notifier),
  ),
);

const _alreadyOnboardedKey = 'alreadyOnboarded';

class OnboardingManager extends StateNotifier<OnboardingState> {
  final KeyValueLocalStorage kVLocalStorage;
  final NetWorthRepo netWorthRepo;
  final UUIDGen uuidGen;
  final UserManager userManager;
  final NWorthManager nWorthManager;

  OnboardingManager({
    required this.kVLocalStorage,
    required this.netWorthRepo,
    required this.uuidGen,
    required this.userManager,
    required this.nWorthManager,
  }) : super(const OnboardingState.checking());

  bool checkIfAlreadyOnboarded() {
    final alreadyOnboarded =
        kVLocalStorage.getBool(_alreadyOnboardedKey) ?? false;
    state = alreadyOnboarded
        ? const OnboardingState.onboarded()
        : const OnboardingState.notOnboarded();
    return alreadyOnboarded;
  }

  Future<void> onboardWithNewAccount(
    String accountName,
    double accountValue,
  ) async {
    final amount = Amount(
      currencyCode: userManager.user!.baseCurrencyCode,
      value: accountValue,
    );
    final fItem = FinancialItem(
      id: uuidGen.generate(),
      name: accountName,
      type: const FiType.account(),
      currentValue: amount,
    );
    final instruct = AddUpdateItemInstruction.add(item: fItem);
    final nWorthEntry = NetWorthEntry(
      id: uuidGen.generate(),
      assetsValue: amount,
      liabilitiesValue: Amount(
        currencyCode: userManager.user!.baseCurrencyCode,
        value: 0.0,
      ),
      dateTime: DateTime.now(),
    );
    nWorthManager.notifyNewUpdate(
      nWorthEntry,
      Holdings(financialItems: [fItem]),
    );
    state = const OnboardingState.onboarded();
    final repoUpdate = netWorthRepo.updateFinancials(
      netWorthEntry: nWorthEntry,
      instructions: [instruct],
    );
    final kVUpdate = kVLocalStorage.saveBool(_alreadyOnboardedKey, true);
    await repoUpdate;
    await kVUpdate;
  }
}
