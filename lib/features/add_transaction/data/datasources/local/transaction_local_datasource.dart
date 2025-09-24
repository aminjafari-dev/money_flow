import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_flow/core/error/exceptions.dart';
import 'package:money_flow/shared/models/transaction/transaction_model.dart';

/// Local data source for transaction data using Hive database.
/// This handles all local storage operations for transaction information.
///
/// Usage Example:
/// ```dart
/// final localDataSource = TransactionLocalDataSource();
/// await localDataSource.initialize();
///
/// // Add transaction
/// await localDataSource.addTransaction(transactionModel);
///
/// // Get transactions
/// final transactions = await localDataSource.getTransactions();
/// ```
class TransactionLocalDataSource {
  /// Hive box name for storing transaction data
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
  /// final localDataSource = TransactionLocalDataSource();
  /// await localDataSource.initialize();
  /// ```
  Future<void> initialize() async {
    try {
      // Register adapter for type-safe storage
      if (!Hive.isAdapterRegistered(2)) {
        Hive.registerAdapter(TransactionModelAdapter());
      }

      // Open transaction data box
      _transactionBox = await Hive.openBox<TransactionModel>(
        _transactionBoxName,
      );
    } catch (e) {
      // If there's a type mismatch error (data migration issue), clear the box and retry
      if (e.toString().contains('is not a subtype of type') ||
          e.toString().contains('type cast')) {
        try {
          // Close the box if it's open
          if (_transactionBox != null && _transactionBox!.isOpen) {
            await _transactionBox!.close();
          }

          // Delete the box to clear all data
          await Hive.deleteBoxFromDisk(_transactionBoxName);

          // Try to open the box again (this will create a fresh box)
          _transactionBox = await Hive.openBox<TransactionModel>(
            _transactionBoxName,
          );
        } catch (retryError) {
          // If retry also fails, throw the original error
          throw CacheException(
            'Failed to initialize transaction local storage after data migration: $retryError',
          );
        }
      } else {
        // For other types of errors, throw cache exception
        throw CacheException(
          'Failed to initialize transaction local storage: $e',
        );
      }
    }
  }

  /// Adds a new transaction to local storage.
  /// This method stores the transaction with its ID as the key.
  ///
  /// Parameters:
  /// - [transaction]: Transaction model to store
  ///
  /// Usage Example:
  /// ```dart
  /// final transaction = TransactionModel(...);
  /// await localDataSource.addTransaction(transaction);
  /// ```
  Future<void> addTransaction(TransactionModel transaction) async {
    try {
      // Ensure box is initialized
      if (_transactionBox == null) {
        await initialize();
      }

      // Store transaction with ID as key
      await _transactionBox!.put(transaction.id, transaction);
    } catch (e) {
      throw CacheException('Failed to add transaction: $e');
    }
  }

  /// Updates an existing transaction in local storage.
  /// This method replaces the existing transaction with updated data.
  ///
  /// Parameters:
  /// - [transaction]: Updated transaction model
  ///
  /// Usage Example:
  /// ```dart
  /// final updatedTransaction = TransactionModel(...);
  /// await localDataSource.updateTransaction(updatedTransaction);
  /// ```
  Future<void> updateTransaction(TransactionModel transaction) async {
    try {
      // Ensure box is initialized
      if (_transactionBox == null) {
        await initialize();
      }

      // Update transaction with new data
      await _transactionBox!.put(transaction.id, transaction);
    } catch (e) {
      throw CacheException('Failed to update transaction: $e');
    }
  }

  /// Deletes a transaction from local storage.
  /// This method removes the transaction permanently.
  ///
  /// Parameters:
  /// - [transactionId]: ID of the transaction to delete
  ///
  /// Usage Example:
  /// ```dart
  /// await localDataSource.deleteTransaction('txn_123');
  /// ```
  Future<void> deleteTransaction(String transactionId) async {
    try {
      // Ensure box is initialized
      if (_transactionBox == null) {
        await initialize();
      }

      // Remove transaction
      await _transactionBox!.delete(transactionId);
    } catch (e) {
      throw CacheException('Failed to delete transaction: $e');
    }
  }

