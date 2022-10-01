import 'package:clink_mobile_app/features/net_worth_tracker/subfeatures/net_worth_chart/presentation/state_management/chart_time_period.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final nWorthChartManProv =
    StateNotifierProvider<NetWorthChartManager, ChartTimePeriod>(
  (ref) => NetWorthChartManager(),
);

class NetWorthChartManager extends StateNotifier<ChartTimePeriod> {
  NetWorthChartManager() : super(const ChartTimePeriod.today());

  void changeTimePeriod(ChartTimePeriod newPeriod) {
    state = newPeriod;
  }
}
