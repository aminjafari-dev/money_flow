// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sms_import_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ConversationsState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<SmsConversationEntity> conversations)
        loadingMore,
    required TResult Function(
            List<SmsConversationEntity> conversations, bool hasMore)
        completed,
    required TResult Function(String message) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<SmsConversationEntity> conversations)? loadingMore,
    TResult? Function(List<SmsConversationEntity> conversations, bool hasMore)?
        completed,
    TResult? Function(String message)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<SmsConversationEntity> conversations)? loadingMore,
    TResult Function(List<SmsConversationEntity> conversations, bool hasMore)?
        completed,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ConversationsInitial value) initial,
    required TResult Function(ConversationsLoading value) loading,
    required TResult Function(ConversationsLoadingMore value) loadingMore,
    required TResult Function(ConversationsCompleted value) completed,
    required TResult Function(ConversationsError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ConversationsInitial value)? initial,
    TResult? Function(ConversationsLoading value)? loading,
    TResult? Function(ConversationsLoadingMore value)? loadingMore,
    TResult? Function(ConversationsCompleted value)? completed,
    TResult? Function(ConversationsError value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ConversationsInitial value)? initial,
    TResult Function(ConversationsLoading value)? loading,
    TResult Function(ConversationsLoadingMore value)? loadingMore,
    TResult Function(ConversationsCompleted value)? completed,
    TResult Function(ConversationsError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConversationsStateCopyWith<$Res> {
  factory $ConversationsStateCopyWith(
          ConversationsState value, $Res Function(ConversationsState) then) =
      _$ConversationsStateCopyWithImpl<$Res, ConversationsState>;
}

/// @nodoc
class _$ConversationsStateCopyWithImpl<$Res, $Val extends ConversationsState>
    implements $ConversationsStateCopyWith<$Res> {
  _$ConversationsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ConversationsState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$ConversationsInitialImplCopyWith<$Res> {
  factory _$$ConversationsInitialImplCopyWith(_$ConversationsInitialImpl value,
          $Res Function(_$ConversationsInitialImpl) then) =
      __$$ConversationsInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ConversationsInitialImplCopyWithImpl<$Res>
    extends _$ConversationsStateCopyWithImpl<$Res, _$ConversationsInitialImpl>
    implements _$$ConversationsInitialImplCopyWith<$Res> {
  __$$ConversationsInitialImplCopyWithImpl(_$ConversationsInitialImpl _value,
      $Res Function(_$ConversationsInitialImpl) _then)
      : super(_value, _then);

  /// Create a copy of ConversationsState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ConversationsInitialImpl implements ConversationsInitial {
  const _$ConversationsInitialImpl();

  @override
  String toString() {
    return 'ConversationsState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConversationsInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<SmsConversationEntity> conversations)
        loadingMore,
    required TResult Function(
            List<SmsConversationEntity> conversations, bool hasMore)
        completed,
    required TResult Function(String message) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<SmsConversationEntity> conversations)? loadingMore,
    TResult? Function(List<SmsConversationEntity> conversations, bool hasMore)?
        completed,
    TResult? Function(String message)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<SmsConversationEntity> conversations)? loadingMore,
    TResult Function(List<SmsConversationEntity> conversations, bool hasMore)?
        completed,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ConversationsInitial value) initial,
    required TResult Function(ConversationsLoading value) loading,
    required TResult Function(ConversationsLoadingMore value) loadingMore,
    required TResult Function(ConversationsCompleted value) completed,
    required TResult Function(ConversationsError value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ConversationsInitial value)? initial,
    TResult? Function(ConversationsLoading value)? loading,
    TResult? Function(ConversationsLoadingMore value)? loadingMore,
    TResult? Function(ConversationsCompleted value)? completed,
    TResult? Function(ConversationsError value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ConversationsInitial value)? initial,
    TResult Function(ConversationsLoading value)? loading,
    TResult Function(ConversationsLoadingMore value)? loadingMore,
    TResult Function(ConversationsCompleted value)? completed,
    TResult Function(ConversationsError value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class ConversationsInitial implements ConversationsState {
  const factory ConversationsInitial() = _$ConversationsInitialImpl;
}

/// @nodoc
abstract class _$$ConversationsLoadingImplCopyWith<$Res> {
  factory _$$ConversationsLoadingImplCopyWith(_$ConversationsLoadingImpl value,
          $Res Function(_$ConversationsLoadingImpl) then) =
      __$$ConversationsLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ConversationsLoadingImplCopyWithImpl<$Res>
    extends _$ConversationsStateCopyWithImpl<$Res, _$ConversationsLoadingImpl>
    implements _$$ConversationsLoadingImplCopyWith<$Res> {
  __$$ConversationsLoadingImplCopyWithImpl(_$ConversationsLoadingImpl _value,
      $Res Function(_$ConversationsLoadingImpl) _then)
      : super(_value, _then);

  /// Create a copy of ConversationsState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ConversationsLoadingImpl implements ConversationsLoading {
  const _$ConversationsLoadingImpl();

  @override
  String toString() {
    return 'ConversationsState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConversationsLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<SmsConversationEntity> conversations)
        loadingMore,
    required TResult Function(
            List<SmsConversationEntity> conversations, bool hasMore)
        completed,
    required TResult Function(String message) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<SmsConversationEntity> conversations)? loadingMore,
    TResult? Function(List<SmsConversationEntity> conversations, bool hasMore)?
        completed,
    TResult? Function(String message)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<SmsConversationEntity> conversations)? loadingMore,
    TResult Function(List<SmsConversationEntity> conversations, bool hasMore)?
        completed,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ConversationsInitial value) initial,
    required TResult Function(ConversationsLoading value) loading,
    required TResult Function(ConversationsLoadingMore value) loadingMore,
    required TResult Function(ConversationsCompleted value) completed,
    required TResult Function(ConversationsError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ConversationsInitial value)? initial,
    TResult? Function(ConversationsLoading value)? loading,
    TResult? Function(ConversationsLoadingMore value)? loadingMore,
    TResult? Function(ConversationsCompleted value)? completed,
    TResult? Function(ConversationsError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ConversationsInitial value)? initial,
    TResult Function(ConversationsLoading value)? loading,
    TResult Function(ConversationsLoadingMore value)? loadingMore,
    TResult Function(ConversationsCompleted value)? completed,
    TResult Function(ConversationsError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class ConversationsLoading implements ConversationsState {
  const factory ConversationsLoading() = _$ConversationsLoadingImpl;
}

/// @nodoc
abstract class _$$ConversationsLoadingMoreImplCopyWith<$Res> {
  factory _$$ConversationsLoadingMoreImplCopyWith(
          _$ConversationsLoadingMoreImpl value,
          $Res Function(_$ConversationsLoadingMoreImpl) then) =
      __$$ConversationsLoadingMoreImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<SmsConversationEntity> conversations});
}

/// @nodoc
class __$$ConversationsLoadingMoreImplCopyWithImpl<$Res>
    extends _$ConversationsStateCopyWithImpl<$Res,
        _$ConversationsLoadingMoreImpl>
    implements _$$ConversationsLoadingMoreImplCopyWith<$Res> {
  __$$ConversationsLoadingMoreImplCopyWithImpl(
      _$ConversationsLoadingMoreImpl _value,
      $Res Function(_$ConversationsLoadingMoreImpl) _then)
      : super(_value, _then);

  /// Create a copy of ConversationsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? conversations = null,
  }) {
    return _then(_$ConversationsLoadingMoreImpl(
      null == conversations
          ? _value._conversations
          : conversations // ignore: cast_nullable_to_non_nullable
              as List<SmsConversationEntity>,
    ));
  }
}

