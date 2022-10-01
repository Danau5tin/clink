import 'package:clink_mobile_app/core/common/presentation/utils/number_formatter.dart';
import 'package:clink_mobile_app/core/feature_registration/service_locator.dart';
import 'package:clink_mobile_app/features/net_worth_tracker/domain/entities/historical_net_worth.dart';
import 'package:clink_mobile_app/features/net_worth_tracker/subfeatures/net_worth_chart/presentation/state_management/net_worth_chart_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GrowthChip extends ConsumerWidget {
  final HistoricalNWorthData historicalNWorth;
  final NumberFormatter numberFormatter = sl.get<NumberFormatter>();

  GrowthChip({
    required this.historicalNWorth,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final startDate = ref.watch(nWorthChartManProv).relevantDate;
    final info = historicalNWorth.getLossGainInfoFrom(startDate);
    final operator = info.amount.value >= 0 ? '+' : '';
    final color = info.amount.value >= 0 ? Colors.green : Colors.red;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: color.withOpacity(0.3),
      ),
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: Text(
        '$operator${numberFormatter.toSimpleCurrencyWithAmount(info.amount)} '
        '($operator${info.percentageChange.toStringAsFixed(2)}%)',
        style: Theme.of(context).textTheme.bodyText1!.copyWith(
              fontSize: 11,
              color: color,
            ),
      ),
    );
  }
}
