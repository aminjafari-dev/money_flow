import 'package:equatable/equatable.dart';

/// Transaction entity representing a financial transaction in the domain layer.
/// This is a pure business object with no external dependencies.
///
/// Usage Example:
/// ```dart
/// final transaction = TransactionEntity(
///   id: 'txn_123',
///   amount: 25.50,
///   category: 'Food',
///   subcategory: 'Groceries',
///   description: 'Weekly grocery shopping',
///   dateTime: DateTime.now(),
///   type: TransactionType.expense,
/// );
/// ```
class TransactionEntity extends Equatable {
  /// Unique identifier for the transaction
  final String id;

  /// Transaction amount (positive for income, negative for expense)
  final double amount;

  /// Main category of the transaction (e.g., Food, Transportation)
  final String category;

  /// Specific subcategory within the main category (e.g., Groceries, Gas)
  final String subcategory;

  /// Optional description or notes about the transaction
  final String? description;

  /// Date and time when the transaction occurred
  final DateTime dateTime;

  /// Type of transaction (expense or income)
  final TransactionType type;

  /// Whether this transaction was created from SMS import
  final bool isFromSms;

  /// Merchant or vendor name (extracted from SMS or manually entered)
  final String? merchant;

  const TransactionEntity({
    required this.id,
    required this.amount,
    required this.category,
    required this.subcategory,
    this.description,
    required this.dateTime,
    required this.type,
    this.isFromSms = false,
    this.merchant,
  });

  /// Creates a copy of this transaction with updated fields
  /// This is useful for updating transaction details while maintaining immutability
  TransactionEntity copyWith({
    String? id,
    double? amount,
    String? category,
    String? subcategory,
    String? description,
    DateTime? dateTime,
    TransactionType? type,
    bool? isFromSms,
    String? merchant,
  }) {
    return TransactionEntity(
      id: id ?? this.id,
      amount: amount ?? this.amount,
      category: category ?? this.category,
      subcategory: subcategory ?? this.subcategory,
      description: description ?? this.description,
      dateTime: dateTime ?? this.dateTime,
      type: type ?? this.type,
      isFromSms: isFromSms ?? this.isFromSms,
      merchant: merchant ?? this.merchant,
    );
  }

  /// Checks if this is an expense transaction
  /// Returns true if the transaction type is expense
  bool get isExpense => type == TransactionType.expense;

  /// Checks if this is an income transaction
  /// Returns true if the transaction type is income
  bool get isIncome => type == TransactionType.income;

  /// Gets the absolute amount value
  /// This is useful for calculations where you need the positive value
  double get absoluteAmount => amount.abs();

  /// Gets formatted amount string with currency symbol
  /// Returns formatted string like "$25.50" or "-$15.00"
  String get formattedAmount {
    final sign = isExpense ? '-' : '';
    return '$sign\$${absoluteAmount.toStringAsFixed(2)}';
  }

  @override
  List<Object?> get props => [
    id,
    amount,
    category,
    subcategory,
    description,
    dateTime,
    type,
    isFromSms,
    merchant,
  ];
}

/// Enum representing the type of transaction
/// This helps distinguish between income and expense transactions
enum TransactionType {
  /// Represents money going out (expenses)
  expense,

  /// Represents money coming in (income)
  income,
}

/// Extension on TransactionType for better usability
/// Provides helper methods for transaction type operations
extension TransactionTypeExtension on TransactionType {
  /// Gets the display name for the transaction type
  /// Returns "Expense" or "Income" for UI display
  String get displayName {
    switch (this) {
      case TransactionType.expense:
        return 'Expense';
      case TransactionType.income:
        return 'Income';
    }
  }

  /// Gets the opposite transaction type
  /// Useful for toggling between expense and income
  TransactionType get opposite {
    switch (this) {
      case TransactionType.expense:
        return TransactionType.income;
      case TransactionType.income:
        return TransactionType.expense;
    }
  }
}
