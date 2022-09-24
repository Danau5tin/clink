const _currCodeKey = 'currency_code';

class NWorthEntryDBTable {
  static const tableName = 'n_w_entry';
  static const idKey = 'nwe_id';
  static const assetsValKey = 'assets_value';
  static const liabValKey = 'liabilities_value';
  static const createdOnKey = 'created_on_unix';
}

class UserDBTable {
  static const tableName = 'user';
  static const idKey = 'user_id';
  static const currencyKey = _currCodeKey;
}

class FITemTable {
  static const tableName = 'financial_item';
  static const idKey = 'fi_id';
  static const nameKey = 'i_name';
  static const currencyKey = _currCodeKey;
  static const fItemTypeKey = 'fi_type_id';
}

class HValueTable {
  static const tableName = 'historical_value';
  static const idKey = 'hv_id';
  static const fItemKey = 'fi_id';
  static const valueKey = 'value';
  static const dateRecordedKey = 'date_recorded_unix';
}