  /// Gets a specific transaction by its ID.
  /// This method retrieves a single transaction from local storage.
  ///
  /// Parameters:
  /// - [transactionId]: ID of the transaction to retrieve
  ///
  /// Returns:
  /// - [TransactionModel?]: Transaction model or null if not found
  ///
  /// Usage Example:
  /// ```dart
  /// final transaction = await localDataSource.getTransaction('txn_123');
  /// if (transaction != null) {
  ///   // Use transaction data
  /// }
  /// ```
  Future<TransactionModel?> getTransaction(String transactionId) async {
    try {
      // Ensure box is initialized
      if (_transactionBox == null) {
        await initialize();
      }

      // Get transaction by ID
      return _transactionBox!.get(transactionId);
    } catch (e) {
      throw CacheException('Failed to get transaction: $e');
    }
  }

  /// Gets all transactions from local storage.
  /// This method retrieves all stored transactions.
  ///
  /// Returns:
  /// - [List<TransactionModel>]: List of all transaction models
  ///
  /// Usage Example:
  /// ```dart
  /// final transactions = await localDataSource.getTransactions();
  /// for (final transaction in transactions) {
  ///   // Process each transaction
  /// }
  /// ```
  Future<List<TransactionModel>> getTransactions() async {
    try {
      // Ensure box is initialized
      if (_transactionBox == null) {
        await initialize();
      }

      // Get all transactions
      return _transactionBox!.values.toList();
    } catch (e) {
      throw CacheException('Failed to get transactions: $e');
    }
  }

