import 'package:clink_mobile_app/core/common/data/repositories/sql_db/sql_database.dart';
import 'package:clink_mobile_app/core/common/data/repositories/sql_db/table_helpers.dart';
import 'package:clink_mobile_app/core/network/data_state/data_state.dart';
import 'package:clink_mobile_app/features/net_worth_tracker/data/models/financial_item_model.dart';
import 'package:clink_mobile_app/features/net_worth_tracker/data/models/net_worth_entry_model.dart';
import 'package:clink_mobile_app/features/net_worth_tracker/domain/entities/holdings.dart';
import 'package:clink_mobile_app/features/net_worth_tracker/domain/entities/historical_net_worth.dart';
import 'package:clink_mobile_app/features/net_worth_tracker/domain/entities/net_worth_data.dart';
import 'package:clink_mobile_app/features/net_worth_tracker/domain/repositories/net_worth_repo.dart';

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

  Future<Holdings> _fetchAssetsLiabilities() async {
    const qry = '''
      SELECT * FROM ${FITemTable.tableName} fi
      JOIN (
        SELECT 
          ${HValueTable.valueKey}, 
          ${HValueTable.fItemKey}, 
          MAX(${HValueTable.dateRecordedKey}) AS ${HValueTable.dateRecordedKey}
        FROM ${HValueTable.tableName} GROUP BY ${HValueTable.fItemKey}
        ) AS lookup
      ON lookup.${HValueTable.fItemKey} = fi.${FITemTable.idKey};
    ''';

    final res = await dbWrap.db.rawQuery(qry);

    final holdings =
        res.map((e) => FinancialItemModel.fromSqlDbMap(e)).toList();
    return Holdings(financialItems: holdings);
  }
}
