import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_flow/core/error/exceptions.dart';
import 'package:money_flow/features/dashboard/data/models/dashboard_model.dart';
import 'package:money_flow/shared/models/transaction_model.dart';

/// Local data source for dashboard data using Hive database.
/// This handles all local storage operations for dashboard information.
///
/// Usage Example:
/// ```dart
/// final localDataSource = DashboardLocalDataSource();
/// await localDataSource.initialize();
///
/// // Cache dashboard data
/// await localDataSource.cacheDashboardData(dashboardModel);
///
/// // Retrieve cached data
/// final cachedData = await localDataSource.getCachedDashboardData('user123');
/// ```
class DashboardLocalDataSource {
  /// Hive box name for storing dashboard data
  static const String _dashboardBoxName = 'dashboard_data';

  /// Hive box name for storing transaction data
  static const String _transactionBoxName = 'transaction_data';

  /// Hive box instance for dashboard data
  Box<DashboardModel>? _dashboardBox;

  /// Hive box instance for transaction data
  Box<TransactionModel>? _transactionBox;

  /// Initializes Hive boxes for dashboard and transaction data.
  /// This method must be called before using any other methods.
  ///
  /// Usage Example:
  /// ```dart
  /// final localDataSource = DashboardLocalDataSource();
  /// await localDataSource.initialize();
  /// ```
  Future<void> initialize() async {
    try {
      // Register adapters for type-safe storage
      if (!Hive.isAdapterRegistered(0)) {
        Hive.registerAdapter(DashboardModelAdapter());
      }
      if (!Hive.isAdapterRegistered(1)) {
        Hive.registerAdapter(TransactionModelAdapter());
      }

      // Open dashboard data box
      _dashboardBox = await Hive.openBox<DashboardModel>(_dashboardBoxName);

      // Open transaction data box
      _transactionBox = await Hive.openBox<TransactionModel>(
        _transactionBoxName,
      );
    } catch (e) {
      // If initialization fails, throw cache exception
      throw CacheException('Failed to initialize dashboard local storage: $e');
    }
  }

  /// Retrieves cached dashboard data for a specific user.
  /// This method gets the most recent dashboard data from local storage.
  ///
  /// Parameters:
  /// - [userId]: Unique identifier for the user
  ///
  /// Returns:
  /// - [DashboardModel?]: Cached dashboard data or null if not found
  ///
  /// Usage Example:
  /// ```dart
  /// final cachedData = await localDataSource.getCachedDashboardData('user123');
  /// if (cachedData != null) {
  ///   // Use cached data for offline functionality
  ///   final dashboardEntity = cachedData.toDomain();
  /// }
  /// ```
  Future<DashboardModel?> getCachedDashboardData(String userId) async {
    try {
      // Ensure box is initialized
      if (_dashboardBox == null) {
        await initialize();
      }

      // Get dashboard data for user
      final dashboardData = _dashboardBox!.get(userId);

      if (dashboardData == null) {
        return null;
      }

      // Get recent transactions for this user
      final recentTransactions = await _getRecentTransactions(
        userId,
        limit: 10,
      );

      // Create updated dashboard model with fresh transaction data
      return DashboardModel(
        totalIncome: dashboardData.totalIncome,
        totalExpenses: dashboardData.totalExpenses,
        totalCharity: dashboardData.totalCharity,
        totalInvestments: dashboardData.totalInvestments,
        recentTransactions: recentTransactions,
      );
    } catch (e) {
      throw CacheException('Failed to retrieve cached dashboard data: $e');
    }
  }

