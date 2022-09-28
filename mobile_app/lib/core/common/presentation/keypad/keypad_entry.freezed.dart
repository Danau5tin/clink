// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'keypad_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$KeypadEntry {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int digit) digit,
    required TResult Function() decimal,
    required TResult Function() backspace,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(int digit)? digit,
    TResult Function()? decimal,
    TResult Function()? backspace,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int digit)? digit,
    TResult Function()? decimal,
    TResult Function()? backspace,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Digit value) digit,
    required TResult Function(Decimal value) decimal,
    required TResult Function(Backspace value) backspace,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(Digit value)? digit,
    TResult Function(Decimal value)? decimal,
    TResult Function(Backspace value)? backspace,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Digit value)? digit,
    TResult Function(Decimal value)? decimal,
    TResult Function(Backspace value)? backspace,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $KeypadEntryCopyWith<$Res> {
  factory $KeypadEntryCopyWith(
          KeypadEntry value, $Res Function(KeypadEntry) then) =
      _$KeypadEntryCopyWithImpl<$Res>;
}

/// @nodoc
class _$KeypadEntryCopyWithImpl<$Res> implements $KeypadEntryCopyWith<$Res> {
  _$KeypadEntryCopyWithImpl(this._value, this._then);

  final KeypadEntry _value;
  // ignore: unused_field
  final $Res Function(KeypadEntry) _then;
}

/// @nodoc
abstract class _$$DigitCopyWith<$Res> {
  factory _$$DigitCopyWith(_$Digit value, $Res Function(_$Digit) then) =
      __$$DigitCopyWithImpl<$Res>;
  $Res call({int digit});
}

/// @nodoc
class __$$DigitCopyWithImpl<$Res> extends _$KeypadEntryCopyWithImpl<$Res>
    implements _$$DigitCopyWith<$Res> {
  __$$DigitCopyWithImpl(_$Digit _value, $Res Function(_$Digit) _then)
      : super(_value, (v) => _then(v as _$Digit));

  @override
  _$Digit get _value => super._value as _$Digit;

  @override
  $Res call({
    Object? digit = freezed,
  }) {
    return _then(_$Digit(
      digit == freezed
          ? _value.digit
          : digit // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$Digit implements Digit {
  const _$Digit(this.digit);

  @override
  final int digit;

  @override
  String toString() {
    return 'KeypadEntry.digit(digit: $digit)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$Digit &&
            const DeepCollectionEquality().equals(other.digit, digit));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(digit));

  @JsonKey(ignore: true)
  @override
  _$$DigitCopyWith<_$Digit> get copyWith =>
      __$$DigitCopyWithImpl<_$Digit>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int digit) digit,
    required TResult Function() decimal,
    required TResult Function() backspace,
  }) {
    return digit(this.digit);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(int digit)? digit,
    TResult Function()? decimal,
    TResult Function()? backspace,
  }) {
    return digit?.call(this.digit);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int digit)? digit,
    TResult Function()? decimal,
    TResult Function()? backspace,
    required TResult orElse(),
  }) {
    if (digit != null) {
      return digit(this.digit);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Digit value) digit,
    required TResult Function(Decimal value) decimal,
    required TResult Function(Backspace value) backspace,
  }) {
    return digit(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(Digit value)? digit,
    TResult Function(Decimal value)? decimal,
    TResult Function(Backspace value)? backspace,
  }) {
    return digit?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Digit value)? digit,
    TResult Function(Decimal value)? decimal,
    TResult Function(Backspace value)? backspace,
    required TResult orElse(),
  }) {
    if (digit != null) {
      return digit(this);
    }
    return orElse();
  }
}

abstract class Digit implements KeypadEntry {
  const factory Digit(final int digit) = _$Digit;

  int get digit;
  @JsonKey(ignore: true)
  _$$DigitCopyWith<_$Digit> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DecimalCopyWith<$Res> {
  factory _$$DecimalCopyWith(_$Decimal value, $Res Function(_$Decimal) then) =
      __$$DecimalCopyWithImpl<$Res>;
}

/// @nodoc
class __$$DecimalCopyWithImpl<$Res> extends _$KeypadEntryCopyWithImpl<$Res>
    implements _$$DecimalCopyWith<$Res> {
  __$$DecimalCopyWithImpl(_$Decimal _value, $Res Function(_$Decimal) _then)
      : super(_value, (v) => _then(v as _$Decimal));

  @override
  _$Decimal get _value => super._value as _$Decimal;
}

/// @nodoc

class _$Decimal implements Decimal {
  const _$Decimal();

  @override
  String toString() {
    return 'KeypadEntry.decimal()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$Decimal);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int digit) digit,
    required TResult Function() decimal,
    required TResult Function() backspace,
  }) {
    return decimal();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(int digit)? digit,
    TResult Function()? decimal,
    TResult Function()? backspace,
  }) {
    return decimal?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int digit)? digit,
    TResult Function()? decimal,
    TResult Function()? backspace,
    required TResult orElse(),
  }) {
    if (decimal != null) {
      return decimal();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Digit value) digit,
    required TResult Function(Decimal value) decimal,
    required TResult Function(Backspace value) backspace,
  }) {
    return decimal(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(Digit value)? digit,
    TResult Function(Decimal value)? decimal,
    TResult Function(Backspace value)? backspace,
  }) {
    return decimal?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Digit value)? digit,
    TResult Function(Decimal value)? decimal,
    TResult Function(Backspace value)? backspace,
    required TResult orElse(),
  }) {
    if (decimal != null) {
      return decimal(this);
    }
    return orElse();
  }
}

abstract class Decimal implements KeypadEntry {
  const factory Decimal() = _$Decimal;
}

/// @nodoc
abstract class _$$BackspaceCopyWith<$Res> {
  factory _$$BackspaceCopyWith(
          _$Backspace value, $Res Function(_$Backspace) then) =
      __$$BackspaceCopyWithImpl<$Res>;
}

/// @nodoc
class __$$BackspaceCopyWithImpl<$Res> extends _$KeypadEntryCopyWithImpl<$Res>
    implements _$$BackspaceCopyWith<$Res> {
  __$$BackspaceCopyWithImpl(
      _$Backspace _value, $Res Function(_$Backspace) _then)
      : super(_value, (v) => _then(v as _$Backspace));

  @override
  _$Backspace get _value => super._value as _$Backspace;
}

/// @nodoc

class _$Backspace implements Backspace {
  const _$Backspace();

  @override
  String toString() {
    return 'KeypadEntry.backspace()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$Backspace);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int digit) digit,
    required TResult Function() decimal,
    required TResult Function() backspace,
  }) {
    return backspace();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(int digit)? digit,
    TResult Function()? decimal,
    TResult Function()? backspace,
  }) {
    return backspace?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int digit)? digit,
    TResult Function()? decimal,
    TResult Function()? backspace,
    required TResult orElse(),
  }) {
    if (backspace != null) {
      return backspace();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Digit value) digit,
    required TResult Function(Decimal value) decimal,
    required TResult Function(Backspace value) backspace,
  }) {
    return backspace(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(Digit value)? digit,
    TResult Function(Decimal value)? decimal,
    TResult Function(Backspace value)? backspace,
  }) {
    return backspace?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Digit value)? digit,
    TResult Function(Decimal value)? decimal,
    TResult Function(Backspace value)? backspace,
    required TResult orElse(),
  }) {
    if (backspace != null) {
      return backspace(this);
    }
    return orElse();
  }
}

abstract class Backspace implements KeypadEntry {
  const factory Backspace() = _$Backspace;
}