/// @nodoc

class _$ConversationsLoadingMoreImpl implements ConversationsLoadingMore {
  const _$ConversationsLoadingMoreImpl(
      final List<SmsConversationEntity> conversations)
      : _conversations = conversations;

  final List<SmsConversationEntity> _conversations;
  @override
  List<SmsConversationEntity> get conversations {
    if (_conversations is EqualUnmodifiableListView) return _conversations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_conversations);
  }

  @override
  String toString() {
    return 'ConversationsState.loadingMore(conversations: $conversations)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConversationsLoadingMoreImpl &&
            const DeepCollectionEquality()
                .equals(other._conversations, _conversations));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_conversations));

  /// Create a copy of ConversationsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ConversationsLoadingMoreImplCopyWith<_$ConversationsLoadingMoreImpl>
      get copyWith => __$$ConversationsLoadingMoreImplCopyWithImpl<
          _$ConversationsLoadingMoreImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<SmsConversationEntity> conversations)
        loadingMore,
    required TResult Function(
            List<SmsConversationEntity> conversations, bool hasMore)
        completed,
    required TResult Function(String message) error,
  }) {
    return loadingMore(conversations);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<SmsConversationEntity> conversations)? loadingMore,
    TResult? Function(List<SmsConversationEntity> conversations, bool hasMore)?
        completed,
    TResult? Function(String message)? error,
  }) {
    return loadingMore?.call(conversations);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<SmsConversationEntity> conversations)? loadingMore,
    TResult Function(List<SmsConversationEntity> conversations, bool hasMore)?
        completed,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loadingMore != null) {
      return loadingMore(conversations);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ConversationsInitial value) initial,
    required TResult Function(ConversationsLoading value) loading,
    required TResult Function(ConversationsLoadingMore value) loadingMore,
    required TResult Function(ConversationsCompleted value) completed,
    required TResult Function(ConversationsError value) error,
  }) {
    return loadingMore(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ConversationsInitial value)? initial,
    TResult? Function(ConversationsLoading value)? loading,
    TResult? Function(ConversationsLoadingMore value)? loadingMore,
    TResult? Function(ConversationsCompleted value)? completed,
    TResult? Function(ConversationsError value)? error,
  }) {
    return loadingMore?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ConversationsInitial value)? initial,
    TResult Function(ConversationsLoading value)? loading,
    TResult Function(ConversationsLoadingMore value)? loadingMore,
    TResult Function(ConversationsCompleted value)? completed,
    TResult Function(ConversationsError value)? error,
    required TResult orElse(),
  }) {
    if (loadingMore != null) {
      return loadingMore(this);
    }
    return orElse();
  }
}

abstract class ConversationsLoadingMore implements ConversationsState {
  const factory ConversationsLoadingMore(
          final List<SmsConversationEntity> conversations) =
      _$ConversationsLoadingMoreImpl;

