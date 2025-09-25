// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sms_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SmsEntity {
  String get id => throw _privateConstructorUsedError;
  String get address => throw _privateConstructorUsedError;
  String get body => throw _privateConstructorUsedError;
  DateTime get date => throw _privateConstructorUsedError;
  bool get isRead => throw _privateConstructorUsedError;

  /// Create a copy of SmsEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SmsEntityCopyWith<SmsEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SmsEntityCopyWith<$Res> {
  factory $SmsEntityCopyWith(SmsEntity value, $Res Function(SmsEntity) then) =
      _$SmsEntityCopyWithImpl<$Res, SmsEntity>;
  @useResult
  $Res call(
      {String id, String address, String body, DateTime date, bool isRead});
}

/// @nodoc
class _$SmsEntityCopyWithImpl<$Res, $Val extends SmsEntity>
    implements $SmsEntityCopyWith<$Res> {
  _$SmsEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SmsEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? address = null,
    Object? body = null,
    Object? date = null,
    Object? isRead = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      body: null == body
          ? _value.body
          : body // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isRead: null == isRead
          ? _value.isRead
          : isRead // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SmsEntityImplCopyWith<$Res>
    implements $SmsEntityCopyWith<$Res> {
  factory _$$SmsEntityImplCopyWith(
          _$SmsEntityImpl value, $Res Function(_$SmsEntityImpl) then) =
      __$$SmsEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id, String address, String body, DateTime date, bool isRead});
}

