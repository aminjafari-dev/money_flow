import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';
import 'package:money_flow/core/error/failures.dart';
import 'package:money_flow/features/sms_import/data/models/sms_category_tracking_model.dart';
import 'package:money_flow/features/sms_import/domain/entities/sms_category_tracking_entity.dart';
import 'package:money_flow/features/sms_import/domain/repositories/sms_category_tracking_repository.dart';

/// Implementation of SMS category tracking repository using Hive for local storage.
/// This repository handles all CRUD operations for SMS category tracking
/// using Hive as the storage backend.
///
/// Usage Example:
/// ```dart
/// final repository = SmsCategoryTrackingRepositoryImpl();
/// await repository.init();
/// final result = await repository.isSmsAddedToCategory('sms_123', 'Income');
/// ```
class SmsCategoryTrackingRepositoryImpl
    implements SmsCategoryTrackingRepository {
  static const String _boxName = 'sms_category_tracking';
  late Box<SmsCategoryTrackingModel> _box;

  /// Initializes the Hive box for SMS category tracking storage.
  /// This method must be called before using any repository methods.
  Future<void> init() async {
    _box = await Hive.openBox<SmsCategoryTrackingModel>(_boxName);
  }

  /// Checks if an SMS message has been added to a specific category.
  ///
  /// Parameters:
  /// - [smsId]: The SMS message ID
  /// - [category]: The category name to check
  ///
  /// Returns:
  /// - [Right]: Boolean indicating if the SMS was added to the category
  /// - [Left]: Failure if operation fails
  @override
  Future<Either<Failure, bool>> isSmsAddedToCategory(
    String smsId,
    String category,
  ) async {
    try {
      await _ensureBoxInitialized();

      // Create a composite key for the SMS and category combination
      final key = '${smsId}_$category';
      final tracking = _box.get(key);

      return Right(tracking != null);
    } catch (e) {
      return Left(
        CacheFailure('Failed to check SMS category tracking: ${e.toString()}'),
      );
    }
  }

  /// Gets all categories that an SMS message has been added to.
  ///
  /// Parameters:
  /// - [smsId]: The SMS message ID
  ///
  /// Returns:
  /// - [Right]: List of categories the SMS was added to
  /// - [Left]: Failure if operation fails
  @override
  Future<Either<Failure, List<String>>> getSmsCategories(String smsId) async {
    try {
      await _ensureBoxInitialized();

      // Get all tracking records for this SMS
      final allTracking = _box.values
          .where((tracking) => tracking.smsId == smsId)
          .map((tracking) => tracking.category)
          .toList();

      return Right(allTracking);
    } catch (e) {
      return Left(
        CacheFailure('Failed to get SMS categories: ${e.toString()}'),
      );
    }
  }

  /// Adds an SMS message to a specific category.
  ///
  /// Parameters:
  /// - [tracking]: The tracking entity to save
  ///
  /// Returns:
  /// - [Right]: Success result
  /// - [Left]: Failure if operation fails
  @override
  Future<Either<Failure, void>> addSmsToCategory(
    SmsCategoryTrackingEntity tracking,
  ) async {
    try {
      await _ensureBoxInitialized();

      // Convert entity to model
      final model = SmsCategoryTrackingModel(
        smsId: tracking.smsId,
        category: tracking.category,
        mainCategory: tracking.mainCategory,
        addedAt: tracking.addedAt,
        transactionId: tracking.transactionId,
      );

      // Create a composite key for the SMS and category combination
      final key = '${tracking.smsId}_${tracking.category}';
      await _box.put(key, model);

      return const Right(null);
    } catch (e) {
      return Left(
        CacheFailure('Failed to add SMS to category: ${e.toString()}'),
      );
    }
  }

  /// Removes an SMS message from a specific category.
  ///
  /// Parameters:
  /// - [smsId]: The SMS message ID
  /// - [category]: The category name to remove from
  ///
  /// Returns:
  /// - [Right]: Success result
  /// - [Left]: Failure if operation fails
  @override
  Future<Either<Failure, void>> removeSmsFromCategory(
    String smsId,
    String category,
  ) async {
    try {
      await _ensureBoxInitialized();

      // Create a composite key for the SMS and category combination
      final key = '${smsId}_$category';
      await _box.delete(key);

      return const Right(null);
    } catch (e) {
      return Left(
        CacheFailure('Failed to remove SMS from category: ${e.toString()}'),
      );
    }
  }

  /// Gets all SMS category tracking records.
  ///
  /// Returns:
  /// - [Right]: List of all tracking records
  /// - [Left]: Failure if operation fails
  @override
  Future<Either<Failure, List<SmsCategoryTrackingEntity>>>
  getAllTracking() async {
    try {
      await _ensureBoxInitialized();

      final allTracking = _box.values
          .map(
            (model) => SmsCategoryTrackingEntity(
              smsId: model.smsId,
              category: model.category,
              mainCategory: model.mainCategory,
              addedAt: model.addedAt,
              transactionId: model.transactionId,
            ),
          )
          .toList();

      return Right(allTracking);
    } catch (e) {
      return Left(CacheFailure('Failed to get all tracking: ${e.toString()}'));
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
