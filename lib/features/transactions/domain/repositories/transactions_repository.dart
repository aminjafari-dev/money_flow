import 'package:money_flow/core/data_status.dart';
import 'package:money_flow/features/transactions/domain/entities/transaction_list_entity.dart';

/// Abstract repository interface for transactions data operations.
/// This interface defines the contract for transaction data access in the domain layer.
///
/// The repository pattern provides a clean abstraction over data sources,
/// allowing the domain layer to be independent of data implementation details.
///
/// Usage Example:
/// ```dart
/// class TransactionsRepositoryImpl implements TransactionsRepository {
///   @override
///   Future<DataStatus<TransactionListEntity>> getAllTransactions() async {
///     // Implementation details
///   }
/// }
/// ```
abstract class TransactionsRepository {
  /// Gets all transactions from the data source.
  /// This method retrieves all available transactions without any filtering.
  ///
  /// Returns:
  /// - [DataStatus<TransactionListEntity>]: Result containing transaction list or error
  ///
  /// Usage Example:
  /// ```dart
  /// final result = await repository.getAllTransactions();
  /// result.fold(
  ///   (error) => print('Error: $error'),
  ///   (transactionList) => print('Found ${transactionList.transactions.length} transactions'),
  /// );
  /// ```
  Future<DataStatus<TransactionListEntity>> getAllTransactions();

  /// Gets transactions with pagination support.
  /// This method retrieves transactions in chunks for better performance.
  ///
  /// Parameters:
  /// - [page]: Page number (starting from 1)
  /// - [limit]: Number of transactions per page
  ///
  /// Returns:
  /// - [DataStatus<TransactionListEntity>]: Result containing paginated transaction list or error
  ///
  /// Usage Example:
  /// ```dart
  /// final result = await repository.getTransactionsPaginated(page: 1, limit: 20);
  /// result.fold(
  ///   (error) => print('Error: $error'),
  ///   (transactionList) => print('Page 1: ${transactionList.transactions.length} transactions'),
  /// );
  /// ```
  Future<DataStatus<TransactionListEntity>> getTransactionsPaginated({
    int page = 1,
    int limit = 20,
  });

  /// Gets transactions sorted by date (newest first).
  /// This method retrieves transactions ordered by their date/time.
  ///
  /// Parameters:
  /// - [limit]: Optional limit on number of results
  ///
  /// Returns:
  /// - [DataStatus<TransactionListEntity>]: Result containing sorted transaction list or error
  ///
  /// Usage Example:
  /// ```dart
  /// final result = await repository.getTransactionsSortedByDate(limit: 50);
  /// result.fold(
  ///   (error) => print('Error: $error'),
  ///   (transactionList) => print('Recent transactions: ${transactionList.transactions.length}'),
  /// );
  /// ```
  Future<DataStatus<TransactionListEntity>> getTransactionsSortedByDate({
    int? limit,
  });

  /// Gets transactions by category.
  /// This method filters transactions based on their category.
  ///
  /// Parameters:
  /// - [category]: Category to filter by
  /// - [limit]: Optional limit on number of results
  ///
  /// Returns:
  /// - [DataStatus<TransactionListEntity>]: Result containing filtered transaction list or error
  ///
  /// Usage Example:
  /// ```dart
  /// final result = await repository.getTransactionsByCategory('Food', limit: 10);
  /// result.fold(
  ///   (error) => print('Error: $error'),
  ///   (transactionList) => print('Food transactions: ${transactionList.transactions.length}'),
  /// );
  /// ```
  Future<DataStatus<TransactionListEntity>> getTransactionsByCategory(
    String category, {
    int? limit,
  });

  /// Gets transactions within a date range.
  /// This method filters transactions based on their date.
  ///
  /// Parameters:
  /// - [startDate]: Start date for filtering (inclusive)
  /// - [endDate]: End date for filtering (inclusive)
  ///
  /// Returns:
  /// - [DataStatus<TransactionListEntity>]: Result containing filtered transaction list or error
  ///
  /// Usage Example:
  /// ```dart
  /// final startDate = DateTime(2024, 1, 1);
  /// final endDate = DateTime(2024, 1, 31);
  /// final result = await repository.getTransactionsByDateRange(startDate, endDate);
  /// result.fold(
  ///   (error) => print('Error: $error'),
  ///   (transactionList) => print('January transactions: ${transactionList.transactions.length}'),
  /// );
  /// ```
  Future<DataStatus<TransactionListEntity>> getTransactionsByDateRange(
    DateTime startDate,
    DateTime endDate,
  );

  /// Gets transaction statistics.
  /// This method calculates aggregated data from transactions.
  ///
  /// Parameters:
  /// - [startDate]: Optional start date for statistics calculation
  /// - [endDate]: Optional end date for statistics calculation
  ///
  /// Returns:
  /// - [DataStatus<Map<String, dynamic>>]: Result containing statistics or error
  ///
  /// Usage Example:
  /// ```dart
  /// final result = await repository.getTransactionStatistics();
  /// result.fold(
  ///   (error) => print('Error: $error'),
  ///   (stats) => print('Total income: ${stats['totalIncome']}'),
  /// );
  /// ```
  Future<DataStatus<Map<String, dynamic>>> getTransactionStatistics({
    DateTime? startDate,
    DateTime? endDate,
  });

  /// Refreshes transaction data from the data source.
  /// This method forces a refresh of transaction data, useful for pull-to-refresh.
  ///
  /// Returns:
  /// - [DataStatus<TransactionListEntity>]: Result containing refreshed transaction list or error
  ///
  /// Usage Example:
  /// ```dart
  /// final result = await repository.refreshTransactions();
  /// result.fold(
  ///   (error) => print('Error: $error'),
  ///   (transactionList) => print('Refreshed: ${transactionList.transactions.length} transactions'),
  /// );
  /// ```
  Future<DataStatus<TransactionListEntity>> refreshTransactions();
}
