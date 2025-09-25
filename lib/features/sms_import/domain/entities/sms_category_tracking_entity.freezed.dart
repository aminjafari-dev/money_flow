// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sms_category_tracking_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SmsCategoryTrackingEntity {
  String get smsId => throw _privateConstructorUsedError;
  String get category => throw _privateConstructorUsedError;
  String get mainCategory => throw _privateConstructorUsedError;
  DateTime get addedAt => throw _privateConstructorUsedError;
  String? get transactionId => throw _privateConstructorUsedError;

  /// Create a copy of SmsCategoryTrackingEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SmsCategoryTrackingEntityCopyWith<SmsCategoryTrackingEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SmsCategoryTrackingEntityCopyWith<$Res> {
  factory $SmsCategoryTrackingEntityCopyWith(SmsCategoryTrackingEntity value,
          $Res Function(SmsCategoryTrackingEntity) then) =
      _$SmsCategoryTrackingEntityCopyWithImpl<$Res, SmsCategoryTrackingEntity>;
  @useResult
  $Res call(
      {String smsId,
      String category,
      String mainCategory,
      DateTime addedAt,
      String? transactionId});
}

/// @nodoc
class _$SmsCategoryTrackingEntityCopyWithImpl<$Res,
        $Val extends SmsCategoryTrackingEntity>
    implements $SmsCategoryTrackingEntityCopyWith<$Res> {
  _$SmsCategoryTrackingEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SmsCategoryTrackingEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? smsId = null,
    Object? category = null,
    Object? mainCategory = null,
    Object? addedAt = null,
    Object? transactionId = freezed,
  }) {
    return _then(_value.copyWith(
      smsId: null == smsId
          ? _value.smsId
          : smsId // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      mainCategory: null == mainCategory
          ? _value.mainCategory
          : mainCategory // ignore: cast_nullable_to_non_nullable
              as String,
      addedAt: null == addedAt
          ? _value.addedAt
          : addedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      transactionId: freezed == transactionId
          ? _value.transactionId
          : transactionId // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SmsCategoryTrackingEntityImplCopyWith<$Res>
    implements $SmsCategoryTrackingEntityCopyWith<$Res> {
  factory _$$SmsCategoryTrackingEntityImplCopyWith(
          _$SmsCategoryTrackingEntityImpl value,
          $Res Function(_$SmsCategoryTrackingEntityImpl) then) =
      __$$SmsCategoryTrackingEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String smsId,
      String category,
      String mainCategory,
      DateTime addedAt,
      String? transactionId});
}

/// @nodoc
class __$$SmsCategoryTrackingEntityImplCopyWithImpl<$Res>
    extends _$SmsCategoryTrackingEntityCopyWithImpl<$Res,
        _$SmsCategoryTrackingEntityImpl>
    implements _$$SmsCategoryTrackingEntityImplCopyWith<$Res> {
  __$$SmsCategoryTrackingEntityImplCopyWithImpl(
      _$SmsCategoryTrackingEntityImpl _value,
      $Res Function(_$SmsCategoryTrackingEntityImpl) _then)
      : super(_value, _then);

  /// Create a copy of SmsCategoryTrackingEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? smsId = null,
    Object? category = null,
    Object? mainCategory = null,
    Object? addedAt = null,
    Object? transactionId = freezed,
  }) {
    return _then(_$SmsCategoryTrackingEntityImpl(
      smsId: null == smsId
          ? _value.smsId
          : smsId // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      mainCategory: null == mainCategory
          ? _value.mainCategory
          : mainCategory // ignore: cast_nullable_to_non_nullable
              as String,
      addedAt: null == addedAt
          ? _value.addedAt
          : addedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      transactionId: freezed == transactionId
          ? _value.transactionId
          : transactionId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$SmsCategoryTrackingEntityImpl implements _SmsCategoryTrackingEntity {
  const _$SmsCategoryTrackingEntityImpl(
      {required this.smsId,
      required this.category,
      required this.mainCategory,
      required this.addedAt,
      this.transactionId});

  @override
  final String smsId;
  @override
  final String category;
  @override
  final String mainCategory;
  @override
  final DateTime addedAt;
  @override
  final String? transactionId;

  @override
  String toString() {
    return 'SmsCategoryTrackingEntity(smsId: $smsId, category: $category, mainCategory: $mainCategory, addedAt: $addedAt, transactionId: $transactionId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SmsCategoryTrackingEntityImpl &&
            (identical(other.smsId, smsId) || other.smsId == smsId) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.mainCategory, mainCategory) ||
                other.mainCategory == mainCategory) &&
            (identical(other.addedAt, addedAt) || other.addedAt == addedAt) &&
            (identical(other.transactionId, transactionId) ||
                other.transactionId == transactionId));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, smsId, category, mainCategory, addedAt, transactionId);

  /// Create a copy of SmsCategoryTrackingEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SmsCategoryTrackingEntityImplCopyWith<_$SmsCategoryTrackingEntityImpl>
      get copyWith => __$$SmsCategoryTrackingEntityImplCopyWithImpl<
          _$SmsCategoryTrackingEntityImpl>(this, _$identity);
}

abstract class _SmsCategoryTrackingEntity implements SmsCategoryTrackingEntity {
  const factory _SmsCategoryTrackingEntity(
      {required final String smsId,
      required final String category,
      required final String mainCategory,
      required final DateTime addedAt,
      final String? transactionId}) = _$SmsCategoryTrackingEntityImpl;

  @override
  String get smsId;
  @override
  String get category;
  @override
  String get mainCategory;
  @override
  DateTime get addedAt;
  @override
  String? get transactionId;

  /// Create a copy of SmsCategoryTrackingEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SmsCategoryTrackingEntityImplCopyWith<_$SmsCategoryTrackingEntityImpl>
      get copyWith => throw _privateConstructorUsedError;
}
