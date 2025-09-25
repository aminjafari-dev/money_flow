import 'package:dartz/dartz.dart';
import 'package:money_flow/core/error/failures.dart';
import 'package:money_flow/features/sms_import/domain/repositories/bank_repository.dart';

/// Use case for deleting a bank from storage.
/// This use case handles the business logic for removing
/// a bank from the repository.
///
/// Usage Example:
/// ```dart
/// final useCase = DeleteBankUseCase(bankRepository);
/// final result = await useCase.call(DeleteBankParams(bankId: 'bank_123'));
/// result.fold(
///   (failure) => handleError(failure),
///   (_) => showSuccess(),
/// );
/// ```
class DeleteBankUseCase {
  /// The bank repository for data operations.
  final BankRepository _bankRepository;

  /// Creates a new instance of DeleteBankUseCase.
  ///
  /// Parameters:
  /// - [bankRepository]: Repository for bank operations
  const DeleteBankUseCase(this._bankRepository);

  /// Executes the use case to delete a bank.
  ///
  /// Parameters:
  /// - [params]: Parameters containing the bank ID to delete
  ///
  /// Returns:
  /// - [Right]: Success result
  /// - [Left]: Failure if operation fails
  Future<Either<Failure, void>> call(DeleteBankParams params) async {
    return await _bankRepository.deleteBank(params.bankId);
  }
}

/// Parameters for deleting a bank.
class DeleteBankParams {
  /// The ID of the bank to delete.
  final String bankId;

  /// Creates a new instance of DeleteBankParams.
  ///
  /// Parameters:
  /// - [bankId]: The ID of the bank to delete
  const DeleteBankParams({required this.bankId});
}
