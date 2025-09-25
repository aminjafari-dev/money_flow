// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bank_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$BankEntity {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get phoneNumber => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;

  /// Create a copy of BankEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BankEntityCopyWith<BankEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BankEntityCopyWith<$Res> {
  factory $BankEntityCopyWith(
          BankEntity value, $Res Function(BankEntity) then) =
      _$BankEntityCopyWithImpl<$Res, BankEntity>;
  @useResult
  $Res call({String id, String name, String phoneNumber, bool isActive});
}

/// @nodoc
class _$BankEntityCopyWithImpl<$Res, $Val extends BankEntity>
    implements $BankEntityCopyWith<$Res> {
  _$BankEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BankEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? phoneNumber = null,
    Object? isActive = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      phoneNumber: null == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BankEntityImplCopyWith<$Res>
    implements $BankEntityCopyWith<$Res> {
  factory _$$BankEntityImplCopyWith(
          _$BankEntityImpl value, $Res Function(_$BankEntityImpl) then) =
      __$$BankEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String name, String phoneNumber, bool isActive});
}

/// @nodoc
class __$$BankEntityImplCopyWithImpl<$Res>
    extends _$BankEntityCopyWithImpl<$Res, _$BankEntityImpl>
    implements _$$BankEntityImplCopyWith<$Res> {
  __$$BankEntityImplCopyWithImpl(
      _$BankEntityImpl _value, $Res Function(_$BankEntityImpl) _then)
      : super(_value, _then);

  /// Create a copy of BankEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? phoneNumber = null,
    Object? isActive = null,
  }) {
    return _then(_$BankEntityImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      phoneNumber: null == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$BankEntityImpl implements _BankEntity {
  const _$BankEntityImpl(
      {required this.id,
      required this.name,
      required this.phoneNumber,
      this.isActive = true});

  @override
  final String id;
  @override
  final String name;
  @override
  final String phoneNumber;
  @override
  @JsonKey()
  final bool isActive;

  @override
  String toString() {
    return 'BankEntity(id: $id, name: $name, phoneNumber: $phoneNumber, isActive: $isActive)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BankEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, name, phoneNumber, isActive);

  /// Create a copy of BankEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BankEntityImplCopyWith<_$BankEntityImpl> get copyWith =>
      __$$BankEntityImplCopyWithImpl<_$BankEntityImpl>(this, _$identity);
}

abstract class _BankEntity implements BankEntity {
  const factory _BankEntity(
      {required final String id,
      required final String name,
      required final String phoneNumber,
      final bool isActive}) = _$BankEntityImpl;

  @override
  String get id;
  @override
  String get name;
  @override
  String get phoneNumber;
  @override
  bool get isActive;

  /// Create a copy of BankEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BankEntityImplCopyWith<_$BankEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
