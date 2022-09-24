abstract class CrashlyticsReporter {
  /// if [exception] is null then nothing should be reported
  Future<void> reportException(Exception? exception);

  Future<void> reportMessage(String message);

  Future<void> identifyUser({
    String? userId,
    String? username,
    String? email,
  });
}
