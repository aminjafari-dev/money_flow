// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sms_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SmsModel _$SmsModelFromJson(Map<String, dynamic> json) {
  return _SmsModel.fromJson(json);
}

/// @nodoc
mixin _$SmsModel {
  String get id => throw _privateConstructorUsedError;
  String get address => throw _privateConstructorUsedError;
  String get body => throw _privateConstructorUsedError;
  int get date => throw _privateConstructorUsedError;
  bool get isRead => throw _privateConstructorUsedError;

  /// Serializes this SmsModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SmsModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SmsModelCopyWith<SmsModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SmsModelCopyWith<$Res> {
  factory $SmsModelCopyWith(SmsModel value, $Res Function(SmsModel) then) =
      _$SmsModelCopyWithImpl<$Res, SmsModel>;
  @useResult
  $Res call({String id, String address, String body, int date, bool isRead});
}

/// @nodoc
class _$SmsModelCopyWithImpl<$Res, $Val extends SmsModel>
    implements $SmsModelCopyWith<$Res> {
  _$SmsModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SmsModel
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
              as int,
      isRead: null == isRead
          ? _value.isRead
          : isRead // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SmsModelImplCopyWith<$Res>
    implements $SmsModelCopyWith<$Res> {
  factory _$$SmsModelImplCopyWith(
          _$SmsModelImpl value, $Res Function(_$SmsModelImpl) then) =
      __$$SmsModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String address, String body, int date, bool isRead});
}

/// @nodoc
class __$$SmsModelImplCopyWithImpl<$Res>
    extends _$SmsModelCopyWithImpl<$Res, _$SmsModelImpl>
    implements _$$SmsModelImplCopyWith<$Res> {
  __$$SmsModelImplCopyWithImpl(
      _$SmsModelImpl _value, $Res Function(_$SmsModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of SmsModel
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
    return _then(_$SmsModelImpl(
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
              as int,
      isRead: null == isRead
          ? _value.isRead
          : isRead // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SmsModelImpl implements _SmsModel {
  const _$SmsModelImpl(
      {required this.id,
      required this.address,
      required this.body,
      required this.date,
      this.isRead = false});

  factory _$SmsModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$SmsModelImplFromJson(json);

  @override
  final String id;
  @override
  final String address;
  @override
  final String body;
  @override
  final int date;
  @override
  @JsonKey()
  final bool isRead;

  @override
  String toString() {
    return 'SmsModel(id: $id, address: $address, body: $body, date: $date, isRead: $isRead)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SmsModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.body, body) || other.body == body) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.isRead, isRead) || other.isRead == isRead));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, address, body, date, isRead);

  /// Create a copy of SmsModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SmsModelImplCopyWith<_$SmsModelImpl> get copyWith =>
      __$$SmsModelImplCopyWithImpl<_$SmsModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SmsModelImplToJson(
      this,
    );
  }
}

abstract class _SmsModel implements SmsModel {
  const factory _SmsModel(
      {required final String id,
      required final String address,
      required final String body,
      required final int date,
      final bool isRead}) = _$SmsModelImpl;

  factory _SmsModel.fromJson(Map<String, dynamic> json) =
      _$SmsModelImpl.fromJson;

  @override
  String get id;
  @override
  String get address;
  @override
  String get body;
  @override
  int get date;
  @override
  bool get isRead;

  /// Create a copy of SmsModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SmsModelImplCopyWith<_$SmsModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SmsConversationModel _$SmsConversationModelFromJson(Map<String, dynamic> json) {
  return _SmsConversationModel.fromJson(json);
}

/// @nodoc
mixin _$SmsConversationModel {
  String get address => throw _privateConstructorUsedError;
  String get lastMessage => throw _privateConstructorUsedError;
  int get messageCount => throw _privateConstructorUsedError;
  int get lastMessageDate => throw _privateConstructorUsedError;

  /// Serializes this SmsConversationModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SmsConversationModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SmsConversationModelCopyWith<SmsConversationModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SmsConversationModelCopyWith<$Res> {
  factory $SmsConversationModelCopyWith(SmsConversationModel value,
          $Res Function(SmsConversationModel) then) =
      _$SmsConversationModelCopyWithImpl<$Res, SmsConversationModel>;
  @useResult
  $Res call(
      {String address,
      String lastMessage,
      int messageCount,
      int lastMessageDate});
}

/// @nodoc
class _$SmsConversationModelCopyWithImpl<$Res,
        $Val extends SmsConversationModel>
    implements $SmsConversationModelCopyWith<$Res> {
  _$SmsConversationModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SmsConversationModel
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
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SmsConversationModelImplCopyWith<$Res>
    implements $SmsConversationModelCopyWith<$Res> {
  factory _$$SmsConversationModelImplCopyWith(_$SmsConversationModelImpl value,
          $Res Function(_$SmsConversationModelImpl) then) =
      __$$SmsConversationModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String address,
      String lastMessage,
      int messageCount,
      int lastMessageDate});
}

/// @nodoc
class __$$SmsConversationModelImplCopyWithImpl<$Res>
    extends _$SmsConversationModelCopyWithImpl<$Res, _$SmsConversationModelImpl>
    implements _$$SmsConversationModelImplCopyWith<$Res> {
  __$$SmsConversationModelImplCopyWithImpl(_$SmsConversationModelImpl _value,
      $Res Function(_$SmsConversationModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of SmsConversationModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? address = null,
    Object? lastMessage = null,
    Object? messageCount = null,
    Object? lastMessageDate = null,
  }) {
    return _then(_$SmsConversationModelImpl(
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
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SmsConversationModelImpl implements _SmsConversationModel {
  const _$SmsConversationModelImpl(
      {required this.address,
      required this.lastMessage,
      required this.messageCount,
      required this.lastMessageDate});

  factory _$SmsConversationModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$SmsConversationModelImplFromJson(json);

  @override
  final String address;
  @override
  final String lastMessage;
  @override
  final int messageCount;
  @override
  final int lastMessageDate;

  @override
  String toString() {
    return 'SmsConversationModel(address: $address, lastMessage: $lastMessage, messageCount: $messageCount, lastMessageDate: $lastMessageDate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SmsConversationModelImpl &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.lastMessage, lastMessage) ||
                other.lastMessage == lastMessage) &&
            (identical(other.messageCount, messageCount) ||
                other.messageCount == messageCount) &&
            (identical(other.lastMessageDate, lastMessageDate) ||
                other.lastMessageDate == lastMessageDate));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, address, lastMessage, messageCount, lastMessageDate);

  /// Create a copy of SmsConversationModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SmsConversationModelImplCopyWith<_$SmsConversationModelImpl>
      get copyWith =>
          __$$SmsConversationModelImplCopyWithImpl<_$SmsConversationModelImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SmsConversationModelImplToJson(
      this,
    );
  }
}

abstract class _SmsConversationModel implements SmsConversationModel {
  const factory _SmsConversationModel(
      {required final String address,
      required final String lastMessage,
      required final int messageCount,
      required final int lastMessageDate}) = _$SmsConversationModelImpl;

  factory _SmsConversationModel.fromJson(Map<String, dynamic> json) =
      _$SmsConversationModelImpl.fromJson;

  @override
  String get address;
  @override
  String get lastMessage;
  @override
  int get messageCount;
  @override
  int get lastMessageDate;

  /// Create a copy of SmsConversationModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SmsConversationModelImplCopyWith<_$SmsConversationModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
