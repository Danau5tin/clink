import 'package:clink_mobile_app/core/crashlytics/crashlytics_reporter.dart';
import 'package:clink_mobile_app/core/crashlytics/sentry_reporter.dart';
import 'package:clink_mobile_app/core/env/env_vars_retriever.dart';
import 'package:clink_mobile_app/core/feature_registration/feature_sl_reg.dart';
import 'package:get_it/get_it.dart';

class CoreSlReg extends FeatureSlReg {
  @override
  void registerObjects(GetIt instance) {
    instance.registerLazySingleton<EnvVarsRetriever>(
      () => EnvVarsRetrieverImpl(),
    );

    instance.registerLazySingleton<CrashlyticsReporter>(
      () => SentryReporter(),
    );
  }
}
