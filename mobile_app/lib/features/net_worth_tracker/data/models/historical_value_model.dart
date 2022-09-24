import 'package:clink_mobile_app/core/common/data/repositories/sql_db/table_helpers.dart';
import 'package:clink_mobile_app/core/common/domain/entities/amount.dart';
import 'package:clink_mobile_app/features/net_worth_tracker/domain/entities/historical_value.dart';

class HistoricalValueModel extends HistoricalValue {
  HistoricalValueModel({
    required super.id,
    required super.amount,
    required super.dateTime,
  });

  factory HistoricalValueModel.fromSqlDbMap(
    Map<String, dynamic> map,
    String currencyCode,
  ) {
    return HistoricalValueModel(
      id: map[HValueTable.idKey],
      amount: Amount(
        currencyCode: currencyCode,
        value: map[HValueTable.valueKey],
      ),
      dateTime: DateTime.fromMillisecondsSinceEpoch(
        map[HValueTable.dateRecordedKey],
      ),
    );
  }
}
