import 'package:clink_mobile_app/core/common/data/repositories/sql_db/table_helpers.dart';
import 'package:clink_mobile_app/core/common/domain/entities/amount.dart';
import 'package:clink_mobile_app/features/net_worth_tracker/domain/entities/net_worth_entry.dart';

class NetWorthEntryModel extends NetWorthEntry {
  NetWorthEntryModel({
    required super.id,
    required super.assetsValue,
    required super.liabilitiesValue,
    required super.dateTime,
  });

  factory NetWorthEntryModel.fromSqlDb(
    Map<String, dynamic> map,
    String currencyCode,
  ) {
    return NetWorthEntryModel(
      id: map[NWorthEntryDBTable.idKey],
      assetsValue: Amount(
        currencyCode: currencyCode,
        value: map[NWorthEntryDBTable.assetsValKey],
      ),
      liabilitiesValue: Amount(
        currencyCode: currencyCode,
        value: map[NWorthEntryDBTable.liabValKey],
      ),
      dateTime: DateTime.fromMillisecondsSinceEpoch(
        map[NWorthEntryDBTable.createdOnKey],
      ),
    );
  }
}
