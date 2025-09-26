import 'package:dartz/dartz.dart';
import 'package:money_flow/core/error/failures.dart';
import 'package:money_flow/features/add_transaction/domain/repositories/transaction_repository.dart';

/// Use case for deleting a transaction from the system.
/// This use case handles the business logic for removing transactions
/// permanently from the database.
///
/// Usage Example:
/// ```dart
/// final useCase = DeleteTransactionUseCase(repository: getIt<TransactionRepository>());
///
/// final result = await useCase.call('txn_123');
///
/// result.fold(
///   (failure) => print('Error: ${failure.message}'),
///   (_) => print('Transaction deleted successfully'),
/// );
/// ```
class DeleteTransactionUseCase {
  /// Repository for transaction operations
  final TransactionRepository _repository;

  /// Creates a new instance of DeleteTransactionUseCase.
  ///
  /// Parameters:
  /// - [repository]: Repository for transaction operations
  const DeleteTransactionUseCase({required TransactionRepository repository})
    : _repository = repository;

  /// Executes the delete transaction use case.
  /// This method removes a transaction permanently from the system.
  ///
  /// Parameters:
  /// - [transactionId]: The unique identifier of the transaction to delete
  ///
  /// Returns:
  /// - [Either<Failure, Unit>]: Success or failure indication
  ///
  /// This method handles:
  /// - Input validation
  /// - Repository call for deletion
  /// - Error handling
  Future<Either<Failure, Unit>> call(String transactionId) async {
    try {
      // Validate input parameters
      if (transactionId.isEmpty) {
        return const Left(ValidationFailure('Transaction ID cannot be empty'));
      }

      // Delete transaction through repository
      return await _repository.deleteTransaction(transactionId);
    } catch (e) {
      return Left(UnknownFailure('Failed to delete transaction: $e'));
    }
  }
}
