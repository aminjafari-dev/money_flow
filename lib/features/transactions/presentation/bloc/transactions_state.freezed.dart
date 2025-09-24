// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'transactions_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$TransactionsState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(TransactionListEntity data) completed,
    required TResult Function(String message) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(TransactionListEntity data)? completed,
    TResult? Function(String message)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(TransactionListEntity data)? completed,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TransactionsInitial value) initial,
    required TResult Function(TransactionsLoading value) loading,
    required TResult Function(TransactionsCompleted value) completed,
    required TResult Function(TransactionsError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TransactionsInitial value)? initial,
    TResult? Function(TransactionsLoading value)? loading,
    TResult? Function(TransactionsCompleted value)? completed,
    TResult? Function(TransactionsError value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TransactionsInitial value)? initial,
    TResult Function(TransactionsLoading value)? loading,
    TResult Function(TransactionsCompleted value)? completed,
    TResult Function(TransactionsError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TransactionsStateCopyWith<$Res> {
  factory $TransactionsStateCopyWith(
          TransactionsState value, $Res Function(TransactionsState) then) =
      _$TransactionsStateCopyWithImpl<$Res, TransactionsState>;
}

/// @nodoc
class _$TransactionsStateCopyWithImpl<$Res, $Val extends TransactionsState>
    implements $TransactionsStateCopyWith<$Res> {
  _$TransactionsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TransactionsState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$TransactionsInitialImplCopyWith<$Res> {
  factory _$$TransactionsInitialImplCopyWith(_$TransactionsInitialImpl value,
          $Res Function(_$TransactionsInitialImpl) then) =
      __$$TransactionsInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$TransactionsInitialImplCopyWithImpl<$Res>
    extends _$TransactionsStateCopyWithImpl<$Res, _$TransactionsInitialImpl>
    implements _$$TransactionsInitialImplCopyWith<$Res> {
  __$$TransactionsInitialImplCopyWithImpl(_$TransactionsInitialImpl _value,
      $Res Function(_$TransactionsInitialImpl) _then)
      : super(_value, _then);

  /// Create a copy of TransactionsState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$TransactionsInitialImpl implements TransactionsInitial {
  const _$TransactionsInitialImpl();

  @override
  String toString() {
    return 'TransactionsState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TransactionsInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(TransactionListEntity data) completed,
    required TResult Function(String message) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(TransactionListEntity data)? completed,
    TResult? Function(String message)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(TransactionListEntity data)? completed,
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
    required TResult Function(TransactionsInitial value) initial,
    required TResult Function(TransactionsLoading value) loading,
    required TResult Function(TransactionsCompleted value) completed,
    required TResult Function(TransactionsError value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TransactionsInitial value)? initial,
    TResult? Function(TransactionsLoading value)? loading,
    TResult? Function(TransactionsCompleted value)? completed,
    TResult? Function(TransactionsError value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TransactionsInitial value)? initial,
    TResult Function(TransactionsLoading value)? loading,
    TResult Function(TransactionsCompleted value)? completed,
    TResult Function(TransactionsError value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class TransactionsInitial implements TransactionsState {
  const factory TransactionsInitial() = _$TransactionsInitialImpl;
}

/// @nodoc
abstract class _$$TransactionsLoadingImplCopyWith<$Res> {
  factory _$$TransactionsLoadingImplCopyWith(_$TransactionsLoadingImpl value,
          $Res Function(_$TransactionsLoadingImpl) then) =
      __$$TransactionsLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$TransactionsLoadingImplCopyWithImpl<$Res>
    extends _$TransactionsStateCopyWithImpl<$Res, _$TransactionsLoadingImpl>
    implements _$$TransactionsLoadingImplCopyWith<$Res> {
  __$$TransactionsLoadingImplCopyWithImpl(_$TransactionsLoadingImpl _value,
      $Res Function(_$TransactionsLoadingImpl) _then)
      : super(_value, _then);

  /// Create a copy of TransactionsState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$TransactionsLoadingImpl implements TransactionsLoading {
  const _$TransactionsLoadingImpl();

  @override
  String toString() {
    return 'TransactionsState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TransactionsLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(TransactionListEntity data) completed,
    required TResult Function(String message) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(TransactionListEntity data)? completed,
    TResult? Function(String message)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(TransactionListEntity data)? completed,
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
    required TResult Function(TransactionsInitial value) initial,
    required TResult Function(TransactionsLoading value) loading,
    required TResult Function(TransactionsCompleted value) completed,
    required TResult Function(TransactionsError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TransactionsInitial value)? initial,
    TResult? Function(TransactionsLoading value)? loading,
    TResult? Function(TransactionsCompleted value)? completed,
    TResult? Function(TransactionsError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TransactionsInitial value)? initial,
    TResult Function(TransactionsLoading value)? loading,
    TResult Function(TransactionsCompleted value)? completed,
    TResult Function(TransactionsError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class TransactionsLoading implements TransactionsState {
  const factory TransactionsLoading() = _$TransactionsLoadingImpl;
}

/// @nodoc
abstract class _$$TransactionsCompletedImplCopyWith<$Res> {
  factory _$$TransactionsCompletedImplCopyWith(
          _$TransactionsCompletedImpl value,
          $Res Function(_$TransactionsCompletedImpl) then) =
      __$$TransactionsCompletedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({TransactionListEntity data});
}

/// @nodoc
class __$$TransactionsCompletedImplCopyWithImpl<$Res>
    extends _$TransactionsStateCopyWithImpl<$Res, _$TransactionsCompletedImpl>
    implements _$$TransactionsCompletedImplCopyWith<$Res> {
  __$$TransactionsCompletedImplCopyWithImpl(_$TransactionsCompletedImpl _value,
      $Res Function(_$TransactionsCompletedImpl) _then)
      : super(_value, _then);

  /// Create a copy of TransactionsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
  }) {
    return _then(_$TransactionsCompletedImpl(
      null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as TransactionListEntity,
    ));
  }
}

/// @nodoc

class _$TransactionsCompletedImpl implements TransactionsCompleted {
  const _$TransactionsCompletedImpl(this.data);

  @override
  final TransactionListEntity data;

  @override
  String toString() {
    return 'TransactionsState.completed(data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TransactionsCompletedImpl &&
            (identical(other.data, data) || other.data == data));
  }

  @override
  int get hashCode => Object.hash(runtimeType, data);

  /// Create a copy of TransactionsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TransactionsCompletedImplCopyWith<_$TransactionsCompletedImpl>
      get copyWith => __$$TransactionsCompletedImplCopyWithImpl<
          _$TransactionsCompletedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(TransactionListEntity data) completed,
    required TResult Function(String message) error,
  }) {
    return completed(data);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(TransactionListEntity data)? completed,
    TResult? Function(String message)? error,
  }) {
    return completed?.call(data);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(TransactionListEntity data)? completed,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (completed != null) {
      return completed(data);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TransactionsInitial value) initial,
    required TResult Function(TransactionsLoading value) loading,
    required TResult Function(TransactionsCompleted value) completed,
    required TResult Function(TransactionsError value) error,
  }) {
    return completed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TransactionsInitial value)? initial,
    TResult? Function(TransactionsLoading value)? loading,
    TResult? Function(TransactionsCompleted value)? completed,
    TResult? Function(TransactionsError value)? error,
  }) {
    return completed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TransactionsInitial value)? initial,
    TResult Function(TransactionsLoading value)? loading,
    TResult Function(TransactionsCompleted value)? completed,
    TResult Function(TransactionsError value)? error,
    required TResult orElse(),
  }) {
    if (completed != null) {
      return completed(this);
    }
    return orElse();
  }
}

