import 'package:dartz/dartz.dart';
import 'package:money_flow/core/error/failures.dart';
import 'package:money_flow/features/sms_import/domain/entities/sms_category_tracking_entity.dart';

/// Repository interface for SMS category tracking operations.
/// This interface defines the contract for tracking which SMS messages
/// have been added to which categories.
///
/// Usage Example:
/// ```dart
/// final result = await repository.isSmsAddedToCategory('sms_123', 'Income');
/// result.fold(
///   (failure) => handleError(failure),
///   (isAdded) => updateUI(isAdded),
/// );
/// ```
abstract class SmsCategoryTrackingRepository {
  /// Checks if an SMS message has been added to a specific category.
  ///
  /// Parameters:
  /// - [smsId]: The SMS message ID
  /// - [category]: The category name to check
  ///
  /// Returns:
  /// - [Right]: Boolean indicating if the SMS was added to the category
  /// - [Left]: Failure if operation fails
  Future<Either<Failure, bool>> isSmsAddedToCategory(
    String smsId,
    String category,
  );

  /// Gets all categories that an SMS message has been added to.
  ///
  /// Parameters:
  /// - [smsId]: The SMS message ID
  ///
  /// Returns:
  /// - [Right]: List of categories the SMS was added to
  /// - [Left]: Failure if operation fails
  Future<Either<Failure, List<String>>> getSmsCategories(String smsId);

  /// Adds an SMS message to a specific category.
  ///
  /// Parameters:
  /// - [tracking]: The tracking entity to save
  ///
  /// Returns:
  /// - [Right]: Success result
  /// - [Left]: Failure if operation fails
  Future<Either<Failure, void>> addSmsToCategory(
    SmsCategoryTrackingEntity tracking,
  );

  /// Gets the tracking entity for a specific SMS and category combination.
  ///
  /// Parameters:
  /// - [smsId]: The SMS message ID
  /// - [category]: The category name
  ///
  /// Returns:
  /// - [Right]: The tracking entity or null if not found
  /// - [Left]: Failure if operation fails
  Future<Either<Failure, SmsCategoryTrackingEntity?>> getSmsCategoryTracking(
    String smsId,
    String category,
  );

  /// Removes an SMS message from a specific category.
  ///
  /// Parameters:
  /// - [smsId]: The SMS message ID
  /// - [category]: The category name to remove from
  ///
  /// Returns:
  /// - [Right]: Success result
  /// - [Left]: Failure if operation fails
  Future<Either<Failure, void>> removeSmsFromCategory(
    String smsId,
    String category,
  );

  /// Gets all SMS category tracking records.
  ///
  /// Returns:
  /// - [Right]: List of all tracking records
  /// - [Left]: Failure if operation fails
  Future<Either<Failure, List<SmsCategoryTrackingEntity>>> getAllTracking();
}
