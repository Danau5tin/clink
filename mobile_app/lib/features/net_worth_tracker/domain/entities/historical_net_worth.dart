import 'package:clink_mobile_app/core/common/domain/entities/amount.dart';
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
    return AmountPercentageInfo(
      amount: Amount(
        currencyCode: currentNWorth.totalNWorth.currencyCode,
        value: valueChange,
      ),
      percentageChange: currentNWorth.totalNWorth.value / valueChange,
    );
  }
}
