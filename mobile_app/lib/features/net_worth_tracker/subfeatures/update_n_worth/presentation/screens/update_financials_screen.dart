import 'package:clink_mobile_app/core/common/presentation/circular_progress_bar.dart';
import 'package:clink_mobile_app/core/common/presentation/dynamic_sized_box.dart';
import 'package:clink_mobile_app/core/common/presentation/errors/something_went_wrong_column.dart';
import 'package:clink_mobile_app/core/common/presentation/standard_app_bar.dart';
import 'package:clink_mobile_app/core/common/presentation/theme/colors.dart';
import 'package:clink_mobile_app/core/common/presentation/utils/cta_info.dart';
import 'package:clink_mobile_app/core/translations/translation_provider.dart';
import 'package:clink_mobile_app/features/net_worth_tracker/domain/entities/fi_type.dart';
import 'package:clink_mobile_app/features/net_worth_tracker/domain/entities/financial_item.dart';
import 'package:clink_mobile_app/features/net_worth_tracker/domain/entities/holdings.dart';
import 'package:clink_mobile_app/features/net_worth_tracker/navigation/net_worth_tracker_nav_handler.dart';
import 'package:clink_mobile_app/features/net_worth_tracker/presentation/widgets/f_item_summary.dart';
import 'package:clink_mobile_app/features/net_worth_tracker/subfeatures/add_update_holding/presentation/screens/add_update_holding_screen.dart';
import 'package:clink_mobile_app/features/net_worth_tracker/subfeatures/update_n_worth/presentation/state_management/update_financials_manager.dart';
import 'package:clink_mobile_app/features/net_worth_tracker/subfeatures/update_n_worth/presentation/state_management/update_financials_state.dart';
import 'package:clink_mobile_app/features/net_worth_tracker/subfeatures/update_n_worth/presentation/widgets/summary_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UpdateFinancialsScreen extends ConsumerWidget {
  static const viewPath = '${NetWorthTrackerNavHandler.startingPath}/update';

  const UpdateFinancialsScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _listenForUpdates(ref, context);
    return Scaffold(
      appBar: StandardAppBar(
        context: context,
        title: 'update_financials'.tr,
        actions: [
          TextButton(
            onPressed: ref.read(updateFinsManProv.notifier).saveAllUpdates,
            child: Text('save'.tr),
          )
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        clipBehavior: Clip.none,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ref.watch(updateFinsManProv).when(
                initial: (originalHoldings, updatedHoldings, saving) =>
                    _buildMainUi(
                  context,
                  originalHoldings,
                  updatedHoldings,
                  saving,
                  ref,
                ),
                success: () => const Center(
                  child: Icon(Icons.check, color: Colors.green),
                ),
                error: () => const SomethingWentWrongColumn(),
              ),
        ),
      ),
    );
  }

  Widget _buildMainUi(
    BuildContext context,
    Holdings originalHoldings,
    Holdings updatedHoldings,
    bool saving,
    WidgetRef ref,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildExplText(context),
        _buildDynamicHSizedBox,
        ..._buildContainers(context, originalHoldings, updatedHoldings),
        _buildDynamicHSizedBox,
        SummaryContainer(
          originalHoldings: originalHoldings,
          updatedHoldings: updatedHoldings,
        ),
        _buildDynamicHSizedBox,
        saving
            ? const CircularProgressBar()
            : ElevatedButton(
                onPressed: ref.read(updateFinsManProv.notifier).saveAllUpdates,
                child: Text('save'.tr),
              ),
        _buildDynamicHSizedBox,
      ],
    );
  }

  void _listenForUpdates(WidgetRef ref, BuildContext context) {
    ref.listen<UpdateFinancialsState>(updateFinsManProv, (previous, next) {
      next.maybeWhen(
        success: () {
          Navigator.pop(context);
        },
        orElse: () {},
      );
    });
  }

  List<Widget> _buildContainers(
    BuildContext context,
    Holdings originalHoldings,
    Holdings updatedHoldings,
  ) {
    const account = FiType.account();
    const asset = FiType.physAsset();
    const liab = FiType.liability();
    return [
      FItemSummary(
        fItemType: account,
        holdings: updatedHoldings,
        onTap: (fItem) => _navigateToNewUpdate(context, account, fItem),
        ctaInfo: CTAInfo(
          text: 'add_new_account'.tr,
          onTap: () => _navigateToNewUpdate(context, account),
        ),
      ),
      _buildDynamicHSizedBox,
      FItemSummary(
        fItemType: asset,
        holdings: updatedHoldings,
        onTap: (fItem) => _navigateToNewUpdate(context, asset, fItem),
        ctaInfo: CTAInfo(
          text: 'add_new_asset'.tr,
          onTap: () => _navigateToNewUpdate(context, asset),
        ),
      ),
      _buildDynamicHSizedBox,
      FItemSummary(
        fItemType: liab,
        holdings: updatedHoldings,
        onTap: (fItem) => _navigateToNewUpdate(context, liab, fItem),
        ctaInfo: CTAInfo(
          text: 'add_new_liability'.tr,
          onTap: () => _navigateToNewUpdate(context, liab),
        ),
      )
    ];
  }

  Future<void> _navigateToNewUpdate(
    BuildContext context,
    FiType type, [
    FinancialItem? item,
  ]) async {
    await Navigator.pushNamed(
      context,
      AddUpdateHoldingScreen.viewPath,
      arguments: AddUpdateHoldingScreenArgs(type: type, itemToBeUpdated: item),
    );
  }

  DynamicHSizedBox get _buildDynamicHSizedBox => DynamicHSizedBox.l();

  Text _buildExplText(BuildContext context) {
    return Text(
      'tap_an_item_then_tap_save'.tr,
      style: Theme.of(context).textTheme.bodyText1!.copyWith(
            color: CColors.greyText,
          ),
    );
  }
}
