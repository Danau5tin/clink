import 'package:clink_mobile_app/core/common/domain/entities/amount.dart';
import 'package:clink_mobile_app/features/net_worth_tracker/domain/entities/historical_net_worth.dart';
import 'package:clink_mobile_app/features/net_worth_tracker/domain/entities/net_worth_entry.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late HistoricalNWorthData historicalNWorthData;
  late NetWorthEntry entry1;
  late NetWorthEntry entry2;
  late NetWorthEntry entry3;

  const currency = 'GBP';
  final now = DateTime.now();
  final oldestNWDate = now.subtract(const Duration(days: 14));

  setUp(() {
    entry1 = NetWorthEntry(
      id: 'id1',
      assetsValue: Amount(currencyCode: currency, value: 200),
      liabilitiesValue: Amount(currencyCode: currency, value: -50),
      dateTime: oldestNWDate,
    );
    entry2 = NetWorthEntry(
      id: 'id2',
      assetsValue: Amount(currencyCode: currency, value: 150),
      liabilitiesValue: Amount(currencyCode: currency, value: -100),
      dateTime: now.subtract(const Duration(days: 7)),
    );
    entry3 = NetWorthEntry(
      id: 'id3',
      assetsValue: Amount(currencyCode: currency, value: 200),
      liabilitiesValue: Amount(currencyCode: currency, value: -50),
      dateTime: now,
    );

    historicalNWorthData = HistoricalNWorthData(
      entries: [entry1, entry2, entry3],
    );
  });

  group('getLossGainInfoFrom', () {
    test(
        'if start date before first entry then should be 100% increase'
        ' and current net worth value', () async {
      // Arrange
      final startDate = oldestNWDate.subtract(const Duration(days: 7));
      // Act
      final info = historicalNWorthData.getLossGainInfoFrom(startDate);
      // Assert
      expect(
        historicalNWorthData.currentNWorth.totalNWorth.value,
        info.amount.value,
      );
      expect(100.00, info.percentageChange);
    });

    test('should return correct change', () async {
      // Arrange
      final startDate = oldestNWDate.add(const Duration(days: 2));
      // Act
      final info = historicalNWorthData.getLossGainInfoFrom(startDate);
      // Assert
      expect(info.percentageChange, 200);
      expect(info.amount.value, 100);
    });
  });

  group('allEntriesWithEmptiesIfNeededFrom', () {
    test('should return extra entries as empty if start date is before',
        () async {
      // Arrange
      const numDays = 5;
      final startDate = oldestNWDate.subtract(const Duration(days: numDays));
      // Act
      final allEntries =
          historicalNWorthData.allEntriesWithEmptiesIfNeededFrom(startDate);
      // Assert
      expect(allEntries.length, historicalNWorthData.entries.length + numDays);
    });

    test('should return only entries if startDate is not before oldest',
        () async {
      // Arrange
      final startDate = oldestNWDate.add(const Duration(days: 1));
      // Act
      final allEntries =
          historicalNWorthData.allEntriesWithEmptiesIfNeededFrom(startDate);
      // Assert
      expect(allEntries.length, historicalNWorthData.entries.length);
    });
  });
}
