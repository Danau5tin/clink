abstract class KeyValueLocalStorage {
  Future<void> init();

  String? getString(String key);

  Future<void> saveString(String key, String value);
}
