// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dashboard_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$DashboardEvent {
  String get userId => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String userId) getDashboardData,
    required TResult Function(String userId) refreshDashboardData,
    required TResult Function(String userId) getCachedDashboardData,
    required TResult Function(String userId, Map<String, dynamic> dashboard)
        updateDashboardData,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String userId)? getDashboardData,
    TResult? Function(String userId)? refreshDashboardData,
    TResult? Function(String userId)? getCachedDashboardData,
    TResult? Function(String userId, Map<String, dynamic> dashboard)?
        updateDashboardData,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String userId)? getDashboardData,
    TResult Function(String userId)? refreshDashboardData,
    TResult Function(String userId)? getCachedDashboardData,
    TResult Function(String userId, Map<String, dynamic> dashboard)?
        updateDashboardData,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(GetDashboardData value) getDashboardData,
    required TResult Function(RefreshDashboardData value) refreshDashboardData,
    required TResult Function(GetCachedDashboardData value)
        getCachedDashboardData,
    required TResult Function(UpdateDashboardData value) updateDashboardData,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(GetDashboardData value)? getDashboardData,
    TResult? Function(RefreshDashboardData value)? refreshDashboardData,
    TResult? Function(GetCachedDashboardData value)? getCachedDashboardData,
    TResult? Function(UpdateDashboardData value)? updateDashboardData,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(GetDashboardData value)? getDashboardData,
    TResult Function(RefreshDashboardData value)? refreshDashboardData,
    TResult Function(GetCachedDashboardData value)? getCachedDashboardData,
    TResult Function(UpdateDashboardData value)? updateDashboardData,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Create a copy of DashboardEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DashboardEventCopyWith<DashboardEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DashboardEventCopyWith<$Res> {
  factory $DashboardEventCopyWith(
          DashboardEvent value, $Res Function(DashboardEvent) then) =
      _$DashboardEventCopyWithImpl<$Res, DashboardEvent>;
  @useResult
  $Res call({String userId});
}

/// @nodoc
class _$DashboardEventCopyWithImpl<$Res, $Val extends DashboardEvent>
    implements $DashboardEventCopyWith<$Res> {
  _$DashboardEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DashboardEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
  }) {
    return _then(_value.copyWith(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GetDashboardDataImplCopyWith<$Res>
    implements $DashboardEventCopyWith<$Res> {
  factory _$$GetDashboardDataImplCopyWith(_$GetDashboardDataImpl value,
          $Res Function(_$GetDashboardDataImpl) then) =
      __$$GetDashboardDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String userId});
}

/// @nodoc
class __$$GetDashboardDataImplCopyWithImpl<$Res>
    extends _$DashboardEventCopyWithImpl<$Res, _$GetDashboardDataImpl>
    implements _$$GetDashboardDataImplCopyWith<$Res> {
  __$$GetDashboardDataImplCopyWithImpl(_$GetDashboardDataImpl _value,
      $Res Function(_$GetDashboardDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of DashboardEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
  }) {
    return _then(_$GetDashboardDataImpl(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$GetDashboardDataImpl implements GetDashboardData {
  const _$GetDashboardDataImpl({required this.userId});

  @override
  final String userId;

  @override
  String toString() {
    return 'DashboardEvent.getDashboardData(userId: $userId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetDashboardDataImpl &&
            (identical(other.userId, userId) || other.userId == userId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, userId);

  /// Create a copy of DashboardEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GetDashboardDataImplCopyWith<_$GetDashboardDataImpl> get copyWith =>
      __$$GetDashboardDataImplCopyWithImpl<_$GetDashboardDataImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String userId) getDashboardData,
    required TResult Function(String userId) refreshDashboardData,
    required TResult Function(String userId) getCachedDashboardData,
    required TResult Function(String userId, Map<String, dynamic> dashboard)
        updateDashboardData,
  }) {
    return getDashboardData(userId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String userId)? getDashboardData,
    TResult? Function(String userId)? refreshDashboardData,
    TResult? Function(String userId)? getCachedDashboardData,
    TResult? Function(String userId, Map<String, dynamic> dashboard)?
        updateDashboardData,
  }) {
    return getDashboardData?.call(userId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String userId)? getDashboardData,
    TResult Function(String userId)? refreshDashboardData,
    TResult Function(String userId)? getCachedDashboardData,
    TResult Function(String userId, Map<String, dynamic> dashboard)?
        updateDashboardData,
    required TResult orElse(),
  }) {
    if (getDashboardData != null) {
      return getDashboardData(userId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(GetDashboardData value) getDashboardData,
    required TResult Function(RefreshDashboardData value) refreshDashboardData,
    required TResult Function(GetCachedDashboardData value)
        getCachedDashboardData,
    required TResult Function(UpdateDashboardData value) updateDashboardData,
  }) {
    return getDashboardData(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(GetDashboardData value)? getDashboardData,
    TResult? Function(RefreshDashboardData value)? refreshDashboardData,
    TResult? Function(GetCachedDashboardData value)? getCachedDashboardData,
    TResult? Function(UpdateDashboardData value)? updateDashboardData,
  }) {
    return getDashboardData?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(GetDashboardData value)? getDashboardData,
    TResult Function(RefreshDashboardData value)? refreshDashboardData,
    TResult Function(GetCachedDashboardData value)? getCachedDashboardData,
    TResult Function(UpdateDashboardData value)? updateDashboardData,
    required TResult orElse(),
  }) {
    if (getDashboardData != null) {
      return getDashboardData(this);
    }
    return orElse();
  }
}

abstract class GetDashboardData implements DashboardEvent {
  const factory GetDashboardData({required final String userId}) =
      _$GetDashboardDataImpl;

  @override
  String get userId;

  /// Create a copy of DashboardEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GetDashboardDataImplCopyWith<_$GetDashboardDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$RefreshDashboardDataImplCopyWith<$Res>
    implements $DashboardEventCopyWith<$Res> {
  factory _$$RefreshDashboardDataImplCopyWith(_$RefreshDashboardDataImpl value,
          $Res Function(_$RefreshDashboardDataImpl) then) =
      __$$RefreshDashboardDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String userId});
}