/// @nodoc
class __$$SmsEntityImplCopyWithImpl<$Res>
    extends _$SmsEntityCopyWithImpl<$Res, _$SmsEntityImpl>
    implements _$$SmsEntityImplCopyWith<$Res> {
  __$$SmsEntityImplCopyWithImpl(
      _$SmsEntityImpl _value, $Res Function(_$SmsEntityImpl) _then)
      : super(_value, _then);

  /// Create a copy of SmsEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? address = null,
    Object? body = null,
    Object? date = null,
    Object? isRead = null,
  }) {
    return _then(_$SmsEntityImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      body: null == body
          ? _value.body
          : body // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isRead: null == isRead
          ? _value.isRead
          : isRead // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$SmsEntityImpl implements _SmsEntity {
  const _$SmsEntityImpl(
      {required this.id,
      required this.address,
      required this.body,
      required this.date,
      this.isRead = false});

  @override
  final String id;
  @override
  final String address;
  @override
  final String body;
  @override
  final DateTime date;
  @override
  @JsonKey()
  final bool isRead;

  @override
  String toString() {
    return 'SmsEntity(id: $id, address: $address, body: $body, date: $date, isRead: $isRead)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SmsEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.body, body) || other.body == body) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.isRead, isRead) || other.isRead == isRead));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, address, body, date, isRead);

  /// Create a copy of SmsEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SmsEntityImplCopyWith<_$SmsEntityImpl> get copyWith =>
      __$$SmsEntityImplCopyWithImpl<_$SmsEntityImpl>(this, _$identity);
}

abstract class _SmsEntity implements SmsEntity {
  const factory _SmsEntity(
      {required final String id,
      required final String address,
      required final String body,
      required final DateTime date,
      final bool isRead}) = _$SmsEntityImpl;

  @override
  String get id;
  @override
  String get address;
  @override
  String get body;
  @override
  DateTime get date;
  @override
  bool get isRead;

  /// Create a copy of SmsEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SmsEntityImplCopyWith<_$SmsEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$SmsConversationEntity {
  String get address => throw _privateConstructorUsedError;
  String get lastMessage => throw _privateConstructorUsedError;
  int get messageCount => throw _privateConstructorUsedError;
  DateTime get lastMessageDate => throw _privateConstructorUsedError;

  /// Create a copy of SmsConversationEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SmsConversationEntityCopyWith<SmsConversationEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SmsConversationEntityCopyWith<$Res> {
  factory $SmsConversationEntityCopyWith(SmsConversationEntity value,
          $Res Function(SmsConversationEntity) then) =
      _$SmsConversationEntityCopyWithImpl<$Res, SmsConversationEntity>;
  @useResult
  $Res call(
      {String address,
      String lastMessage,
      int messageCount,
      DateTime lastMessageDate});
}

/// @nodoc
class _$SmsConversationEntityCopyWithImpl<$Res,
        $Val extends SmsConversationEntity>
    implements $SmsConversationEntityCopyWith<$Res> {
  _$SmsConversationEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SmsConversationEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? address = null,
    Object? lastMessage = null,
    Object? messageCount = null,
    Object? lastMessageDate = null,
  }) {
    return _then(_value.copyWith(
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      lastMessage: null == lastMessage
          ? _value.lastMessage
          : lastMessage // ignore: cast_nullable_to_non_nullable
              as String,
      messageCount: null == messageCount
          ? _value.messageCount
          : messageCount // ignore: cast_nullable_to_non_nullable
              as int,
      lastMessageDate: null == lastMessageDate
          ? _value.lastMessageDate
          : lastMessageDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SmsConversationEntityImplCopyWith<$Res>
    implements $SmsConversationEntityCopyWith<$Res> {
  factory _$$SmsConversationEntityImplCopyWith(
          _$SmsConversationEntityImpl value,
          $Res Function(_$SmsConversationEntityImpl) then) =
      __$$SmsConversationEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String address,
      String lastMessage,
      int messageCount,
      DateTime lastMessageDate});
}

/// @nodoc
class __$$SmsConversationEntityImplCopyWithImpl<$Res>
    extends _$SmsConversationEntityCopyWithImpl<$Res,
        _$SmsConversationEntityImpl>
    implements _$$SmsConversationEntityImplCopyWith<$Res> {
  __$$SmsConversationEntityImplCopyWithImpl(_$SmsConversationEntityImpl _value,
      $Res Function(_$SmsConversationEntityImpl) _then)
      : super(_value, _then);

  /// Create a copy of SmsConversationEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? address = null,
    Object? lastMessage = null,
    Object? messageCount = null,
    Object? lastMessageDate = null,
  }) {
    return _then(_$SmsConversationEntityImpl(
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      lastMessage: null == lastMessage
          ? _value.lastMessage
          : lastMessage // ignore: cast_nullable_to_non_nullable
              as String,
      messageCount: null == messageCount
          ? _value.messageCount
          : messageCount // ignore: cast_nullable_to_non_nullable
              as int,
      lastMessageDate: null == lastMessageDate
          ? _value.lastMessageDate
          : lastMessageDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc

class _$SmsConversationEntityImpl implements _SmsConversationEntity {
  const _$SmsConversationEntityImpl(
      {required this.address,
      required this.lastMessage,
      required this.messageCount,
      required this.lastMessageDate});

  @override
  final String address;
  @override
  final String lastMessage;
  @override
  final int messageCount;
  @override
  final DateTime lastMessageDate;

  @override
  String toString() {
    return 'SmsConversationEntity(address: $address, lastMessage: $lastMessage, messageCount: $messageCount, lastMessageDate: $lastMessageDate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SmsConversationEntityImpl &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.lastMessage, lastMessage) ||
                other.lastMessage == lastMessage) &&
            (identical(other.messageCount, messageCount) ||
                other.messageCount == messageCount) &&
            (identical(other.lastMessageDate, lastMessageDate) ||
                other.lastMessageDate == lastMessageDate));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, address, lastMessage, messageCount, lastMessageDate);

  /// Create a copy of SmsConversationEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SmsConversationEntityImplCopyWith<_$SmsConversationEntityImpl>
      get copyWith => __$$SmsConversationEntityImplCopyWithImpl<
          _$SmsConversationEntityImpl>(this, _$identity);
}

abstract class _SmsConversationEntity implements SmsConversationEntity {
  const factory _SmsConversationEntity(
      {required final String address,
      required final String lastMessage,
      required final int messageCount,
      required final DateTime lastMessageDate}) = _$SmsConversationEntityImpl;

  @override
  String get address;
  @override
  String get lastMessage;
  @override
  int get messageCount;
  @override
  DateTime get lastMessageDate;

  /// Create a copy of SmsConversationEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SmsConversationEntityImplCopyWith<_$SmsConversationEntityImpl>
      get copyWith => throw _privateConstructorUsedError;
}
