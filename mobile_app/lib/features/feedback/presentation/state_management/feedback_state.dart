import 'package:freezed_annotation/freezed_annotation.dart';

part 'feedback_state.freezed.dart';

@freezed
class FeedbackState with _$FeedbackState {
  const factory FeedbackState.initial({
    @Default(false) bool submitting,
  }) = Initial;

  const factory FeedbackState.error() = Error;

  const factory FeedbackState.success() = Success;
}
