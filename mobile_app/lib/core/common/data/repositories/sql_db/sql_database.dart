import 'package:clink_mobile_app/core/common/data/repositories/sql_db/table_helpers.dart';
import 'package:sqflite/sqflite.dart';

class SqlDbWrapper {
  late final Database db;

  Future<void> init() async {
    db = await openDatabase(
      'clink.db',
      version: 2,
      onConfigure: (db) async {
        await db.execute('PRAGMA foreign_keys = ON');
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 1) {
          final batch = db.batch();
          batch.execute(_createNWEntryTable);
          batch.execute(_createUserTable);
          batch.execute(_createFItemTable);
          batch.execute(_createHValueTable);
          await batch.commit();
        }
      },
    );
  }

  String get _createNWEntryTable => '''
  CREATE TABLE ${NWorthEntryDBTable.tableName} (
    ${NWorthEntryDBTable.idKey} TEXT PRIMARY KEY,
    ${NWorthEntryDBTable.assetsValKey} REAL,
    ${NWorthEntryDBTable.liabValKey} REAL,
    ${NWorthEntryDBTable.createdOnKey} INTEGER
  );
  ''';

  String get _createUserTable => '''
  CREATE TABLE ${UserDBTable.tableName} (
    ${UserDBTable.idKey} TEXT PRIMARY KEY,
    ${UserDBTable.currencyKey} TEXT
  );
  ''';


  String get _createFItemTable => '''
  CREATE TABLE ${FITemTable.tableName} (
    ${FITemTable.idKey} TEXT PRIMARY KEY,
    ${FITemTable.nameKey} TEXT,
    ${FITemTable.currencyKey} TEXT,
    ${FITemTable.fItemTypeKey} INTEGER
  );
  ''';

  String get _createHValueTable => '''
  CREATE TABLE ${HValueTable.tableName} (
    ${HValueTable.idKey} TEXT PRIMARY KEY,
    ${HValueTable.fItemKey} INTEGER,
    ${HValueTable.valueKey} REAL,
    ${HValueTable.dateRecordedKey} INTEGER,
    FOREIGN KEY (${HValueTable.fItemKey}) REFERENCES ${FITemTable.tableName} (${FITemTable.idKey})
  );
  ''';
}
