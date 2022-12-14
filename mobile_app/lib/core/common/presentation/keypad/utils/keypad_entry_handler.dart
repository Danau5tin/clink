import 'package:clink_mobile_app/core/common/presentation/keypad/keypad_entry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final keypadHandlerProv =
    StateNotifierProvider.autoDispose<KeypadEntryHandler, String>(
  (ref) => KeypadEntryHandler(),
);

class KeypadEntryHandler extends StateNotifier<String> {
  KeypadEntryHandler({String? startingVal}) : super(startingVal ?? '0');

  void inputDouble(double input) {
    for (var c in input.toStringAsFixed(2).characters) {
      if (c == '-') {
        continue;
      }
      processNewInput(KeypadEntry.fromString(c));
    }
  }

  void processNewInput(KeypadEntry entry) {
    state = entry.when(
      digit: (digit) => _handleDigit(digit),
      decimal: () => _handleDecimal(),
      backspace: () => _handleBackSpace(),
    );
  }

  String _handleDigit(int digit) {
    final idxOfDecimal = state.indexOf('.');
    if (idxOfDecimal != -1) {
      if (state.length - idxOfDecimal <= 2) {
        return '$state$digit';
      } else {
        return state;
      }
    }
    final dbleOfOriginalInp = double.tryParse(state);
    if ((dbleOfOriginalInp ?? 0.0) == 0.0) {
      return digit.toString();
    }
    return '$state$digit';
  }

  String _handleDecimal() {
    if (state.contains('.')) {
      return state;
    }
    final dbleOfOriginalInp = double.tryParse(state);
    if ((dbleOfOriginalInp ?? 0) < 1) {
      return state;
    }
    return '$state.';
  }

  String _handleBackSpace() {
    final dbleOfOriginalInp = double.tryParse(state);
    if (state.length <= 1 || dbleOfOriginalInp == 0.0) {
      return '0';
    }
    if (state.contains('.')) {
      final split = state.split('.');
      if (split.length > 1 && split[1] != '') {
        return state.substring(
          0,
          split[1] == '00'
              ? state.length - 4
              : split[1] == '0'
                  ? state.length - 3
                  : state.length - 1,
        );
      } else {
        return split[0].substring(0, split[0].length - 1);
      }
    }
    return state.substring(0, state.length - 1);
  }
}
