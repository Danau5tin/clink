import 'package:clink_mobile_app/core/common/data/repositories/sql_db/table_helpers.dart';
import 'package:clink_mobile_app/features/net_worth_tracker/domain/entities/historical_value.dart';

class HistoricalValueModel extends HistoricalValue {
  HistoricalValueModel({
    required super.id,
    required super.value,
    required super.dateTime,
  });

  factory HistoricalValueModel.fromSqlDbMap(
    Map<String, dynamic> map,
  ) {
    return HistoricalValueModel(
      id: map[HValueTable.idKey],
      value: map[HValueTable.valueKey],
      dateTime: DateTime.fromMillisecondsSinceEpoch(
        map[HValueTable.dateRecordedKey],
      ),
    );
  }

  Map<String, dynamic> toSqlMap(String fItemKey) {
    return {
      HValueTable.idKey: id,
      HValueTable.valueKey: value,
      HValueTable.dateRecordedKey: dateTime.millisecondsSinceEpoch,
      HValueTable.fItemKey: fItemKey,
    };
  }
}
