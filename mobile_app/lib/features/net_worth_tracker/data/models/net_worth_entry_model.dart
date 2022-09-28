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

  Map<String, dynamic> toSqlMap() {
    return {
      NWorthEntryDBTable.idKey: id,
      NWorthEntryDBTable.assetsValKey: assetsValue.value,
      NWorthEntryDBTable.liabValKey: liabilitiesValue.value,
      NWorthEntryDBTable.createdOnKey: dateTime.millisecondsSinceEpoch,
    };
  }

  factory NetWorthEntryModel.fromNetWorthEntry(NetWorthEntry entry) {
    return NetWorthEntryModel(
      id: entry.id,
      assetsValue: entry.assetsValue,
      liabilitiesValue: entry.liabilitiesValue,
      dateTime: entry.dateTime,
    );
  }
}
