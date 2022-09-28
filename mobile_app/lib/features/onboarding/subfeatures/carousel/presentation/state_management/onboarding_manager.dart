import 'package:clink_mobile_app/core/common/domain/repositories/key_value_local_storage.dart';
import 'package:clink_mobile_app/core/feature_registration/service_locator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'onboarding_state.dart';

final onboardingManProv =
    StateNotifierProvider<OnboardingManager, OnboardingState>(
  (ref) => OnboardingManager(
    kVLocalStorage: sl.get<KeyValueLocalStorage>(),
  ),
);

const _alreadyOnboardedKey = 'alreadyOnboarded';

class OnboardingManager extends StateNotifier<OnboardingState> {
  final KeyValueLocalStorage kVLocalStorage;

  OnboardingManager({
    required this.kVLocalStorage,
  }) : super(const OnboardingState.checking());

  bool checkIfAlreadyOnboarded() {
    final alreadyOnboarded =
        kVLocalStorage.getBool(_alreadyOnboardedKey) ?? false;
    state = alreadyOnboarded
        ? const OnboardingState.onboarded()
        : const OnboardingState.notOnboarded();
    return alreadyOnboarded;
  }


}
