import 'package:clink_mobile_app/core/common/domain/entities/amount.dart';
import 'package:clink_mobile_app/core/common/presentation/dynamic_amount_text.dart';
import 'package:clink_mobile_app/core/common/presentation/dynamic_sized_box.dart';
import 'package:clink_mobile_app/core/common/presentation/light_rounded_container.dart';
import 'package:clink_mobile_app/core/translations/translation_provider.dart';
import 'package:clink_mobile_app/features/net_worth_tracker/domain/entities/net_worth_entry.dart';
import 'package:easy_localization/easy_localization.dart'
    hide StringTranslateExtension;
import 'package:flutter/material.dart';

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
          DynamicAmountText(amount: nwEntry.totalNWorth),
          _buildDynamicHBox,
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildRow(context, 'assets'.tr, nwEntry.assetsValue),
              DynamicWSizedBox.m(),
              _buildRow(context, 'liabilities'.tr, nwEntry.liabilitiesValue),
            ],
          ),
        ],
      ),
    );
  }

  Widget get _buildDynamicHBox => DynamicHSizedBox.s();

  Widget _buildRow(BuildContext context, String title, Amount amount) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(title),
        DynamicWSizedBox.xs(),
        DynamicAmountText(
          amount: amount,
          textStyle: Theme.of(context).textTheme.bodyText2,
        ),
      ],
    );
  }
}