import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_flow/core/error/exceptions.dart';
import 'package:money_flow/features/dashboard/data/models/dashboard_model.dart';
import 'package:money_flow/shared/models/transaction_model.dart';

/// Local data source for dashboard data using Hive database.
/// This handles all local storage operations for dashboard information.
/// Uses shared TransactionModel for consistency across the app.
///
/// Usage Example:
/// ```dart
/// final localDataSource = DashboardLocalDataSource();
/// await localDataSource.initialize();
///
/// // Cache dashboard data
/// await localDataSource.cacheDashboardData('user123', dashboardModel);
///
/// // Retrieve cached data
/// final cachedData = await localDataSource.getCachedDashboardData('user123');
/// ```
class DashboardLocalDataSource {
  /// Hive box name for storing transaction data
  /// Note: This should match the box name used in TransactionLocalDataSource
  static const String _transactionBoxName = 'transactions';

  /// Hive box instance for transaction data
  Box<TransactionModel>? _transactionBox;

  /// Initializes Hive box for transaction data.
  /// This method must be called before using any other methods.
  ///
  /// If there's a data migration issue (type mismatch), it will clear the existing data
  /// and start fresh to prevent app crashes.
  ///
  /// Usage Example:
  /// ```dart
  /// final localDataSource = DashboardLocalDataSource();
  /// await localDataSource.initialize();
  /// ```
  Future<void> initialize() async {
    try {
      // Note: TransactionModelAdapter is registered by TransactionLocalDataSource
      // with typeId: 2, not here with typeId: 1

      // Open transaction data box
      // Note: This uses the same box name as TransactionLocalDataSource
      // to ensure consistency across the app
      _transactionBox = await Hive.openBox<TransactionModel>(
        _transactionBoxName,
      );
    } catch (e) {
      // If there's a type mismatch error (data migration issue), clear the box and retry
      if (e.toString().contains('is not a subtype of type') ||
          e.toString().contains('type cast') ||
          e.toString().contains('unknown typeId') ||
          e.toString().contains('Did you forget to register an adapter')) {
        try {
          // Close box if it's open
          if (_transactionBox != null && _transactionBox!.isOpen) {
            await _transactionBox!.close();
          }

          // Delete the box to clear all data
          await Hive.deleteBoxFromDisk(_transactionBoxName);

          // Try to open the box again (this will create fresh box)
          _transactionBox = await Hive.openBox<TransactionModel>(
            _transactionBoxName,
          );
        } catch (retryError) {
          // If retry also fails, throw the original error
          throw CacheException(
            'Failed to initialize dashboard local storage after data migration: $retryError',
          );
        }
      } else {
        // For other types of errors, throw cache exception
        throw CacheException(
          'Failed to initialize dashboard local storage: $e',
        );
      }
    }
  }

  /// Retrieves dashboard data calculated from transactions.
  /// This method calculates dashboard data from stored transactions.
  ///
  /// Parameters:
  /// - [userId]: Unique identifier for the user
  ///
  /// Returns:
  /// - [DashboardModel]: Calculated dashboard data from transactions
  ///
  /// Usage Example:
  /// ```dart
  /// final dashboardData = await localDataSource.getCachedDashboardData('user123');
  /// final dashboardEntity = dashboardData.toDomain();
  /// ```
  Future<DashboardModel> getCachedDashboardData(String userId) async {
    try {
      // Ensure box is initialized
      if (_transactionBox == null) {
        await initialize();
      }

      // Get all transactions from the transaction box
      final allTransactions = _transactionBox!.values.toList();

      // Calculate totals from transactions
      double totalIncome = 0.0;
      double totalExpenses = 0.0;
      double totalCharity = 0.0;
      double totalInvestments = 0.0;

      for (final transaction in allTransactions) {
        final amount = transaction.amount;
        final mainCategory = transaction.mainCategory.toLowerCase();

        if (transaction.type.toLowerCase() == 'income') {
          totalIncome += amount;
        } else if (transaction.type.toLowerCase() == 'expense') {
          totalExpenses += amount.abs(); // Ensure positive value for expenses

          // Categorize expenses
          if (mainCategory == 'charity') {
            totalCharity += amount.abs();
          } else if (mainCategory == 'investments') {
            totalInvestments += amount.abs();
          }
        }
      }

      // Get recent transactions (last 10)
      final recentTransactions = await _getRecentTransactions(
        userId,
        limit: 10,
      );

      // Create dashboard model with calculated data
      return DashboardModel(
        totalIncome: totalIncome,
        totalExpenses: totalExpenses,
        totalCharity: totalCharity,
        totalInvestments: totalInvestments,
        recentTransactions: recentTransactions,
      );
    } catch (e) {
      throw CacheException('Failed to retrieve dashboard data: $e');
    }
  }

