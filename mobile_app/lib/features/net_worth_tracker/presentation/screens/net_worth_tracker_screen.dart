import 'package:auto_size_text/auto_size_text.dart';
import 'package:clink_mobile_app/core/common/presentation/dynamic_sized_box.dart';
import 'package:clink_mobile_app/core/common/presentation/tip_text.dart';
import 'package:clink_mobile_app/core/translations/translation_provider.dart';
import 'package:clink_mobile_app/features/feedback/presentation/screens/feedback_screen.dart';
import 'package:clink_mobile_app/features/net_worth_tracker/domain/entities/holdings.dart';
import 'package:clink_mobile_app/features/net_worth_tracker/domain/entities/fi_type.dart';
import 'package:clink_mobile_app/features/net_worth_tracker/domain/entities/historical_net_worth.dart';
import 'package:clink_mobile_app/features/net_worth_tracker/navigation/net_worth_tracker_nav_handler.dart';
import 'package:clink_mobile_app/features/net_worth_tracker/presentation/widgets/current_n_worth_display.dart';
import 'package:clink_mobile_app/features/net_worth_tracker/presentation/widgets/f_item_summary.dart';
import 'package:clink_mobile_app/features/net_worth_tracker/subfeatures/net_worth_chart/presentation/widgets/n_worth_chart.dart';
import 'package:clink_mobile_app/features/net_worth_tracker/subfeatures/net_worth_chart/presentation/widgets/time_period_row.dart';
import 'package:clink_mobile_app/features/net_worth_tracker/subfeatures/update_n_worth/presentation/screens/update_financials_screen.dart';
import 'package:flutter/material.dart';

class NetWorthTrackerScreen extends StatelessWidget {
  static const String viewPath =
      '${NetWorthTrackerNavHandler.startingPath}/dash';

  final HistoricalNWorthData historicalNWorthData;
  final Holdings holdings;

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
                child: historicalNWorthData.entries.length == 1
                    ? Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: TipText(text: 'this_is_your_dashboard'.tr),
                        ),
                      )
                    : NWorthChart(historicalNWorth: historicalNWorthData),
              ),
              _buildDynamicHSizedBox,
              _wrapPadding(const TimePeriodRow()),
              _buildDynamicHSizedBox,
              _wrapPadding(_buildUpdateCTA(context)),
              _buildDynamicHSizedBox,
              _wrapPadding(_buildFeedbackCTA(context)),
              _buildDynamicHSizedBox,
              _buildSummary(const FiType.account()),
              _buildDynamicHSizedBox,
              _buildSummary(const FiType.physAsset()),
              _buildDynamicHSizedBox,
              _buildSummary(const FiType.liability()),
              _buildDynamicHSizedBox,
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSummary(FiType type) =>
      _wrapPadding(FItemSummary(fItemType: type, holdings: holdings));

  ElevatedButton _buildUpdateCTA(BuildContext context) {
    return ElevatedButton(
      onPressed: () => Navigator.pushNamed(
        context,
        UpdateFinancialsScreen.viewPath,
      ),
      child: Text('update_financials'.tr),
    );
  }

  ElevatedButton _buildFeedbackCTA(BuildContext context) {
    return ElevatedButton(
      onPressed: () => Navigator.pushNamed(
        context,
        FeedbackScreen.viewPath,
      ),
      child: AutoSizeText(
        'give_feedback_features'.tr,
        maxLines: 1,
      ),
    );
  }

  Widget _wrapPadding(Widget child) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: child,
      );

  DynamicHSizedBox get _buildDynamicHSizedBox => DynamicHSizedBox.l();
}
