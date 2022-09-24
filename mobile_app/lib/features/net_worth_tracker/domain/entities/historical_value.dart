import 'package:clink_mobile_app/core/common/domain/entities/amount.dart';

class HistoricalValue {
  final String id;
  final Amount value;
  final DateTime dateTime;

  HistoricalValue({
    required this.id,
    required this.value,
    required this.dateTime,
  });
}
