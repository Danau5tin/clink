import 'package:clink_mobile_app/features/net_worth_tracker/domain/entities/holdings.dart';
import 'package:clink_mobile_app/features/net_worth_tracker/domain/entities/historical_net_worth.dart';

/// [NetWorthData] is a data class used for combining the data required at
/// app startup so we just make 1 request from the repo
class NetWorthData {
  final HistoricalNWorthData historicalNWorthData;
  final Holdings assetsLiabilitiesHoldings;

  NetWorthData({
    required this.historicalNWorthData,
    required this.assetsLiabilitiesHoldings,
  });
}
