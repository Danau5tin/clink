import 'package:clink_mobile_app/core/common/presentation/dynamic_sized_box.dart';
import 'package:clink_mobile_app/core/common/presentation/utils/number_formatter.dart';
import 'package:clink_mobile_app/core/feature_registration/service_locator.dart';
import 'package:clink_mobile_app/features/net_worth_tracker/domain/entities/historical_net_worth.dart';
import 'package:clink_mobile_app/features/net_worth_tracker/presentation/widgets/growth_chip.dart';
import 'package:flutter/material.dart';

class CurrentNWorthDisplay extends StatelessWidget {
  final HistoricalNWorthData historicalNWorth;
  final NumberFormatter numberFormatter = sl.get<NumberFormatter>();

  CurrentNWorthDisplay({
    required this.historicalNWorth,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildValueText(context),
        DynamicHSizedBox.xs(),
        GrowthChip(historicalNWorth: historicalNWorth)
      ],
    );
  }

  Text _buildValueText(BuildContext context) {
    return Text(
      numberFormatter.toSimpleCurrency(
        historicalNWorth.currentNWorth.totalNWorth.value,
      ),
      style: Theme.of(context).textTheme.headline5,
    );
  }
}
