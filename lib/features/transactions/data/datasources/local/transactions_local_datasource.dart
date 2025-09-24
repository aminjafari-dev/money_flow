import 'package:money_flow/core/error/exceptions.dart';
import 'package:money_flow/features/add_transaction/data/datasources/local/transaction_local_datasource.dart';
import 'package:money_flow/features/transactions/domain/entities/transaction_list_entity.dart';

/// Local data source for transactions list data using existing transaction local data source.
/// This handles all local storage operations for transaction list information.
///
/// This data source leverages the existing TransactionLocalDataSource to provide
/// transaction list functionality without duplicating storage logic.
///
/// Usage Example:
/// ```dart
/// final localDataSource = TransactionsLocalDataSource(transactionLocalDataSource);
/// await localDataSource.initialize();
///
/// // Get all transactions
/// final transactions = await localDataSource.getAllTransactions();
///
/// // Get transactions sorted by date
/// final sortedTransactions = await localDataSource.getTransactionsSortedByDate();
/// ```
class TransactionsLocalDataSource {
  /// Local data source for individual transaction operations
  final TransactionLocalDataSource _transactionLocalDataSource;

  /// Creates a new instance of TransactionsLocalDataSource.
  ///
  /// Parameters:
  /// - [transactionLocalDataSource]: Local data source for transaction operations
  ///
  /// Usage Example:
  /// ```dart
  /// final localDataSource = TransactionsLocalDataSource(transactionLocalDataSource);
  /// ```
  const TransactionsLocalDataSource(this._transactionLocalDataSource);

  /// Initializes the local data source.
  /// This method ensures the underlying transaction data source is ready.
  ///
  /// Usage Example:
  /// ```dart
  /// await localDataSource.initialize();
  /// ```
  Future<void> initialize() async {
    try {
      // Initialize the underlying transaction local data source
      await _transactionLocalDataSource.initialize();
    } catch (e) {
      throw CacheException(
        'Failed to initialize transactions local data source: $e',
      );
    }
  }

  /// Gets all transactions from local storage.
  /// This method retrieves all stored transactions and converts them to entities.
  ///
  /// Returns:
  /// - [TransactionListEntity]: List of all transaction entities
  ///
  /// Usage Example:
  /// ```dart
  /// final transactionList = await localDataSource.getAllTransactions();
  /// print('Found ${transactionList.transactions.length} transactions');
  /// ```
  Future<TransactionListEntity> getAllTransactions() async {
    try {
      // Get all transactions from the underlying data source
      final transactionModels = await _transactionLocalDataSource
          .getTransactions();

      // Convert models to entities
      final transactionEntities = transactionModels
          .map((model) => model.toDomain())
          .toList();

      // Create and return transaction list entity
      return TransactionListEntity(
        transactions: transactionEntities,
        totalCount: transactionEntities.length,
        hasMore: false, // Local storage doesn't support pagination
      );
    } catch (e) {
      throw CacheException('Failed to get all transactions: $e');
    }
  }

  /// Gets transactions with pagination support.
  /// This method retrieves transactions in chunks for better performance.
  ///
  /// Parameters:
  /// - [page]: Page number (starting from 1)
  /// - [limit]: Number of transactions per page
  ///
  /// Returns:
  /// - [TransactionListEntity]: Paginated list of transaction entities
  ///
  /// Usage Example:
  /// ```dart
  /// final transactionList = await localDataSource.getTransactionsPaginated(
  ///   page: 1, limit: 20,
  /// );
  /// print('Page 1: ${transactionList.transactions.length} transactions');
  /// ```
  Future<TransactionListEntity> getTransactionsPaginated({
    int page = 1,
    int limit = 20,
  }) async {
    try {
      // Get all transactions first
      final allTransactions = await getAllTransactions();

      // Calculate pagination
      final startIndex = (page - 1) * limit;

      // Get paginated transactions
      final paginatedTransactions = allTransactions.transactions
          .skip(startIndex)
          .take(limit)
          .toList();

      // Calculate total pages
      final totalPages = (allTransactions.totalCount / limit).ceil();
      final hasMore = page < totalPages;

      // Return paginated transaction list entity
      return TransactionListEntity(
        transactions: paginatedTransactions,
        totalCount: allTransactions.totalCount,
        hasMore: hasMore,
      );
    } catch (e) {
      throw CacheException('Failed to get paginated transactions: $e');
    }
  }

  /// Gets transactions sorted by date (newest first).
  /// This method retrieves transactions ordered by their date/time.
  ///
  /// Parameters:
  /// - [limit]: Optional limit on number of results
  ///
  /// Returns:
  /// - [TransactionListEntity]: Sorted list of transaction entities
  ///
  /// Usage Example:
  /// ```dart
  /// final transactionList = await localDataSource.getTransactionsSortedByDate(limit: 50);
  /// print('Recent transactions: ${transactionList.transactions.length}');
  /// ```
  Future<TransactionListEntity> getTransactionsSortedByDate({
    int? limit,
  }) async {
    try {
      // Get all transactions first
      final allTransactions = await getAllTransactions();

      // Sort by date (newest first)
      final sortedTransactions = allTransactions.sortedByDate;

      // Apply limit if specified
      final limitedTransactions = limit != null && limit > 0
          ? sortedTransactions.take(limit).toList()
          : sortedTransactions;

      // Return sorted transaction list entity
      return TransactionListEntity(
        transactions: limitedTransactions,
        totalCount: allTransactions.totalCount,
        hasMore:
            limit != null && limit > 0 && sortedTransactions.length > limit,
      );
    } catch (e) {
      throw CacheException('Failed to get transactions sorted by date: $e');
    }
  }

