import 'package:clink_mobile_app/core/common/presentation/keypad/keypad_entry.dart';
import 'package:clink_mobile_app/core/common/presentation/keypad/utils/keypad_entry_handler.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late KeypadEntryHandler handler;
  late KeypadEntry entry;

  setUp(() {
    handler = KeypadEntryHandler();
  });

  group('processNewInput for original input of 0', () {
    test('should return digit if original is 0 and we add digit', () async {
      // Arrange
      entry = const KeypadEntry.digit(1);
      // Act
      handler.processNewInput(entry);
      // Assert
      expect(handler.debugState, '1');
    });

    test('should return same if original is 0 and we backspace', () async {
      // Arrange
      entry = const KeypadEntry.backspace();
      // Act
      handler.processNewInput(entry);
      // Assert
      expect(handler.debugState, '0');
    });

    test('should return 0 if original is 0 and we decimal', () async {
      // Arrange
      entry = const KeypadEntry.decimal();
      // Act
      handler.processNewInput(entry);
      // Assert
      expect(handler.debugState, '0');
    });
  });

  group('processNewInput decimal checks', () {
    setUp(() {
      entry = const KeypadEntry.decimal();
      handler = KeypadEntryHandler(startingVal: '10');
    });

    test('should return digits with decimal if decimal is tapped', () async {
      // Arrange
      // Act
      handler.processNewInput(entry);
      // Assert
      expect(handler.debugState, '10.');
    });

    test('should return original if decimal is tapped when already exists',
        () async {
      // Arrange
      handler.processNewInput(const KeypadEntry.decimal());
      // Act
      handler.processNewInput(entry);
      // Assert
      expect(handler.debugState, '10.');
    });
  });

  group('processNewInput backspace checks', () {
    setUp(() {
      entry = const KeypadEntry.backspace();
    });

    test('should return remove decimal and digit if backspace is tapped'
        ' when only decimal present',
        () async {
      // Arrange
      handler = KeypadEntryHandler(startingVal: '10.');
      // Act
      handler.processNewInput(entry);
      // Assert
      expect(handler.debugState, '1');
    });

    test('should return 0 if only existing digit is backspaced', () async {
      // Arrange
      handler.processNewInput(const KeypadEntry.digit(8));
      // Act
      handler.processNewInput(entry);
      // Assert
      expect(handler.debugState, '0');
    });
  });

  group('processNewInput digit checks', () {
    setUp(() {
      entry = const KeypadEntry.digit(7);
    });

    test('should add digit after decimal', () async {
      // Arrange
      handler = KeypadEntryHandler(startingVal: '10.');
      // Act
      handler.processNewInput(entry);
      // Assert
      expect(handler.debugState, '10.7');
    });

    test('should add digit after decimal + 1', () async {
      // Arrange
      handler = KeypadEntryHandler(startingVal: '8.9');
      // Act
      handler.processNewInput(entry);
      // Assert
      expect(handler.debugState, '8.97');
    });

    test('should not add digit after decimal + 2', () async {
      // Arrange
      handler = KeypadEntryHandler(startingVal: '2.65');
      // Act
      handler.processNewInput(entry);
      // Assert
      expect(handler.debugState, '2.65');
    });
  });
}
