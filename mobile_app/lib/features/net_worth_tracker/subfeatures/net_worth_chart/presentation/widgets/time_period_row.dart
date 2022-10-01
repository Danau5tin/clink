import 'package:clink_mobile_app/features/net_worth_tracker/subfeatures/net_worth_chart/presentation/state_management/chart_time_period.dart';
import 'package:clink_mobile_app/features/net_worth_tracker/subfeatures/net_worth_chart/presentation/state_management/net_worth_chart_manager.dart';
import 'package:clink_mobile_app/features/net_worth_tracker/subfeatures/net_worth_chart/presentation/widgets/time_period_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const List<ChartTimePeriod> _availablePeriods = [
  ChartTimePeriod.today(),
  ChartTimePeriod.oneWeek(),
  ChartTimePeriod.oneMonth(),
  ChartTimePeriod.threeMonths(),
  ChartTimePeriod.sixMonths(),
  ChartTimePeriod.oneYear(),
];

class TimePeriodRow extends ConsumerWidget {
  const TimePeriodRow({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTimePeriod = ref.watch(nWorthChartManProv);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: _availablePeriods
          .map(
            (timePeriod) => TimePeriodButton(
              timeRange: timePeriod,
              selected: timePeriod.runtimeType == currentTimePeriod.runtimeType,
              onTap: (_) {
                ref
                    .read(nWorthChartManProv.notifier)
                    .changeTimePeriod(timePeriod);
              },
            ),
          )
          .toList(),
    );
  }
}
