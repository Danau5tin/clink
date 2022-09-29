import 'package:clink_mobile_app/core/common/data/repositories/sql_db/sql_database.dart';
import 'package:clink_mobile_app/core/common/data/repositories/sql_db/table_helpers.dart';
import 'package:clink_mobile_app/core/common/domain/misc/user_info_manager.dart';
import 'package:clink_mobile_app/core/common/domain/misc/uuid_gen.dart';
import 'package:clink_mobile_app/core/network/data_state/data_state.dart';
import 'package:clink_mobile_app/features/net_worth_tracker/data/models/financial_item_model.dart';
import 'package:clink_mobile_app/features/net_worth_tracker/data/models/historical_value_model.dart';
import 'package:clink_mobile_app/features/net_worth_tracker/data/models/net_worth_entry_model.dart';
import 'package:clink_mobile_app/features/net_worth_tracker/domain/entities/add_update_item_instruction.dart';
import 'package:clink_mobile_app/features/net_worth_tracker/domain/entities/financial_item.dart';
import 'package:clink_mobile_app/features/net_worth_tracker/domain/entities/holdings.dart';
import 'package:clink_mobile_app/features/net_worth_tracker/domain/entities/historical_net_worth.dart';
import 'package:clink_mobile_app/features/net_worth_tracker/domain/entities/net_worth_data.dart';
import 'package:clink_mobile_app/features/net_worth_tracker/domain/entities/net_worth_entry.dart';
import 'package:clink_mobile_app/features/net_worth_tracker/domain/repositories/net_worth_repo.dart';
import 'package:sqflite/sqflite.dart';

class NetWorthRepoLocalDb implements NetWorthRepo {
  final SqlDbWrapper dbWrap;
  final UUIDGen uuidGen;
  final UserManager userManager;

  NetWorthRepoLocalDb({
    required this.dbWrap,
    required this.uuidGen,
    required this.userManager,
  });

  @override
  Future<DataState<NetWorthData, void>> fetchNWorthData() async {
    try {
      final hDataFut = _fetchHistoricalNWData();
      final aLDataFut = _fetchAssetsLiabilities();
      return DataState.success(
        NetWorthData(
          historicalNWorthData: await hDataFut,
          holdings: await aLDataFut,
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
              NetWorthEntryModel.fromSqlDb(e, userManager.usersBaseCurrency),
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

  @override
  Future<DataState<bool, void>> updateFinancials({
    required NetWorthEntry netWorthEntry,
    required List<AddUpdateItemInstruction> instructions,
  }) async {
    final now = DateTime.now();
    try {
      dbWrap.db.transaction((txn) async {
        final batch = txn.batch();
        batch.insert(
          NWorthEntryDBTable.tableName,
          NetWorthEntryModel.fromNetWorthEntry(netWorthEntry).toSqlMap(),
        );
        for (var instr in instructions) {
          await instr.when(
            add: (item) async => await _addNewFItem(batch, item, now),
            update: (idOfItem, newName, newValue) async =>
                await _updateFItem(batch, idOfItem, newName, newValue, now),
          );
        }
        await batch.commit();
      });
      return const DataState.success(true);
    } on DatabaseException catch (e) {
      return DataState.failure(exception: e);
    }
  }

  Future<void> _updateFItem(
    Batch batch,
    String idOfItem,
    String? newName,
    double? newValue,
    DateTime now,
  ) async {
    if (newName != null) {
      batch.update(
        FITemTable.tableName,
        {FITemTable.nameKey: newName},
        where: '${FITemTable.idKey} = ?',
        whereArgs: [idOfItem],
      );
    }
    if (newValue != null) {
      final hValue = HistoricalValueModel(
        id: uuidGen.generate(),
        value: newValue,
        dateTime: now,
      );
      batch.insert(
        HValueTable.tableName,
        hValue.toSqlMap(idOfItem),
      );
    }
  }

  Future<void> _addNewFItem(
    Batch batch,
    FinancialItem item,
    DateTime now,
  ) async {
    batch.insert(
      FITemTable.tableName,
      FinancialItemModel.fromFItem(item).toSqlMap(),
    );
    final hValue = HistoricalValueModel(
      id: uuidGen.generate(),
      value: item.currentValue.value,
      dateTime: now,
    );
    batch.insert(HValueTable.tableName, hValue.toSqlMap(item.id));
  }
}
