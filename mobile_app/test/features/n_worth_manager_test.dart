import 'package:clink_mobile_app/core/analytics_crashlytics/crashlytics_reporter.dart';
import 'package:clink_mobile_app/core/network/data_state/data_state.dart';
import 'package:clink_mobile_app/features/net_worth_tracker/domain/entities/holdings.dart';
import 'package:clink_mobile_app/features/net_worth_tracker/domain/entities/historical_net_worth.dart';
import 'package:clink_mobile_app/features/net_worth_tracker/domain/entities/net_worth_data.dart';
import 'package:clink_mobile_app/features/net_worth_tracker/domain/repositories/net_worth_repo.dart';
import 'package:clink_mobile_app/features/net_worth_tracker/presentation/state_management/n_worth_manager.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../mocks/data_classes.dart';
import '../mocks/repos.dart';

void main() {
  late NetWorthRepo netWorthRepo;
  late CrashlyticsReporter crashlyticsReporter;
  late HistoricalNWorthData historicalNWorthData;
  late Holdings assetsLiabilitiesHoldings;
  late NetWorthData netWorthData;

  late NWorthManager nWorthManager;

  setUp(() {
    netWorthRepo = MockNetWorthRepo();
    crashlyticsReporter = MockCrashlyticsReporter();
    netWorthData = MockNetWorthData();
    historicalNWorthData = MockHistoricalNWorthData();
    assetsLiabilitiesHoldings = MockHoldings();

    when(() => netWorthData.historicalNWorthData)
        .thenReturn(historicalNWorthData);
    when(() => netWorthData.holdings).thenReturn(assetsLiabilitiesHoldings);

    nWorthManager = NWorthManager(
      netWorthRepo: netWorthRepo,
      crashlyticsReporter: crashlyticsReporter,
    );
  });

  group('fetch initial data', () {
    test('should update state with correct data if success', () async {
      // Arrange
      when(() => netWorthRepo.fetchNWorthData()).thenAnswer(
        (_) async => DataState.success(netWorthData),
      );
      // Act
      await nWorthManager.fetchNWData();
      // Assert
      nWorthManager.debugState.maybeWhen(
        loaded: (hdata, holdings) {
          expect(hdata, historicalNWorthData);
          expect(holdings, assetsLiabilitiesHoldings);
        },
        orElse: () => throw Exception('Unexpected state'),
      );
    });

    test(
        'should update state with error if failed and call crashlytics',
        () async {
      // Arrange
      when(() => netWorthRepo.fetchNWorthData()).thenAnswer(
        (_) async => const DataState.failure(),
      );
      when(() => crashlyticsReporter.reportException(any()))
          .thenAnswer((_) async {});
      // Act
      await nWorthManager.fetchNWData();
      // Assert
      nWorthManager.debugState.maybeWhen(
        error: () {
          verify(() => crashlyticsReporter.reportException(any()));
        },
        orElse: () => throw Exception('Unexpected state'),
      );
    });
  });
}