  /// Refreshes dashboard data by recalculating from transactions.
  /// This method is used when user makes changes that affect dashboard calculations.
  ///
  /// Parameters:
  /// - [userId]: Unique identifier for the user
  ///
  /// Usage Example:
  /// ```dart
  /// await localDataSource.refreshDashboardData('user123');
  /// ```
  Future<void> refreshDashboardData(String userId) async {
    try {
      // Dashboard data is now calculated on-demand from transactions
      // No need to cache separate dashboard data
      // This method is kept for API compatibility
    } catch (e) {
      throw CacheException('Failed to refresh dashboard data: $e');
    }
  }

  /// Clears all transaction data.
  /// This method is useful for data cleanup or user logout scenarios.
  /// Note: This clears ALL transactions since we don't use user-specific keys.
  ///
  /// Parameters:
  /// - [userId]: Unique identifier for the user
  ///
  /// Usage Example:
  /// ```dart
  /// await localDataSource.clearCachedData('user123');
  /// ```
  Future<void> clearCachedData(String userId) async {
    try {
      // Ensure transaction box is initialized
      if (_transactionBox == null) {
        await initialize();
      }

      // Clear all transactions (since we don't use user-specific keys)
      // In a multi-user app, this would need to be more selective
      await _transactionBox!.clear();
    } catch (e) {
      throw CacheException('Failed to clear cached data: $e');
    }
  }

  /// Gets recent transactions for a specific user.
  /// This method retrieves the most recent transactions from local storage.
  ///
  /// Parameters:
  /// - [userId]: Unique identifier for the user
  /// - [limit]: Maximum number of transactions to retrieve (default: 10)
  ///
  /// Returns:
  /// - [List<TransactionModel>]: List of recent transaction models
  ///
  /// Usage Example:
  /// ```dart
  /// final recentTransactions = await localDataSource.getRecentTransactions('user123', limit: 5);
  /// ```
  Future<List<TransactionModel>> getRecentTransactions(
    String userId, {
    int limit = 10,
  }) async {
    try {
      // Ensure transaction box is initialized
      if (_transactionBox == null) {
        await initialize();
      }

      return await _getRecentTransactions(userId, limit: limit);
    } catch (e) {
      throw CacheException('Failed to retrieve recent transactions: $e');
    }
  }

  /// Private method to retrieve recent transactions from Hive.
  /// This method handles the actual data retrieval logic.
  ///
  /// Parameters:
  /// - [userId]: Unique identifier for the user
  /// - [limit]: Maximum number of transactions to retrieve
  ///
  /// Returns:
  /// - [List<TransactionModel>]: List of recent transaction models
  Future<List<TransactionModel>> _getRecentTransactions(
    String userId, {
    int limit = 10,
  }) async {
    try {
      // Get all transactions from the transaction box (not user-specific keys)
      final allTransactions = _transactionBox!.values.toList();

      // Sort transactions by date (newest first)
      allTransactions.sort((a, b) {
        final dateA = DateTime.parse(a.dateTime);
        final dateB = DateTime.parse(b.dateTime);
        return dateB.compareTo(dateA);
      });

      // Return limited results
      final transactions = allTransactions.take(limit).toList();
      return transactions;
    } catch (e) {
      throw CacheException('Failed to retrieve recent transactions: $e');
    }
  }

  /// Closes Hive box and cleans up resources.
  /// This method should be called when the data source is no longer needed.
  ///
  /// Usage Example:
  /// ```dart
  /// await localDataSource.dispose();
  /// ```
  Future<void> dispose() async {
    try {
      await _transactionBox?.close();
    } catch (e) {
      // Log error but don't throw exception during cleanup
      // In production, this should use proper logging
      // ignore: avoid_print
      print('Error disposing dashboard local data source: $e');
    }
  }
}
