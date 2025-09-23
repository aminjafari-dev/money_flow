// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'add_transaction_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AddTransactionState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(TransactionEntity transaction) completed,
    required TResult Function(String message) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(TransactionEntity transaction)? completed,
    TResult? Function(String message)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(TransactionEntity transaction)? completed,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AddTransactionInitial value) initial,
    required TResult Function(AddTransactionLoading value) loading,
    required TResult Function(AddTransactionCompleted value) completed,
    required TResult Function(AddTransactionError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AddTransactionInitial value)? initial,
    TResult? Function(AddTransactionLoading value)? loading,
    TResult? Function(AddTransactionCompleted value)? completed,
    TResult? Function(AddTransactionError value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AddTransactionInitial value)? initial,
    TResult Function(AddTransactionLoading value)? loading,
    TResult Function(AddTransactionCompleted value)? completed,
    TResult Function(AddTransactionError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AddTransactionStateCopyWith<$Res> {
  factory $AddTransactionStateCopyWith(
          AddTransactionState value, $Res Function(AddTransactionState) then) =
      _$AddTransactionStateCopyWithImpl<$Res, AddTransactionState>;
}

/// @nodoc
class _$AddTransactionStateCopyWithImpl<$Res, $Val extends AddTransactionState>
    implements $AddTransactionStateCopyWith<$Res> {
  _$AddTransactionStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AddTransactionState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$AddTransactionInitialImplCopyWith<$Res> {
  factory _$$AddTransactionInitialImplCopyWith(
          _$AddTransactionInitialImpl value,
          $Res Function(_$AddTransactionInitialImpl) then) =
      __$$AddTransactionInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AddTransactionInitialImplCopyWithImpl<$Res>
    extends _$AddTransactionStateCopyWithImpl<$Res, _$AddTransactionInitialImpl>
    implements _$$AddTransactionInitialImplCopyWith<$Res> {
  __$$AddTransactionInitialImplCopyWithImpl(_$AddTransactionInitialImpl _value,
      $Res Function(_$AddTransactionInitialImpl) _then)
      : super(_value, _then);

  /// Create a copy of AddTransactionState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$AddTransactionInitialImpl implements AddTransactionInitial {
  const _$AddTransactionInitialImpl();

  @override
  String toString() {
    return 'AddTransactionState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddTransactionInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(TransactionEntity transaction) completed,
    required TResult Function(String message) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(TransactionEntity transaction)? completed,
    TResult? Function(String message)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(TransactionEntity transaction)? completed,
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
    required TResult Function(AddTransactionInitial value) initial,
    required TResult Function(AddTransactionLoading value) loading,
    required TResult Function(AddTransactionCompleted value) completed,
    required TResult Function(AddTransactionError value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AddTransactionInitial value)? initial,
    TResult? Function(AddTransactionLoading value)? loading,
    TResult? Function(AddTransactionCompleted value)? completed,
    TResult? Function(AddTransactionError value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AddTransactionInitial value)? initial,
    TResult Function(AddTransactionLoading value)? loading,
    TResult Function(AddTransactionCompleted value)? completed,
    TResult Function(AddTransactionError value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class AddTransactionInitial implements AddTransactionState {
  const factory AddTransactionInitial() = _$AddTransactionInitialImpl;
}

/// @nodoc
abstract class _$$AddTransactionLoadingImplCopyWith<$Res> {
  factory _$$AddTransactionLoadingImplCopyWith(
          _$AddTransactionLoadingImpl value,
          $Res Function(_$AddTransactionLoadingImpl) then) =
      __$$AddTransactionLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AddTransactionLoadingImplCopyWithImpl<$Res>
    extends _$AddTransactionStateCopyWithImpl<$Res, _$AddTransactionLoadingImpl>
    implements _$$AddTransactionLoadingImplCopyWith<$Res> {
  __$$AddTransactionLoadingImplCopyWithImpl(_$AddTransactionLoadingImpl _value,
      $Res Function(_$AddTransactionLoadingImpl) _then)
      : super(_value, _then);

  /// Create a copy of AddTransactionState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$AddTransactionLoadingImpl implements AddTransactionLoading {
  const _$AddTransactionLoadingImpl();

  @override
  String toString() {
    return 'AddTransactionState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddTransactionLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(TransactionEntity transaction) completed,
    required TResult Function(String message) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(TransactionEntity transaction)? completed,
    TResult? Function(String message)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(TransactionEntity transaction)? completed,
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
    required TResult Function(AddTransactionInitial value) initial,
    required TResult Function(AddTransactionLoading value) loading,
    required TResult Function(AddTransactionCompleted value) completed,
    required TResult Function(AddTransactionError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AddTransactionInitial value)? initial,
    TResult? Function(AddTransactionLoading value)? loading,
    TResult? Function(AddTransactionCompleted value)? completed,
    TResult? Function(AddTransactionError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AddTransactionInitial value)? initial,
    TResult Function(AddTransactionLoading value)? loading,
    TResult Function(AddTransactionCompleted value)? completed,
    TResult Function(AddTransactionError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class AddTransactionLoading implements AddTransactionState {
  const factory AddTransactionLoading() = _$AddTransactionLoadingImpl;
}

/// @nodoc
abstract class _$$AddTransactionCompletedImplCopyWith<$Res> {
  factory _$$AddTransactionCompletedImplCopyWith(
          _$AddTransactionCompletedImpl value,
          $Res Function(_$AddTransactionCompletedImpl) then) =
      __$$AddTransactionCompletedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({TransactionEntity transaction});
}

/// @nodoc
class __$$AddTransactionCompletedImplCopyWithImpl<$Res>
    extends _$AddTransactionStateCopyWithImpl<$Res,
        _$AddTransactionCompletedImpl>
    implements _$$AddTransactionCompletedImplCopyWith<$Res> {
  __$$AddTransactionCompletedImplCopyWithImpl(
      _$AddTransactionCompletedImpl _value,
      $Res Function(_$AddTransactionCompletedImpl) _then)
      : super(_value, _then);

  /// Create a copy of AddTransactionState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? transaction = null,
  }) {
    return _then(_$AddTransactionCompletedImpl(
      null == transaction
          ? _value.transaction
          : transaction // ignore: cast_nullable_to_non_nullable
              as TransactionEntity,
    ));
  }
}

/// @nodoc

class _$AddTransactionCompletedImpl implements AddTransactionCompleted {
  const _$AddTransactionCompletedImpl(this.transaction);

  @override
  final TransactionEntity transaction;

  @override
  String toString() {
    return 'AddTransactionState.completed(transaction: $transaction)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddTransactionCompletedImpl &&
            (identical(other.transaction, transaction) ||
                other.transaction == transaction));
  }

  @override
  int get hashCode => Object.hash(runtimeType, transaction);

  /// Create a copy of AddTransactionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AddTransactionCompletedImplCopyWith<_$AddTransactionCompletedImpl>
      get copyWith => __$$AddTransactionCompletedImplCopyWithImpl<
          _$AddTransactionCompletedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(TransactionEntity transaction) completed,
    required TResult Function(String message) error,
  }) {
    return completed(transaction);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(TransactionEntity transaction)? completed,
    TResult? Function(String message)? error,
  }) {
    return completed?.call(transaction);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(TransactionEntity transaction)? completed,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (completed != null) {
      return completed(transaction);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AddTransactionInitial value) initial,
    required TResult Function(AddTransactionLoading value) loading,
    required TResult Function(AddTransactionCompleted value) completed,
    required TResult Function(AddTransactionError value) error,
  }) {
    return completed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AddTransactionInitial value)? initial,
    TResult? Function(AddTransactionLoading value)? loading,
    TResult? Function(AddTransactionCompleted value)? completed,
    TResult? Function(AddTransactionError value)? error,
  }) {
    return completed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AddTransactionInitial value)? initial,
    TResult Function(AddTransactionLoading value)? loading,
    TResult Function(AddTransactionCompleted value)? completed,
    TResult Function(AddTransactionError value)? error,
    required TResult orElse(),
  }) {
    if (completed != null) {
      return completed(this);
    }
    return orElse();
  }
}

