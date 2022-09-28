import 'package:clink_mobile_app/core/common/presentation/dynamic_amount_text.dart';
import 'package:clink_mobile_app/core/common/presentation/dynamic_sized_box.dart';
import 'package:clink_mobile_app/core/common/presentation/utils/number_formatter.dart';
import 'package:clink_mobile_app/core/feature_registration/service_locator.dart';
import 'package:clink_mobile_app/features/net_worth_tracker/domain/entities/financial_item.dart';
import 'package:flutter/material.dart';

class FinancialItemListTile extends StatelessWidget {
  final NumberFormatter numberFormatter = sl.get<NumberFormatter>();

  final FinancialItem item;

  FinancialItemListTile({
    required this.item,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildImage,
        DynamicWSizedBox.s(),
        _buildTitle(context),
        const Spacer(),
        DynamicAmountText(amount: item.currentValue),
      ],
    );
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
            item.type.when(
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
