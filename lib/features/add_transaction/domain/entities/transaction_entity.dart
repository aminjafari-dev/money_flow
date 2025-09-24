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

  /// Main category of the transaction (income, expenses, charity, investments)
  final String mainCategory;

  /// Category name of the transaction (Income, Expenses, Charity, Investments)
  final String category;

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
    required this.mainCategory,
    required this.category,
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
    String? mainCategory,
    String? category,
    String? description,
    DateTime? dateTime,
    TransactionType? type,
    bool? isFromSms,
    String? merchant,
  }) {
    return TransactionEntity(
      id: id ?? this.id,
      amount: amount ?? this.amount,
      mainCategory: mainCategory ?? this.mainCategory,
      category: category ?? this.category,
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
    mainCategory,
    category,
    description,
    dateTime,
    type,
    isFromSms,
    merchant,
  ];
}

/// Enum representing the type of transaction
/// This helps distinguish between different transaction categories
enum TransactionType {
  /// Represents money going out (expenses)
  expense,

  /// Represents money coming in (income)
  income,

  /// Represents money going out for charity donations
  charity,

  /// Represents money going out for investments
  investments,
}

/// Extension on TransactionType for better usability
/// Provides helper methods for transaction type operations
extension TransactionTypeExtension on TransactionType {
  /// Gets the display name for the transaction type
  /// Returns display name for UI display
  String get displayName {
    switch (this) {
      case TransactionType.expense:
        return 'Expense';
      case TransactionType.income:
        return 'Income';
      case TransactionType.charity:
        return 'Charity';
      case TransactionType.investments:
        return 'Investments';
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
      case TransactionType.charity:
        return TransactionType.income;
      case TransactionType.investments:
        return TransactionType.income;
    }
  }

  /// Checks if this transaction type represents money going out
  /// Returns true for expense, charity, and investments
  bool get isOutgoing {
    switch (this) {
      case TransactionType.expense:
      case TransactionType.charity:
      case TransactionType.investments:
        return true;
      case TransactionType.income:
        return false;
    }
  }

  /// Checks if this transaction type represents money coming in
  /// Returns true only for income
  bool get isIncoming {
    return this == TransactionType.income;
  }
}
