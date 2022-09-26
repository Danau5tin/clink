import 'package:freezed_annotation/freezed_annotation.dart';

part 'keypad_entry.freezed.dart';

@freezed
class KeypadEntry with _$KeypadEntry {
  const factory KeypadEntry.digit(int digit) = Digit;

  const factory KeypadEntry.decimal() = Decimal;

  const factory KeypadEntry.backspace() = Backspace;
}
