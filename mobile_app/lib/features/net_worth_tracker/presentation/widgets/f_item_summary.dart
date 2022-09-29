import 'package:clink_mobile_app/core/common/domain/misc/user_info_manager.dart';
import 'package:clink_mobile_app/core/common/presentation/dynamic_sized_box.dart';
import 'package:clink_mobile_app/core/common/presentation/light_rounded_container.dart';
import 'package:clink_mobile_app/core/common/presentation/utils/cta_info.dart';
import 'package:clink_mobile_app/core/common/presentation/utils/number_formatter.dart';
import 'package:clink_mobile_app/core/feature_registration/service_locator.dart';
import 'package:clink_mobile_app/features/net_worth_tracker/domain/entities/holdings.dart';
import 'package:clink_mobile_app/features/net_worth_tracker/domain/entities/fi_type.dart';
import 'package:clink_mobile_app/features/net_worth_tracker/domain/entities/financial_item.dart';
import 'package:clink_mobile_app/features/net_worth_tracker/presentation/widgets/financial_item_list_tile.dart';
import 'package:flutter/material.dart';

class FItemSummary extends StatelessWidget {
  final NumberFormatter _numberFormatter = sl.get<NumberFormatter>();
  final UserManager _userManager = sl.get<UserManager>();

  final FiType fItemType;
  final Holdings holdings;
  final CTAInfo? ctaInfo;
  final Function(FinancialItem)? onTap;
  final String? currencyCode;

  FItemSummary({
    required this.fItemType,
    required this.holdings,
    this.ctaInfo,
    this.onTap,
    this.currencyCode,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final items = fItemType.when(
      account: () => holdings.getAllAccounts,
      physAsset: () => holdings.getAllPhysAssets,
      liability: () => holdings.getAllLiabilities,
    );
    final itemTotalVal = holdings.valueOfItems(items);
    return _buildColumn(context, items, itemTotalVal);
  }

  Widget _buildColumn(
    BuildContext context,
    List<FinancialItem> items,
    double value,
  ) {
    final lView = ListView.separated(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      itemBuilder: (context, index) => _buildTile(items, index),
      separatorBuilder: (context, index) => const SizedBox(height: 16),
    );
    return LightRoundedContainer.withTopRow(
      context: context,
      title: fItemType.toString(),
      topRightWidget: LightRoundedContainer.builtTopTitle(
        context,
        _numberFormatter.toSimpleCurrency(
          value,
          currencyCode: currencyCode ?? _userManager.usersBaseCurrency,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 8),
        child: ctaInfo == null
            ? lView
            : Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  lView,
                  DynamicHSizedBox.l(),
                  ElevatedButton(
                    onPressed: ctaInfo!.onTap,
                    child: Text(ctaInfo!.text),
                  )
                ],
              ),
      ),
    );
  }

  StatelessWidget _buildTile(List<FinancialItem> items, int index) {
    final tile = FinancialItemListTile(item: items[index]);
    return onTap == null
        ? tile
        : GestureDetector(
            onTap: () => onTap!(items[index]),
            child: tile,
          );
  }
}
