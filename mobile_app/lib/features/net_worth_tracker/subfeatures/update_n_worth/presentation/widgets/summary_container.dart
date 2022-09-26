import 'package:clink_mobile_app/core/common/domain/entities/amount.dart';
import 'package:clink_mobile_app/core/common/presentation/dynamic_amount_text.dart';
import 'package:clink_mobile_app/core/common/presentation/dynamic_sized_box.dart';
import 'package:clink_mobile_app/core/common/presentation/light_rounded_container.dart';
import 'package:clink_mobile_app/core/translations/translation_provider.dart';
import 'package:clink_mobile_app/features/net_worth_tracker/domain/entities/fi_type.dart';
import 'package:clink_mobile_app/features/net_worth_tracker/domain/entities/holdings.dart';
import 'package:clink_mobile_app/features/net_worth_tracker/subfeatures/update_n_worth/presentation/state_management/update_financials_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SummaryContainer extends StatelessWidget {

  final Holdings originalHoldings;
  final Holdings updatedHoldings;

  const SummaryContainer({
    required this.originalHoldings,
    required this.updatedHoldings,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LightRoundedContainer.withTopRow(
      context: context,
      title: 'summary'.tr,
      topRightWidget: DynamicAmountText(
        amount: Amount(
          currencyCode: 'GBP',
          value: updatedHoldings.totalValue,
        ), // TODO: Stop hardcoding
        greyOut: updatedHoldings.totalValue == originalHoldings.totalValue,
        textStyle: Theme.of(context).textTheme.bodyText1,
      ),
      child: Column(
        children: [
          _buildSummaryRow(const FiType.account()),
          DynamicHSizedBox.s(),
          _buildSummaryRow(const FiType.physAsset()),
          DynamicHSizedBox.s(),
          _buildSummaryRow(const FiType.liability()),
        ],
      ),
    );
  }


  Widget _buildSummaryRow(FiType fiType) {
    return Consumer(
      builder: (context, ref, child) {
        final info =
        ref.read(updateFinsManProv.notifier).getUpdatedValueFor(fiType);
        final changesMade = info.percentageChange != 0.0;
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              fiType.toString(),
              style: Theme.of(context).textTheme.bodyText1,
            ),
            DynamicAmountText(
              amount: info.amount,
              greyOut: !changesMade,
              textStyle: Theme.of(context).textTheme.bodyText2,
              extraText: changesMade
                  ? '(${info.amount.value >= 0 ? '+' : ''}'
                  '${info.percentageChange.toStringAsFixed(2)}%)'
                  : null,
            )
          ],
        );
      },
    );
  }
}
