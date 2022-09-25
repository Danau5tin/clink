import 'package:clink_mobile_app/core/common/data/repositories/sql_db/sql_database.dart';
import 'package:clink_mobile_app/core/common/presentation/circular_progress_bar.dart';
import 'package:clink_mobile_app/core/common/presentation/errors/something_went_wrong_screen.dart';
import 'package:clink_mobile_app/core/common/presentation/theme/remove_scroll_glow.dart';
import 'package:clink_mobile_app/core/common/presentation/theme/theme_data.dart';
import 'package:clink_mobile_app/core/env/env_vars_retriever.dart';
import 'package:clink_mobile_app/core/feature_registration/service_locator.dart';
import 'package:clink_mobile_app/core/navigation/route_generator.dart';
import 'package:clink_mobile_app/features/net_worth_tracker/presentation/screens/net_worth_tracker_screen.dart';
import 'package:clink_mobile_app/features/net_worth_tracker/presentation/state_management/n_worth_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

void main() async {
  setUpSL();
  WidgetsFlutterBinding.ensureInitialized();
  final dbInit = sl.get<SqlDbWrapper>().init();
  await EasyLocalization.ensureInitialized();
  final envRet = sl.get<EnvVarsRetriever>();
  final envInit = envRet.init();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
  await envInit;
  await dbInit;

  final container = ProviderContainer();
  await container.read(nWorthManagerProv.notifier).fetchNWData();

  await SentryFlutter.init(
    (options) {
      options.dsn = envRet.getEnvVar('SENTRY_DSN');
    },
    appRunner: () => runApp(
      UncontrolledProviderScope(
        container: container,
        child: EasyLocalization(
          supportedLocales: const [Locale('en'), Locale('fr')],
          path: 'assets/translations',
          fallbackLocale: const Locale('en'),
          child: const MyApp(),
        ),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: appTheme,
      locale: context.locale,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      onGenerateRoute: sl<RouteGenerator>().generateRoute,
      scrollBehavior: RemoveScrollGlow(),
      home: Scaffold(
        body: Consumer(
          builder: (context, ref, child) {
            final nWorthState = ref.watch(nWorthManagerProv);
            return nWorthState.when(
              loading: () => const CircularProgressBar(),
              error: () => const SomethingWentWrongScreen(),
              loaded: (nWorthData, holdings) => NetWorthTrackerScreen(
                historicalNWorthData: nWorthData,
                holdings: holdings,
              ),
            );
          },
        ),
      ),
    );
  }
}
