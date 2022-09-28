import 'package:clink_mobile_app/core/common/data/repositories/key_value_local_storage/key_value_local_storage.dart';
import 'package:clink_mobile_app/core/common/data/repositories/sql_db/sql_database.dart';
import 'package:clink_mobile_app/core/common/domain/misc/uuid_gen.dart';
import 'package:clink_mobile_app/core/common/domain/repositories/key_value_local_storage.dart';
import 'package:clink_mobile_app/core/common/presentation/utils/number_formatter.dart';
import 'package:clink_mobile_app/core/crashlytics/crashlytics_reporter.dart';
import 'package:clink_mobile_app/core/crashlytics/sentry_reporter.dart';
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
      () => NumberFormatterImpl(),
    );

    instance.registerLazySingleton<UUIDGen>(
      () => UUidGenImpl(),
    );

    instance.registerLazySingleton<KeyValueLocalStorage>(
      () => KeyValueLocalStorageImpl(),
    );
  }
}
