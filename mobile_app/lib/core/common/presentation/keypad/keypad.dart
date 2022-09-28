import 'package:clink_mobile_app/core/common/presentation/keypad/keypad_button.dart';
import 'package:clink_mobile_app/core/common/presentation/keypad/keypad_entry.dart';
import 'package:flutter/material.dart';

class Keypad extends StatelessWidget {
  final Function(KeypadEntry) onTap;

  const Keypad({
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Row(
            children: [
              _buildKeypadButton(const KeypadEntry.digit(1)),
              _buildKeypadButton(const KeypadEntry.digit(2)),
              _buildKeypadButton(const KeypadEntry.digit(3)),
            ],
          ),
        ),
        Expanded(
          child: Row(
            children: [
              _buildKeypadButton(const KeypadEntry.digit(4)),
              _buildKeypadButton(const KeypadEntry.digit(5)),
              _buildKeypadButton(const KeypadEntry.digit(6)),
            ],
          ),
        ),
        Expanded(
          child: Row(
            children: [
              _buildKeypadButton(const KeypadEntry.digit(7)),
              _buildKeypadButton(const KeypadEntry.digit(8)),
              _buildKeypadButton(const KeypadEntry.digit(9)),
            ],
          ),
        ),
        Expanded(
          child: Row(
            children: [
              _buildKeypadButton(const KeypadEntry.decimal()),
              _buildKeypadButton(const KeypadEntry.digit(0)),
              _buildKeypadButton(const KeypadEntry.backspace()),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildKeypadButton(KeypadEntry entry) {
    return Expanded(
      child: KeypadButton(
        entry: entry,
        onTap: onTap,
      ),
    );
  }
}
