import 'package:clink_mobile_app/core/common/domain/repositories/key_value_local_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';

class KeyValueLocalStorageImpl implements KeyValueLocalStorage {
  late final Box _box;

  @override
  Future<void> init() async {
    await Hive.initFlutter();
    _box = await Hive.openBox('clink_box');
  }

  @override
  String? getString(String key) {
    final res = _box.get(key);
    return res is String? ? res : null;
  }

  @override
  Future<void> saveString(String key, String value) async {
    await _box.put(key, value);
  }

  @override
  bool? getBool(String key) {
    final res = _box.get(key);
    return res is bool? ? res : null;
  }

  @override
  Future<void> saveBool(String key, bool value) async {
    await _box.put(key, value);
  }
}
