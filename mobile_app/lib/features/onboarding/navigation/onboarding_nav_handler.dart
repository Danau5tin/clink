import 'package:clink_mobile_app/core/feature_registration/abstract/feature_nav_handler.dart';
import 'package:flutter/material.dart';

class OnboardingNavHandler extends FeatureNavHandler {
  static const startingPath = ''; // TODO:

  OnboardingNavHandler() : super(startingPath);

  @override
  Widget? getScreenForPath(String remainingPath, args) {
    switch (remainingPath) {
      // TODO:
      default:
        return null;
    }
  }
}

