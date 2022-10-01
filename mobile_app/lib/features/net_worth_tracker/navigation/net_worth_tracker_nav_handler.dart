import 'package:clink_mobile_app/core/feature_registration/abstract/feature_nav_handler.dart';
import 'package:clink_mobile_app/features/net_worth_tracker/subfeatures/add_update_holding/presentation/screens/add_update_holding_screen.dart';
import 'package:clink_mobile_app/features/net_worth_tracker/subfeatures/update_n_worth/presentation/screens/update_financials_screen.dart';
import 'package:flutter/material.dart';

class NetWorthTrackerNavHandler extends FeatureNavHandler {
  static const startingPath = 'netWorth';

  NetWorthTrackerNavHandler() : super(startingPath);

  @override
  Widget? getScreenForPath(String remainingPath, args) {
    switch (remainingPath) {
      case 'update':
        return UpdateFinancialsScreen();
      case 'addUpdateHolding' :{
        if (args is AddUpdateHoldingScreenArgs) {
          return AddUpdateHoldingScreen(args: args);
        }
        return null;
      }
      default:
        return null;
    }
  }
}
