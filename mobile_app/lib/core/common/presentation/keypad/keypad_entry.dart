import 'package:freezed_annotation/freezed_annotation.dart';

part 'keypad_entry.freezed.dart';

@freezed
class KeypadEntry with _$KeypadEntry {
  const factory KeypadEntry.digit(int digit) = Digit;

  const factory KeypadEntry.decimal() = Decimal;

  const factory KeypadEntry.backspace() = Backspace;

  factory KeypadEntry.fromString(String val) {
    if (val == '.' || val == ',') {
      return const KeypadEntry.decimal();
    }
    return KeypadEntry.digit(int.parse(val));
  }
}
