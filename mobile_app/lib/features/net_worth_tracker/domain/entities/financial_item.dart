import 'package:clink_mobile_app/features/net_worth_tracker/domain/entities/fi_type.dart';

import 'historical_value.dart';

class FinancialItem {
  final String id;
  final String name;
  final String currencyCode;
  final FiType type;
  final List<HistoricalValue> historicalValues;

  FinancialItem({
    required this.id,
    required this.name,
    required this.currencyCode,
    required this.type,
    required this.historicalValues,
  });
}
