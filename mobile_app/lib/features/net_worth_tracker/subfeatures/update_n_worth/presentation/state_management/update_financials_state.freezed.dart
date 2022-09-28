// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'update_financials_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$UpdateFinancialsState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            Holdings originalHoldings, Holdings updatedHoldings, dynamic saving)
        initial,
    required TResult Function() success,
    required TResult Function() error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(Holdings originalHoldings, Holdings updatedHoldings,
            dynamic saving)?
        initial,
    TResult Function()? success,
    TResult Function()? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Holdings originalHoldings, Holdings updatedHoldings,
            dynamic saving)?
        initial,
    TResult Function()? success,
    TResult Function()? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Initial value) initial,
    required TResult Function(Success value) success,
    required TResult Function(Error value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(Initial value)? initial,
    TResult Function(Success value)? success,
    TResult Function(Error value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initial value)? initial,
    TResult Function(Success value)? success,
    TResult Function(Error value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UpdateFinancialsStateCopyWith<$Res> {
  factory $UpdateFinancialsStateCopyWith(UpdateFinancialsState value,
          $Res Function(UpdateFinancialsState) then) =
      _$UpdateFinancialsStateCopyWithImpl<$Res>;
}

/// @nodoc
class _$UpdateFinancialsStateCopyWithImpl<$Res>
    implements $UpdateFinancialsStateCopyWith<$Res> {
  _$UpdateFinancialsStateCopyWithImpl(this._value, this._then);

  final UpdateFinancialsState _value;
  // ignore: unused_field
  final $Res Function(UpdateFinancialsState) _then;
}

/// @nodoc
abstract class _$$InitialCopyWith<$Res> {
  factory _$$InitialCopyWith(_$Initial value, $Res Function(_$Initial) then) =
      __$$InitialCopyWithImpl<$Res>;
  $Res call(
      {Holdings originalHoldings, Holdings updatedHoldings, dynamic saving});
}

/// @nodoc
class __$$InitialCopyWithImpl<$Res>
    extends _$UpdateFinancialsStateCopyWithImpl<$Res>
    implements _$$InitialCopyWith<$Res> {
  __$$InitialCopyWithImpl(_$Initial _value, $Res Function(_$Initial) _then)
      : super(_value, (v) => _then(v as _$Initial));

  @override
  _$Initial get _value => super._value as _$Initial;

  @override
  $Res call({
    Object? originalHoldings = freezed,
    Object? updatedHoldings = freezed,
    Object? saving = freezed,
  }) {
    return _then(_$Initial(
      originalHoldings: originalHoldings == freezed
          ? _value.originalHoldings
          : originalHoldings // ignore: cast_nullable_to_non_nullable
              as Holdings,
      updatedHoldings: updatedHoldings == freezed
          ? _value.updatedHoldings
          : updatedHoldings // ignore: cast_nullable_to_non_nullable
              as Holdings,
      saving: saving == freezed ? _value.saving : saving,
    ));
  }
}

/// @nodoc

class _$Initial implements Initial {
  const _$Initial(
      {required this.originalHoldings,
      required this.updatedHoldings,
      this.saving = false});

  @override
  final Holdings originalHoldings;
  @override
  final Holdings updatedHoldings;
  @override
  @JsonKey()
  final dynamic saving;

  @override
  String toString() {
    return 'UpdateFinancialsState.initial(originalHoldings: $originalHoldings, updatedHoldings: $updatedHoldings, saving: $saving)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$Initial &&
            const DeepCollectionEquality()
                .equals(other.originalHoldings, originalHoldings) &&
            const DeepCollectionEquality()
                .equals(other.updatedHoldings, updatedHoldings) &&
            const DeepCollectionEquality().equals(other.saving, saving));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(originalHoldings),
      const DeepCollectionEquality().hash(updatedHoldings),
      const DeepCollectionEquality().hash(saving));

  @JsonKey(ignore: true)
  @override
  _$$InitialCopyWith<_$Initial> get copyWith =>
      __$$InitialCopyWithImpl<_$Initial>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            Holdings originalHoldings, Holdings updatedHoldings, dynamic saving)
        initial,
    required TResult Function() success,
    required TResult Function() error,
  }) {
    return initial(originalHoldings, updatedHoldings, saving);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(Holdings originalHoldings, Holdings updatedHoldings,
            dynamic saving)?
        initial,
    TResult Function()? success,
    TResult Function()? error,
  }) {
    return initial?.call(originalHoldings, updatedHoldings, saving);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Holdings originalHoldings, Holdings updatedHoldings,
            dynamic saving)?
        initial,
    TResult Function()? success,
    TResult Function()? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(originalHoldings, updatedHoldings, saving);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Initial value) initial,
    required TResult Function(Success value) success,
    required TResult Function(Error value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(Initial value)? initial,
    TResult Function(Success value)? success,
    TResult Function(Error value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initial value)? initial,
    TResult Function(Success value)? success,
    TResult Function(Error value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class Initial implements UpdateFinancialsState {
  const factory Initial(
      {required final Holdings originalHoldings,
      required final Holdings updatedHoldings,
      final dynamic saving}) = _$Initial;

  Holdings get originalHoldings;
  Holdings get updatedHoldings;
  dynamic get saving;
  @JsonKey(ignore: true)
  _$$InitialCopyWith<_$Initial> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SuccessCopyWith<$Res> {
  factory _$$SuccessCopyWith(_$Success value, $Res Function(_$Success) then) =
      __$$SuccessCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SuccessCopyWithImpl<$Res>
    extends _$UpdateFinancialsStateCopyWithImpl<$Res>
    implements _$$SuccessCopyWith<$Res> {
  __$$SuccessCopyWithImpl(_$Success _value, $Res Function(_$Success) _then)
      : super(_value, (v) => _then(v as _$Success));

  @override
  _$Success get _value => super._value as _$Success;
}

/// @nodoc

class _$Success implements Success {
  const _$Success();

  @override
  String toString() {
    return 'UpdateFinancialsState.success()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$Success);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            Holdings originalHoldings, Holdings updatedHoldings, dynamic saving)
        initial,
    required TResult Function() success,
    required TResult Function() error,
  }) {
    return success();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(Holdings originalHoldings, Holdings updatedHoldings,
            dynamic saving)?
        initial,
    TResult Function()? success,
    TResult Function()? error,
  }) {
    return success?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Holdings originalHoldings, Holdings updatedHoldings,
            dynamic saving)?
        initial,
    TResult Function()? success,
    TResult Function()? error,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Initial value) initial,
    required TResult Function(Success value) success,
    required TResult Function(Error value) error,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(Initial value)? initial,
    TResult Function(Success value)? success,
    TResult Function(Error value)? error,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initial value)? initial,
    TResult Function(Success value)? success,
    TResult Function(Error value)? error,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class Success implements UpdateFinancialsState {
  const factory Success() = _$Success;
}

/// @nodoc
abstract class _$$ErrorCopyWith<$Res> {
  factory _$$ErrorCopyWith(_$Error value, $Res Function(_$Error) then) =
      __$$ErrorCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ErrorCopyWithImpl<$Res>
    extends _$UpdateFinancialsStateCopyWithImpl<$Res>
    implements _$$ErrorCopyWith<$Res> {
  __$$ErrorCopyWithImpl(_$Error _value, $Res Function(_$Error) _then)
      : super(_value, (v) => _then(v as _$Error));

  @override
  _$Error get _value => super._value as _$Error;
}

/// @nodoc

class _$Error implements Error {
  const _$Error();

  @override
  String toString() {
    return 'UpdateFinancialsState.error()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$Error);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            Holdings originalHoldings, Holdings updatedHoldings, dynamic saving)
        initial,
    required TResult Function() success,
    required TResult Function() error,
  }) {
    return error();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(Holdings originalHoldings, Holdings updatedHoldings,
            dynamic saving)?
        initial,
    TResult Function()? success,
    TResult Function()? error,
  }) {
    return error?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Holdings originalHoldings, Holdings updatedHoldings,
            dynamic saving)?
        initial,
    TResult Function()? success,
    TResult Function()? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Initial value) initial,
    required TResult Function(Success value) success,
    required TResult Function(Error value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(Initial value)? initial,
    TResult Function(Success value)? success,
    TResult Function(Error value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initial value)? initial,
    TResult Function(Success value)? success,
    TResult Function(Error value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class Error implements UpdateFinancialsState {
  const factory Error() = _$Error;
}
