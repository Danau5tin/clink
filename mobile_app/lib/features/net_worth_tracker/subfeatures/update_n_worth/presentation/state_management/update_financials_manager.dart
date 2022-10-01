import 'package:clink_mobile_app/core/analytics_crashlytics/analytics_reporter.dart';
import 'package:clink_mobile_app/core/common/domain/entities/amount.dart';
import 'package:clink_mobile_app/core/common/domain/misc/user_info_manager.dart';
import 'package:clink_mobile_app/core/common/domain/misc/uuid_gen.dart';
import 'package:clink_mobile_app/core/feature_registration/service_locator.dart';
import 'package:clink_mobile_app/features/net_worth_tracker/domain/entities/add_update_item_instruction.dart';
import 'package:clink_mobile_app/features/net_worth_tracker/domain/entities/amount_precentage_info.dart';
import 'package:clink_mobile_app/features/net_worth_tracker/domain/entities/fi_type.dart';
import 'package:clink_mobile_app/features/net_worth_tracker/domain/entities/financial_item.dart';
import 'package:clink_mobile_app/features/net_worth_tracker/domain/entities/holdings.dart';
import 'package:clink_mobile_app/features/net_worth_tracker/domain/entities/net_worth_entry.dart';
import 'package:clink_mobile_app/features/net_worth_tracker/domain/repositories/net_worth_repo.dart';
import 'package:clink_mobile_app/features/net_worth_tracker/presentation/state_management/n_worth_manager.dart';
import 'package:clink_mobile_app/features/net_worth_tracker/subfeatures/update_n_worth/presentation/state_management/update_financials_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final updateFinsManProv = StateNotifierProvider.autoDispose<
    UpdateFinancialsManager, UpdateFinancialsState>(
  (ref) => UpdateFinancialsManager(
    nWorthManager: ref.read(nWorthManagerProv.notifier),
    netWorthRepo: sl.get<NetWorthRepo>(),
    holdings: ref.read(nWorthManagerProv).maybeWhen(
          loaded: (historicalNetWorthData, holdings) => holdings,
          orElse: () => Holdings(financialItems: []),
        ),
  ),
);

class UpdateFinancialsManager extends StateNotifier<UpdateFinancialsState> {
  final NWorthManager nWorthManager;
  final NetWorthRepo netWorthRepo;
  final UUIDGen _uuidGen = sl.get<UUIDGen>();
  final UserManager _userManager = sl.get<UserManager>();
  final AnalyticsReporter _analytics = sl.get<AnalyticsReporter>();

  UpdateFinancialsManager({
    required this.nWorthManager,
    required this.netWorthRepo,
    required Holdings holdings,
  }) : super(
          UpdateFinancialsState.initial(
            originalHoldings:
                Holdings(financialItems: [...holdings.financialItems]),
            updatedHoldings:
                Holdings(financialItems: [...holdings.financialItems]),
          ),
        );

  AmountPercentageInfo getUpdatedValueFor(FiType fiType) {
    return state.maybeWhen(
      initial: (originalHoldings, updatedHoldings, saving) {
        final originalAmount = originalHoldings.valueOfItems(
          fiType.when(
            account: () => originalHoldings.getAllAccounts,
            physAsset: () => originalHoldings.getAllPhysAssets,
            liability: () => originalHoldings.getAllLiabilities,
          ),
        );
        final newAmount = updatedHoldings.valueOfItems(
          fiType.when(
            account: () => updatedHoldings.getAllAccounts,
            physAsset: () => updatedHoldings.getAllPhysAssets,
            liability: () => updatedHoldings.getAllLiabilities,
          ),
        );
        return AmountPercentageInfo(
          amount: Amount(
            currencyCode: _userManager.usersBaseCurrency,
            value: newAmount,
          ),
          percentageChange: _calculatePercChange(newAmount, originalAmount),
        );
      },
      orElse: () {
        throw Exception('Should not be able to access in state $state');
      },
    );
  }

  double _calculatePercChange(double newAmount, double originalAmount) =>
      ((newAmount - originalAmount) / originalAmount) * 100;

