import 'package:clink_mobile_app/core/analytics_crashlytics/analytics_reporter.dart';
import 'package:clink_mobile_app/core/analytics_crashlytics/crashlytics_reporter.dart';
import 'package:clink_mobile_app/core/common/domain/misc/user_info_manager.dart';
import 'package:clink_mobile_app/core/common/domain/misc/uuid_gen.dart';
import 'package:clink_mobile_app/core/common/domain/repositories/key_value_local_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../mocks/repos.dart';

void main() {
  late UUIDGen uuidGen;
  late CrashlyticsReporter crashlyticsReporter;
  late AnalyticsReporter analyticsReporter;
  late KeyValueLocalStorage keyValueLocalStorage;

  late UserManager userManager;

  final uuid = UUidGenImpl().generate();
  const baseCurrency = 'GBP';

  setUp(() {
    uuidGen = MockUUIDGen();
    crashlyticsReporter = MockCrashlyticsReporter();
    analyticsReporter = MockAnalyticsReporter();
    keyValueLocalStorage = MockKeyValueLocalStorage();

    userManager = UserManager(
      uuidGen: uuidGen,
      kValLocalStorage: keyValueLocalStorage,
      crashlyticsReporter: crashlyticsReporter,
      analyticsReporter: analyticsReporter,
    );

    when(() => uuidGen.generate()).thenReturn(uuid);
    when(() => crashlyticsReporter.identifyUser(userId: uuid))
        .thenAnswer((_) async {});
    when(() => crashlyticsReporter.reportMessage(any()))
        .thenAnswer((_) async {});
    when(() => analyticsReporter.identifyUser(id: uuid))
        .thenAnswer((_) async {});
  });

  group('init', () {
    test('should update state if user is persisted', () async {
      // Arrange
      when(() => keyValueLocalStorage.getString('userId')).thenReturn(uuid);
      when(() => keyValueLocalStorage.getString('baseCurr')).thenReturn(
        baseCurrency,
      );
      // Act
      userManager.init();
      // Assert
      verify(() => crashlyticsReporter.identifyUser(userId: uuid)).called(1);
      verify(() => analyticsReporter.identifyUser(id: uuid)).called(1);
      expect(userManager.debugState!.id, uuid);
      expect(userManager.debugState!.baseCurrencyCode, baseCurrency);
    });

    test('should not update state if user is persisted', () async {
      // Arrange
      when(() => keyValueLocalStorage.getString(any())).thenReturn(null);
      // Act
      userManager.init();
      // Assert
      verifyNever(() => crashlyticsReporter.identifyUser(userId: uuid));
      verifyNever(() => analyticsReporter.identifyUser(id: uuid));
      verify(() => crashlyticsReporter.reportMessage(any())).called(1);
      expect(userManager.debugState, null);
    });
  });

  group('createNewUser', () {
    test('should update state and reporters and persist the data', () async {
      // Arrange

      when(() => keyValueLocalStorage.saveString(any(), any()))
          .thenAnswer((_) async {});
      // Act
      await userManager.createNewUser(baseCurrency);
      // Assert
      verify(() => keyValueLocalStorage.saveString(any(), uuid)).called(1);
      verify(() => keyValueLocalStorage.saveString(any(), baseCurrency))
          .called(1);
      verify(() => crashlyticsReporter.identifyUser(userId: uuid)).called(1);
      verify(() => analyticsReporter.identifyUser(id: uuid)).called(1);
      expect(userManager.debugState!.id, uuid);
      expect(userManager.debugState!.baseCurrencyCode, baseCurrency);
    });
  });
}
