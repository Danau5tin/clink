// ignore: depend_on_referenced_packages
import 'package:collection/collection.dart';
import 'package:clink_mobile_app/core/common/presentation/errors/something_went_wrong_screen.dart';
import 'package:clink_mobile_app/core/crashlytics/crashlytics_reporter.dart';
import 'package:clink_mobile_app/core/feature_registration/feature_nav_handler.dart';
import 'package:flutter/material.dart';

abstract class RouteGenerator {
  MaterialPageRoute<dynamic> generateRoute(RouteSettings settings);
}

class RouteGeneratorImpl implements RouteGenerator {
  final List<FeatureNavHandler> _featureNavHandlers;
  final CrashlyticsReporter crashlyticsReporter;

  RouteGeneratorImpl(this._featureNavHandlers, this.crashlyticsReporter);

  @override
  MaterialPageRoute<dynamic> generateRoute(RouteSettings settings) {
    try {
      final widget = _returnWidget(settings);
      if (widget == null) {
        crashlyticsReporter.reportMessage(
          'Tried navigating to ${settings.name} with ${settings.arguments}. '
          'However we could not find the correct screen',
        );
        return _somethingWentWrong(settings);
      }
      return MaterialPageRoute(builder: (_) => widget, settings: settings);
    } catch (e) {
      crashlyticsReporter
          .reportMessage('error when navigating: ${e.toString()}');
      return _somethingWentWrong(settings);
    }
  }

  MaterialPageRoute<dynamic> _somethingWentWrong(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (_) => const SomethingWentWrongScreen(),
      settings: settings,
    );
  }

  Widget? _returnWidget(RouteSettings settings) {
    final startPath = _getStartPath(settings);
    if (startPath == null) {
      crashlyticsReporter.reportMessage('Invalid path of ${settings.name}');
      return null;
    }
    final handler = _featureNavHandlers.firstWhereOrNull(
      (handler) => handler.canHandleNavigation(startPath),
    );
    if (handler == null) {
      crashlyticsReporter.reportMessage('No handler available for $startPath');
      return null;
    }
    return handler.getScreenForPath(
      settings.name!.split('/').sublist(1).join('/'),
      settings.arguments,
    );
  }

  String? _getStartPath(RouteSettings settings) {
    final splitPath = settings.name?.split('/');
    if (splitPath == null || splitPath.length == 1) {
      return null;
    }
    return splitPath[0];
  }
}
