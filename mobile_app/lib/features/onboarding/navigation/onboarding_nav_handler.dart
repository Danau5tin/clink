import 'package:clink_mobile_app/core/feature_registration/abstract/feature_nav_handler.dart';
import 'package:clink_mobile_app/features/onboarding/subfeatures/currency_select/presentation/screens/currency_select_screen.dart';
import 'package:flutter/material.dart';

class OnboardingNavHandler extends FeatureNavHandler {
  static const startingPath = 'onboarding';

  OnboardingNavHandler() : super(startingPath);

  @override
  Widget? getScreenForPath(String remainingPath, args) {
    switch (remainingPath) {
      case 'currencySelect':
        {
          if (args is String) {
            return CurrencySelectScreen(usersPredictedCurrency: args);
          }
          return null;
        }
      default:
        return null;
    }
  }
}
