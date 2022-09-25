import 'package:clink_mobile_app/core/common/domain/entities/amount.dart';

class HistoricalValue {
  final String id;
  final Amount amount;
  final DateTime dateTime;

  HistoricalValue({
    required this.id,
    required this.amount,
    required this.dateTime,
  });
}
