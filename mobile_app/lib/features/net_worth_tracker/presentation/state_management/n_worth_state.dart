import 'package:clink_mobile_app/features/net_worth_tracker/domain/entities/holdings.dart';
import 'package:clink_mobile_app/features/net_worth_tracker/domain/entities/historical_net_worth.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'n_worth_state.freezed.dart';

@freezed
class NWorthState with _$NWorthState {
  const factory NWorthState.empty() = Empty;

  const factory NWorthState.loading() = Loading;

  const factory NWorthState.error() = Error;

  const factory NWorthState.loaded({
    required HistoricalNWorthData historicalNetWorthData,
    required Holdings holdings,
  }) = Loaded;
}
