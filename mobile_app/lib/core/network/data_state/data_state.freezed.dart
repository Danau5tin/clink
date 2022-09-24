// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'data_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$DataState<T, F> {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(T data) success,
    required TResult Function(F? failureInfo, Exception? exception) failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(T data)? success,
    TResult Function(F? failureInfo, Exception? exception)? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(T data)? success,
    TResult Function(F? failureInfo, Exception? exception)? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Success<T, F> value) success,
    required TResult Function(Failure<T, F> value) failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(Success<T, F> value)? success,
    TResult Function(Failure<T, F> value)? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Success<T, F> value)? success,
    TResult Function(Failure<T, F> value)? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DataStateCopyWith<T, F, $Res> {
  factory $DataStateCopyWith(
          DataState<T, F> value, $Res Function(DataState<T, F>) then) =
      _$DataStateCopyWithImpl<T, F, $Res>;
}

/// @nodoc
class _$DataStateCopyWithImpl<T, F, $Res>
    implements $DataStateCopyWith<T, F, $Res> {
  _$DataStateCopyWithImpl(this._value, this._then);

  final DataState<T, F> _value;
  // ignore: unused_field
  final $Res Function(DataState<T, F>) _then;
}

/// @nodoc
abstract class _$$SuccessCopyWith<T, F, $Res> {
  factory _$$SuccessCopyWith(
          _$Success<T, F> value, $Res Function(_$Success<T, F>) then) =
      __$$SuccessCopyWithImpl<T, F, $Res>;
  $Res call({T data});
}

/// @nodoc
class __$$SuccessCopyWithImpl<T, F, $Res>
    extends _$DataStateCopyWithImpl<T, F, $Res>
    implements _$$SuccessCopyWith<T, F, $Res> {
  __$$SuccessCopyWithImpl(
      _$Success<T, F> _value, $Res Function(_$Success<T, F>) _then)
      : super(_value, (v) => _then(v as _$Success<T, F>));

  @override
  _$Success<T, F> get _value => super._value as _$Success<T, F>;

  @override
  $Res call({
    Object? data = freezed,
  }) {
    return _then(_$Success<T, F>(
      data == freezed
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as T,
    ));
  }
}

/// @nodoc

class _$Success<T, F> implements Success<T, F> {
  const _$Success(this.data);

  @override
  final T data;

  @override
  String toString() {
    return 'DataState<$T, $F>.success(data: $data)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$Success<T, F> &&
            const DeepCollectionEquality().equals(other.data, data));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(data));

  @JsonKey(ignore: true)
  @override
  _$$SuccessCopyWith<T, F, _$Success<T, F>> get copyWith =>
      __$$SuccessCopyWithImpl<T, F, _$Success<T, F>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(T data) success,
    required TResult Function(F? failureInfo, Exception? exception) failure,
  }) {
    return success(data);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(T data)? success,
    TResult Function(F? failureInfo, Exception? exception)? failure,
  }) {
    return success?.call(data);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(T data)? success,
    TResult Function(F? failureInfo, Exception? exception)? failure,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(data);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Success<T, F> value) success,
    required TResult Function(Failure<T, F> value) failure,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(Success<T, F> value)? success,
    TResult Function(Failure<T, F> value)? failure,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Success<T, F> value)? success,
    TResult Function(Failure<T, F> value)? failure,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class Success<T, F> implements DataState<T, F> {
  const factory Success(final T data) = _$Success<T, F>;

  T get data;
  @JsonKey(ignore: true)
  _$$SuccessCopyWith<T, F, _$Success<T, F>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$FailureCopyWith<T, F, $Res> {
  factory _$$FailureCopyWith(
          _$Failure<T, F> value, $Res Function(_$Failure<T, F>) then) =
      __$$FailureCopyWithImpl<T, F, $Res>;
  $Res call({F? failureInfo, Exception? exception});
}

/// @nodoc
class __$$FailureCopyWithImpl<T, F, $Res>
    extends _$DataStateCopyWithImpl<T, F, $Res>
    implements _$$FailureCopyWith<T, F, $Res> {
  __$$FailureCopyWithImpl(
      _$Failure<T, F> _value, $Res Function(_$Failure<T, F>) _then)
      : super(_value, (v) => _then(v as _$Failure<T, F>));

  @override
  _$Failure<T, F> get _value => super._value as _$Failure<T, F>;

  @override
  $Res call({
    Object? failureInfo = freezed,
    Object? exception = freezed,
  }) {
    return _then(_$Failure<T, F>(
      failureInfo: failureInfo == freezed
          ? _value.failureInfo
          : failureInfo // ignore: cast_nullable_to_non_nullable
              as F?,
      exception: exception == freezed
          ? _value.exception
          : exception // ignore: cast_nullable_to_non_nullable
              as Exception?,
    ));
  }
}

/// @nodoc

class _$Failure<T, F> implements Failure<T, F> {
  const _$Failure({this.failureInfo, this.exception});

  @override
  final F? failureInfo;
  @override
  final Exception? exception;

  @override
  String toString() {
    return 'DataState<$T, $F>.failure(failureInfo: $failureInfo, exception: $exception)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$Failure<T, F> &&
            const DeepCollectionEquality()
                .equals(other.failureInfo, failureInfo) &&
            const DeepCollectionEquality().equals(other.exception, exception));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(failureInfo),
      const DeepCollectionEquality().hash(exception));

  @JsonKey(ignore: true)
  @override
  _$$FailureCopyWith<T, F, _$Failure<T, F>> get copyWith =>
      __$$FailureCopyWithImpl<T, F, _$Failure<T, F>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(T data) success,
    required TResult Function(F? failureInfo, Exception? exception) failure,
  }) {
    return failure(failureInfo, exception);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(T data)? success,
    TResult Function(F? failureInfo, Exception? exception)? failure,
  }) {
    return failure?.call(failureInfo, exception);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(T data)? success,
    TResult Function(F? failureInfo, Exception? exception)? failure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(failureInfo, exception);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Success<T, F> value) success,
    required TResult Function(Failure<T, F> value) failure,
  }) {
    return failure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(Success<T, F> value)? success,
    TResult Function(Failure<T, F> value)? failure,
  }) {
    return failure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Success<T, F> value)? success,
    TResult Function(Failure<T, F> value)? failure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(this);
    }
    return orElse();
  }
}

abstract class Failure<T, F> implements DataState<T, F> {
  const factory Failure({final F? failureInfo, final Exception? exception}) =
      _$Failure<T, F>;

  F? get failureInfo;
  Exception? get exception;
  @JsonKey(ignore: true)
  _$$FailureCopyWith<T, F, _$Failure<T, F>> get copyWith =>
      throw _privateConstructorUsedError;
}
