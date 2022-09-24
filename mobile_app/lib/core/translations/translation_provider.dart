// ignore_for_file: unnecessary_this
import 'package:easy_localization/easy_localization.dart' as ez;

extension StringExt on String {
  /// [tr] fetches the translation, if not found it attempts to recreate the
  /// string with the key, which is arguably a better alternative than showing
  /// the key to the user.
  String get tr {
    final res = ez.tr(this);
    return _processResult(this, res);
  }

  String trParams(Map<String, String> params) {
    final res = ez.tr(this, namedArgs: params);
    return _processResult(this, res);
  }

  String capitalise() {
    return '${this[0].toUpperCase()}${this.substring(1).toLowerCase()}';
  }
}

String _processResult(String originalString, String res) {
  if (res == originalString) {
    return originalString.split('_').join(' ').capitalise();
  } else {
    return res;
  }
}
