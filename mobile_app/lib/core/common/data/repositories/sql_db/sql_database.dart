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
          await _fillWithSeedData(db);
        }
      },
    );
  }

  Future<void> _fillWithSeedData(Database db) async {
    // TODO: Remove all seed data
    final batch = db.batch();
    batch.execute('INSERT INTO user (user_id, currency_code) VALUES '
        '(\'21f2bea9-d1ab-44e9-8978-f8f1a1193175\', \'GBP\');');
    batch.execute('''
    INSERT INTO financial_item (fi_id, i_name, currency_code, fi_type_id) VALUES 
('511123b0-e102-496b-a827-ac2d0cdb6a14', 'Revolut GBP', 'GBP', 1),
('66d59dd8-8917-4ed2-890f-6fb24e015740', 'Barclays', 'GBP', 1),
('4e003b29-3336-4354-a6b8-a26fbc90ed98', 'Macbook Pro', 'GBP', 2),
('569017b6-034a-4583-8156-ed2c6822f771', 'Samsung S10', 'GBP', 2),
('d2f6b60a-35a1-4f65-9b38-af13aa36bfda', 'Triccount', 'GBP', 3);
    ''');

    // 3 weeks before
    batch.execute('''
    INSERT INTO historical_value (hv_id, fi_id, value, date_recorded_unix) VALUES 
('5cefb3be-d5c7-419d-b079-2e4abda2d237', '511123b0-e102-496b-a827-ac2d0cdb6a14', 10845.94, 1662284454000),
('e333ccfc-e263-46e6-9783-441808fc69cb', '66d59dd8-8917-4ed2-890f-6fb24e015740', 140.40, 1662284454000),
('760f7b48-5c34-4dfc-a4ad-e014cc021fb8', '4e003b29-3336-4354-a6b8-a26fbc90ed98', 1900, 1662284454000),
('57d62b90-429f-468d-a70b-c41df479a068', '569017b6-034a-4583-8156-ed2c6822f771', 160, 1662284454000),
('f15ea391-70a3-4a64-af74-841aa6d6a937', 'd2f6b60a-35a1-4f65-9b38-af13aa36bfda', -120.3, 1662284454000);
    ''');
    batch.execute('''
    INSERT INTO n_w_entry (nwe_id, assets_value, liabilities_value, created_on_unix) VALUES 
('35787479-48a6-4bd3-90a8-3b7a336f5cdc', 13046.34, -120.30, 1662284454000);
    ''');

    // 2 weeks before
    batch.execute('''
    INSERT INTO historical_value (hv_id, fi_id, value, date_recorded_unix) VALUES 
('96317d41-2e4f-4ba6-917f-c7d2ba79af22', '511123b0-e102-496b-a827-ac2d0cdb6a14', 4236.94, 1662889254000),
('91c51664-3b00-4199-8063-f1564685561a', 'd2f6b60a-35a1-4f65-9b38-af13aa36bfda', -100.3, 1662889254000);
    ''');
    batch.execute('''
    INSERT INTO n_w_entry (nwe_id, assets_value, liabilities_value, created_on_unix) VALUES 
('9d518ad8-d50d-4484-b09c-97ffde473cac', 6437.34, -100.30, 1662889254000);
    ''');

    // 1 week before
    batch.execute('''
    INSERT INTO historical_value (hv_id, fi_id, value, date_recorded_unix) VALUES 
('38348aed-4037-496d-a533-aeba0308ed71', '66d59dd8-8917-4ed2-890f-6fb24e015740', 169.50, 1663494054000),
('e2a6fdf9-c75a-4867-9a8a-c55d3376933f', 'd2f6b60a-35a1-4f65-9b38-af13aa36bfda', -80.39, 1663494054000);
    ''');
    batch.execute('''
    INSERT INTO n_w_entry (nwe_id, assets_value, liabilities_value, created_on_unix) VALUES 
('7a410737-8753-4619-943a-c253c2519d05', 6466.44, -80.39, 1663494054000);
    ''');

    // Today
    batch.execute('''
    INSERT INTO historical_value (hv_id, fi_id, value, date_recorded_unix) VALUES 
('bf30b05b-8bad-4170-8884-c5d8f8385684', '511123b0-e102-496b-a827-ac2d0cdb6a14', 12245.98, 1664098854000),
('bd7c3551-ea54-4186-bb21-aa98c43fd1e0', '66d59dd8-8917-4ed2-890f-6fb24e015740', 10.40, 1664098854000),
('25b7a7b7-b664-4583-a447-e4b38f06337c', '4e003b29-3336-4354-a6b8-a26fbc90ed98', 1800, 1664098854000),
('bc4426fb-fc87-409e-a1af-d6da89a4b798', '569017b6-034a-4583-8156-ed2c6822f771', 150, 1664098854000),
('faac943b-63ff-4f8f-aad5-f8e5840092b6', 'd2f6b60a-35a1-4f65-9b38-af13aa36bfda', -12.3, 1664098854000);
    ''');
    batch.execute('''
    INSERT INTO n_w_entry (nwe_id, assets_value, liabilities_value, created_on_unix) VALUES 
('e3100efb-b471-44f9-b465-26f09bd23121', 14206.38, -12.30, 1664098854000);
    ''');
    await batch.commit();
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
