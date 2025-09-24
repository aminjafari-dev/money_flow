import 'package:money_flow/core/data_status.dart';
import 'package:money_flow/core/error/failures.dart';
import 'package:money_flow/features/transactions/data/datasources/local/transactions_local_datasource.dart';
import 'package:money_flow/features/transactions/domain/entities/transaction_list_entity.dart';
import 'package:money_flow/features/transactions/domain/repositories/transactions_repository.dart';

/// Implementation of TransactionsRepository using local data source.
/// This repository handles all transaction list operations using local storage.
///
/// The repository pattern provides a clean abstraction over data sources,
/// allowing the domain layer to be independent of data implementation details.
///
/// Usage Example:
/// ```dart
/// final repository = TransactionsRepositoryImpl(localDataSource);
/// final result = await repository.getAllTransactions();
/// result.fold(
///   (error) => print('Error: $error'),
///   (transactionList) => print('Found ${transactionList.transactions.length} transactions'),
/// );
/// ```
class TransactionsRepositoryImpl implements TransactionsRepository {
  /// Local data source for transaction operations
  final TransactionsLocalDataSource _localDataSource;

  /// Creates a new instance of TransactionsRepositoryImpl.
  ///
  /// Parameters:
  /// - [localDataSource]: Local data source for transaction operations
  ///
  /// Usage Example:
  /// ```dart
  /// final repository = TransactionsRepositoryImpl(transactionsLocalDataSource);
  /// ```
  const TransactionsRepositoryImpl(this._localDataSource);

  @override
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
  Future<DataStatus<TransactionListEntity>> getAllTransactions() async {
    try {
      // Ensure data source is initialized
      await _localDataSource.initialize();

      // Get all transactions from local data source
      final transactionList = await _localDataSource.getAllTransactions();

      // Return success result
      return DataSuccess(transactionList);
    } catch (e) {
      // Return error result
      return DataFailed(ServerFailure('Failed to get all transactions: $e'));
    }
  }

  @override
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
  }) async {
    try {
      // Validate parameters
      if (page < 1) {
        return DataFailed(
          ValidationFailure('Page number must be greater than 0'),
        );
      }
      if (limit < 1) {
        return DataFailed(ValidationFailure('Limit must be greater than 0'));
      }

      // Ensure data source is initialized
      await _localDataSource.initialize();

      // Get paginated transactions from local data source
      final transactionList = await _localDataSource.getTransactionsPaginated(
        page: page,
        limit: limit,
      );

      // Return success result
      return DataSuccess(transactionList);
    } catch (e) {
      // Return error result
      return DataFailed(
        ServerFailure('Failed to get paginated transactions: $e'),
      );
    }
  }

  @override
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
  }) async {
    try {
      // Validate limit parameter if provided
      if (limit != null && limit <= 0) {
        return DataFailed(ValidationFailure('Limit must be a positive number'));
      }

      // Ensure data source is initialized
      await _localDataSource.initialize();

      // Get transactions sorted by date from local data source
      final transactionList = await _localDataSource
          .getTransactionsSortedByDate(limit: limit);

      // Return success result
      return DataSuccess(transactionList);
    } catch (e) {
      // Return error result
      return DataFailed(
        ServerFailure('Failed to get transactions sorted by date: $e'),
      );
    }
  }

  @override
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
  }) async {
    try {
      // Validate category parameter
      if (category.isEmpty) {
        return DataFailed(ValidationFailure('Category cannot be empty'));
      }

      // Validate limit parameter if provided
      if (limit != null && limit <= 0) {
        return DataFailed(ValidationFailure('Limit must be a positive number'));
      }

      // Ensure data source is initialized
      await _localDataSource.initialize();

      // Get transactions by category from local data source
      final transactionList = await _localDataSource.getTransactionsByCategory(
        category,
        limit: limit,
      );

      // Return success result
      return DataSuccess(transactionList);
    } catch (e) {
      // Return error result
      return DataFailed(
        ServerFailure('Failed to get transactions by category: $e'),
      );
    }
  }

  @override
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
  ) async {
    try {
      // Validate date parameters
      if (startDate.isAfter(endDate)) {
        return DataFailed(
          ValidationFailure('Start date cannot be after end date'),
        );
      }

      // Ensure data source is initialized
      await _localDataSource.initialize();

      // Get transactions by date range from local data source
      final transactionList = await _localDataSource.getTransactionsByDateRange(
        startDate,
        endDate,
      );

      // Return success result
      return DataSuccess(transactionList);
    } catch (e) {
      // Return error result
      return DataFailed(
        ServerFailure('Failed to get transactions by date range: $e'),
      );
    }
  }

  @override
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
  }) async {
    try {
      // Validate date parameters if provided
      if (startDate != null && endDate != null && startDate.isAfter(endDate)) {
        return DataFailed(
          ValidationFailure('Start date cannot be after end date'),
        );
      }

      // Ensure data source is initialized
      await _localDataSource.initialize();

      // Get transaction statistics from local data source
      final statistics = await _localDataSource.getTransactionStatistics(
        startDate: startDate,
        endDate: endDate,
      );

      // Return success result
      return DataSuccess(statistics);
    } catch (e) {
      // Return error result
      return DataFailed(
        ServerFailure('Failed to get transaction statistics: $e'),
      );
    }
  }

  @override
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
  Future<DataStatus<TransactionListEntity>> refreshTransactions() async {
    try {
      // Ensure data source is initialized
      await _localDataSource.initialize();

      // Refresh transactions from local data source
      final transactionList = await _localDataSource.refreshTransactions();

      // Return success result
      return DataSuccess(transactionList);
    } catch (e) {
      // Return error result
      return DataFailed(ServerFailure('Failed to refresh transactions: $e'));
    }
  }
}