/// @nodoc
class __$$RefreshDashboardDataImplCopyWithImpl<$Res>
    extends _$DashboardEventCopyWithImpl<$Res, _$RefreshDashboardDataImpl>
    implements _$$RefreshDashboardDataImplCopyWith<$Res> {
  __$$RefreshDashboardDataImplCopyWithImpl(_$RefreshDashboardDataImpl _value,
      $Res Function(_$RefreshDashboardDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of DashboardEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
  }) {
    return _then(_$RefreshDashboardDataImpl(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$RefreshDashboardDataImpl implements RefreshDashboardData {
  const _$RefreshDashboardDataImpl({required this.userId});

  @override
  final String userId;

  @override
  String toString() {
    return 'DashboardEvent.refreshDashboardData(userId: $userId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RefreshDashboardDataImpl &&
            (identical(other.userId, userId) || other.userId == userId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, userId);

  /// Create a copy of DashboardEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RefreshDashboardDataImplCopyWith<_$RefreshDashboardDataImpl>
      get copyWith =>
          __$$RefreshDashboardDataImplCopyWithImpl<_$RefreshDashboardDataImpl>(
              this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String userId) getDashboardData,
    required TResult Function(String userId) refreshDashboardData,
    required TResult Function(String userId) getCachedDashboardData,
    required TResult Function(String userId, Map<String, dynamic> dashboard)
        updateDashboardData,
  }) {
    return refreshDashboardData(userId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String userId)? getDashboardData,
    TResult? Function(String userId)? refreshDashboardData,
    TResult? Function(String userId)? getCachedDashboardData,
    TResult? Function(String userId, Map<String, dynamic> dashboard)?
        updateDashboardData,
  }) {
    return refreshDashboardData?.call(userId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String userId)? getDashboardData,
    TResult Function(String userId)? refreshDashboardData,
    TResult Function(String userId)? getCachedDashboardData,
    TResult Function(String userId, Map<String, dynamic> dashboard)?
        updateDashboardData,
    required TResult orElse(),
  }) {
    if (refreshDashboardData != null) {
      return refreshDashboardData(userId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(GetDashboardData value) getDashboardData,
    required TResult Function(RefreshDashboardData value) refreshDashboardData,
    required TResult Function(GetCachedDashboardData value)
        getCachedDashboardData,
    required TResult Function(UpdateDashboardData value) updateDashboardData,
  }) {
    return refreshDashboardData(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(GetDashboardData value)? getDashboardData,
    TResult? Function(RefreshDashboardData value)? refreshDashboardData,
    TResult? Function(GetCachedDashboardData value)? getCachedDashboardData,
    TResult? Function(UpdateDashboardData value)? updateDashboardData,
  }) {
    return refreshDashboardData?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(GetDashboardData value)? getDashboardData,
    TResult Function(RefreshDashboardData value)? refreshDashboardData,
    TResult Function(GetCachedDashboardData value)? getCachedDashboardData,
    TResult Function(UpdateDashboardData value)? updateDashboardData,
    required TResult orElse(),
  }) {
    if (refreshDashboardData != null) {
      return refreshDashboardData(this);
    }
    return orElse();
  }
}

abstract class RefreshDashboardData implements DashboardEvent {
  const factory RefreshDashboardData({required final String userId}) =
      _$RefreshDashboardDataImpl;

  @override
  String get userId;

  /// Create a copy of DashboardEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RefreshDashboardDataImplCopyWith<_$RefreshDashboardDataImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$GetCachedDashboardDataImplCopyWith<$Res>
    implements $DashboardEventCopyWith<$Res> {
  factory _$$GetCachedDashboardDataImplCopyWith(
          _$GetCachedDashboardDataImpl value,
          $Res Function(_$GetCachedDashboardDataImpl) then) =
      __$$GetCachedDashboardDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String userId});
}

