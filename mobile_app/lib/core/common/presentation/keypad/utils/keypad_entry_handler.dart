import 'package:clink_mobile_app/core/common/presentation/keypad/keypad_entry.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final keypadHandlerProv =
    StateNotifierProvider.autoDispose<KeypadEntryHandler, String>(
  (ref) => KeypadEntryHandler(),
);

class KeypadEntryHandler extends StateNotifier<String> {
  KeypadEntryHandler({String? startingVal}) : super(startingVal ?? '0');

  void processNewInput(KeypadEntry entry) {
    state =  entry.when(
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
    return state.substring(0, state.length - 1);
  }
}
