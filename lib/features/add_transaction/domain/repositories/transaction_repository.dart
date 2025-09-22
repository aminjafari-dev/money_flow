import 'package:dartz/dartz.dart';
import 'package:money_flow/core/error/failures.dart';
import 'package:money_flow/features/add_transaction/domain/entities/transaction_entity.dart';

/// Abstract repository interface for transaction operations.
/// This defines the contract that any transaction repository implementation must follow.
///
/// Usage Example:
/// ```dart
/// final repository = getIt<TransactionRepository>();
/// final result = await repository.addTransaction(transaction);
/// result.fold(
///   (failure) => print('Error: ${failure.message}'),
///   (transaction) => print('Transaction added: ${transaction.id}'),
/// );
/// ```
abstract class TransactionRepository {
  /// Adds a new transaction to the system.
  ///
  /// Parameters:
  /// - [transaction]: The transaction entity to be added
  ///
  /// Returns:
  /// - [Either<Failure, TransactionEntity>]: Success with the created transaction or failure
  ///
  /// This method handles the business logic for adding transactions,
  /// including validation, categorization, and persistence.
  Future<Either<Failure, TransactionEntity>> addTransaction(
    TransactionEntity transaction,
  );

  /// Updates an existing transaction.
  ///
  /// Parameters:
  /// - [transaction]: The updated transaction entity
  ///
  /// Returns:
  /// - [Either<Failure, TransactionEntity>]: Success with the updated transaction or failure
  ///
  /// This method allows users to modify transaction details after creation.
  Future<Either<Failure, TransactionEntity>> updateTransaction(
    TransactionEntity transaction,
  );

  /// Deletes a transaction by its ID.
  ///
  /// Parameters:
  /// - [transactionId]: The unique identifier of the transaction to delete
  ///
  /// Returns:
  /// - [Either<Failure, Unit>]: Success or failure indication
  ///
  /// This method removes transactions from the system permanently.
  Future<Either<Failure, Unit>> deleteTransaction(String transactionId);

  /// Gets a transaction by its ID.
  ///
  /// Parameters:
  /// - [transactionId]: The unique identifier of the transaction
  ///
  /// Returns:
  /// - [Either<Failure, TransactionEntity>]: Success with the transaction or failure
  ///
  /// This method retrieves specific transaction details for editing or viewing.
  Future<Either<Failure, TransactionEntity>> getTransaction(
    String transactionId,
  );

  /// Gets all transactions for a specific date range.
  ///
  /// Parameters:
  /// - [startDate]: The start date for the range (inclusive)
  /// - [endDate]: The end date for the range (inclusive)
  ///
  /// Returns:
  /// - [Either<Failure, List<TransactionEntity>>]: Success with transaction list or failure
  ///
  /// This method is used for displaying transaction history and analytics.
  Future<Either<Failure, List<TransactionEntity>>> getTransactionsByDateRange(
    DateTime startDate,
    DateTime endDate,
  );

  /// Gets transactions by category.
  ///
  /// Parameters:
  /// - [category]: The category to filter by
  /// - [limit]: Optional limit on the number of results
  ///
  /// Returns:
  /// - [Either<Failure, List<TransactionEntity>>]: Success with transaction list or failure
  ///
  /// This method helps with category-specific analysis and filtering.
  Future<Either<Failure, List<TransactionEntity>>> getTransactionsByCategory(
    String category, {
    int? limit,
  });

  /// Gets recent transactions for quick access.
  ///
  /// Parameters:
  /// - [limit]: Maximum number of recent transactions to return
  ///
  /// Returns:
  /// - [Either<Failure, List<TransactionEntity>>]: Success with recent transactions or failure
  ///
  /// This method provides quick access to the most recent transactions,
  /// useful for dashboard displays and quick reference.
  Future<Either<Failure, List<TransactionEntity>>> getRecentTransactions({
    int limit = 10,
  });

  /// Gets available categories for transaction categorization.
  ///
  /// Returns:
  /// - [Either<Failure, List<String>>]: Success with category list or failure
  ///
  /// This method provides the list of available categories for the add transaction form.
  Future<Either<Failure, List<String>>> getAvailableCategories();

  /// Gets available subcategories for a specific category.
  ///
  /// Parameters:
  /// - [category]: The parent category
  ///
  /// Returns:
  /// - [Either<Failure, List<String>>]: Success with subcategory list or failure
  ///
  /// This method provides subcategories based on the selected main category.
  Future<Either<Failure, List<String>>> getSubcategoriesForCategory(
    String category,
  );

  /// Gets transaction statistics for analytics.
  ///
  /// Parameters:
  /// - [startDate]: The start date for statistics calculation
  /// - [endDate]: The end date for statistics calculation
  ///
  /// Returns:
  /// - [Either<Failure, TransactionStatistics>]: Success with statistics or failure
  ///
  /// This method provides aggregated data for dashboard and analytics features.
  Future<Either<Failure, TransactionStatistics>> getTransactionStatistics(
    DateTime startDate,
    DateTime endDate,
  );

  /// Suggests category and subcategory based on transaction details.
  ///
  /// Parameters:
  /// - [amount]: The transaction amount
  /// - [description]: The transaction description
  /// - [merchant]: The merchant name (if available)
  ///
  /// Returns:
  /// - [Either<Failure, CategorySuggestion>]: Success with suggestions or failure
  ///
  /// This method uses AI/ML to suggest appropriate categories based on transaction patterns.
  Future<Either<Failure, CategorySuggestion>> suggestCategory({
    required double amount,
    String? description,
    String? merchant,
  });
}

/// Data class representing transaction statistics.
/// This provides aggregated data for analytics and dashboard features.
class TransactionStatistics {
  /// Total income for the period
  final double totalIncome;

  /// Total expenses for the period
  final double totalExpenses;

  /// Net amount (income - expenses)
  final double netAmount;

  /// Number of transactions in the period
  final int transactionCount;

  /// Category-wise breakdown
  final Map<String, double> categoryBreakdown;

  /// Most used category
  final String? mostUsedCategory;

  /// Average transaction amount
  final double averageTransactionAmount;

  const TransactionStatistics({
    required this.totalIncome,
    required this.totalExpenses,
    required this.netAmount,
    required this.transactionCount,
    required this.categoryBreakdown,
    this.mostUsedCategory,
    required this.averageTransactionAmount,
  });
}

/// Data class representing category suggestions.
/// This provides AI-powered suggestions for transaction categorization.
class CategorySuggestion {
  /// Suggested main category
  final String suggestedCategory;

  /// Suggested subcategory
  final String suggestedSubcategory;

  /// Confidence level of the suggestion (0.0 to 1.0)
  final double confidence;

  /// Alternative suggestions if the primary suggestion is not suitable
  final List<String> alternativeCategories;

  const CategorySuggestion({
    required this.suggestedCategory,
    required this.suggestedSubcategory,
    required this.confidence,
    this.alternativeCategories = const [],
  });
}
