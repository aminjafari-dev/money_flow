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
  String get timePeriod => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String userId, String timePeriod)
        getDashboardData,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String userId, String timePeriod)? getDashboardData,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String userId, String timePeriod)? getDashboardData,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(GetDashboardData value) getDashboardData,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(GetDashboardData value)? getDashboardData,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(GetDashboardData value)? getDashboardData,
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
  $Res call({String userId, String timePeriod});
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
    Object? timePeriod = null,
  }) {
    return _then(_value.copyWith(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      timePeriod: null == timePeriod
          ? _value.timePeriod
          : timePeriod // ignore: cast_nullable_to_non_nullable
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
  $Res call({String userId, String timePeriod});
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
    Object? timePeriod = null,
  }) {
    return _then(_$GetDashboardDataImpl(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      timePeriod: null == timePeriod
          ? _value.timePeriod
          : timePeriod // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$GetDashboardDataImpl implements GetDashboardData {
  const _$GetDashboardDataImpl(
      {required this.userId, required this.timePeriod});

  @override
  final String userId;
  @override
  final String timePeriod;

  @override
  String toString() {
    return 'DashboardEvent.getDashboardData(userId: $userId, timePeriod: $timePeriod)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetDashboardDataImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.timePeriod, timePeriod) ||
                other.timePeriod == timePeriod));
  }

  @override
  int get hashCode => Object.hash(runtimeType, userId, timePeriod);

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
    required TResult Function(String userId, String timePeriod)
        getDashboardData,
  }) {
    return getDashboardData(userId, timePeriod);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String userId, String timePeriod)? getDashboardData,
  }) {
    return getDashboardData?.call(userId, timePeriod);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String userId, String timePeriod)? getDashboardData,
    required TResult orElse(),
  }) {
    if (getDashboardData != null) {
      return getDashboardData(userId, timePeriod);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(GetDashboardData value) getDashboardData,
  }) {
    return getDashboardData(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(GetDashboardData value)? getDashboardData,
  }) {
    return getDashboardData?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(GetDashboardData value)? getDashboardData,
    required TResult orElse(),
  }) {
    if (getDashboardData != null) {
      return getDashboardData(this);
    }
    return orElse();
  }
}

abstract class GetDashboardData implements DashboardEvent {
  const factory GetDashboardData(
      {required final String userId,
      required final String timePeriod}) = _$GetDashboardDataImpl;

  @override
  String get userId;
  @override
  String get timePeriod;

  /// Create a copy of DashboardEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GetDashboardDataImplCopyWith<_$GetDashboardDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
