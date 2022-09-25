import 'package:clink_mobile_app/core/core_sl_reg.dart';
import 'package:clink_mobile_app/core/feature_registration/navigation_sl_reg.dart';
import 'package:clink_mobile_app/features/net_worth_tracker/net_worth_tracker_sl_reg.dart';
import 'package:get_it/get_it.dart';

import 'abstract/feature_sl_reg.dart';

final sl = GetIt.instance;

final List<FeatureSlReg> _featuresToRegAtStartup = [
  CoreSlReg(),
  NavigationSlReg(),
  NetWorthTrackerSlReg(),
];

void setUpSL() {
  for (var featObjReg in _featuresToRegAtStartup) {
    featObjReg.registerObjects(sl);
  }
}
