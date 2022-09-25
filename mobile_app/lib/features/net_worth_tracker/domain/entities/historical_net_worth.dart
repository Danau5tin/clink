import 'package:clink_mobile_app/core/common/domain/entities/amount.dart';
import 'package:clink_mobile_app/features/net_worth_tracker/domain/entities/loss_gain_info.dart';

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

  LossGainInfo get getLossGainInfo {
    final valueChange =
        currentNWorth.totalNWorth.value - _entries.first.totalNWorth.value;
    return LossGainInfo(
      amount: Amount(
        currencyCode: currentNWorth.totalNWorth.currencyCode,
        value: valueChange,
      ),
      percentageChange: currentNWorth.totalNWorth.value / valueChange,
    );
  }
}
