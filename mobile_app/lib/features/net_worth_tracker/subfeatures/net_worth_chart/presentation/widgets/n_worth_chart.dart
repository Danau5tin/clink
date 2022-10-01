import 'package:clink_mobile_app/features/net_worth_tracker/domain/entities/historical_net_worth.dart';
import 'package:clink_mobile_app/features/net_worth_tracker/domain/entities/net_worth_entry.dart';
import 'package:clink_mobile_app/features/net_worth_tracker/subfeatures/net_worth_chart/presentation/state_management/net_worth_chart_manager.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'n_w_tooltip_container.dart';

class NWorthChart extends ConsumerWidget {
  final HistoricalNWorthData historicalNWorth;

  const NWorthChart({
    required this.historicalNWorth,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timePeriod = ref.watch(nWorthChartManProv);
    final startDate = timePeriod.relevantDate;
    final entries =
        historicalNWorth.allEntriesWithEmptiesIfNeededFrom(startDate);

    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      primaryXAxis: DateTimeAxis(
        isVisible: false,
        minimum: timePeriod.maybeWhen(
          today: () => null,
          orElse: () => startDate,
        ),
        maximum: entries.last.dateTime,
      ),
      primaryYAxis: NumericAxis(isVisible: false),
      enableAxisAnimation: true,
      trackballBehavior: TrackballBehavior(
        activationMode: ActivationMode.singleTap,
        enable: true,
        shouldAlwaysShow: false,
        builder: (context, trackballDetails) {
          final tappedEntry = entries[trackballDetails.pointIndex!];
          return NWToolTipContainer(nwEntry: tappedEntry);
        },
      ),
      series: <LineSeries<NetWorthEntry, DateTime>>[
        LineSeries<NetWorthEntry, DateTime>(
          dataSource: entries,
          xValueMapper: (NetWorthEntry entry, _) => entry.dateTime,
          yValueMapper: (NetWorthEntry entry, _) =>
              entry.totalNWorth.value == 0 ? null : entry.totalNWorth.value,
          emptyPointSettings: EmptyPointSettings(mode: EmptyPointMode.zero),
          markerSettings: const MarkerSettings(isVisible: true),
        ),
      ],
    );
  }
}
