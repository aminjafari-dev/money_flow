// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'add_transaction_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AddTransactionEvent {
  double get amount => throw _privateConstructorUsedError;
  String get mainCategory => throw _privateConstructorUsedError;
  String get category => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  DateTime get dateTime => throw _privateConstructorUsedError;
  TransactionType get type => throw _privateConstructorUsedError;
  String? get merchant => throw _privateConstructorUsedError;
  bool get isFromSms => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            double amount,
            String mainCategory,
            String category,
            String? description,
            DateTime dateTime,
            TransactionType type,
            String? merchant,
            bool isFromSms)
        addTransaction,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            double amount,
            String mainCategory,
            String category,
            String? description,
            DateTime dateTime,
            TransactionType type,
            String? merchant,
            bool isFromSms)?
        addTransaction,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            double amount,
            String mainCategory,
            String category,
            String? description,
            DateTime dateTime,
            TransactionType type,
            String? merchant,
            bool isFromSms)?
        addTransaction,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AddTransaction value) addTransaction,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AddTransaction value)? addTransaction,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AddTransaction value)? addTransaction,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Create a copy of AddTransactionEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AddTransactionEventCopyWith<AddTransactionEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AddTransactionEventCopyWith<$Res> {
  factory $AddTransactionEventCopyWith(
          AddTransactionEvent value, $Res Function(AddTransactionEvent) then) =
      _$AddTransactionEventCopyWithImpl<$Res, AddTransactionEvent>;
  @useResult
  $Res call(
      {double amount,
      String mainCategory,
      String category,
      String? description,
      DateTime dateTime,
      TransactionType type,
      String? merchant,
      bool isFromSms});
}

/// @nodoc
class _$AddTransactionEventCopyWithImpl<$Res, $Val extends AddTransactionEvent>
    implements $AddTransactionEventCopyWith<$Res> {
  _$AddTransactionEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AddTransactionEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? amount = null,
    Object? mainCategory = null,
    Object? category = null,
    Object? description = freezed,
    Object? dateTime = null,
    Object? type = null,
    Object? merchant = freezed,
    Object? isFromSms = null,
  }) {
    return _then(_value.copyWith(
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      mainCategory: null == mainCategory
          ? _value.mainCategory
          : mainCategory // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      dateTime: null == dateTime
          ? _value.dateTime
          : dateTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as TransactionType,
      merchant: freezed == merchant
          ? _value.merchant
          : merchant // ignore: cast_nullable_to_non_nullable
              as String?,
      isFromSms: null == isFromSms
          ? _value.isFromSms
          : isFromSms // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AddTransactionImplCopyWith<$Res>
    implements $AddTransactionEventCopyWith<$Res> {
  factory _$$AddTransactionImplCopyWith(_$AddTransactionImpl value,
          $Res Function(_$AddTransactionImpl) then) =
      __$$AddTransactionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {double amount,
      String mainCategory,
      String category,
      String? description,
      DateTime dateTime,
      TransactionType type,
      String? merchant,
      bool isFromSms});
}

/// @nodoc
class __$$AddTransactionImplCopyWithImpl<$Res>
    extends _$AddTransactionEventCopyWithImpl<$Res, _$AddTransactionImpl>
    implements _$$AddTransactionImplCopyWith<$Res> {
  __$$AddTransactionImplCopyWithImpl(
      _$AddTransactionImpl _value, $Res Function(_$AddTransactionImpl) _then)
      : super(_value, _then);

  /// Create a copy of AddTransactionEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? amount = null,
    Object? mainCategory = null,
    Object? category = null,
    Object? description = freezed,
    Object? dateTime = null,
    Object? type = null,
    Object? merchant = freezed,
    Object? isFromSms = null,
  }) {
    return _then(_$AddTransactionImpl(
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      mainCategory: null == mainCategory
          ? _value.mainCategory
          : mainCategory // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      dateTime: null == dateTime
          ? _value.dateTime
          : dateTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as TransactionType,
      merchant: freezed == merchant
          ? _value.merchant
          : merchant // ignore: cast_nullable_to_non_nullable
              as String?,
      isFromSms: null == isFromSms
          ? _value.isFromSms
          : isFromSms // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$AddTransactionImpl implements AddTransaction {
  const _$AddTransactionImpl(
      {required this.amount,
      required this.mainCategory,
      required this.category,
      this.description,
      required this.dateTime,
      required this.type,
      this.merchant,
      this.isFromSms = false});

  @override
  final double amount;
  @override
  final String mainCategory;
  @override
  final String category;
  @override
  final String? description;
  @override
  final DateTime dateTime;
  @override
  final TransactionType type;
  @override
  final String? merchant;
  @override
  @JsonKey()
  final bool isFromSms;

  @override
  String toString() {
    return 'AddTransactionEvent.addTransaction(amount: $amount, mainCategory: $mainCategory, category: $category, description: $description, dateTime: $dateTime, type: $type, merchant: $merchant, isFromSms: $isFromSms)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddTransactionImpl &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.mainCategory, mainCategory) ||
                other.mainCategory == mainCategory) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.dateTime, dateTime) ||
                other.dateTime == dateTime) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.merchant, merchant) ||
                other.merchant == merchant) &&
            (identical(other.isFromSms, isFromSms) ||
                other.isFromSms == isFromSms));
  }

  @override
  int get hashCode => Object.hash(runtimeType, amount, mainCategory, category,
      description, dateTime, type, merchant, isFromSms);

  /// Create a copy of AddTransactionEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AddTransactionImplCopyWith<_$AddTransactionImpl> get copyWith =>
      __$$AddTransactionImplCopyWithImpl<_$AddTransactionImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            double amount,
            String mainCategory,
            String category,
            String? description,
            DateTime dateTime,
            TransactionType type,
            String? merchant,
            bool isFromSms)
        addTransaction,
  }) {
    return addTransaction(amount, mainCategory, category, description, dateTime,
        type, merchant, isFromSms);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            double amount,
            String mainCategory,
            String category,
            String? description,
            DateTime dateTime,
            TransactionType type,
            String? merchant,
            bool isFromSms)?
        addTransaction,
  }) {
    return addTransaction?.call(amount, mainCategory, category, description,
        dateTime, type, merchant, isFromSms);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            double amount,
            String mainCategory,
            String category,
            String? description,
            DateTime dateTime,
            TransactionType type,
            String? merchant,
            bool isFromSms)?
        addTransaction,
    required TResult orElse(),
  }) {
    if (addTransaction != null) {
      return addTransaction(amount, mainCategory, category, description,
          dateTime, type, merchant, isFromSms);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AddTransaction value) addTransaction,
  }) {
    return addTransaction(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AddTransaction value)? addTransaction,
  }) {
    return addTransaction?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AddTransaction value)? addTransaction,
    required TResult orElse(),
  }) {
    if (addTransaction != null) {
      return addTransaction(this);
    }
    return orElse();
  }
}

abstract class AddTransaction implements AddTransactionEvent {
  const factory AddTransaction(
      {required final double amount,
      required final String mainCategory,
      required final String category,
      final String? description,
      required final DateTime dateTime,
      required final TransactionType type,
      final String? merchant,
      final bool isFromSms}) = _$AddTransactionImpl;

  @override
  double get amount;
  @override
  String get mainCategory;
  @override
  String get category;
  @override
  String? get description;
  @override
  DateTime get dateTime;
  @override
  TransactionType get type;
  @override
  String? get merchant;
  @override
  bool get isFromSms;

  /// Create a copy of AddTransactionEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AddTransactionImplCopyWith<_$AddTransactionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