  /// Gets transactions by category.
  /// This method filters transactions based on their category.
  ///
  /// Parameters:
  /// - [category]: Category to filter by
  /// - [limit]: Optional limit on number of results
  ///
  /// Returns:
  /// - [TransactionListEntity]: Filtered list of transaction entities
  ///
  /// Usage Example:
  /// ```dart
  /// final transactionList = await localDataSource.getTransactionsByCategory(
  ///   'Food', limit: 10,
  /// );
  /// print('Food transactions: ${transactionList.transactions.length}');
  /// ```
  Future<TransactionListEntity> getTransactionsByCategory(
    String category, {
    int? limit,
  }) async {
    try {
      // Get all transactions first
      final allTransactions = await getAllTransactions();

      // Filter by category
      final filteredTransactions = allTransactions.transactions
          .where((transaction) => transaction.category == category)
          .toList();

      // Apply limit if specified
      final limitedTransactions = limit != null && limit > 0
          ? filteredTransactions.take(limit).toList()
          : filteredTransactions;

      // Return filtered transaction list entity
      return TransactionListEntity(
        transactions: limitedTransactions,
        totalCount: filteredTransactions.length,
        hasMore:
            limit != null && limit > 0 && filteredTransactions.length > limit,
      );
    } catch (e) {
      throw CacheException('Failed to get transactions by category: $e');
    }
  }

  /// Gets transactions within a date range.
  /// This method filters transactions based on their date.
  ///
  /// Parameters:
  /// - [startDate]: Start date for filtering (inclusive)
  /// - [endDate]: End date for filtering (inclusive)
  ///
  /// Returns:
  /// - [TransactionListEntity]: Filtered list of transaction entities
  ///
  /// Usage Example:
  /// ```dart
  /// final startDate = DateTime(2024, 1, 1);
  /// final endDate = DateTime(2024, 1, 31);
  /// final transactionList = await localDataSource.getTransactionsByDateRange(
  ///   startDate, endDate,
  /// );
  /// print('January transactions: ${transactionList.transactions.length}');
  /// ```
  Future<TransactionListEntity> getTransactionsByDateRange(
    DateTime startDate,
    DateTime endDate,
  ) async {
    try {
      // Get transactions by date range from the underlying data source
      final transactionModels = await _transactionLocalDataSource
          .getTransactionsByDateRange(startDate, endDate);

      // Convert models to entities
      final transactionEntities = transactionModels
          .map((model) => model.toDomain())
          .toList();

      // Return filtered transaction list entity
      return TransactionListEntity(
        transactions: transactionEntities,
        totalCount: transactionEntities.length,
        hasMore: false, // Date range queries don't support pagination
      );
    } catch (e) {
      throw CacheException('Failed to get transactions by date range: $e');
    }
  }

  /// Gets transaction statistics.
  /// This method calculates aggregated data from transactions.
  ///
  /// Parameters:
  /// - [startDate]: Optional start date for statistics calculation
  /// - [endDate]: Optional end date for statistics calculation
  ///
  /// Returns:
  /// - [Map<String, dynamic>]: Statistics data including totals and breakdowns
  ///
  /// Usage Example:
  /// ```dart
  /// final stats = await localDataSource.getTransactionStatistics();
  /// print('Total income: ${stats['totalIncome']}');
  /// ```
  Future<Map<String, dynamic>> getTransactionStatistics({
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    try {
      // Use the underlying data source for statistics
      if (startDate != null && endDate != null) {
        return await _transactionLocalDataSource.getTransactionStatistics(
          startDate,
          endDate,
        );
      } else {
        // Get statistics for all time
        final now = DateTime.now();
        final startOfYear = DateTime(now.year, 1, 1);
        return await _transactionLocalDataSource.getTransactionStatistics(
          startOfYear,
          now,
        );
      }
    } catch (e) {
      throw CacheException('Failed to get transaction statistics: $e');
    }
  }

  /// Refreshes transaction data from local storage.
  /// This method forces a refresh of transaction data, useful for pull-to-refresh.
  ///
  /// Returns:
  /// - [TransactionListEntity]: Refreshed list of transaction entities
  ///
  /// Usage Example:
  /// ```dart
  /// final transactionList = await localDataSource.refreshTransactions();
  /// print('Refreshed: ${transactionList.transactions.length} transactions');
  /// ```
  Future<TransactionListEntity> refreshTransactions() async {
    try {
      // For local storage, refresh is the same as getting all transactions
      // In a real implementation with remote data, this would sync with server
      return await getAllTransactions();
    } catch (e) {
      throw CacheException('Failed to refresh transactions: $e');
    }
  }

  /// Closes the data source and cleans up resources.
  /// This method should be called when the data source is no longer needed.
  ///
  /// Usage Example:
  /// ```dart
  /// await localDataSource.dispose();
  /// ```
  Future<void> dispose() async {
    try {
      // Dispose the underlying transaction local data source
      await _transactionLocalDataSource.dispose();
    } catch (e) {
      // Log error but don't throw exception during cleanup
      print('Error disposing transactions local data source: $e');
    }
  }
}
