abstract class KeyValueLocalStorage {
  Future<void> init();

  String? getString(String key);

  bool? getBool(String key);

  Future<void> saveString(String key, String value);

  // ignore: avoid_positional_boolean_parameters
  Future<void> saveBool(String key, bool value);
}
