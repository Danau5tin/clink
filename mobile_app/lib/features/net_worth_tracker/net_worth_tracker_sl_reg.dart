import 'package:clink_mobile_app/core/common/data/repositories/sql_db/sql_database.dart';
import 'package:clink_mobile_app/core/crashlytics/crashlytics_reporter.dart';
import 'package:clink_mobile_app/core/feature_registration/abstract/feature_sl_reg.dart';
import 'package:clink_mobile_app/features/net_worth_tracker/data/repositories/net_worth_repo.dart';
import 'package:clink_mobile_app/features/net_worth_tracker/domain/repositories/net_worth_repo.dart';
import 'package:clink_mobile_app/features/net_worth_tracker/presentation/state_management/n_worth_manager.dart';

import 'package:get_it/get_it.dart';

class NetWorthTrackerSlReg extends FeatureSlReg {
  @override
  void registerObjects(GetIt instance) {
    instance.registerLazySingleton<NetWorthRepo>(
      () => NetWorthRepoLocalDb(dbWrap: instance.get<SqlDbWrapper>()),
    );

    instance.registerLazySingleton(
      () => NWorthManager(
        netWorthRepo: instance.get<NetWorthRepo>(),
        crashlyticsReporter: instance.get<CrashlyticsReporter>(),
      ),
    );
  }
}
