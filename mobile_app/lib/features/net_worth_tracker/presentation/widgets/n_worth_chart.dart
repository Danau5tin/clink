import 'package:clink_mobile_app/core/common/domain/entities/amount.dart';
import 'package:clink_mobile_app/core/common/presentation/dynamic_amount_text.dart';
import 'package:clink_mobile_app/core/common/presentation/dynamic_sized_box.dart';
import 'package:clink_mobile_app/core/common/presentation/light_rounded_container.dart';
import 'package:clink_mobile_app/core/translations/translation_provider.dart';
import 'package:clink_mobile_app/features/net_worth_tracker/domain/entities/historical_net_worth.dart';
import 'package:clink_mobile_app/features/net_worth_tracker/domain/entities/net_worth_entry.dart';
import 'package:easy_localization/easy_localization.dart'
    hide StringTranslateExtension;
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class NWorthChart extends StatelessWidget {
  final HistoricalNWorthData historicalNWorth;

  const NWorthChart({
    required this.historicalNWorth,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      primaryXAxis: NumericAxis(isVisible: false),
      primaryYAxis: NumericAxis(isVisible: false),
      trackballBehavior: TrackballBehavior(
        activationMode: ActivationMode.singleTap,
        enable: true,
        builder: (context, trackballDetails) => NWToolTipContainer(
          nwEntry: historicalNWorth.entries[trackballDetails.pointIndex!],
        ),
      ),
      series: <LineSeries<NetWorthEntry, double>>[
        LineSeries<NetWorthEntry, double>(
          dataSource: historicalNWorth.entries,
          xValueMapper: (NetWorthEntry entry, _) =>
              entry.dateTime.millisecondsSinceEpoch.toDouble(),
          yValueMapper: (NetWorthEntry entry, _) => entry.totalNWorth.value,
        )
      ],
    );
  }
}

class NWToolTipContainer extends StatelessWidget {
  final NetWorthEntry nwEntry;

  const NWToolTipContainer({
    required this.nwEntry,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LightRoundedContainer(
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            DateFormat('dd/MM/yy').format(nwEntry.dateTime),
            style: Theme.of(context).textTheme.bodyText1,
          ),
          _buildDynamicHBox,
          _buildRow(context, 'assets'.tr, nwEntry.assetsValue),
          _buildDynamicHBox,
          _buildRow(context, 'liabilities'.tr, nwEntry.liabilitiesValue),
          _buildDynamicHBox,
          DynamicAmountText(amount: nwEntry.totalNWorth),
        ],
      ),
    );
  }

  Widget get _buildDynamicHBox => DynamicHSizedBox.xs();

  Widget _buildRow(BuildContext context, String title, Amount amount) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(title),
        DynamicWSizedBox.s(),
        DynamicAmountText(
          amount: amount,
          textStyle: Theme.of(context).textTheme.bodyText2,
        ),
      ],
    );
  }
}