abstract class AddTransactionCompleted implements AddTransactionState {
  const factory AddTransactionCompleted(final TransactionEntity transaction) =
      _$AddTransactionCompletedImpl;

  TransactionEntity get transaction;

  /// Create a copy of AddTransactionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AddTransactionCompletedImplCopyWith<_$AddTransactionCompletedImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AddTransactionErrorImplCopyWith<$Res> {
  factory _$$AddTransactionErrorImplCopyWith(_$AddTransactionErrorImpl value,
          $Res Function(_$AddTransactionErrorImpl) then) =
      __$$AddTransactionErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$AddTransactionErrorImplCopyWithImpl<$Res>
    extends _$AddTransactionStateCopyWithImpl<$Res, _$AddTransactionErrorImpl>
    implements _$$AddTransactionErrorImplCopyWith<$Res> {
  __$$AddTransactionErrorImplCopyWithImpl(_$AddTransactionErrorImpl _value,
      $Res Function(_$AddTransactionErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of AddTransactionState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$AddTransactionErrorImpl(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$AddTransactionErrorImpl implements AddTransactionError {
  const _$AddTransactionErrorImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'AddTransactionState.error(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddTransactionErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of AddTransactionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AddTransactionErrorImplCopyWith<_$AddTransactionErrorImpl> get copyWith =>
      __$$AddTransactionErrorImplCopyWithImpl<_$AddTransactionErrorImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(TransactionEntity transaction) completed,
    required TResult Function(String message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(TransactionEntity transaction)? completed,
    TResult? Function(String message)? error,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(TransactionEntity transaction)? completed,
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
    required TResult Function(AddTransactionInitial value) initial,
    required TResult Function(AddTransactionLoading value) loading,
    required TResult Function(AddTransactionCompleted value) completed,
    required TResult Function(AddTransactionError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AddTransactionInitial value)? initial,
    TResult? Function(AddTransactionLoading value)? loading,
    TResult? Function(AddTransactionCompleted value)? completed,
    TResult? Function(AddTransactionError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AddTransactionInitial value)? initial,
    TResult Function(AddTransactionLoading value)? loading,
    TResult Function(AddTransactionCompleted value)? completed,
    TResult Function(AddTransactionError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class AddTransactionError implements AddTransactionState {
  const factory AddTransactionError(final String message) =
      _$AddTransactionErrorImpl;

  String get message;

  /// Create a copy of AddTransactionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AddTransactionErrorImplCopyWith<_$AddTransactionErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$AddTransactionMainState {
  /// State for adding transaction operation
  AddTransactionState get addTransaction => throw _privateConstructorUsedError;

  /// Create a copy of AddTransactionMainState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AddTransactionMainStateCopyWith<AddTransactionMainState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AddTransactionMainStateCopyWith<$Res> {
  factory $AddTransactionMainStateCopyWith(AddTransactionMainState value,
          $Res Function(AddTransactionMainState) then) =
      _$AddTransactionMainStateCopyWithImpl<$Res, AddTransactionMainState>;
  @useResult
  $Res call({AddTransactionState addTransaction});

  $AddTransactionStateCopyWith<$Res> get addTransaction;
}

/// @nodoc
class _$AddTransactionMainStateCopyWithImpl<$Res,
        $Val extends AddTransactionMainState>
    implements $AddTransactionMainStateCopyWith<$Res> {
  _$AddTransactionMainStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AddTransactionMainState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? addTransaction = null,
  }) {
    return _then(_value.copyWith(
      addTransaction: null == addTransaction
          ? _value.addTransaction
          : addTransaction // ignore: cast_nullable_to_non_nullable
              as AddTransactionState,
    ) as $Val);
  }

  /// Create a copy of AddTransactionMainState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AddTransactionStateCopyWith<$Res> get addTransaction {
    return $AddTransactionStateCopyWith<$Res>(_value.addTransaction, (value) {
      return _then(_value.copyWith(addTransaction: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AddTransactionMainStateImplCopyWith<$Res>
    implements $AddTransactionMainStateCopyWith<$Res> {
  factory _$$AddTransactionMainStateImplCopyWith(
          _$AddTransactionMainStateImpl value,
          $Res Function(_$AddTransactionMainStateImpl) then) =
      __$$AddTransactionMainStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({AddTransactionState addTransaction});

  @override
  $AddTransactionStateCopyWith<$Res> get addTransaction;
}

/// @nodoc
class __$$AddTransactionMainStateImplCopyWithImpl<$Res>
    extends _$AddTransactionMainStateCopyWithImpl<$Res,
        _$AddTransactionMainStateImpl>
    implements _$$AddTransactionMainStateImplCopyWith<$Res> {
  __$$AddTransactionMainStateImplCopyWithImpl(
      _$AddTransactionMainStateImpl _value,
      $Res Function(_$AddTransactionMainStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of AddTransactionMainState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? addTransaction = null,
  }) {
    return _then(_$AddTransactionMainStateImpl(
      addTransaction: null == addTransaction
          ? _value.addTransaction
          : addTransaction // ignore: cast_nullable_to_non_nullable
              as AddTransactionState,
    ));
  }
}

/// @nodoc

class _$AddTransactionMainStateImpl implements _AddTransactionMainState {
  const _$AddTransactionMainStateImpl(
      {this.addTransaction = const AddTransactionState.initial()});

  /// State for adding transaction operation
  @override
  @JsonKey()
  final AddTransactionState addTransaction;

  @override
  String toString() {
    return 'AddTransactionMainState(addTransaction: $addTransaction)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddTransactionMainStateImpl &&
            (identical(other.addTransaction, addTransaction) ||
                other.addTransaction == addTransaction));
  }

  @override
  int get hashCode => Object.hash(runtimeType, addTransaction);

  /// Create a copy of AddTransactionMainState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AddTransactionMainStateImplCopyWith<_$AddTransactionMainStateImpl>
      get copyWith => __$$AddTransactionMainStateImplCopyWithImpl<
          _$AddTransactionMainStateImpl>(this, _$identity);
}

abstract class _AddTransactionMainState implements AddTransactionMainState {
  const factory _AddTransactionMainState(
          {final AddTransactionState addTransaction}) =
      _$AddTransactionMainStateImpl;

  /// State for adding transaction operation
  @override
  AddTransactionState get addTransaction;

  /// Create a copy of AddTransactionMainState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AddTransactionMainStateImplCopyWith<_$AddTransactionMainStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
