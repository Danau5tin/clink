import 'package:clink_mobile_app/core/common/domain/entities/amount.dart';
import 'package:clink_mobile_app/core/common/presentation/dynamic_amount_text.dart';
import 'package:clink_mobile_app/core/common/presentation/dynamic_sized_box.dart';
import 'package:clink_mobile_app/core/common/presentation/utils/number_formatter.dart';
import 'package:clink_mobile_app/core/feature_registration/service_locator.dart';
import 'package:clink_mobile_app/features/net_worth_tracker/domain/entities/fi_type.dart';
import 'package:clink_mobile_app/features/net_worth_tracker/domain/entities/financial_item.dart';
import 'package:clink_mobile_app/features/net_worth_tracker/domain/entities/historical_value.dart';
import 'package:flutter/material.dart';

class FinancialItemListTile extends StatelessWidget {
  final NumberFormatter numberFormatter = sl.get<NumberFormatter>();

  final FiType fItemType;
  final FinancialItem item;
  final Amount? comparisonAmount;

  bool get _shouldCompare => comparisonAmount != null;

  FinancialItemListTile({
    required this.fItemType,
    required this.item,
    this.comparisonAmount,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final itemVal = item.currentValue;
    return Row(
      children: [
        _buildImage,
        DynamicWSizedBox.s(),
        _buildTitle(context),
        const Spacer(),
        _buildAmount(context, itemVal),
      ],
    );
  }

  Widget _buildAmount(BuildContext context, HistoricalValue itemVal) {
    if (!_shouldCompare) {
      return DynamicAmountText(amount: itemVal.amount);
    }
    if (comparisonAmount!.value == itemVal.amount.value) {
      return DynamicAmountText(
        amount: itemVal.amount,
        greyOut: true,
      );
    } else {
      return Column(
        children: [
          DynamicAmountText(amount: itemVal.amount),
          DynamicAmountText(
            amount: comparisonAmount!,
            greyOut: true,
            textStyle: Theme.of(context).textTheme.bodyText2!.copyWith(
                  fontSize: 10,
                ),
          ),
        ],
      );
    }
  }

  // TODO: Remove hardcoded images

  Widget get _buildImage {
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage(
            fItemType.when(
              account: () => 'assets/images/revolut.png',
              physAsset: () => 'assets/images/computer.svg.png',
              liability: () => 'assets/images/loan.png',
            ),
          ),
        ),
        boxShadow: const [
          BoxShadow(color: Colors.grey, blurRadius: 4, offset: Offset(0, 3)),
        ],
      ),
    );
  }

  Text _buildTitle(BuildContext context) {
    return Text(
      item.name,
      style: Theme.of(context).textTheme.bodyText1,
      maxLines: 2,
    );
  }
}
