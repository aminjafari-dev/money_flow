import 'package:money_flow/core/data_status.dart';
import 'package:money_flow/core/error/failures.dart';
import 'package:money_flow/features/transactions/domain/entities/transaction_list_entity.dart';
import 'package:money_flow/features/transactions/domain/repositories/transactions_repository.dart';

/// Use case for retrieving all transactions.
/// This use case handles the business logic for fetching all available transactions.
///
/// The use case follows the single responsibility principle and encapsulates
/// the business rules for transaction retrieval operations.
///
/// Usage Example:
/// ```dart
/// final useCase = GetAllTransactionsUseCase(repository);
/// final result = await useCase.call();
/// result.fold(
///   (error) => print('Error: $error'),
///   (transactionList) => print('Found ${transactionList.transactions.length} transactions'),
/// );
/// ```
class GetAllTransactionsUseCase {
  /// Repository for transaction data access
  final TransactionsRepository _repository;

  /// Creates a new instance of GetAllTransactionsUseCase.
  ///
  /// Parameters:
  /// - [repository]: Repository for transaction data access
  ///
  /// Usage Example:
  /// ```dart
  /// final useCase = GetAllTransactionsUseCase(transactionsRepository);
  /// ```
  const GetAllTransactionsUseCase(this._repository);

  /// Executes the use case to get all transactions.
  /// This method retrieves all available transactions from the repository.
  ///
  /// Returns:
  /// - [DataStatus<TransactionListEntity>]: Result containing transaction list or error
  ///
  /// Usage Example:
  /// ```dart
  /// final result = await useCase.call();
  /// result.fold(
  ///   (error) => print('Error: $error'),
  ///   (transactionList) => print('Found ${transactionList.transactions.length} transactions'),
  /// );
  /// ```
  Future<DataStatus<TransactionListEntity>> call() async {
    try {
      // Call repository to get all transactions
      final result = await _repository.getAllTransactions();

      // Return the result directly as the use case doesn't need additional business logic
      // The repository already handles data validation and error cases
      return result;
    } catch (e) {
      // Handle any unexpected errors that might occur during execution
      return DataFailed(ServerFailure('Failed to get all transactions: $e'));
    }
  }
}
