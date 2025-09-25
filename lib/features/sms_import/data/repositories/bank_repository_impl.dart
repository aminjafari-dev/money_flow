import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';
import 'package:money_flow/core/error/failures.dart';
import 'package:money_flow/features/sms_import/domain/entities/bank_entity.dart';
import 'package:money_flow/features/sms_import/domain/repositories/bank_repository.dart';
import 'package:money_flow/shared/models/bank/bank_model.dart';

/// Implementation of BankRepository using Hive for local storage.
/// This repository handles all CRUD operations for bank entities
/// using Hive as the storage backend.
///
/// Usage Example:
/// ```dart
/// final repository = BankRepositoryImpl();
/// final result = await repository.getAllBanks();
/// ```
class BankRepositoryImpl implements BankRepository {
  static const String _boxName = 'banks';
  late Box<BankModel> _box;

  /// Initializes the Hive box for bank storage.
  /// This method must be called before using any repository methods.
  Future<void> init() async {
    _box = await Hive.openBox<BankModel>(_boxName);
  }

  /// Gets all banks from storage.
  ///
  /// Returns:
  /// - [Right]: List of all bank entities
  /// - [Left]: Failure if operation fails
  @override
  Future<Either<Failure, List<BankEntity>>> getAllBanks() async {
    try {
      await _ensureBoxInitialized();
      final banks = _box.values.map((model) => model.toDomain()).toList();
      return Right(banks);
    } catch (e) {
      return Left(CacheFailure('Failed to load banks: ${e.toString()}'));
    }
  }

  /// Saves a bank to storage.
  ///
  /// Parameters:
  /// - [bank]: The bank entity to save
  ///
  /// Returns:
  /// - [Right]: Success result
  /// - [Left]: Failure if operation fails
  @override
  Future<Either<Failure, void>> saveBank(BankEntity bank) async {
    try {
      await _ensureBoxInitialized();
      final model = BankModel.fromDomain(bank);
      await _box.put(bank.id, model);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure('Failed to save bank: ${e.toString()}'));
    }
  }

  /// Deletes a bank from storage.
  ///
  /// Parameters:
  /// - [bankId]: The ID of the bank to delete
  ///
  /// Returns:
  /// - [Right]: Success result
  /// - [Left]: Failure if operation fails
  @override
  Future<Either<Failure, void>> deleteBank(String bankId) async {
    try {
      await _ensureBoxInitialized();
      await _box.delete(bankId);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure('Failed to delete bank: ${e.toString()}'));
    }
  }

  /// Updates a bank in storage.
  ///
  /// Parameters:
  /// - [bank]: The bank entity to update
  ///
  /// Returns:
  /// - [Right]: Success result
  /// - [Left]: Failure if operation fails
  @override
  Future<Either<Failure, void>> updateBank(BankEntity bank) async {
    try {
      await _ensureBoxInitialized();
      final model = BankModel.fromDomain(bank);
      await _box.put(bank.id, model);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure('Failed to update bank: ${e.toString()}'));
    }
  }

  /// Ensures the Hive box is initialized before operations.
  Future<void> _ensureBoxInitialized() async {
    if (!Hive.isBoxOpen(_boxName)) {
      await init();
    }
  }

  /// Closes the Hive box.
  /// This method should be called when the repository is no longer needed.
  Future<void> close() async {
    if (Hive.isBoxOpen(_boxName)) {
      await _box.close();
    }
  }
}
