import 'package:clink_mobile_app/core/feature_registration/abstract/feature_nav_handler.dart';
import 'package:clink_mobile_app/features/feedback/presentation/screens/feedback_screen.dart';
import 'package:flutter/material.dart';

class FeedbackNavHandler extends FeatureNavHandler {
  static const startingPath = 'feedback';

  FeedbackNavHandler() : super(startingPath);

  @override
  Widget? getScreenForPath(String remainingPath, args) {
    switch (remainingPath) {
      case 'textInput':
        return const FeedbackScreen();
      default:
        return null;
    }
  }
}