  List<SmsConversationEntity> get conversations;

  /// Create a copy of ConversationsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ConversationsLoadingMoreImplCopyWith<_$ConversationsLoadingMoreImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ConversationsCompletedImplCopyWith<$Res> {
  factory _$$ConversationsCompletedImplCopyWith(
          _$ConversationsCompletedImpl value,
          $Res Function(_$ConversationsCompletedImpl) then) =
      __$$ConversationsCompletedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<SmsConversationEntity> conversations, bool hasMore});
}

/// @nodoc
class __$$ConversationsCompletedImplCopyWithImpl<$Res>
    extends _$ConversationsStateCopyWithImpl<$Res, _$ConversationsCompletedImpl>
    implements _$$ConversationsCompletedImplCopyWith<$Res> {
  __$$ConversationsCompletedImplCopyWithImpl(
      _$ConversationsCompletedImpl _value,
      $Res Function(_$ConversationsCompletedImpl) _then)
      : super(_value, _then);

  /// Create a copy of ConversationsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? conversations = null,
    Object? hasMore = null,
  }) {
    return _then(_$ConversationsCompletedImpl(
      null == conversations
          ? _value._conversations
          : conversations // ignore: cast_nullable_to_non_nullable
              as List<SmsConversationEntity>,
      null == hasMore
          ? _value.hasMore
          : hasMore // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$ConversationsCompletedImpl implements ConversationsCompleted {
  const _$ConversationsCompletedImpl(
      final List<SmsConversationEntity> conversations, this.hasMore)
      : _conversations = conversations;

  final List<SmsConversationEntity> _conversations;
  @override
  List<SmsConversationEntity> get conversations {
    if (_conversations is EqualUnmodifiableListView) return _conversations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_conversations);
  }

  @override
  final bool hasMore;

  @override
  String toString() {
    return 'ConversationsState.completed(conversations: $conversations, hasMore: $hasMore)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConversationsCompletedImpl &&
            const DeepCollectionEquality()
                .equals(other._conversations, _conversations) &&
            (identical(other.hasMore, hasMore) || other.hasMore == hasMore));
  }

  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_conversations), hasMore);

  /// Create a copy of ConversationsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ConversationsCompletedImplCopyWith<_$ConversationsCompletedImpl>
      get copyWith => __$$ConversationsCompletedImplCopyWithImpl<
          _$ConversationsCompletedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<SmsConversationEntity> conversations)
        loadingMore,
    required TResult Function(
            List<SmsConversationEntity> conversations, bool hasMore)
        completed,
    required TResult Function(String message) error,
  }) {
    return completed(conversations, hasMore);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<SmsConversationEntity> conversations)? loadingMore,
    TResult? Function(List<SmsConversationEntity> conversations, bool hasMore)?
        completed,
    TResult? Function(String message)? error,
  }) {
    return completed?.call(conversations, hasMore);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<SmsConversationEntity> conversations)? loadingMore,
    TResult Function(List<SmsConversationEntity> conversations, bool hasMore)?
        completed,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (completed != null) {
      return completed(conversations, hasMore);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ConversationsInitial value) initial,
    required TResult Function(ConversationsLoading value) loading,
    required TResult Function(ConversationsLoadingMore value) loadingMore,
    required TResult Function(ConversationsCompleted value) completed,
    required TResult Function(ConversationsError value) error,
  }) {
    return completed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ConversationsInitial value)? initial,
    TResult? Function(ConversationsLoading value)? loading,
    TResult? Function(ConversationsLoadingMore value)? loadingMore,
    TResult? Function(ConversationsCompleted value)? completed,
    TResult? Function(ConversationsError value)? error,
  }) {
    return completed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ConversationsInitial value)? initial,
    TResult Function(ConversationsLoading value)? loading,
    TResult Function(ConversationsLoadingMore value)? loadingMore,
    TResult Function(ConversationsCompleted value)? completed,
    TResult Function(ConversationsError value)? error,
    required TResult orElse(),
  }) {
    if (completed != null) {
      return completed(this);
    }
    return orElse();
  }
}

abstract class ConversationsCompleted implements ConversationsState {
  const factory ConversationsCompleted(
          final List<SmsConversationEntity> conversations, final bool hasMore) =
      _$ConversationsCompletedImpl;

  List<SmsConversationEntity> get conversations;
  bool get hasMore;

