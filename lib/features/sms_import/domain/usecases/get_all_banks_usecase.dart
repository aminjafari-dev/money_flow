import 'package:dartz/dartz.dart';
import 'package:money_flow/core/error/failures.dart';
import 'package:money_flow/core/constants/no_params.dart';
import 'package:money_flow/features/sms_import/domain/entities/bank_entity.dart';
import 'package:money_flow/features/sms_import/domain/repositories/bank_repository.dart';

/// Use case for getting all banks from storage.
/// This use case handles the business logic for retrieving
/// all saved banks from the repository.
///
/// Usage Example:
/// ```dart
/// final useCase = GetAllBanksUseCase(bankRepository);
/// final result = await useCase.call(NoParams());
/// result.fold(
///   (failure) => handleError(failure),
///   (banks) => displayBanks(banks),
/// );
/// ```
class GetAllBanksUseCase {
  /// The bank repository for data operations.
  final BankRepository _bankRepository;

  /// Creates a new instance of GetAllBanksUseCase.
  ///
  /// Parameters:
  /// - [bankRepository]: Repository for bank operations
  const GetAllBanksUseCase(this._bankRepository);

  /// Executes the use case to get all banks.
  ///
  /// Parameters:
  /// - [params]: No parameters needed (uses NoParams)
  ///
  /// Returns:
  /// - [Right]: List of all bank entities
  /// - [Left]: Failure if operation fails
  Future<Either<Failure, List<BankEntity>>> call(NoParams params) async {
    return await _bankRepository.getAllBanks();
  }
}
