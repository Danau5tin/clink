import 'package:clink_mobile_app/core/analytics_crashlytics/analytics_reporter.dart';
import 'package:clink_mobile_app/core/analytics_crashlytics/mixpanel_reporter.dart';
import 'package:clink_mobile_app/core/common/data/repositories/key_value_local_storage/key_value_local_storage.dart';
import 'package:clink_mobile_app/core/common/data/repositories/sql_db/sql_database.dart';
import 'package:clink_mobile_app/core/common/domain/misc/user_info_manager.dart';
import 'package:clink_mobile_app/core/common/domain/misc/uuid_gen.dart';
import 'package:clink_mobile_app/core/common/domain/repositories/key_value_local_storage.dart';
import 'package:clink_mobile_app/core/common/presentation/utils/number_formatter.dart';
import 'package:clink_mobile_app/core/analytics_crashlytics/crashlytics_reporter.dart';
import 'package:clink_mobile_app/core/analytics_crashlytics/sentry_reporter.dart';
import 'package:clink_mobile_app/core/env/env_vars_retriever.dart';
import 'package:clink_mobile_app/core/feature_registration/abstract/feature_sl_reg.dart';
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

    instance.registerLazySingleton<SqlDbWrapper>(
      () => SqlDbWrapper(),
    );

    instance.registerLazySingleton<NumberFormatter>(
      () => NumberFormatterImpl(
        userManager: instance.get<UserManager>(),
      ),
    );

    instance.registerLazySingleton<UUIDGen>(
      () => UUidGenImpl(),
    );

    instance.registerLazySingleton<KeyValueLocalStorage>(
      () => KeyValueLocalStorageImpl(),
    );

    instance.registerLazySingleton<AnalyticsReporter>(
      () => MixpanelReporter(
        envVarsRetriever: instance.get<EnvVarsRetriever>(),
      ),
    );

    instance.registerLazySingleton<UserManager>(
      () => UserManager(
        uuidGen: instance.get<UUIDGen>(),
        kValLocalStorage: instance.get<KeyValueLocalStorage>(),
        crashlyticsReporter: instance.get<CrashlyticsReporter>(),
        analyticsReporter: instance.get<AnalyticsReporter>(),
      ),
    );
  }
}
