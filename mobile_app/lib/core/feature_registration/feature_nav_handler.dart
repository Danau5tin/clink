import 'package:flutter/cupertino.dart';

abstract class FeatureNavHandler {
  final String startPath;

  FeatureNavHandler(this.startPath);

  bool canHandleNavigation(String startingPath) => startPath == startingPath;

  Widget? getScreenForPath(String remainingPath, dynamic args);
}
