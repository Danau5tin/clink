import 'package:clink_mobile_app/core/analytics_crashlytics/analytics_reporter.dart';
import 'package:clink_mobile_app/core/analytics_crashlytics/crashlytics_reporter.dart';
import 'package:clink_mobile_app/core/common/domain/misc/uuid_gen.dart';
import 'package:clink_mobile_app/core/common/domain/repositories/key_value_local_storage.dart';
import 'package:clink_mobile_app/features/net_worth_tracker/domain/repositories/net_worth_repo.dart';
import 'package:mocktail/mocktail.dart';

class MockNetWorthRepo extends Mock implements NetWorthRepo {}

class MockCrashlyticsReporter extends Mock implements CrashlyticsReporter {}

class MockAnalyticsReporter extends Mock implements AnalyticsReporter {}

class MockKeyValueLocalStorage extends Mock implements KeyValueLocalStorage {}

class MockUUIDGen extends Mock implements UUIDGen {}