  /// Caches dashboard data for offline access.
  /// This method stores dashboard information locally for quick retrieval.
  ///
  /// Parameters:
  /// - [userId]: Unique identifier for the user
  /// - [dashboardData]: Dashboard model to cache
  ///
  /// Usage Example:
  /// ```dart
  /// final dashboardModel = DashboardModel(...);
  /// await localDataSource.cacheDashboardData('user123', dashboardModel);
  /// ```
  Future<void> cacheDashboardData(
    String userId,
    DashboardModel dashboardData,
  ) async {
    try {
      // Ensure box is initialized
      if (_dashboardBox == null) {
        await initialize();
      }

      // Store dashboard data with user ID as key
      await _dashboardBox!.put(userId, dashboardData);

      // Cache individual transactions for better query performance
      await _cacheTransactions(userId, dashboardData.recentTransactions);
    } catch (e) {
      throw CacheException('Failed to cache dashboard data: $e');
    }
  }

  /// Updates dashboard data with new information.
  /// This method is used when user makes changes that affect dashboard calculations.
  ///
  /// Parameters:
  /// - [userId]: Unique identifier for the user
  /// - [dashboardData]: Updated dashboard data to save
  ///
  /// Usage Example:
  /// ```dart
  /// final updatedDashboard = DashboardModel(...);
  /// await localDataSource.updateDashboardData('user123', updatedDashboard);
  /// ```
  Future<void> updateDashboardData(
    String userId,
    DashboardModel dashboardData,
  ) async {
    try {
      // Ensure box is initialized
      if (_dashboardBox == null) {
        await initialize();
      }

      // Update dashboard data
      await _dashboardBox!.put(userId, dashboardData);

      // Update cached transactions
      await _cacheTransactions(userId, dashboardData.recentTransactions);
    } catch (e) {
      throw CacheException('Failed to update dashboard data: $e');
    }
  }

  /// Clears all cached dashboard data for a user.
  /// This method is useful for data cleanup or user logout scenarios.
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
      // Ensure boxes are initialized
      if (_dashboardBox == null || _transactionBox == null) {
        await initialize();
      }

      // Remove dashboard data
      await _dashboardBox!.delete(userId);

      // Remove all transactions for this user
      final userTransactionKeys = _transactionBox!.keys
          .where((key) => key.toString().startsWith('${userId}_'))
          .toList();

      await _transactionBox!.deleteAll(userTransactionKeys);
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
      // Get all transaction keys for this user
      final userTransactionKeys = _transactionBox!.keys
          .where((key) => key.toString().startsWith('${userId}_'))
          .toList();

      // Sort keys by timestamp (newest first)
      userTransactionKeys.sort((a, b) => b.toString().compareTo(a.toString()));

      // Get transactions up to the limit
      final transactions = <TransactionModel>[];
      for (int i = 0; i < limit && i < userTransactionKeys.length; i++) {
        final transaction = _transactionBox!.get(userTransactionKeys[i]);
        if (transaction != null) {
          transactions.add(transaction);
        }
      }

      return transactions;
    } catch (e) {
      throw CacheException('Failed to retrieve recent transactions: $e');
    }
  }

  /// Private method to cache transactions in Hive.
  /// This method stores individual transactions for efficient querying.
  ///
  /// Parameters:
  /// - [userId]: Unique identifier for the user
  /// - [transactions]: List of transactions to cache
  Future<void> _cacheTransactions(
    String userId,
    List<TransactionModel> transactions,
  ) async {
    try {
      // Ensure transaction box is initialized
      if (_transactionBox == null) {
        await initialize();
      }

      // Cache each transaction with user-specific key
      for (final transaction in transactions) {
        final key =
            '${userId}_${transaction.id}_${DateTime.parse(transaction.dateTime).millisecondsSinceEpoch}';
        await _transactionBox!.put(key, transaction);
      }
    } catch (e) {
      throw CacheException('Failed to cache transactions: $e');
    }
  }

  /// Closes Hive boxes and cleans up resources.
  /// This method should be called when the data source is no longer needed.
  ///
  /// Usage Example:
  /// ```dart
  /// await localDataSource.dispose();
  /// ```
  Future<void> dispose() async {
    try {
      await _dashboardBox?.close();
      await _transactionBox?.close();
    } catch (e) {
      // Log error but don't throw exception during cleanup
      print('Error disposing dashboard local data source: $e');
    }
  }
}
