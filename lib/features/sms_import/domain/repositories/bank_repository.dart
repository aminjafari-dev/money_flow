import 'package:dartz/dartz.dart';
import 'package:money_flow/core/error/failures.dart';
import 'package:money_flow/features/sms_import/domain/entities/bank_entity.dart';

/// Repository interface for bank operations.
/// This interface defines the contract for bank data operations
/// following Clean Architecture principles.
///
/// Usage Example:
/// ```dart
/// final result = await bankRepository.getAllBanks();
/// result.fold(
///   (failure) => handleError(failure),
///   (banks) => displayBanks(banks),
/// );
/// ```
abstract class BankRepository {
  /// Gets all banks from storage.
  ///
  /// Returns:
  /// - [Right]: List of all bank entities
  /// - [Left]: Failure if operation fails
  Future<Either<Failure, List<BankEntity>>> getAllBanks();

  /// Saves a bank to storage.
  ///
  /// Parameters:
  /// - [bank]: The bank entity to save
  ///
  /// Returns:
  /// - [Right]: Success result
  /// - [Left]: Failure if operation fails
  Future<Either<Failure, void>> saveBank(BankEntity bank);

  /// Deletes a bank from storage.
  ///
  /// Parameters:
  /// - [bankId]: The ID of the bank to delete
  ///
  /// Returns:
  /// - [Right]: Success result
  /// - [Left]: Failure if operation fails
  Future<Either<Failure, void>> deleteBank(String bankId);

  /// Updates a bank in storage.
  ///
  /// Parameters:
  /// - [bank]: The bank entity to update
  ///
  /// Returns:
  /// - [Right]: Success result
  /// - [Left]: Failure if operation fails
  Future<Either<Failure, void>> updateBank(BankEntity bank);
}
