import 'package:money_flow/features/add_transaction/domain/entities/transaction_entity.dart';

/// Domain entity representing a list of transactions.
/// This entity contains the business logic for managing transaction collections.
///
/// Usage Example:
/// ```dart
/// final transactionList = TransactionListEntity(
///   transactions: [transaction1, transaction2],
///   totalCount: 2,
/// );
/// ```
class TransactionListEntity {
  /// List of transaction entities
  final List<TransactionEntity> transactions;

  /// Total count of transactions
  final int totalCount;

  /// Whether there are more transactions to load (for pagination)
  final bool hasMore;

  const TransactionListEntity({
    required this.transactions,
    required this.totalCount,
    this.hasMore = false,
  });

  /// Creates an empty transaction list entity.
  /// This is useful for initial states or when no transactions are available.
  ///
  /// Returns:
  /// - [TransactionListEntity]: Empty transaction list
  ///
  /// Usage Example:
  /// ```dart
  /// final emptyList = TransactionListEntity.empty();
  /// ```
  factory TransactionListEntity.empty() {
    return const TransactionListEntity(
      transactions: [],
      totalCount: 0,
      hasMore: false,
    );
  }

  /// Creates a copy of this entity with updated fields.
  /// This is useful for updating transaction list while maintaining immutability.
  ///
  /// Parameters:
  /// - [transactions]: Optional new transactions list
  /// - [totalCount]: Optional new total count
  /// - [hasMore]: Optional new hasMore flag
  ///
  /// Returns:
  /// - [TransactionListEntity]: Updated transaction list entity
  ///
  /// Usage Example:
  /// ```dart
  /// final updatedList = transactionList.copyWith(
  ///   transactions: newTransactions,
  ///   totalCount: newCount,
  /// );
  /// ```
  TransactionListEntity copyWith({
    List<TransactionEntity>? transactions,
    int? totalCount,
    bool? hasMore,
  }) {
    return TransactionListEntity(
      transactions: transactions ?? this.transactions,
      totalCount: totalCount ?? this.totalCount,
      hasMore: hasMore ?? this.hasMore,
    );
  }

  /// Gets transactions sorted by date (newest first).
  /// This method provides a sorted view of transactions for display.
  ///
  /// Returns:
  /// - [List<TransactionEntity>]: Sorted list of transactions
  ///
  /// Usage Example:
  /// ```dart
  /// final sortedTransactions = transactionList.sortedByDate;
  /// ```
  List<TransactionEntity> get sortedByDate {
    final sortedList = List<TransactionEntity>.from(transactions);
    sortedList.sort((a, b) => b.dateTime.compareTo(a.dateTime));
    return sortedList;
  }

  /// Gets transactions sorted by amount (highest first).
  /// This method provides a sorted view of transactions by amount.
  ///
  /// Returns:
  /// - [List<TransactionEntity>]: Sorted list of transactions by amount
  ///
  /// Usage Example:
  /// ```dart
  /// final sortedByAmount = transactionList.sortedByAmount;
  /// ```
  List<TransactionEntity> get sortedByAmount {
    final sortedList = List<TransactionEntity>.from(transactions);
    sortedList.sort((a, b) => b.amount.compareTo(a.amount));
    return sortedList;
  }

  /// Gets transactions grouped by category.
  /// This method organizes transactions by their category for better display.
  ///
  /// Returns:
  /// - [Map<String, List<TransactionEntity>>]: Map of category to transactions
  ///
  /// Usage Example:
  /// ```dart
  /// final groupedTransactions = transactionList.groupedByCategory;
  /// for (final entry in groupedTransactions.entries) {
  ///   print('${entry.key}: ${entry.value.length} transactions');
  /// }
  /// ```
  Map<String, List<TransactionEntity>> get groupedByCategory {
    final grouped = <String, List<TransactionEntity>>{};
    for (final transaction in transactions) {
      final category = transaction.category;
      if (grouped.containsKey(category)) {
        grouped[category]!.add(transaction);
      } else {
        grouped[category] = [transaction];
      }
    }
    return grouped;
  }

  /// Calculates total income from all transactions.
  /// This method sums up all income transactions.
  ///
  /// Returns:
  /// - [double]: Total income amount
  ///
  /// Usage Example:
  /// ```dart
  /// final totalIncome = transactionList.totalIncome;
  /// ```
  double get totalIncome {
    return transactions
        .where((transaction) => transaction.type.name == 'income')
        .fold(0.0, (sum, transaction) => sum + transaction.amount);
  }

  /// Calculates total expenses from all transactions.
  /// This method sums up all expense transactions.
  ///
  /// Returns:
  /// - [double]: Total expenses amount
  ///
  /// Usage Example:
  /// ```dart
  /// final totalExpenses = transactionList.totalExpenses;
  /// ```
  double get totalExpenses {
    return transactions
        .where((transaction) => transaction.type.name == 'expense')
        .fold(0.0, (sum, transaction) => sum + transaction.amount);
  }

  /// Calculates net amount (income - expenses).
  /// This method provides the net financial position.
  ///
  /// Returns:
  /// - [double]: Net amount (positive for profit, negative for loss)
  ///
  /// Usage Example:
  /// ```dart
  /// final netAmount = transactionList.netAmount;
  /// ```
  double get netAmount {
    return totalIncome - totalExpenses;
  }

  /// Checks if the transaction list is empty.
  /// This method provides a convenient way to check for empty state.
  ///
  /// Returns:
  /// - [bool]: True if no transactions, false otherwise
  ///
  /// Usage Example:
  /// ```dart
  /// if (transactionList.isEmpty) {
  ///   // Show empty state
  /// }
  /// ```
  bool get isEmpty => transactions.isEmpty;

  /// Checks if the transaction list is not empty.
  /// This method provides a convenient way to check for non-empty state.
  ///
  /// Returns:
  /// - [bool]: True if has transactions, false otherwise
  ///
  /// Usage Example:
  /// ```dart
  /// if (transactionList.isNotEmpty) {
  ///   // Show transaction list
  /// }
  /// ```
  bool get isNotEmpty => transactions.isNotEmpty;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is TransactionListEntity &&
        other.transactions.length == transactions.length &&
        other.totalCount == totalCount &&
        other.hasMore == hasMore;
  }

  @override
  int get hashCode {
    return Object.hash(transactions.length, totalCount, hasMore);
  }

  @override
  String toString() {
    return 'TransactionListEntity(transactions: ${transactions.length}, totalCount: $totalCount, hasMore: $hasMore)';
  }
}
