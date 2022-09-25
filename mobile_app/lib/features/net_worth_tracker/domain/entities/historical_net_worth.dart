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
}