  /// Create a copy of ConversationsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ConversationsCompletedImplCopyWith<_$ConversationsCompletedImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ConversationsErrorImplCopyWith<$Res> {
  factory _$$ConversationsErrorImplCopyWith(_$ConversationsErrorImpl value,
          $Res Function(_$ConversationsErrorImpl) then) =
      __$$ConversationsErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$ConversationsErrorImplCopyWithImpl<$Res>
    extends _$ConversationsStateCopyWithImpl<$Res, _$ConversationsErrorImpl>
    implements _$$ConversationsErrorImplCopyWith<$Res> {
  __$$ConversationsErrorImplCopyWithImpl(_$ConversationsErrorImpl _value,
      $Res Function(_$ConversationsErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of ConversationsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$ConversationsErrorImpl(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ConversationsErrorImpl implements ConversationsError {
  const _$ConversationsErrorImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'ConversationsState.error(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConversationsErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of ConversationsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ConversationsErrorImplCopyWith<_$ConversationsErrorImpl> get copyWith =>
      __$$ConversationsErrorImplCopyWithImpl<_$ConversationsErrorImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<SmsConversationEntity> conversations)
        loadingMore,
    required TResult Function(
            List<SmsConversationEntity> conversations, bool hasMore)
        completed,
    required TResult Function(String message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<SmsConversationEntity> conversations)? loadingMore,
    TResult? Function(List<SmsConversationEntity> conversations, bool hasMore)?
        completed,
    TResult? Function(String message)? error,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<SmsConversationEntity> conversations)? loadingMore,
    TResult Function(List<SmsConversationEntity> conversations, bool hasMore)?
        completed,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ConversationsInitial value) initial,
    required TResult Function(ConversationsLoading value) loading,
    required TResult Function(ConversationsLoadingMore value) loadingMore,
    required TResult Function(ConversationsCompleted value) completed,
    required TResult Function(ConversationsError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ConversationsInitial value)? initial,
    TResult? Function(ConversationsLoading value)? loading,
    TResult? Function(ConversationsLoadingMore value)? loadingMore,
    TResult? Function(ConversationsCompleted value)? completed,
    TResult? Function(ConversationsError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ConversationsInitial value)? initial,
    TResult Function(ConversationsLoading value)? loading,
    TResult Function(ConversationsLoadingMore value)? loadingMore,
    TResult Function(ConversationsCompleted value)? completed,
    TResult Function(ConversationsError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class ConversationsError implements ConversationsState {
  const factory ConversationsError(final String message) =
      _$ConversationsErrorImpl;

  String get message;

  /// Create a copy of ConversationsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ConversationsErrorImplCopyWith<_$ConversationsErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$MessagesState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<SmsEntity> messages) completed,
    required TResult Function(String message) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<SmsEntity> messages)? completed,
    TResult? Function(String message)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<SmsEntity> messages)? completed,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(MessagesInitial value) initial,
    required TResult Function(MessagesLoading value) loading,
    required TResult Function(MessagesCompleted value) completed,
    required TResult Function(MessagesError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(MessagesInitial value)? initial,
    TResult? Function(MessagesLoading value)? loading,
    TResult? Function(MessagesCompleted value)? completed,
    TResult? Function(MessagesError value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MessagesInitial value)? initial,
    TResult Function(MessagesLoading value)? loading,
    TResult Function(MessagesCompleted value)? completed,
    TResult Function(MessagesError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MessagesStateCopyWith<$Res> {
  factory $MessagesStateCopyWith(
          MessagesState value, $Res Function(MessagesState) then) =
      _$MessagesStateCopyWithImpl<$Res, MessagesState>;
}

/// @nodoc
class _$MessagesStateCopyWithImpl<$Res, $Val extends MessagesState>
    implements $MessagesStateCopyWith<$Res> {
  _$MessagesStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MessagesState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$MessagesInitialImplCopyWith<$Res> {
  factory _$$MessagesInitialImplCopyWith(_$MessagesInitialImpl value,
          $Res Function(_$MessagesInitialImpl) then) =
      __$$MessagesInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$MessagesInitialImplCopyWithImpl<$Res>
    extends _$MessagesStateCopyWithImpl<$Res, _$MessagesInitialImpl>
    implements _$$MessagesInitialImplCopyWith<$Res> {
  __$$MessagesInitialImplCopyWithImpl(
      _$MessagesInitialImpl _value, $Res Function(_$MessagesInitialImpl) _then)
      : super(_value, _then);

  /// Create a copy of MessagesState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$MessagesInitialImpl implements MessagesInitial {
  const _$MessagesInitialImpl();

  @override
  String toString() {
    return 'MessagesState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$MessagesInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<SmsEntity> messages) completed,
    required TResult Function(String message) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<SmsEntity> messages)? completed,
    TResult? Function(String message)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<SmsEntity> messages)? completed,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(MessagesInitial value) initial,
    required TResult Function(MessagesLoading value) loading,
    required TResult Function(MessagesCompleted value) completed,
    required TResult Function(MessagesError value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(MessagesInitial value)? initial,
    TResult? Function(MessagesLoading value)? loading,
    TResult? Function(MessagesCompleted value)? completed,
    TResult? Function(MessagesError value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MessagesInitial value)? initial,
    TResult Function(MessagesLoading value)? loading,
    TResult Function(MessagesCompleted value)? completed,
    TResult Function(MessagesError value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class MessagesInitial implements MessagesState {
  const factory MessagesInitial() = _$MessagesInitialImpl;
}

/// @nodoc
abstract class _$$MessagesLoadingImplCopyWith<$Res> {
  factory _$$MessagesLoadingImplCopyWith(_$MessagesLoadingImpl value,
          $Res Function(_$MessagesLoadingImpl) then) =
      __$$MessagesLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$MessagesLoadingImplCopyWithImpl<$Res>
    extends _$MessagesStateCopyWithImpl<$Res, _$MessagesLoadingImpl>
    implements _$$MessagesLoadingImplCopyWith<$Res> {
  __$$MessagesLoadingImplCopyWithImpl(
      _$MessagesLoadingImpl _value, $Res Function(_$MessagesLoadingImpl) _then)
      : super(_value, _then);

  /// Create a copy of MessagesState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$MessagesLoadingImpl implements MessagesLoading {
  const _$MessagesLoadingImpl();

  @override
  String toString() {
    return 'MessagesState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$MessagesLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<SmsEntity> messages) completed,
    required TResult Function(String message) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<SmsEntity> messages)? completed,
    TResult? Function(String message)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<SmsEntity> messages)? completed,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(MessagesInitial value) initial,
    required TResult Function(MessagesLoading value) loading,
    required TResult Function(MessagesCompleted value) completed,
    required TResult Function(MessagesError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(MessagesInitial value)? initial,
    TResult? Function(MessagesLoading value)? loading,
    TResult? Function(MessagesCompleted value)? completed,
    TResult? Function(MessagesError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MessagesInitial value)? initial,
    TResult Function(MessagesLoading value)? loading,
    TResult Function(MessagesCompleted value)? completed,
    TResult Function(MessagesError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class MessagesLoading implements MessagesState {
  const factory MessagesLoading() = _$MessagesLoadingImpl;
}

/// @nodoc
abstract class _$$MessagesCompletedImplCopyWith<$Res> {
  factory _$$MessagesCompletedImplCopyWith(_$MessagesCompletedImpl value,
          $Res Function(_$MessagesCompletedImpl) then) =
      __$$MessagesCompletedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<SmsEntity> messages});
}

/// @nodoc
class __$$MessagesCompletedImplCopyWithImpl<$Res>
    extends _$MessagesStateCopyWithImpl<$Res, _$MessagesCompletedImpl>
    implements _$$MessagesCompletedImplCopyWith<$Res> {
  __$$MessagesCompletedImplCopyWithImpl(_$MessagesCompletedImpl _value,
      $Res Function(_$MessagesCompletedImpl) _then)
      : super(_value, _then);

  /// Create a copy of MessagesState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? messages = null,
  }) {
    return _then(_$MessagesCompletedImpl(
      null == messages
          ? _value._messages
          : messages // ignore: cast_nullable_to_non_nullable
              as List<SmsEntity>,
    ));
  }
}

/// @nodoc

class _$MessagesCompletedImpl implements MessagesCompleted {
  const _$MessagesCompletedImpl(final List<SmsEntity> messages)
      : _messages = messages;

  final List<SmsEntity> _messages;
  @override
  List<SmsEntity> get messages {
    if (_messages is EqualUnmodifiableListView) return _messages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_messages);
  }

  @override
  String toString() {
    return 'MessagesState.completed(messages: $messages)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MessagesCompletedImpl &&
            const DeepCollectionEquality().equals(other._messages, _messages));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_messages));

  /// Create a copy of MessagesState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MessagesCompletedImplCopyWith<_$MessagesCompletedImpl> get copyWith =>
      __$$MessagesCompletedImplCopyWithImpl<_$MessagesCompletedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<SmsEntity> messages) completed,
    required TResult Function(String message) error,
  }) {
    return completed(messages);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<SmsEntity> messages)? completed,
    TResult? Function(String message)? error,
  }) {
    return completed?.call(messages);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<SmsEntity> messages)? completed,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (completed != null) {
      return completed(messages);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(MessagesInitial value) initial,
    required TResult Function(MessagesLoading value) loading,
    required TResult Function(MessagesCompleted value) completed,
    required TResult Function(MessagesError value) error,
  }) {
    return completed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(MessagesInitial value)? initial,
    TResult? Function(MessagesLoading value)? loading,
    TResult? Function(MessagesCompleted value)? completed,
    TResult? Function(MessagesError value)? error,
  }) {
    return completed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MessagesInitial value)? initial,
    TResult Function(MessagesLoading value)? loading,
    TResult Function(MessagesCompleted value)? completed,
    TResult Function(MessagesError value)? error,
    required TResult orElse(),
  }) {
    if (completed != null) {
      return completed(this);
    }
    return orElse();
  }
}