  void updateItem(FinancialItem itemToBeUpdated, String name, double value) {
    state.maybeWhen(
      initial: (originalHoldings, updatedHoldings, saving) {
        final updated = itemToBeUpdated.copyWith(
          name: name,
          currentValue: Amount(
            currencyCode: itemToBeUpdated.currentValue.currencyCode,
            value: itemToBeUpdated.type.maybeWhen(
              liability: () => value * -1,
              orElse: () => value,
            ),
          ),
        );
        final newList = [...updatedHoldings.financialItems];
        final idxOfExisting = newList.indexOf(itemToBeUpdated);
        newList.removeAt(idxOfExisting);
        newList.insert(idxOfExisting, updated);
        state = (state as Initial).copyWith(
          updatedHoldings: Holdings(financialItems: newList),
        );
      },
      orElse: () {},
    );
  }

  void addNewItem(String name, double value, FiType type) {
    state.maybeWhen(
      initial: (originalHoldings, updatedHoldings, saving) {
        final List<FinancialItem> newList = [
          ...updatedHoldings.financialItems,
          FinancialItem(
            id: _uuidGen.generate(),
            name: name,
            type: type,
            currentValue: Amount(
              currencyCode: _userManager.usersBaseCurrency,
              value: type.maybeWhen(
                liability: () => value * -1,
                orElse: () => value,
              ),
            ),
          ),
        ];
        state = (state as Initial).copyWith(
          updatedHoldings: Holdings(financialItems: newList),
        );
      },
      orElse: () {},
    );
  }

  Future<void> saveAllUpdates({required String location}) async {
    await state.maybeWhen(
      initial: (originalHoldings, updatedHoldings, saving) async {
        state = (state as Initial).copyWith(saving: true);

        final List<AddUpdateItemInstruction> instructs = [];
        double assetValue = 0.0;
        double liabValue = 0.0;

        int numOfAdds = 0;
        int numOfUpdates = 0;

        for (var item in updatedHoldings.financialItems) {
          item.type.when(
            account: () => assetValue += item.currentValue.value,
            physAsset: () => assetValue += item.currentValue.value,
            liability: () => liabValue += item.currentValue.value,
          );
          final instr = _getInstructionIfRequired(originalHoldings, item);
          if (instr != null) {
            instructs.add(instr);
            instr.when(
              add: (_) => numOfAdds++,
              update: (_, __, ___) => numOfUpdates++,
            );
          }
        }
        _analytics.trackEvent(
          'update_financials_save_tapped',
          data: {
            'num_adds': numOfAdds,
            'num_updates': numOfUpdates,
            'location': location,
          },
        );
        final baseCurrency = _userManager.usersBaseCurrency;
        final newEntry = NetWorthEntry(
          id: _uuidGen.generate(),
          assetsValue: Amount(currencyCode: baseCurrency, value: assetValue),
          liabilitiesValue:
              Amount(currencyCode: baseCurrency, value: liabValue),
          dateTime: DateTime.now(),
        );
        final res = await netWorthRepo.updateFinancials(
          netWorthEntry: newEntry,
          instructions: instructs,
        );
        state = res.when(
          success: (_) {
            nWorthManager.notifyNewUpdate(newEntry, updatedHoldings);
            return const UpdateFinancialsState.success();
          },
          failure: (_, __) => const UpdateFinancialsState.error(),
        );
      },
      orElse: () async {},
    );
  }

  AddUpdateItemInstruction? _getInstructionIfRequired(
    Holdings originalHoldings,
    FinancialItem updatedItem,
  ) {
    final existing = originalHoldings.getById(updatedItem.id);
    if (existing == null) {
      return AddUpdateItemInstruction.add(item: updatedItem);
    }
    final nameChanged = existing.name != updatedItem.name;
    final valueChanged =
        existing.currentValue.value != updatedItem.currentValue.value;
    if (nameChanged || valueChanged) {
      return AddUpdateItemInstruction.update(
        idOfItem: updatedItem.id,
        newName: nameChanged ? updatedItem.name : null,
        newValue: valueChanged ? updatedItem.currentValue.value : null,
      );
    }
    return null;
  }
}
