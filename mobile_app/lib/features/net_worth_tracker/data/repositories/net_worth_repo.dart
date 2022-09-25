import 'package:clink_mobile_app/core/common/data/repositories/sql_db/sql_database.dart';
import 'package:clink_mobile_app/core/common/data/repositories/sql_db/table_helpers.dart';
import 'package:clink_mobile_app/core/network/data_state/data_state.dart';
import 'package:clink_mobile_app/features/net_worth_tracker/data/models/financial_item_model.dart';
import 'package:clink_mobile_app/features/net_worth_tracker/data/models/historical_value_model.dart';
import 'package:clink_mobile_app/features/net_worth_tracker/data/models/net_worth_entry_model.dart';
import 'package:clink_mobile_app/features/net_worth_tracker/domain/entities/assets_liabilites_holdings.dart';
import 'package:clink_mobile_app/features/net_worth_tracker/domain/entities/financial_item.dart';
import 'package:clink_mobile_app/features/net_worth_tracker/domain/entities/historical_net_worth.dart';
import 'package:clink_mobile_app/features/net_worth_tracker/domain/entities/net_worth_data.dart';
import 'package:clink_mobile_app/features/net_worth_tracker/domain/repositories/net_worth_repo.dart';

// ignore:depend_on_referenced_packages
import 'package:collection/collection.dart';

class NetWorthRepoLocalDb implements NetWorthRepo {
  final SqlDbWrapper dbWrap;

  NetWorthRepoLocalDb({
    required this.dbWrap,
  });

  @override
  Future<DataState<NetWorthData, void>> fetchNWorthData() async {
    try {
      final hDataFut = _fetchHistoricalNWData();
      final aLDataFut = _fetchAssetsLiabilities();
      return DataState.success(
        NetWorthData(
          historicalNWorthData: await hDataFut,
          assetsLiabilitiesHoldings: await aLDataFut,
        ),
      );
    } on Exception catch (e) {
      return DataState.failure(exception: e);
    }
  }

  Future<HistoricalNWorthData> _fetchHistoricalNWData() async {
    final res = await dbWrap.db.query(NWorthEntryDBTable.tableName);
    final entries = res
        .map(
          (e) =>
              NetWorthEntryModel.fromSqlDb(e, 'GBP'), // TODO: Remove hardcoding
        )
        .toList();
    return HistoricalNWorthData(entries: entries);
  }

  Future<AssetsLiabilitiesHoldings> _fetchAssetsLiabilities() async {
    final res = await dbWrap.db.rawQuery('''
      SELECT *
      FROM ${FITemTable.tableName} fi
      CROSS JOIN ${HValueTable.tableName} hv ON 
        fi.${FITemTable.idKey} = hv.${HValueTable.fItemKey}
      ORDER BY hv.${HValueTable.dateRecordedKey} ASC;
    ''');
    final List<FinancialItem> holdings = [];
    for (var element in res) {
      final fItem = FinancialItemModel.fromSqlDbMap(element);
      final hVal =
          HistoricalValueModel.fromSqlDbMap(element, fItem.currencyCode);
      final existingFItem = holdings.firstWhereOrNull((h) => h.id == fItem.id);
      if (existingFItem == null) {
        fItem.historicalValues.add(hVal);
        holdings.add(fItem);
      } else {
        existingFItem.historicalValues.add(hVal);
      }
    }
    return AssetsLiabilitiesHoldings(financialItems: holdings);
  }
}
