import 'package:clink_mobile_app/features/net_worth_tracker/domain/entities/holdings.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_financials_state.freezed.dart';

@freezed
class UpdateFinancialsState with _$UpdateFinancialsState {
  const factory UpdateFinancialsState.initial({
    required Holdings originalHoldings,
    required Holdings updatedHoldings,
    @Default(false) saving,
  }) = initial;


  const factory UpdateFinancialsState.success() = Success;

  const factory UpdateFinancialsState.error() = Error;
}
