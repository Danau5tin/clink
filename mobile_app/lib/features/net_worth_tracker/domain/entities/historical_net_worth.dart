import 'package:clink_mobile_app/core/common/domain/entities/amount.dart';
import 'package:clink_mobile_app/core/common/domain/misc/date_time_extension.dart';
import 'package:clink_mobile_app/features/net_worth_tracker/domain/entities/amount_precentage_info.dart';

import 'net_worth_entry.dart';

class HistoricalNWorthData {
  final List<NetWorthEntry> _entries;

  HistoricalNWorthData({
    required List<NetWorthEntry> entries,
  }) : _entries = entries {
    _entries.sort((a, b) => a.dateTime.compareTo(b.dateTime));
  }

  NetWorthEntry get currentNWorth => _entries.last;

  List<NetWorthEntry> get entries => [..._entries];

  AmountPercentageInfo get getLossGainInfo {
    final valueChange =
        currentNWorth.totalNWorth.value - _entries.first.totalNWorth.value;
    final percChange = (currentNWorth.totalNWorth.value / valueChange) * 100;
    return AmountPercentageInfo(
      amount: Amount(
        currencyCode: currentNWorth.totalNWorth.currencyCode,
        value: valueChange,
      ),
      percentageChange: percChange.isInfinite ? 0.0 : percChange,
    );
  }

  List<NetWorthEntry> allEntriesWithEmptiesIfNeededFrom(DateTime startDate) {
    if (!startDate.isBefore(entries.first.dateTime)) {
      return entries;
    }

    final List<NetWorthEntry> emptyEntries = [];
    DateTime workingDate = startDate;
    int emptyId = 0;
    final emptyAmount = Amount(
      currencyCode: entries.first.assetsValue.currencyCode,
      value: 0.0,
    );
    while (!workingDate.isSameDayAs(entries.first.dateTime)) {
      final emptyEntry = NetWorthEntry(
        id: 'empty_$emptyId',
        assetsValue: emptyAmount,
        liabilitiesValue: emptyAmount,
        dateTime: workingDate,
      );
      emptyEntries.add(emptyEntry);
      workingDate = workingDate.add(const Duration(days: 1));
      emptyId ++;
    }

    return [...emptyEntries, ...entries];
  }
}
