import 'package:freezed_annotation/freezed_annotation.dart';

part 'data_state.freezed.dart';

@freezed
class DataState<T, F> with _$DataState {
  const factory DataState.success(
    T data,
  ) = Success;

  const factory DataState.failure({
    F? failureInfo,
    Exception? exception,
  }) = Failure;
}
