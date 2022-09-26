import 'package:clink_mobile_app/core/feature_registration/abstract/feature_nav_handler.dart';
import 'package:clink_mobile_app/features/net_worth_tracker/subfeatures/update_n_worth/presentation/screens/update_financials_screen.dart';
import 'package:flutter/material.dart';

class NetWorthTrackerNavHandler extends FeatureNavHandler {
  static const startingPath = 'netWorth';

  NetWorthTrackerNavHandler() : super(startingPath);

  @override
  Widget? getScreenForPath(String remainingPath, args) {
    switch (remainingPath) {
      case 'update':
        return const UpdateFinancialsScreen();
      default:
        return null;
    }
  }
}
