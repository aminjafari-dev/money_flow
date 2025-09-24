import 'package:dartz/dartz.dart';
import 'package:money_flow/core/error/exceptions.dart';
import 'package:money_flow/core/error/failures.dart';
import 'package:money_flow/core/services/category_service.dart';
import 'package:money_flow/features/add_transaction/data/datasources/local/transaction_local_datasource.dart';
import 'package:money_flow/shared/models/transaction/transaction_model.dart';
import 'package:money_flow/features/add_transaction/domain/entities/transaction_entity.dart';
import 'package:money_flow/features/add_transaction/domain/repositories/transaction_repository.dart';

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
  final CategoryService categoryService;

  TransactionRepositoryImpl({
    required this.localDataSource,
    required this.categoryService,
  });

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
  /// This method retrieves the 4 main categories from the CategoryService.
  ///
  /// Returns:
  /// - [Either<Failure, List<String>>]: Success with main category list or failure
  ///
  /// This method provides the list of available main categories for the add transaction form.
  @override
  Future<Either<Failure, List<String>>> getAvailableCategories() async {
    try {
      // Get main categories from CategoryService
      final mainCategories = await categoryService.getMainCategories();
      final categoryNames = mainCategories
          .map((category) => category.name)
          .toList();

      return Right(categoryNames);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure('Failed to get available categories: $e'));
    }
  }

  /// Gets available subcategories for a specific main category.
  /// Note: Always returns empty list as subcategories are not used.
  ///
  /// Parameters:
  /// - [mainCategoryId]: The main category ID (income, expenses, charity, investments)
  ///
  /// Returns:
  /// - [Either<Failure, List<String>>]: Success with empty list (no subcategories)
  ///
  /// This method is kept for compatibility but returns empty list as subcategories are not supported.
  @override
  @Deprecated('Subcategories are not supported in the current implementation')
  Future<Either<Failure, List<String>>> getSubcategoriesForCategory(
    String mainCategoryId,
  ) async {
    // Always return empty list as subcategories are not supported
    return const Right([]);
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

  /// Suggests category based on transaction details.
  /// This method uses simple pattern matching for category suggestions from the 4 main categories.
  ///
  /// Parameters:
  /// - [amount]: The transaction amount
  /// - [description]: The transaction description
  /// - [merchant]: The merchant name (if available)
  ///
  /// Returns:
  /// - [Either<Failure, CategorySuggestion>]: Success with suggestions or failure
  ///
  /// This method uses simple pattern matching to suggest appropriate main categories.
  @override
  Future<Either<Failure, CategorySuggestion>> suggestCategory({
    required double amount,
    String? description,
    String? merchant,
  }) async {
    try {
      // Simple pattern matching for main category suggestions
      final suggestedCategory = _suggestMainCategoryFromPatterns(
        amount: amount,
        description: description,
        merchant: merchant,
      );

      // Create suggestion object (no subcategory as we don't use them)
      final suggestion = CategorySuggestion(
        suggestedCategory: suggestedCategory,
        suggestedSubcategory: null, // No subcategories
        confidence: 0.7, // Simple pattern matching confidence
        alternativeCategories: _getAlternativeMainCategories(suggestedCategory),
      );

      return Right(suggestion);
    } catch (e) {
      return Left(UnknownFailure('Failed to suggest category: $e'));
    }
  }

  /// Private method to suggest main category based on patterns.
  /// This method uses simple keyword matching and amount analysis for category suggestions.
  ///
  /// Parameters:
  /// - [amount]: Transaction amount
  /// - [description]: Transaction description
  /// - [merchant]: Merchant name
  ///
  /// Returns:
  /// - [String]: Suggested main category (Income, Expenses, Charity, Investments)
  String _suggestMainCategoryFromPatterns({
    required double amount,
    String? description,
    String? merchant,
  }) {
    final text = '${description ?? ''} ${merchant ?? ''}'.toLowerCase();

    // Positive amounts might indicate income
    if (amount > 0) {
      // Income-related keywords
      if (text.contains(
        RegExp(
          r'\b(salary|wage|income|bonus|refund|return|deposit|payment|earn|revenue|profit)\b',
        ),
      )) {
        return 'Income';
      }

      // Investment-related keywords for positive amounts
      if (text.contains(
        RegExp(
          r'\b(investment|dividend|interest|return|gain|stock|bond|fund|crypto|savings)\b',
        ),
      )) {
        return 'Investments';
      }
    }

    // Charity-related keywords
    if (text.contains(
      RegExp(
        r'\b(charity|donation|donate|give|help|support|aid|foundation|nonprofit|church|mosque|temple|zakat|tithe)\b',
      ),
    )) {
      return 'Charity';
    }

    // Investment-related keywords for any amount
    if (text.contains(
      RegExp(
        r'\b(investment|invest|stock|bond|mutual|fund|crypto|bitcoin|ethereum|savings|deposit|portfolio)\b',
      ),
    )) {
      return 'Investments';
    }

    // Default to Expenses for negative amounts or unmatched patterns
    return 'Expenses';
  }

  /// Private method to get alternative main categories.
  /// This method provides alternative category suggestions from the 4 main categories.
  ///
  /// Parameters:
  /// - [suggestedCategory]: The primary suggested category
  ///
  /// Returns:
  /// - [List<String>]: List of alternative main categories
  List<String> _getAlternativeMainCategories(String suggestedCategory) {
    const allMainCategories = ['Income', 'Expenses', 'Charity', 'Investments'];

    return allMainCategories
        .where((category) => category != suggestedCategory)
        .toList();
  }
}
