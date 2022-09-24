import 'package:clink_mobile_app/core/core_sl_reg.dart';
import 'package:clink_mobile_app/core/feature_registration/navigation_sl_reg.dart';
import 'package:get_it/get_it.dart';

import 'feature_sl_reg.dart';

final sl = GetIt.instance;

final List<FeatureSlReg> _featuresToRegAtStartup = [
  CoreSlReg(),
  NavigationSlReg(),
];

void setUpSL() {
  for (var featObjReg in _featuresToRegAtStartup) {
    featObjReg.registerObjects(sl);
  }
}
