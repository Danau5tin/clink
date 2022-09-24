import 'package:clink_mobile_app/core/env/env_vars_retriever.dart';
import 'package:clink_mobile_app/core/feature_registration/service_locator.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

void main() async {
  setUpSL();
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
  await SentryFlutter.init(
    (options) {
      options.dsn = sl.get<EnvVarsRetriever>().getEnvVar('SENTRY_DSN');
    },
    appRunner: () => runApp(const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: Center(
          child: ElevatedButton(
            child: const Text('Hello World'),
            onPressed: () async {

            },
          ),
        ),
      ),
    );
  }
}
