// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'add_update_item_instruction.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$AddUpdateItemInstruction {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(FinancialItem item) add,
    required TResult Function(
            String idOfItem, String? newName, double? newValue)
        update,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(FinancialItem item)? add,
    TResult Function(String idOfItem, String? newName, double? newValue)?
        update,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(FinancialItem item)? add,
    TResult Function(String idOfItem, String? newName, double? newValue)?
        update,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Add value) add,
    required TResult Function(Update value) update,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(Add value)? add,
    TResult Function(Update value)? update,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Add value)? add,
    TResult Function(Update value)? update,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AddUpdateItemInstructionCopyWith<$Res> {
  factory $AddUpdateItemInstructionCopyWith(AddUpdateItemInstruction value,
          $Res Function(AddUpdateItemInstruction) then) =
      _$AddUpdateItemInstructionCopyWithImpl<$Res>;
}

/// @nodoc
class _$AddUpdateItemInstructionCopyWithImpl<$Res>
    implements $AddUpdateItemInstructionCopyWith<$Res> {
  _$AddUpdateItemInstructionCopyWithImpl(this._value, this._then);

  final AddUpdateItemInstruction _value;
  // ignore: unused_field
  final $Res Function(AddUpdateItemInstruction) _then;
}

/// @nodoc
abstract class _$$AddCopyWith<$Res> {
  factory _$$AddCopyWith(_$Add value, $Res Function(_$Add) then) =
      __$$AddCopyWithImpl<$Res>;
  $Res call({FinancialItem item});
}

/// @nodoc
class __$$AddCopyWithImpl<$Res>
    extends _$AddUpdateItemInstructionCopyWithImpl<$Res>
    implements _$$AddCopyWith<$Res> {
  __$$AddCopyWithImpl(_$Add _value, $Res Function(_$Add) _then)
      : super(_value, (v) => _then(v as _$Add));

  @override
  _$Add get _value => super._value as _$Add;

  @override
  $Res call({
    Object? item = freezed,
  }) {
    return _then(_$Add(
      item: item == freezed
          ? _value.item
          : item // ignore: cast_nullable_to_non_nullable
              as FinancialItem,
    ));
  }
}

/// @nodoc

class _$Add implements Add {
  const _$Add({required this.item});

  @override
  final FinancialItem item;

  @override
  String toString() {
    return 'AddUpdateItemInstruction.add(item: $item)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$Add &&
            const DeepCollectionEquality().equals(other.item, item));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(item));

  @JsonKey(ignore: true)
  @override
  _$$AddCopyWith<_$Add> get copyWith =>
      __$$AddCopyWithImpl<_$Add>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(FinancialItem item) add,
    required TResult Function(
            String idOfItem, String? newName, double? newValue)
        update,
  }) {
    return add(item);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(FinancialItem item)? add,
    TResult Function(String idOfItem, String? newName, double? newValue)?
        update,
  }) {
    return add?.call(item);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(FinancialItem item)? add,
    TResult Function(String idOfItem, String? newName, double? newValue)?
        update,
    required TResult orElse(),
  }) {
    if (add != null) {
      return add(item);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Add value) add,
    required TResult Function(Update value) update,
  }) {
    return add(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(Add value)? add,
    TResult Function(Update value)? update,
  }) {
    return add?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Add value)? add,
    TResult Function(Update value)? update,
    required TResult orElse(),
  }) {
    if (add != null) {
      return add(this);
    }
    return orElse();
  }
}

abstract class Add implements AddUpdateItemInstruction {
  const factory Add({required final FinancialItem item}) = _$Add;

  FinancialItem get item;
  @JsonKey(ignore: true)
  _$$AddCopyWith<_$Add> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UpdateCopyWith<$Res> {
  factory _$$UpdateCopyWith(_$Update value, $Res Function(_$Update) then) =
      __$$UpdateCopyWithImpl<$Res>;
  $Res call({String idOfItem, String? newName, double? newValue});
}

/// @nodoc
class __$$UpdateCopyWithImpl<$Res>
    extends _$AddUpdateItemInstructionCopyWithImpl<$Res>
    implements _$$UpdateCopyWith<$Res> {
  __$$UpdateCopyWithImpl(_$Update _value, $Res Function(_$Update) _then)
      : super(_value, (v) => _then(v as _$Update));

  @override
  _$Update get _value => super._value as _$Update;

  @override
  $Res call({
    Object? idOfItem = freezed,
    Object? newName = freezed,
    Object? newValue = freezed,
  }) {
    return _then(_$Update(
      idOfItem: idOfItem == freezed
          ? _value.idOfItem
          : idOfItem // ignore: cast_nullable_to_non_nullable
              as String,
      newName: newName == freezed
          ? _value.newName
          : newName // ignore: cast_nullable_to_non_nullable
              as String?,
      newValue: newValue == freezed
          ? _value.newValue
          : newValue // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc

class _$Update implements Update {
  const _$Update({required this.idOfItem, this.newName, this.newValue});

  @override
  final String idOfItem;
  @override
  final String? newName;
  @override
  final double? newValue;

  @override
  String toString() {
    return 'AddUpdateItemInstruction.update(idOfItem: $idOfItem, newName: $newName, newValue: $newValue)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$Update &&
            const DeepCollectionEquality().equals(other.idOfItem, idOfItem) &&
            const DeepCollectionEquality().equals(other.newName, newName) &&
            const DeepCollectionEquality().equals(other.newValue, newValue));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(idOfItem),
      const DeepCollectionEquality().hash(newName),
      const DeepCollectionEquality().hash(newValue));

  @JsonKey(ignore: true)
  @override
  _$$UpdateCopyWith<_$Update> get copyWith =>
      __$$UpdateCopyWithImpl<_$Update>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(FinancialItem item) add,
    required TResult Function(
            String idOfItem, String? newName, double? newValue)
        update,
  }) {
    return update(idOfItem, newName, newValue);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(FinancialItem item)? add,
    TResult Function(String idOfItem, String? newName, double? newValue)?
        update,
  }) {
    return update?.call(idOfItem, newName, newValue);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(FinancialItem item)? add,
    TResult Function(String idOfItem, String? newName, double? newValue)?
        update,
    required TResult orElse(),
  }) {
    if (update != null) {
      return update(idOfItem, newName, newValue);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Add value) add,
    required TResult Function(Update value) update,
  }) {
    return update(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(Add value)? add,
    TResult Function(Update value)? update,
  }) {
    return update?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Add value)? add,
    TResult Function(Update value)? update,
    required TResult orElse(),
  }) {
    if (update != null) {
      return update(this);
    }
    return orElse();
  }
}

abstract class Update implements AddUpdateItemInstruction {
  const factory Update(
      {required final String idOfItem,
      final String? newName,
      final double? newValue}) = _$Update;

  String get idOfItem;
  String? get newName;
  double? get newValue;
  @JsonKey(ignore: true)
  _$$UpdateCopyWith<_$Update> get copyWith =>
      throw _privateConstructorUsedError;
}