/// @nodoc
class __$$GetCachedDashboardDataImplCopyWithImpl<$Res>
    extends _$DashboardEventCopyWithImpl<$Res, _$GetCachedDashboardDataImpl>
    implements _$$GetCachedDashboardDataImplCopyWith<$Res> {
  __$$GetCachedDashboardDataImplCopyWithImpl(
      _$GetCachedDashboardDataImpl _value,
      $Res Function(_$GetCachedDashboardDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of DashboardEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
  }) {
    return _then(_$GetCachedDashboardDataImpl(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$GetCachedDashboardDataImpl implements GetCachedDashboardData {
  const _$GetCachedDashboardDataImpl({required this.userId});

  @override
  final String userId;

  @override
  String toString() {
    return 'DashboardEvent.getCachedDashboardData(userId: $userId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetCachedDashboardDataImpl &&
            (identical(other.userId, userId) || other.userId == userId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, userId);

  /// Create a copy of DashboardEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GetCachedDashboardDataImplCopyWith<_$GetCachedDashboardDataImpl>
      get copyWith => __$$GetCachedDashboardDataImplCopyWithImpl<
          _$GetCachedDashboardDataImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String userId) getDashboardData,
    required TResult Function(String userId) refreshDashboardData,
    required TResult Function(String userId) getCachedDashboardData,
    required TResult Function(String userId, Map<String, dynamic> dashboard)
        updateDashboardData,
  }) {
    return getCachedDashboardData(userId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String userId)? getDashboardData,
    TResult? Function(String userId)? refreshDashboardData,
    TResult? Function(String userId)? getCachedDashboardData,
    TResult? Function(String userId, Map<String, dynamic> dashboard)?
        updateDashboardData,
  }) {
    return getCachedDashboardData?.call(userId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String userId)? getDashboardData,
    TResult Function(String userId)? refreshDashboardData,
    TResult Function(String userId)? getCachedDashboardData,
    TResult Function(String userId, Map<String, dynamic> dashboard)?
        updateDashboardData,
    required TResult orElse(),
  }) {
    if (getCachedDashboardData != null) {
      return getCachedDashboardData(userId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(GetDashboardData value) getDashboardData,
    required TResult Function(RefreshDashboardData value) refreshDashboardData,
    required TResult Function(GetCachedDashboardData value)
        getCachedDashboardData,
    required TResult Function(UpdateDashboardData value) updateDashboardData,
  }) {
    return getCachedDashboardData(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(GetDashboardData value)? getDashboardData,
    TResult? Function(RefreshDashboardData value)? refreshDashboardData,
    TResult? Function(GetCachedDashboardData value)? getCachedDashboardData,
    TResult? Function(UpdateDashboardData value)? updateDashboardData,
  }) {
    return getCachedDashboardData?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(GetDashboardData value)? getDashboardData,
    TResult Function(RefreshDashboardData value)? refreshDashboardData,
    TResult Function(GetCachedDashboardData value)? getCachedDashboardData,
    TResult Function(UpdateDashboardData value)? updateDashboardData,
    required TResult orElse(),
  }) {
    if (getCachedDashboardData != null) {
      return getCachedDashboardData(this);
    }
    return orElse();
  }
}

abstract class GetCachedDashboardData implements DashboardEvent {
  const factory GetCachedDashboardData({required final String userId}) =
      _$GetCachedDashboardDataImpl;

  @override
  String get userId;

