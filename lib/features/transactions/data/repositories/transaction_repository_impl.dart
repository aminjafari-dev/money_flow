import 'package:dartz/dartz.dart';
import 'package:money_flow/core/error/exceptions.dart';
import 'package:money_flow/core/error/failures.dart';
import 'package:money_flow/features/transactions/data/datasources/local/transaction_local_datasource.dart';
import 'package:money_flow/shared/models/transaction_model.dart';
import 'package:money_flow/features/transactions/domain/entities/transaction_entity.dart';
import 'package:money_flow/features/transactions/domain/repositories/transaction_repository.dart';

/// Implementation of TransactionRepository using local data source.
/// This repository handles all transaction operations using Hive local storage.
///
/// Usage Example:
/// ```dart
/// final repository = TransactionRepositoryImpl(
///   localDataSource: getIt<TransactionLocalDataSource>(),
/// );
///
/// final result = await repository.addTransaction(transaction);
/// result.fold(
///   (failure) => print('Error: ${failure.message}'),
///   (transaction) => print('Transaction added: ${transaction.id}'),
/// );
/// ```
class TransactionRepositoryImpl implements TransactionRepository {
  final TransactionLocalDataSource localDataSource;

  TransactionRepositoryImpl({required this.localDataSource});

  /// Adds a new transaction to the system.
  /// This method validates the transaction and stores it locally.
  ///
  /// Parameters:
  /// - [transaction]: The transaction entity to be added
  ///
  /// Returns:
  /// - [Either<Failure, TransactionEntity>]: Success with the created transaction or failure
  ///
  /// This method handles the business logic for adding transactions,
  /// including validation, categorization, and persistence.
  @override
  Future<Either<Failure, TransactionEntity>> addTransaction(
    TransactionEntity transaction,
  ) async {
    try {
      // Convert entity to model
      final transactionModel = TransactionModel.fromDomain(transaction);

      // Add to local storage
      await localDataSource.addTransaction(transactionModel);

      // Return success with the transaction
      return Right(transaction);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure('Failed to add transaction: $e'));
    }
  }

  /// Updates an existing transaction.
  /// This method validates the updated transaction and stores it locally.
  ///
  /// Parameters:
  /// - [transaction]: The updated transaction entity
  ///
  /// Returns:
  /// - [Either<Failure, TransactionEntity>]: Success with the updated transaction or failure
  ///
  /// This method allows users to modify transaction details after creation.
  @override
  Future<Either<Failure, TransactionEntity>> updateTransaction(
    TransactionEntity transaction,
  ) async {
    try {
      // Convert entity to model
      final transactionModel = TransactionModel.fromDomain(transaction);

      // Update in local storage
      await localDataSource.updateTransaction(transactionModel);

      // Return success with the updated transaction
      return Right(transaction);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure('Failed to update transaction: $e'));
    }
  }

  /// Deletes a transaction by its ID.
  /// This method removes the transaction from local storage.
  ///
  /// Parameters:
  /// - [transactionId]: The unique identifier of the transaction to delete
  ///
  /// Returns:
  /// - [Either<Failure, Unit>]: Success or failure indication
  ///
  /// This method removes transactions from the system permanently.
  @override
  Future<Either<Failure, Unit>> deleteTransaction(String transactionId) async {
    try {
      // Delete from local storage
      await localDataSource.deleteTransaction(transactionId);

      // Return success
      return const Right(unit);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure('Failed to delete transaction: $e'));
    }
  }

  /// Gets a transaction by its ID.
  /// This method retrieves a specific transaction from local storage.
  ///
  /// Parameters:
  /// - [transactionId]: The unique identifier of the transaction
  ///
  /// Returns:
  /// - [Either<Failure, TransactionEntity>]: Success with the transaction or failure
  ///
  /// This method retrieves specific transaction details for editing or viewing.
  @override
  Future<Either<Failure, TransactionEntity>> getTransaction(
    String transactionId,
  ) async {
    try {
      // Get from local storage
      final transactionModel = await localDataSource.getTransaction(
        transactionId,
      );

      if (transactionModel == null) {
        return Left(NotFoundFailure('Transaction not found'));
      }

      // Convert to entity and return
      return Right(transactionModel.toDomain());
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure('Failed to get transaction: $e'));
    }
  }

  /// Gets all transactions for a specific date range.
  /// This method retrieves transactions within the specified date range.
  ///
  /// Parameters:
  /// - [startDate]: The start date for the range (inclusive)
  /// - [endDate]: The end date for the range (inclusive)
  ///
  /// Returns:
  /// - [Either<Failure, List<TransactionEntity>>]: Success with transaction list or failure
  ///
  /// This method is used for displaying transaction history and analytics.
  @override
  Future<Either<Failure, List<TransactionEntity>>> getTransactionsByDateRange(
    DateTime startDate,
    DateTime endDate,
  ) async {
    try {
      // Get from local storage
      final transactionModels = await localDataSource
          .getTransactionsByDateRange(startDate, endDate);

      // Convert to entities
      final transactions = transactionModels
          .map((model) => model.toDomain())
          .toList();

      return Right(transactions);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    } catch (e) {
      return Left(
        UnknownFailure('Failed to get transactions by date range: $e'),
      );
    }
  }

  /// Gets transactions by category.
  /// This method retrieves transactions filtered by category.
  ///
  /// Parameters:
  /// - [category]: The category to filter by
  /// - [limit]: Optional limit on the number of results
  ///
  /// Returns:
  /// - [Either<Failure, List<TransactionEntity>>]: Success with transaction list or failure
  ///
  /// This method helps with category-specific analysis and filtering.
  @override
  Future<Either<Failure, List<TransactionEntity>>> getTransactionsByCategory(
    String category, {
    int? limit,
  }) async {
    try {
      // Get from local storage
      final transactionModels = await localDataSource.getTransactionsByCategory(
        category,
        limit: limit,
      );

      // Convert to entities
      final transactions = transactionModels
          .map((model) => model.toDomain())
          .toList();

      return Right(transactions);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure('Failed to get transactions by category: $e'));
    }
  }

  /// Gets recent transactions for quick access.
  /// This method retrieves the most recent transactions.
  ///
  /// Parameters:
  /// - [limit]: Maximum number of recent transactions to return
  ///
  /// Returns:
  /// - [Either<Failure, List<TransactionEntity>>]: Success with recent transactions or failure
  ///
  /// This method provides quick access to the most recent transactions,
  /// useful for dashboard displays and quick reference.
  @override
  Future<Either<Failure, List<TransactionEntity>>> getRecentTransactions({
    int limit = 10,
  }) async {
    try {
      // Get from local storage
      final transactionModels = await localDataSource.getRecentTransactions(
        limit: limit,
      );

      // Convert to entities
      final transactions = transactionModels
          .map((model) => model.toDomain())
          .toList();

      return Right(transactions);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure('Failed to get recent transactions: $e'));
    }
  }

  /// Gets available categories for transaction categorization.
  /// This method retrieves all unique categories from stored transactions.
  ///
  /// Returns:
  /// - [Either<Failure, List<String>>]: Success with category list or failure
  ///
  /// This method provides the list of available categories for the add transaction form.
  @override
  Future<Either<Failure, List<String>>> getAvailableCategories() async {
    try {
      // Get from local storage
      final categories = await localDataSource.getAvailableCategories();

      // If no categories found, return default categories
      if (categories.isEmpty) {
        return const Right([
          'Food',
          'Transportation',
          'Entertainment',
          'Utilities',
          'Other',
        ]);
      }

      return Right(categories);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure('Failed to get available categories: $e'));
    }
  }

  /// Gets available subcategories for a specific category.
  /// This method retrieves all unique subcategories for the given category.
  ///
  /// Parameters:
  /// - [category]: The parent category
  ///
  /// Returns:
  /// - [Either<Failure, List<String>>]: Success with subcategory list or failure
  ///
  /// This method provides subcategories based on the selected main category.
  @override
  Future<Either<Failure, List<String>>> getSubcategoriesForCategory(
    String category,
  ) async {
    try {
      // Get from local storage
      final subcategories = await localDataSource.getSubcategoriesForCategory(
        category,
      );

      // If no subcategories found, return default subcategories based on category
      if (subcategories.isEmpty) {
        final defaultSubcategories = _getDefaultSubcategories(category);
        return Right(defaultSubcategories);
      }

      return Right(subcategories);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    } catch (e) {
      return Left(
        UnknownFailure('Failed to get subcategories for category: $e'),
      );
    }
  }

  /// Gets transaction statistics for analytics.
  /// This method calculates aggregated data from stored transactions.
  ///
  /// Parameters:
  /// - [startDate]: The start date for statistics calculation
  /// - [endDate]: The end date for statistics calculation
  ///
  /// Returns:
  /// - [Either<Failure, TransactionStatistics>]: Success with statistics or failure
  ///
  /// This method provides aggregated data for dashboard and analytics features.
  @override
  Future<Either<Failure, TransactionStatistics>> getTransactionStatistics(
    DateTime startDate,
    DateTime endDate,
  ) async {
    try {
      // Get statistics from local storage
      final statsData = await localDataSource.getTransactionStatistics(
        startDate,
        endDate,
      );

      // Create statistics object
      final statistics = TransactionStatistics(
        totalIncome: statsData['totalIncome'] as double,
        totalExpenses: statsData['totalExpenses'] as double,
        netAmount: statsData['netAmount'] as double,
        transactionCount: statsData['transactionCount'] as int,
        categoryBreakdown: Map<String, double>.from(
          statsData['categoryBreakdown'],
        ),
        mostUsedCategory: statsData['mostUsedCategory'] as String?,
        averageTransactionAmount:
            statsData['averageTransactionAmount'] as double,
      );

      return Right(statistics);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure('Failed to get transaction statistics: $e'));
    }
  }

  /// Suggests category and subcategory based on transaction details.
  /// This method uses simple pattern matching for category suggestions.
  ///
  /// Parameters:
  /// - [amount]: The transaction amount
  /// - [description]: The transaction description
  /// - [merchant]: The merchant name (if available)
  ///
  /// Returns:
  /// - [Either<Failure, CategorySuggestion>]: Success with suggestions or failure
  ///
  /// This method uses simple pattern matching to suggest appropriate categories.
  @override
  Future<Either<Failure, CategorySuggestion>> suggestCategory({
    required double amount,
    String? description,
    String? merchant,
  }) async {
    try {
      // Simple pattern matching for category suggestions
      final suggestedCategory = _suggestCategoryFromPatterns(
        description: description,
        merchant: merchant,
      );

      final suggestedSubcategory = _suggestSubcategoryFromPatterns(
        category: suggestedCategory,
        description: description,
        merchant: merchant,
      );

      // Create suggestion object
      final suggestion = CategorySuggestion(
        suggestedCategory: suggestedCategory,
        suggestedSubcategory: suggestedSubcategory,
        confidence: 0.7, // Simple pattern matching confidence
        alternativeCategories: _getAlternativeCategories(suggestedCategory),
      );

      return Right(suggestion);
    } catch (e) {
      return Left(UnknownFailure('Failed to suggest category: $e'));
    }
  }

  /// Private method to suggest category based on patterns.
  /// This method uses simple keyword matching for category suggestions.
  ///
  /// Parameters:
  /// - [description]: Transaction description
  /// - [merchant]: Merchant name
  ///
  /// Returns:
  /// - [String]: Suggested category
  String _suggestCategoryFromPatterns({String? description, String? merchant}) {
    final text = '${description ?? ''} ${merchant ?? ''}'.toLowerCase();

    // Food-related keywords
    if (text.contains(
      RegExp(
        r'\b(food|restaurant|cafe|grocery|supermarket|market|dining|eat|meal|pizza|burger|coffee|tea)\b',
      ),
    )) {
      return 'Food';
    }

    // Transportation-related keywords
    if (text.contains(
      RegExp(
        r'\b(transport|taxi|uber|lyft|bus|train|metro|gas|fuel|parking|car|vehicle)\b',
      ),
    )) {
      return 'Transportation';
    }

    // Entertainment-related keywords
    if (text.contains(
      RegExp(
        r'\b(entertainment|movie|cinema|theater|game|sport|gym|fitness|music|book|streaming|netflix|spotify)\b',
      ),
    )) {
      return 'Entertainment';
    }

    // Utilities-related keywords
    if (text.contains(
      RegExp(
        r'\b(utility|electric|water|internet|phone|mobile|bill|payment|subscription)\b',
      ),
    )) {
      return 'Utilities';
    }

    // Default to Other if no pattern matches
    return 'Other';
  }

  /// Private method to suggest subcategory based on patterns.
  /// This method uses simple keyword matching for subcategory suggestions.
  ///
  /// Parameters:
  /// - [category]: Main category
  /// - [description]: Transaction description
  /// - [merchant]: Merchant name
  ///
  /// Returns:
  /// - [String]: Suggested subcategory
  String _suggestSubcategoryFromPatterns({
    required String category,
    String? description,
    String? merchant,
  }) {
    final text = '${description ?? ''} ${merchant ?? ''}'.toLowerCase();

    switch (category) {
      case 'Food':
        if (text.contains(RegExp(r'\b(grocery|supermarket|market|store)\b'))) {
          return 'Groceries';
        }
        if (text.contains(RegExp(r'\b(restaurant|cafe|dining|eat|meal)\b'))) {
          return 'Restaurant';
        }
        return 'Groceries';

      case 'Transportation':
        if (text.contains(RegExp(r'\b(gas|fuel|petrol)\b'))) {
          return 'Gas';
        }
        if (text.contains(RegExp(r'\b(taxi|uber|lyft)\b'))) {
          return 'Taxi';
        }
        if (text.contains(RegExp(r'\b(bus|train|metro|public)\b'))) {
          return 'Public Transport';
        }
        return 'Gas';

      case 'Entertainment':
        if (text.contains(RegExp(r'\b(movie|cinema|theater)\b'))) {
          return 'Movies';
        }
        if (text.contains(RegExp(r'\b(game|gaming)\b'))) {
          return 'Games';
        }
        if (text.contains(RegExp(r'\b(gym|fitness|sport)\b'))) {
          return 'Fitness';
        }
        return 'Movies';

      case 'Utilities':
        if (text.contains(RegExp(r'\b(electric|power|energy)\b'))) {
          return 'Electricity';
        }
        if (text.contains(RegExp(r'\b(water|sewer)\b'))) {
          return 'Water';
        }
        if (text.contains(RegExp(r'\b(internet|wifi|broadband)\b'))) {
          return 'Internet';
        }
        if (text.contains(RegExp(r'\b(phone|mobile|telecom)\b'))) {
          return 'Phone';
        }
        return 'Electricity';

      default:
        return 'Misc';
    }
  }

  /// Private method to get default subcategories for a category.
  /// This method provides fallback subcategories when none are found in storage.
  ///
  /// Parameters:
  /// - [category]: Main category
  ///
  /// Returns:
  /// - [List<String>]: List of default subcategories
  List<String> _getDefaultSubcategories(String category) {
    switch (category) {
      case 'Food':
        return ['Groceries', 'Restaurant', 'Fast Food', 'Coffee'];
      case 'Transportation':
        return ['Gas', 'Taxi', 'Public Transport', 'Parking'];
      case 'Entertainment':
        return ['Movies', 'Games', 'Fitness', 'Music'];
      case 'Utilities':
        return ['Electricity', 'Water', 'Internet', 'Phone'];
      case 'Other':
        return ['Misc', 'Shopping', 'Health', 'Education'];
      default:
        return ['Misc'];
    }
  }

  /// Private method to get alternative categories.
  /// This method provides alternative category suggestions.
  ///
  /// Parameters:
  /// - [suggestedCategory]: The primary suggested category
  ///
  /// Returns:
  /// - [List<String>]: List of alternative categories
  List<String> _getAlternativeCategories(String suggestedCategory) {
    const allCategories = [
      'Food',
      'Transportation',
      'Entertainment',
      'Utilities',
      'Other',
    ];

    return allCategories
        .where((category) => category != suggestedCategory)
        .toList();
  }
}
