import 'package:dartz/dartz.dart';
import 'package:money_flow/core/error/failures.dart';
import 'package:money_flow/features/sms_import/domain/entities/bank_entity.dart';
import 'package:money_flow/features/sms_import/domain/repositories/bank_repository.dart';

/// Use case for saving a bank to storage.
/// This use case handles the business logic for persisting
/// a bank entity to the repository.
///
/// Usage Example:
/// ```dart
/// final useCase = SaveBankUseCase(bankRepository);
/// final result = await useCase.call(SaveBankParams(bank: bankEntity));
/// result.fold(
///   (failure) => handleError(failure),
///   (_) => showSuccess(),
/// );
/// ```
class SaveBankUseCase {
  /// The bank repository for data operations.
  final BankRepository _bankRepository;

  /// Creates a new instance of SaveBankUseCase.
  ///
  /// Parameters:
  /// - [bankRepository]: Repository for bank operations
  const SaveBankUseCase(this._bankRepository);

  /// Executes the use case to save a bank.
  ///
  /// Parameters:
  /// - [params]: Parameters containing the bank to save
  ///
  /// Returns:
  /// - [Right]: Success result
  /// - [Left]: Failure if operation fails
  Future<Either<Failure, void>> call(SaveBankParams params) async {
    return await _bankRepository.saveBank(params.bank);
  }
}

/// Parameters for saving a bank.
class SaveBankParams {
  /// The bank entity to save.
  final BankEntity bank;

  /// Creates a new instance of SaveBankParams.
  ///
  /// Parameters:
  /// - [bank]: The bank entity to save
  const SaveBankParams({required this.bank});
}
