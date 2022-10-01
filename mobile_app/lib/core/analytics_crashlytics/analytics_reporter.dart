abstract class AnalyticsReporter {
  Future<void> init();

  void trackEvent(String eventName, {Map<String, dynamic>? data});

  void identifyUser({
    required String id,
    String? email,
    String? fName,
    String? lName,
  });
}
