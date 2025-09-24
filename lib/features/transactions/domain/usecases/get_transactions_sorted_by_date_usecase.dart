import 'package:money_flow/core/data_status.dart';
import 'package:money_flow/core/error/failures.dart';
import 'package:money_flow/features/transactions/domain/entities/transaction_list_entity.dart';
import 'package:money_flow/features/transactions/domain/repositories/transactions_repository.dart';

/// Use case for retrieving transactions sorted by date (newest first).
/// This use case handles the business logic for fetching transactions in chronological order.
///
/// The use case follows the single responsibility principle and encapsulates
/// the business rules for date-sorted transaction retrieval operations.
///
/// Usage Example:
/// ```dart
/// final useCase = GetTransactionsSortedByDateUseCase(repository);
/// final result = await useCase.call(limit: 50);
/// result.fold(
///   (error) => print('Error: $error'),
///   (transactionList) => print('Found ${transactionList.transactions.length} recent transactions'),
/// );
/// ```
class GetTransactionsSortedByDateUseCase {
  /// Repository for transaction data access
  final TransactionsRepository _repository;

  /// Creates a new instance of GetTransactionsSortedByDateUseCase.
  ///
  /// Parameters:
  /// - [repository]: Repository for transaction data access
  ///
  /// Usage Example:
  /// ```dart
  /// final useCase = GetTransactionsSortedByDateUseCase(transactionsRepository);
  /// ```
  const GetTransactionsSortedByDateUseCase(this._repository);

  /// Executes the use case to get transactions sorted by date.
  /// This method retrieves transactions ordered by their date/time (newest first).
  ///
  /// Parameters:
  /// - [limit]: Optional limit on number of results. If null, returns all transactions.
  ///
  /// Returns:
  /// - [DataStatus<TransactionListEntity>]: Result containing sorted transaction list or error
  ///
  /// Usage Example:
  /// ```dart
  /// // Get all transactions sorted by date
  /// final result = await useCase.call();
  ///
  /// // Get only the 20 most recent transactions
  /// final result = await useCase.call(limit: 20);
  ///
  /// result.fold(
  ///   (error) => print('Error: $error'),
  ///   (transactionList) => print('Found ${transactionList.transactions.length} transactions'),
  /// );
  /// ```
  Future<DataStatus<TransactionListEntity>> call({int? limit}) async {
    try {
      // Validate limit parameter if provided
      if (limit != null && limit <= 0) {
        return DataFailed(ValidationFailure('Limit must be a positive number'));
      }

      // Call repository to get transactions sorted by date
      final result = await _repository.getTransactionsSortedByDate(
        limit: limit,
      );

      // Return the result directly as the use case doesn't need additional business logic
      // The repository already handles data validation, sorting, and error cases
      return result;
    } catch (e) {
      // Handle any unexpected errors that might occur during execution
      return DataFailed(
        ServerFailure('Failed to get transactions sorted by date: $e'),
      );
    }
  }
}