  /// Gets transactions within a specific date range.
  /// This method filters transactions based on their date.
  ///
  /// Parameters:
  /// - [startDate]: Start date for filtering (inclusive)
  /// - [endDate]: End date for filtering (inclusive)
  ///
  /// Returns:
  /// - [List<TransactionModel>]: List of filtered transaction models
  ///
  /// Usage Example:
  /// ```dart
  /// final startDate = DateTime(2024, 1, 1);
  /// final endDate = DateTime(2024, 1, 31);
  /// final transactions = await localDataSource.getTransactionsByDateRange(
  ///   startDate, endDate,
  /// );
  /// ```
  Future<List<TransactionModel>> getTransactionsByDateRange(
    DateTime startDate,
    DateTime endDate,
  ) async {
    try {
      // Ensure box is initialized
      if (_transactionBox == null) {
        await initialize();
      }

      // Get all transactions and filter by date range
      final allTransactions = _transactionBox!.values.toList();
      return allTransactions.where((transaction) {
        final transactionDate = DateTime.parse(transaction.dateTime);
        return transactionDate.isAfter(
              startDate.subtract(const Duration(days: 1)),
            ) &&
            transactionDate.isBefore(endDate.add(const Duration(days: 1)));
      }).toList();
    } catch (e) {
      throw CacheException('Failed to get transactions by date range: $e');
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
  /// - [List<TransactionModel>]: List of filtered transaction models
  ///
  /// Usage Example:
  /// ```dart
  /// final foodTransactions = await localDataSource.getTransactionsByCategory(
  ///   'Food', limit: 10,
  /// );
  /// ```
  Future<List<TransactionModel>> getTransactionsByCategory(
    String category, {
    int? limit,
  }) async {
    try {
      // Ensure box is initialized
      if (_transactionBox == null) {
        await initialize();
      }

      // Get all transactions and filter by category
      final allTransactions = _transactionBox!.values.toList();
      final filteredTransactions = allTransactions
          .where((transaction) => transaction.category == category)
          .toList();

      // Apply limit if specified
      if (limit != null && limit > 0) {
        return filteredTransactions.take(limit).toList();
      }

      return filteredTransactions;
    } catch (e) {
      throw CacheException('Failed to get transactions by category: $e');
    }
  }

  /// Gets recent transactions ordered by date.
  /// This method retrieves the most recent transactions.
  ///
  /// Parameters:
  /// - [limit]: Maximum number of transactions to return
  ///
  /// Returns:
  /// - [List<TransactionModel>]: List of recent transaction models
  ///
  /// Usage Example:
  /// ```dart
  /// final recentTransactions = await localDataSource.getRecentTransactions(
  ///   limit: 5,
  /// );
  /// ```
  Future<List<TransactionModel>> getRecentTransactions({int limit = 10}) async {
    try {
      // Ensure box is initialized
      if (_transactionBox == null) {
        await initialize();
      }

      // Get all transactions and sort by date (newest first)
      final allTransactions = _transactionBox!.values.toList();
      allTransactions.sort(
        (a, b) =>
            DateTime.parse(b.dateTime).compareTo(DateTime.parse(a.dateTime)),
      );

      // Return limited results
      return allTransactions.take(limit).toList();
    } catch (e) {
      throw CacheException('Failed to get recent transactions: $e');
    }
  }

  /// Gets available categories from stored transactions.
  /// This method extracts unique categories from all transactions.
  ///
  /// Returns:
  /// - [List<String>]: List of unique category names
  ///
  /// Usage Example:
  /// ```dart
  /// final categories = await localDataSource.getAvailableCategories();
  /// // Use categories for dropdown or selection
  /// ```
  Future<List<String>> getAvailableCategories() async {
    try {
      // Ensure box is initialized
      if (_transactionBox == null) {
        await initialize();
      }

      // Get all transactions and extract unique categories
      final allTransactions = _transactionBox!.values.toList();
      final categories = allTransactions
          .map((transaction) => transaction.category)
          .toSet()
          .toList();

      // Sort categories alphabetically
      categories.sort();

      return categories;
    } catch (e) {
      throw CacheException('Failed to get available categories: $e');
    }
  }

  /// Gets available subcategories for a specific category.
  /// This method extracts unique subcategories for the given category.
  ///
  /// Parameters:
  /// - [category]: Parent category to get subcategories for
  ///
  /// Returns:
  /// - [List<String>]: List of unique subcategory names
  ///
  /// Usage Example:
  /// ```dart
  /// final subcategories = await localDataSource.getSubcategoriesForCategory('Food');
  /// // Use subcategories for dropdown or selection
  /// ```
  Future<List<String>> getSubcategoriesForCategory(String category) async {
    try {
      // Ensure box is initialized
      if (_transactionBox == null) {
        await initialize();
      }

      // No subcategories in simplified version, return empty list
      final subcategories = <String>[];

      // Sort subcategories alphabetically
      subcategories.sort();

      return subcategories;
    } catch (e) {
      throw CacheException('Failed to get subcategories for category: $e');
    }
  }

  /// Clears all transaction data from local storage.
  /// This method is useful for data cleanup or user logout scenarios.
  ///
  /// Usage Example:
  /// ```dart
  /// await localDataSource.clearAllTransactions();
  /// ```
  Future<void> clearAllTransactions() async {
    try {
      // Ensure box is initialized
      if (_transactionBox == null) {
        await initialize();
      }

      // Clear all transactions
      await _transactionBox!.clear();
    } catch (e) {
      throw CacheException('Failed to clear all transactions: $e');
    }
  }

  /// Gets transaction statistics from local storage.
  /// This method calculates aggregated data from stored transactions.
  ///
  /// Parameters:
  /// - [startDate]: Start date for statistics calculation
  /// - [endDate]: End date for statistics calculation
  ///
  /// Returns:
  /// - [Map<String, dynamic>]: Statistics data including totals and breakdowns
  ///
  /// Usage Example:
  /// ```dart
  /// final startDate = DateTime(2024, 1, 1);
  /// final endDate = DateTime(2024, 1, 31);
  /// final stats = await localDataSource.getTransactionStatistics(
  ///   startDate, endDate,
  /// );
  /// ```
  Future<Map<String, dynamic>> getTransactionStatistics(
    DateTime startDate,
    DateTime endDate,
  ) async {
    try {
      // Ensure box is initialized
      if (_transactionBox == null) {
        await initialize();
      }

      // Get transactions in date range
      final transactions = await getTransactionsByDateRange(startDate, endDate);

      // Calculate statistics
      double totalIncome = 0.0;
      double totalExpenses = 0.0;
      final categoryBreakdown = <String, double>{};
      String? mostUsedCategory;
      int maxCategoryCount = 0;
      final categoryCounts = <String, int>{};

      for (final transaction in transactions) {
        if (transaction.type == 'income') {
          totalIncome += transaction.amount;
        } else {
          totalExpenses += transaction.amount;
        }

        // Category breakdown
        categoryBreakdown[transaction.category] =
            (categoryBreakdown[transaction.category] ?? 0.0) +
            transaction.amount;

        // Most used category
        categoryCounts[transaction.category] =
            (categoryCounts[transaction.category] ?? 0) + 1;
        if (categoryCounts[transaction.category]! > maxCategoryCount) {
          maxCategoryCount = categoryCounts[transaction.category]!;
          mostUsedCategory = transaction.category;
        }
      }

      final netAmount = totalIncome - totalExpenses;
      final averageTransactionAmount = transactions.isNotEmpty
          ? (totalIncome + totalExpenses) / transactions.length
          : 0.0;

      return {
        'totalIncome': totalIncome,
        'totalExpenses': totalExpenses,
        'netAmount': netAmount,
        'transactionCount': transactions.length,
        'categoryBreakdown': categoryBreakdown,
        'mostUsedCategory': mostUsedCategory,
        'averageTransactionAmount': averageTransactionAmount,
      };
    } catch (e) {
      throw CacheException('Failed to get transaction statistics: $e');
    }
  }

  /// Gets transactions for the current week.
  /// This method retrieves all transactions from the start of the current week to now.
  ///
  /// Returns:
  /// - [List<TransactionModel>]: List of weekly transaction models
  ///
  /// Usage Example:
  /// ```dart
  /// final weeklyTransactions = await localDataSource.getWeeklyTransactions();
  /// ```
  Future<List<TransactionModel>> getWeeklyTransactions() async {
    try {
      final now = DateTime.now();
      final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
      final startDate = DateTime(
        startOfWeek.year,
        startOfWeek.month,
        startOfWeek.day,
      );
      final endDate = DateTime(now.year, now.month, now.day, 23, 59, 59);

      return await getTransactionsByDateRange(startDate, endDate);
    } catch (e) {
      throw CacheException('Failed to get weekly transactions: $e');
    }
  }

  /// Gets transactions for the current month.
  /// This method retrieves all transactions from the start of the current month to now.
  ///
  /// Returns:
  /// - [List<TransactionModel>]: List of monthly transaction models
  ///
  /// Usage Example:
  /// ```dart
  /// final monthlyTransactions = await localDataSource.getMonthlyTransactions();
  /// ```
  Future<List<TransactionModel>> getMonthlyTransactions() async {
    try {
      final now = DateTime.now();
      final startOfMonth = DateTime(now.year, now.month, 1);
      final endDate = DateTime(now.year, now.month, now.day, 23, 59, 59);

      return await getTransactionsByDateRange(startOfMonth, endDate);
    } catch (e) {
      throw CacheException('Failed to get monthly transactions: $e');
    }
  }

  /// Gets transactions for the current year.
  /// This method retrieves all transactions from the start of the current year to now.
  ///
  /// Returns:
  /// - [List<TransactionModel>]: List of yearly transaction models
  ///
  /// Usage Example:
  /// ```dart
  /// final yearlyTransactions = await localDataSource.getYearlyTransactions();
  /// ```
  Future<List<TransactionModel>> getYearlyTransactions() async {
    try {
      final now = DateTime.now();
      final startOfYear = DateTime(now.year, 1, 1);
      final endDate = DateTime(now.year, now.month, now.day, 23, 59, 59);

      return await getTransactionsByDateRange(startOfYear, endDate);
    } catch (e) {
      throw CacheException('Failed to get yearly transactions: $e');
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
      print('Error disposing transaction local data source: $e');
    }
  }
}
