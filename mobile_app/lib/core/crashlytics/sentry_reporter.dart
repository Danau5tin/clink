import 'package:sentry_flutter/sentry_flutter.dart';

import 'crashlytics_reporter.dart';

class SentryReporter implements CrashlyticsReporter {
  @override
  Future<void> reportException(Exception? exception) async {
    if (exception != null) {
      Sentry.captureException(exception);
    }
  }

  @override
  Future<void> reportMessage(String message) async {
    Sentry.captureMessage(message);
  }

  @override
  Future<void> identifyUser({
    String? userId,
    String? username,
    String? email,
  }) async {
    Sentry.configureScope((scope) {
      scope.setUser(
        SentryUser(
          id: userId,
          username: username,
          email: email,
        ),
      );
    });
  }

  void _setSentryUser(String? userId, String? username, String? email) {}
}