abstract class MessagesCompleted implements MessagesState {
  const factory MessagesCompleted(final List<SmsEntity> messages) =
      _$MessagesCompletedImpl;

  List<SmsEntity> get messages;

  /// Create a copy of MessagesState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MessagesCompletedImplCopyWith<_$MessagesCompletedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$MessagesErrorImplCopyWith<$Res> {
  factory _$$MessagesErrorImplCopyWith(
          _$MessagesErrorImpl value, $Res Function(_$MessagesErrorImpl) then) =
      __$$MessagesErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$MessagesErrorImplCopyWithImpl<$Res>
    extends _$MessagesStateCopyWithImpl<$Res, _$MessagesErrorImpl>
    implements _$$MessagesErrorImplCopyWith<$Res> {
  __$$MessagesErrorImplCopyWithImpl(
      _$MessagesErrorImpl _value, $Res Function(_$MessagesErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of MessagesState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$MessagesErrorImpl(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$MessagesErrorImpl implements MessagesError {
  const _$MessagesErrorImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'MessagesState.error(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MessagesErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of MessagesState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MessagesErrorImplCopyWith<_$MessagesErrorImpl> get copyWith =>
      __$$MessagesErrorImplCopyWithImpl<_$MessagesErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<SmsEntity> messages) completed,
    required TResult Function(String message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<SmsEntity> messages)? completed,
    TResult? Function(String message)? error,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<SmsEntity> messages)? completed,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(MessagesInitial value) initial,
    required TResult Function(MessagesLoading value) loading,
    required TResult Function(MessagesCompleted value) completed,
    required TResult Function(MessagesError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(MessagesInitial value)? initial,
    TResult? Function(MessagesLoading value)? loading,
    TResult? Function(MessagesCompleted value)? completed,
    TResult? Function(MessagesError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MessagesInitial value)? initial,
    TResult Function(MessagesLoading value)? loading,
    TResult Function(MessagesCompleted value)? completed,
    TResult Function(MessagesError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class MessagesError implements MessagesState {
  const factory MessagesError(final String message) = _$MessagesErrorImpl;

  String get message;

  /// Create a copy of MessagesState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MessagesErrorImplCopyWith<_$MessagesErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$PermissionState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(bool hasPermission) completed,
    required TResult Function(String message) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(bool hasPermission)? completed,
    TResult? Function(String message)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(bool hasPermission)? completed,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PermissionInitial value) initial,
    required TResult Function(PermissionLoading value) loading,
    required TResult Function(PermissionCompleted value) completed,
    required TResult Function(PermissionError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PermissionInitial value)? initial,
    TResult? Function(PermissionLoading value)? loading,
    TResult? Function(PermissionCompleted value)? completed,
    TResult? Function(PermissionError value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PermissionInitial value)? initial,
    TResult Function(PermissionLoading value)? loading,
    TResult Function(PermissionCompleted value)? completed,
    TResult Function(PermissionError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PermissionStateCopyWith<$Res> {
  factory $PermissionStateCopyWith(
          PermissionState value, $Res Function(PermissionState) then) =
      _$PermissionStateCopyWithImpl<$Res, PermissionState>;
}

/// @nodoc
class _$PermissionStateCopyWithImpl<$Res, $Val extends PermissionState>
    implements $PermissionStateCopyWith<$Res> {
  _$PermissionStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PermissionState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$PermissionInitialImplCopyWith<$Res> {
  factory _$$PermissionInitialImplCopyWith(_$PermissionInitialImpl value,
          $Res Function(_$PermissionInitialImpl) then) =
      __$$PermissionInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$PermissionInitialImplCopyWithImpl<$Res>
    extends _$PermissionStateCopyWithImpl<$Res, _$PermissionInitialImpl>
    implements _$$PermissionInitialImplCopyWith<$Res> {
  __$$PermissionInitialImplCopyWithImpl(_$PermissionInitialImpl _value,
      $Res Function(_$PermissionInitialImpl) _then)
      : super(_value, _then);

  /// Create a copy of PermissionState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$PermissionInitialImpl implements PermissionInitial {
  const _$PermissionInitialImpl();

  @override
  String toString() {
    return 'PermissionState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$PermissionInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(bool hasPermission) completed,
    required TResult Function(String message) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(bool hasPermission)? completed,
    TResult? Function(String message)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(bool hasPermission)? completed,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PermissionInitial value) initial,
    required TResult Function(PermissionLoading value) loading,
    required TResult Function(PermissionCompleted value) completed,
    required TResult Function(PermissionError value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PermissionInitial value)? initial,
    TResult? Function(PermissionLoading value)? loading,
    TResult? Function(PermissionCompleted value)? completed,
    TResult? Function(PermissionError value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PermissionInitial value)? initial,
    TResult Function(PermissionLoading value)? loading,
    TResult Function(PermissionCompleted value)? completed,
    TResult Function(PermissionError value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class PermissionInitial implements PermissionState {
  const factory PermissionInitial() = _$PermissionInitialImpl;
}

/// @nodoc
abstract class _$$PermissionLoadingImplCopyWith<$Res> {
  factory _$$PermissionLoadingImplCopyWith(_$PermissionLoadingImpl value,
          $Res Function(_$PermissionLoadingImpl) then) =
      __$$PermissionLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$PermissionLoadingImplCopyWithImpl<$Res>
    extends _$PermissionStateCopyWithImpl<$Res, _$PermissionLoadingImpl>
    implements _$$PermissionLoadingImplCopyWith<$Res> {
  __$$PermissionLoadingImplCopyWithImpl(_$PermissionLoadingImpl _value,
      $Res Function(_$PermissionLoadingImpl) _then)
      : super(_value, _then);

  /// Create a copy of PermissionState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$PermissionLoadingImpl implements PermissionLoading {
  const _$PermissionLoadingImpl();

  @override
  String toString() {
    return 'PermissionState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$PermissionLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(bool hasPermission) completed,
    required TResult Function(String message) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(bool hasPermission)? completed,
    TResult? Function(String message)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(bool hasPermission)? completed,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PermissionInitial value) initial,
    required TResult Function(PermissionLoading value) loading,
    required TResult Function(PermissionCompleted value) completed,
    required TResult Function(PermissionError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PermissionInitial value)? initial,
    TResult? Function(PermissionLoading value)? loading,
    TResult? Function(PermissionCompleted value)? completed,
    TResult? Function(PermissionError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PermissionInitial value)? initial,
    TResult Function(PermissionLoading value)? loading,
    TResult Function(PermissionCompleted value)? completed,
    TResult Function(PermissionError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class PermissionLoading implements PermissionState {
  const factory PermissionLoading() = _$PermissionLoadingImpl;
}

/// @nodoc
abstract class _$$PermissionCompletedImplCopyWith<$Res> {
  factory _$$PermissionCompletedImplCopyWith(_$PermissionCompletedImpl value,
          $Res Function(_$PermissionCompletedImpl) then) =
      __$$PermissionCompletedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({bool hasPermission});
}

/// @nodoc
class __$$PermissionCompletedImplCopyWithImpl<$Res>
    extends _$PermissionStateCopyWithImpl<$Res, _$PermissionCompletedImpl>
    implements _$$PermissionCompletedImplCopyWith<$Res> {
  __$$PermissionCompletedImplCopyWithImpl(_$PermissionCompletedImpl _value,
      $Res Function(_$PermissionCompletedImpl) _then)
      : super(_value, _then);

  /// Create a copy of PermissionState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? hasPermission = null,
  }) {
    return _then(_$PermissionCompletedImpl(
      null == hasPermission
          ? _value.hasPermission
          : hasPermission // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$PermissionCompletedImpl implements PermissionCompleted {
  const _$PermissionCompletedImpl(this.hasPermission);

  @override
  final bool hasPermission;

  @override
  String toString() {
    return 'PermissionState.completed(hasPermission: $hasPermission)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PermissionCompletedImpl &&
            (identical(other.hasPermission, hasPermission) ||
                other.hasPermission == hasPermission));
  }

  @override
  int get hashCode => Object.hash(runtimeType, hasPermission);

  /// Create a copy of PermissionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PermissionCompletedImplCopyWith<_$PermissionCompletedImpl> get copyWith =>
      __$$PermissionCompletedImplCopyWithImpl<_$PermissionCompletedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(bool hasPermission) completed,
    required TResult Function(String message) error,
  }) {
    return completed(hasPermission);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(bool hasPermission)? completed,
    TResult? Function(String message)? error,
  }) {
    return completed?.call(hasPermission);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(bool hasPermission)? completed,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (completed != null) {
      return completed(hasPermission);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PermissionInitial value) initial,
    required TResult Function(PermissionLoading value) loading,
    required TResult Function(PermissionCompleted value) completed,
    required TResult Function(PermissionError value) error,
  }) {
    return completed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PermissionInitial value)? initial,
    TResult? Function(PermissionLoading value)? loading,
    TResult? Function(PermissionCompleted value)? completed,
    TResult? Function(PermissionError value)? error,
  }) {
    return completed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PermissionInitial value)? initial,
    TResult Function(PermissionLoading value)? loading,
    TResult Function(PermissionCompleted value)? completed,
    TResult Function(PermissionError value)? error,
    required TResult orElse(),
  }) {
    if (completed != null) {
      return completed(this);
    }
    return orElse();
  }
}

abstract class PermissionCompleted implements PermissionState {
  const factory PermissionCompleted(final bool hasPermission) =
      _$PermissionCompletedImpl;

  bool get hasPermission;

  /// Create a copy of PermissionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PermissionCompletedImplCopyWith<_$PermissionCompletedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$PermissionErrorImplCopyWith<$Res> {
  factory _$$PermissionErrorImplCopyWith(_$PermissionErrorImpl value,
          $Res Function(_$PermissionErrorImpl) then) =
      __$$PermissionErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$PermissionErrorImplCopyWithImpl<$Res>
    extends _$PermissionStateCopyWithImpl<$Res, _$PermissionErrorImpl>
    implements _$$PermissionErrorImplCopyWith<$Res> {
  __$$PermissionErrorImplCopyWithImpl(
      _$PermissionErrorImpl _value, $Res Function(_$PermissionErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of PermissionState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$PermissionErrorImpl(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$PermissionErrorImpl implements PermissionError {
  const _$PermissionErrorImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'PermissionState.error(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PermissionErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of PermissionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PermissionErrorImplCopyWith<_$PermissionErrorImpl> get copyWith =>
      __$$PermissionErrorImplCopyWithImpl<_$PermissionErrorImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(bool hasPermission) completed,
    required TResult Function(String message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(bool hasPermission)? completed,
    TResult? Function(String message)? error,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(bool hasPermission)? completed,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PermissionInitial value) initial,
    required TResult Function(PermissionLoading value) loading,
    required TResult Function(PermissionCompleted value) completed,
    required TResult Function(PermissionError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PermissionInitial value)? initial,
    TResult? Function(PermissionLoading value)? loading,
    TResult? Function(PermissionCompleted value)? completed,
    TResult? Function(PermissionError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PermissionInitial value)? initial,
    TResult Function(PermissionLoading value)? loading,
    TResult Function(PermissionCompleted value)? completed,
    TResult Function(PermissionError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class PermissionError implements PermissionState {
  const factory PermissionError(final String message) = _$PermissionErrorImpl;

  String get message;

  /// Create a copy of PermissionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PermissionErrorImplCopyWith<_$PermissionErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$SmsImportState {
  ConversationsState get conversations => throw _privateConstructorUsedError;
  MessagesState get messages => throw _privateConstructorUsedError;
  PermissionState get permission => throw _privateConstructorUsedError;

  /// Create a copy of SmsImportState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SmsImportStateCopyWith<SmsImportState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SmsImportStateCopyWith<$Res> {
  factory $SmsImportStateCopyWith(
          SmsImportState value, $Res Function(SmsImportState) then) =
      _$SmsImportStateCopyWithImpl<$Res, SmsImportState>;
  @useResult
  $Res call(
      {ConversationsState conversations,
      MessagesState messages,
      PermissionState permission});

  $ConversationsStateCopyWith<$Res> get conversations;
  $MessagesStateCopyWith<$Res> get messages;
  $PermissionStateCopyWith<$Res> get permission;
}

/// @nodoc
class _$SmsImportStateCopyWithImpl<$Res, $Val extends SmsImportState>
    implements $SmsImportStateCopyWith<$Res> {
  _$SmsImportStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SmsImportState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? conversations = null,
    Object? messages = null,
    Object? permission = null,
  }) {
    return _then(_value.copyWith(
      conversations: null == conversations
          ? _value.conversations
          : conversations // ignore: cast_nullable_to_non_nullable
              as ConversationsState,
      messages: null == messages
          ? _value.messages
          : messages // ignore: cast_nullable_to_non_nullable
              as MessagesState,
      permission: null == permission
          ? _value.permission
          : permission // ignore: cast_nullable_to_non_nullable
              as PermissionState,
    ) as $Val);
  }

  /// Create a copy of SmsImportState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ConversationsStateCopyWith<$Res> get conversations {
    return $ConversationsStateCopyWith<$Res>(_value.conversations, (value) {
      return _then(_value.copyWith(conversations: value) as $Val);
    });
  }

  /// Create a copy of SmsImportState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MessagesStateCopyWith<$Res> get messages {
    return $MessagesStateCopyWith<$Res>(_value.messages, (value) {
      return _then(_value.copyWith(messages: value) as $Val);
    });
  }

  /// Create a copy of SmsImportState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PermissionStateCopyWith<$Res> get permission {
    return $PermissionStateCopyWith<$Res>(_value.permission, (value) {
      return _then(_value.copyWith(permission: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SmsImportStateImplCopyWith<$Res>
    implements $SmsImportStateCopyWith<$Res> {
  factory _$$SmsImportStateImplCopyWith(_$SmsImportStateImpl value,
          $Res Function(_$SmsImportStateImpl) then) =
      __$$SmsImportStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {ConversationsState conversations,
      MessagesState messages,
      PermissionState permission});

  @override
  $ConversationsStateCopyWith<$Res> get conversations;
  @override
  $MessagesStateCopyWith<$Res> get messages;
  @override
  $PermissionStateCopyWith<$Res> get permission;
}

/// @nodoc
class __$$SmsImportStateImplCopyWithImpl<$Res>
    extends _$SmsImportStateCopyWithImpl<$Res, _$SmsImportStateImpl>
    implements _$$SmsImportStateImplCopyWith<$Res> {
  __$$SmsImportStateImplCopyWithImpl(
      _$SmsImportStateImpl _value, $Res Function(_$SmsImportStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of SmsImportState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? conversations = null,
    Object? messages = null,
    Object? permission = null,
  }) {
    return _then(_$SmsImportStateImpl(
      conversations: null == conversations
          ? _value.conversations
          : conversations // ignore: cast_nullable_to_non_nullable
              as ConversationsState,
      messages: null == messages
          ? _value.messages
          : messages // ignore: cast_nullable_to_non_nullable
              as MessagesState,
      permission: null == permission
          ? _value.permission
          : permission // ignore: cast_nullable_to_non_nullable
              as PermissionState,
    ));
  }
}

/// @nodoc

class _$SmsImportStateImpl implements _SmsImportState {
  const _$SmsImportStateImpl(
      {this.conversations = const ConversationsState.initial(),
      this.messages = const MessagesState.initial(),
      this.permission = const PermissionState.initial()});

  @override
  @JsonKey()
  final ConversationsState conversations;
  @override
  @JsonKey()
  final MessagesState messages;
  @override
  @JsonKey()
  final PermissionState permission;

  @override
  String toString() {
    return 'SmsImportState(conversations: $conversations, messages: $messages, permission: $permission)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SmsImportStateImpl &&
            (identical(other.conversations, conversations) ||
                other.conversations == conversations) &&
            (identical(other.messages, messages) ||
                other.messages == messages) &&
            (identical(other.permission, permission) ||
                other.permission == permission));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, conversations, messages, permission);

  /// Create a copy of SmsImportState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SmsImportStateImplCopyWith<_$SmsImportStateImpl> get copyWith =>
      __$$SmsImportStateImplCopyWithImpl<_$SmsImportStateImpl>(
          this, _$identity);
}

abstract class _SmsImportState implements SmsImportState {
  const factory _SmsImportState(
      {final ConversationsState conversations,
      final MessagesState messages,
      final PermissionState permission}) = _$SmsImportStateImpl;

  @override
  ConversationsState get conversations;
  @override
  MessagesState get messages;
  @override
  PermissionState get permission;

  /// Create a copy of SmsImportState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SmsImportStateImplCopyWith<_$SmsImportStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