  /// Create a copy of DashboardEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GetCachedDashboardDataImplCopyWith<_$GetCachedDashboardDataImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UpdateDashboardDataImplCopyWith<$Res>
    implements $DashboardEventCopyWith<$Res> {
  factory _$$UpdateDashboardDataImplCopyWith(_$UpdateDashboardDataImpl value,
          $Res Function(_$UpdateDashboardDataImpl) then) =
      __$$UpdateDashboardDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String userId, Map<String, dynamic> dashboard});
}

/// @nodoc
class __$$UpdateDashboardDataImplCopyWithImpl<$Res>
    extends _$DashboardEventCopyWithImpl<$Res, _$UpdateDashboardDataImpl>
    implements _$$UpdateDashboardDataImplCopyWith<$Res> {
  __$$UpdateDashboardDataImplCopyWithImpl(_$UpdateDashboardDataImpl _value,
      $Res Function(_$UpdateDashboardDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of DashboardEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? dashboard = null,
  }) {
    return _then(_$UpdateDashboardDataImpl(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      dashboard: null == dashboard
          ? _value._dashboard
          : dashboard // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc

class _$UpdateDashboardDataImpl implements UpdateDashboardData {
  const _$UpdateDashboardDataImpl(
      {required this.userId, required final Map<String, dynamic> dashboard})
      : _dashboard = dashboard;

  @override
  final String userId;
  final Map<String, dynamic> _dashboard;
  @override
  Map<String, dynamic> get dashboard {
    if (_dashboard is EqualUnmodifiableMapView) return _dashboard;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_dashboard);
  }

  @override
  String toString() {
    return 'DashboardEvent.updateDashboardData(userId: $userId, dashboard: $dashboard)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateDashboardDataImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            const DeepCollectionEquality()
                .equals(other._dashboard, _dashboard));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, userId, const DeepCollectionEquality().hash(_dashboard));

  /// Create a copy of DashboardEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateDashboardDataImplCopyWith<_$UpdateDashboardDataImpl> get copyWith =>
      __$$UpdateDashboardDataImplCopyWithImpl<_$UpdateDashboardDataImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String userId) getDashboardData,
    required TResult Function(String userId) refreshDashboardData,
    required TResult Function(String userId) getCachedDashboardData,
    required TResult Function(String userId, Map<String, dynamic> dashboard)
        updateDashboardData,
  }) {
    return updateDashboardData(userId, dashboard);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String userId)? getDashboardData,
    TResult? Function(String userId)? refreshDashboardData,
    TResult? Function(String userId)? getCachedDashboardData,
    TResult? Function(String userId, Map<String, dynamic> dashboard)?
        updateDashboardData,
  }) {
    return updateDashboardData?.call(userId, dashboard);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String userId)? getDashboardData,
    TResult Function(String userId)? refreshDashboardData,
    TResult Function(String userId)? getCachedDashboardData,
    TResult Function(String userId, Map<String, dynamic> dashboard)?
        updateDashboardData,
    required TResult orElse(),
  }) {
    if (updateDashboardData != null) {
      return updateDashboardData(userId, dashboard);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(GetDashboardData value) getDashboardData,
    required TResult Function(RefreshDashboardData value) refreshDashboardData,
    required TResult Function(GetCachedDashboardData value)
        getCachedDashboardData,
    required TResult Function(UpdateDashboardData value) updateDashboardData,
  }) {
    return updateDashboardData(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(GetDashboardData value)? getDashboardData,
    TResult? Function(RefreshDashboardData value)? refreshDashboardData,
    TResult? Function(GetCachedDashboardData value)? getCachedDashboardData,
    TResult? Function(UpdateDashboardData value)? updateDashboardData,
  }) {
    return updateDashboardData?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(GetDashboardData value)? getDashboardData,
    TResult Function(RefreshDashboardData value)? refreshDashboardData,
    TResult Function(GetCachedDashboardData value)? getCachedDashboardData,
    TResult Function(UpdateDashboardData value)? updateDashboardData,
    required TResult orElse(),
  }) {
    if (updateDashboardData != null) {
      return updateDashboardData(this);
    }
    return orElse();
  }
}

abstract class UpdateDashboardData implements DashboardEvent {
  const factory UpdateDashboardData(
          {required final String userId,
          required final Map<String, dynamic> dashboard}) =
      _$UpdateDashboardDataImpl;

  @override
  String get userId;
  Map<String, dynamic> get dashboard;

  /// Create a copy of DashboardEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdateDashboardDataImplCopyWith<_$UpdateDashboardDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
