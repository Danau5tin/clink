import 'package:clink_mobile_app/core/crashlytics/crashlytics_reporter.dart';
import 'package:clink_mobile_app/core/navigation/route_generator.dart';
import 'package:get_it/get_it.dart';

import 'feature_nav_handler.dart';
import 'feature_sl_reg.dart';

List<FeatureNavHandler> _featureNavHandlers = [
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
