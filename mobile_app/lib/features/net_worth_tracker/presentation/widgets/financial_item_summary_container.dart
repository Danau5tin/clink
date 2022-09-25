import 'package:clink_mobile_app/core/common/presentation/errors/something_went_wrong_column.dart';
import 'package:clink_mobile_app/core/common/presentation/light_rounded_container.dart';
import 'package:clink_mobile_app/core/common/presentation/utils/number_formatter.dart';
import 'package:clink_mobile_app/core/feature_registration/service_locator.dart';
import 'package:clink_mobile_app/core/translations/translation_provider.dart';
import 'package:clink_mobile_app/features/net_worth_tracker/domain/entities/fi_type.dart';
import 'package:clink_mobile_app/features/net_worth_tracker/domain/entities/financial_item.dart';
import 'package:clink_mobile_app/features/net_worth_tracker/presentation/state_management/n_worth_manager.dart';
import 'package:clink_mobile_app/features/net_worth_tracker/presentation/widgets/financial_item_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FItemSummary extends ConsumerWidget {
  final NumberFormatter numberFormatter = sl.get<NumberFormatter>();
  final FiType fItemType;

  FItemSummary({
    required this.fItemType,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(nWorthManagerProv).maybeWhen(
          loaded: (historicalNetWorthData, holdings) {
            final items = fItemType.when(
              account: () => holdings.getAllAccounts,
              physAsset: () => holdings.getAllPhysAssets,
              liability: () => holdings.getAllLiabilities,
            );
            final itemTotalVal = holdings.valueOfItems(items);
            return _buildColumn(context, items, itemTotalVal);
          },
          orElse: () => const SomethingWentWrongColumn(),
        );
  }

  Widget _buildColumn(
    BuildContext context,
    List<FinancialItem> items,
    double value,
  ) {
    return LightRoundedContainer.withTopRow(
      context: context,
      title: fItemType.when(
        account: () => 'accounts'.tr,
        physAsset: () => 'physical_assets'.tr,
        liability: () => 'liabilities'.tr,
      ),
      topRightWidget: LightRoundedContainer.builtTopTitle(
        context,
        numberFormatter.toSimpleCurrency(value),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 8),
        child: ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: items.length,
          itemBuilder: (context, index) =>
              FinancialItemListTile(fItemType: fItemType, item: items[index]),
          separatorBuilder: (context, index) => const SizedBox(height: 16),
        ),
      ),
    );
  }
}
