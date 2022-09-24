import 'package:clink_mobile_app/core/common/presentation/dynamic_sized_box.dart';
import 'package:clink_mobile_app/core/common/presentation/light_rounded_container.dart';
import 'package:clink_mobile_app/core/translations/translation_provider.dart';
import 'package:clink_mobile_app/features/net_worth_tracker/domain/entities/assets_liabilites_holdings.dart';
import 'package:clink_mobile_app/features/net_worth_tracker/domain/entities/historical_net_worth.dart';
import 'package:clink_mobile_app/features/net_worth_tracker/navigation/net_worth_tracker_nav_handler.dart';
import 'package:easy_localization/easy_localization.dart'
    hide StringTranslateExtension;
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

  /*
      TODO:
       - CurrentNW text to match Figma
       - Loss/Gain chip to be hardcoded below text as per Figma
       - Build the Accounts/PhysAssets/Liabs ListView
       - Refactor the build method into widgets
       - Tests for the nWorthManager
       - Seed data to include 3-4 past entries
       - Chart to be built
        - Interactive when tapped to show status on specific day
        - Preset time frame?
       - Remove hardcoded currency
   */

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final numFrmt = NumberFormat.simpleCurrency(
      name: 'GBP', // TODO: Remove hardcoded currency
    );
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                numFrmt.format(
                  historicalNWorthData.currentNWorth.totalNWorth.value,
                ),
              ),
              _buildDynamicHSizedBox,
              SizedBox(
                height: mq.size.height * 0.29,
                child: const Placeholder(),
              ),
              _buildDynamicHSizedBox,
              ElevatedButton(
                onPressed: () {},
                child: Text('update_financials'.tr),
              ),
              _buildDynamicHSizedBox,
              LightRoundedContainer.withTopRow(
                context: context,
                title: 'title',
                topRightWidget: LightRoundedContainer.builtTopLeftTitle(
                  context,
                  numFrmt.format(holdings.valueOfAccounts),
                ),
                child: Text('helo'),
              )
            ],
          ),
        ),
      ),
    );
  }

  DynamicHSizedBox get _buildDynamicHSizedBox => DynamicHSizedBox.l();
}
