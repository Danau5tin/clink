import 'package:clink_mobile_app/core/analytics_crashlytics/analytics_reporter.dart';
import 'package:clink_mobile_app/core/env/env_vars_retriever.dart';
import 'package:mixpanel_flutter/mixpanel_flutter.dart';

const _mixpanelTokenKey = 'MIXPANEL_TOKEN';

const _kEmailKey = '\$email';
const _kFNameKey = '\$first_name';
const _kLNameKey = '\$last_name';

class MixpanelReporter implements AnalyticsReporter {
  late Mixpanel mixpanel;

  final EnvVarsRetriever envVarsRetriever;

  MixpanelReporter({
    required this.envVarsRetriever,
  });

  @override
  Future<void> init() async {
    mixpanel = await Mixpanel.init(
      envVarsRetriever.getEnvVar(_mixpanelTokenKey)!,
      trackAutomaticEvents: true,
    );
    mixpanel.setServerURL('https://api-eu.mixpanel.com');
  }

  @override
  void identifyUser({
    required String id,
    String? email,
    String? fName,
    String? lName,
  }) {
    mixpanel.identify(id);
    if (email != null && fName != null && lName != null) {
      final people = mixpanel.getPeople();
      people.set(_kEmailKey, email);
      people.set(_kFNameKey, fName);
      people.set(_kLNameKey, lName);
    }
  }

  @override
  void trackEvent(
    String eventName, {
    Map<String, dynamic>? data,
  }) {
    mixpanel.track(eventName, properties: data);
  }
}
