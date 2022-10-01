import 'package:clink_mobile_app/core/common/presentation/dynamic_sized_box.dart';
import 'package:clink_mobile_app/features/net_worth_tracker/subfeatures/net_worth_chart/presentation/state_management/chart_time_period.dart';
import 'package:flutter/material.dart';

class TimePeriodButton extends StatelessWidget {
  final ChartTimePeriod timeRange;
  final bool selected;
  final Function(ChartTimePeriod) onTap;

  const TimePeriodButton({
    required this.timeRange,
    required this.selected,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(timeRange),
      child: selected
          ? Column(
              children: [
                _buildText(context),
                DynamicHSizedBox.xs(),
                Container(
                  height: 6,
                  width: 6,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    shape: BoxShape.circle,
                  ),
                )
              ],
            )
          : _buildText(context),
    );
  }

  Widget _buildText(BuildContext context) {
    return Text(
      timeRange.toString(),
      style: Theme.of(context).textTheme.bodyText1!.copyWith(
            color: selected ? Theme.of(context).primaryColor : Colors.black,
          ),
    );
  }
}