abstract class TransactionsCompleted implements TransactionsState {
  const factory TransactionsCompleted(final TransactionListEntity data) =
      _$TransactionsCompletedImpl;

  TransactionListEntity get data;

  /// Create a copy of TransactionsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TransactionsCompletedImplCopyWith<_$TransactionsCompletedImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$TransactionsErrorImplCopyWith<$Res> {
  factory _$$TransactionsErrorImplCopyWith(_$TransactionsErrorImpl value,
          $Res Function(_$TransactionsErrorImpl) then) =
      __$$TransactionsErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$TransactionsErrorImplCopyWithImpl<$Res>
    extends _$TransactionsStateCopyWithImpl<$Res, _$TransactionsErrorImpl>
    implements _$$TransactionsErrorImplCopyWith<$Res> {
  __$$TransactionsErrorImplCopyWithImpl(_$TransactionsErrorImpl _value,
      $Res Function(_$TransactionsErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of TransactionsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$TransactionsErrorImpl(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$TransactionsErrorImpl implements TransactionsError {
  const _$TransactionsErrorImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'TransactionsState.error(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TransactionsErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of TransactionsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TransactionsErrorImplCopyWith<_$TransactionsErrorImpl> get copyWith =>
      __$$TransactionsErrorImplCopyWithImpl<_$TransactionsErrorImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(TransactionListEntity data) completed,
    required TResult Function(String message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(TransactionListEntity data)? completed,
    TResult? Function(String message)? error,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(TransactionListEntity data)? completed,
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
    required TResult Function(TransactionsInitial value) initial,
    required TResult Function(TransactionsLoading value) loading,
    required TResult Function(TransactionsCompleted value) completed,
    required TResult Function(TransactionsError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TransactionsInitial value)? initial,
    TResult? Function(TransactionsLoading value)? loading,
    TResult? Function(TransactionsCompleted value)? completed,
    TResult? Function(TransactionsError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TransactionsInitial value)? initial,
    TResult Function(TransactionsLoading value)? loading,
    TResult Function(TransactionsCompleted value)? completed,
    TResult Function(TransactionsError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class TransactionsError implements TransactionsState {
  const factory TransactionsError(final String message) =
      _$TransactionsErrorImpl;

  String get message;

  /// Create a copy of TransactionsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TransactionsErrorImplCopyWith<_$TransactionsErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
