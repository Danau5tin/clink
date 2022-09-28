import 'package:freezed_annotation/freezed_annotation.dart';

part 'onboarding_state.freezed.dart';

@freezed
class OnboardingState with _$OnboardingState {
  const factory OnboardingState.checking() = Checking;

  const factory OnboardingState.notOnboarded() = NotOnboarded;

  const factory OnboardingState.onboarded() = Onboarded;
}
