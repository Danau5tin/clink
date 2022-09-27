import 'package:clink_mobile_app/core/common/data/repositories/sql_db/table_helpers.dart';
import 'package:clink_mobile_app/core/common/domain/entities/amount.dart';
import 'package:clink_mobile_app/features/net_worth_tracker/data/models/fi_type_model.dart';
import 'package:clink_mobile_app/features/net_worth_tracker/domain/entities/financial_item.dart';

class FinancialItemModel extends FinancialItem {
  FinancialItemModel({
    required super.id,
    required super.name,
    required super.currentValue,
    required super.type,
  });

  factory FinancialItemModel.fromSqlDbMap(Map<String, dynamic> map) {
    return FinancialItemModel(
      id: map[FITemTable.idKey],
      name: map[FITemTable.nameKey],
      type: FITypeModel.fromSqlDb(map[FITemTable.fItemTypeKey]),
      currentValue: Amount(
        currencyCode: map[FITemTable.currencyKey],
        value: map[HValueTable.valueKey],
      ),
    );
  }
}
