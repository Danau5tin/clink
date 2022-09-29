import 'package:clink_mobile_app/core/common/domain/entities/amount.dart';
import 'package:clink_mobile_app/core/common/presentation/dynamic_sized_box.dart';
import 'package:clink_mobile_app/features/net_worth_tracker/domain/entities/fi_type.dart';
import 'package:clink_mobile_app/features/net_worth_tracker/domain/entities/financial_item.dart';
import 'package:clink_mobile_app/features/net_worth_tracker/domain/entities/holdings.dart';
import 'package:clink_mobile_app/features/net_worth_tracker/presentation/widgets/f_item_summary.dart';
import 'package:flutter/material.dart';

class MockOnboardingItemsColumn extends StatelessWidget {
  final String usersCurrency;

  const MockOnboardingItemsColumn({
    required this.usersCurrency,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          FItemSummary(
            fItemType: const FiType.account(),
            holdings: Holdings(
              financialItems: [
                FinancialItem(
                  id: 'mockId1',
                  name: 'Revolut',
                  type: const FiType.account(),
                  currentValue:
                      Amount(value: 640.17, currencyCode: usersCurrency),
                )
              ],
            ),
            currencyCode: usersCurrency,
          ),
          DynamicHSizedBox.s(),
          FItemSummary(
            fItemType: const FiType.physAsset(),
            holdings: Holdings(
              financialItems: [
                FinancialItem(
                  id: 'mockId2',
                  name: 'Macbook Pro',
                  type: const FiType.physAsset(),
                  currentValue:
                      Amount(value: 1800.00, currencyCode: usersCurrency),
                )
              ],
            ),
            currencyCode: usersCurrency,
          ),
        ],
      ),
    );
  }
}
