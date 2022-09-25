import 'package:clink_mobile_app/core/crashlytics/crashlytics_reporter.dart';
import 'package:clink_mobile_app/features/net_worth_tracker/domain/repositories/net_worth_repo.dart';
import 'package:mocktail/mocktail.dart';

class MockNetWorthRepo extends Mock implements NetWorthRepo {}

class MockCrashlyticsReporter extends Mock implements CrashlyticsReporter {}
