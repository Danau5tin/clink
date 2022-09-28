import 'package:clink_mobile_app/core/crashlytics/crashlytics_reporter.dart';
import 'package:clink_mobile_app/core/navigation/route_generator.dart';
import 'package:clink_mobile_app/features/net_worth_tracker/navigation/net_worth_tracker_nav_handler.dart';
import 'package:clink_mobile_app/features/onboarding/navigation/onboarding_nav_handler.dart';
import 'package:get_it/get_it.dart';

import 'abstract/feature_nav_handler.dart';
import 'abstract/feature_sl_reg.dart';

List<FeatureNavHandler> _featureNavHandlers = [
  NetWorthTrackerNavHandler(),
  OnboardingNavHandler(),
];

class NavigationSlReg implements FeatureSlReg {
  @override
  void registerObjects(GetIt instance) {
    instance.registerSingleton<RouteGenerator>(
      RouteGeneratorImpl(
        _featureNavHandlers,
        instance.get<CrashlyticsReporter>(),
      ),
    );
  }
}
