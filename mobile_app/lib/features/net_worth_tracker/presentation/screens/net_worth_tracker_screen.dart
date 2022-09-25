import 'package:clink_mobile_app/core/common/presentation/dynamic_sized_box.dart';
import 'package:clink_mobile_app/core/translations/translation_provider.dart';
import 'package:clink_mobile_app/features/net_worth_tracker/domain/entities/assets_liabilites_holdings.dart';
import 'package:clink_mobile_app/features/net_worth_tracker/domain/entities/fi_type.dart';
import 'package:clink_mobile_app/features/net_worth_tracker/domain/entities/historical_net_worth.dart';
import 'package:clink_mobile_app/features/net_worth_tracker/navigation/net_worth_tracker_nav_handler.dart';
import 'package:clink_mobile_app/features/net_worth_tracker/presentation/widgets/current_n_worth_display.dart';
import 'package:clink_mobile_app/features/net_worth_tracker/presentation/widgets/financial_item_summary_container.dart';
import 'package:clink_mobile_app/features/net_worth_tracker/presentation/widgets/n_worth_chart.dart';
import 'package:flutter/material.dart';

class NetWorthTrackerScreen extends StatelessWidget {
  static const String viewPath =
      '${NetWorthTrackerNavHandler.startingPath}/dash';

  final HistoricalNWorthData historicalNWorthData;
  final AssetsLiabilitiesHoldings holdings;

  const NetWorthTrackerScreen({
    required this.historicalNWorthData,
    required this.holdings,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          clipBehavior: Clip.none,
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildDynamicHSizedBox,
              _wrapPadding(
                CurrentNWorthDisplay(historicalNWorth: historicalNWorthData),
              ),
              DynamicHSizedBox.s(),
              SizedBox(
                height: mq.size.height * 0.29,
                child: NWorthChart(historicalNWorth: historicalNWorthData),
              ),
              _buildDynamicHSizedBox,
              _wrapPadding(
                ElevatedButton(
                  onPressed: () {},
                  child: Text('update_financials'.tr),
                ),
              ),
              _buildDynamicHSizedBox,
              _wrapPadding(FItemSummary(fItemType: const FiType.account())),
              _buildDynamicHSizedBox,
              _wrapPadding(FItemSummary(fItemType: const FiType.physAsset())),
              _buildDynamicHSizedBox,
              _wrapPadding(FItemSummary(fItemType: const FiType.liability())),
              _buildDynamicHSizedBox,
            ],
          ),
        ),
      ),
    );
  }

  Widget _wrapPadding(Widget child) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: child,
      );

  DynamicHSizedBox get _buildDynamicHSizedBox => DynamicHSizedBox.l();
}
