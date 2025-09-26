import 'package:dartz/dartz.dart';
import 'package:money_flow/core/error/failures.dart';
import 'package:money_flow/features/add_transaction/domain/entities/transaction_entity.dart';
import 'package:money_flow/features/add_transaction/domain/usecases/delete_transaction_usecase.dart';
import 'package:money_flow/features/sms_import/domain/entities/sms_entity.dart';
import 'package:money_flow/features/sms_import/domain/repositories/sms_category_tracking_repository.dart';
import 'package:money_flow/features/sms_import/domain/usecases/add_sms_to_category_usecase.dart';

/// Use case for toggling SMS category selection with single-selection behavior.
/// This use case handles the business logic for:
/// 1. Single category selection (only one category can be selected at a time)
/// 2. Removing previous category when selecting a new one
/// 3. Toggling off the current category when tapped again
/// 4. Creating transactions for new category selections
///
/// Usage Example:
/// ```dart
/// final useCase = ToggleSmsCategoryUseCase(
///   trackingRepository: getIt<SmsCategoryTrackingRepository>(),
///   addSmsToCategoryUseCase: getIt<AddSmsToCategoryUseCase>(),
/// );
///
/// final result = await useCase.call(ToggleSmsCategoryParams(
///   sms: smsEntity,
///   category: 'Income',
///   mainCategory: 'income',
///   amount: 100.0,
/// ));
/// ```
class ToggleSmsCategoryUseCase {
  /// Repository for SMS category tracking operations
  final SmsCategoryTrackingRepository _trackingRepository;

  /// Use case for adding SMS to category
  final AddSmsToCategoryUseCase _addSmsToCategoryUseCase;

  /// Use case for deleting transactions
  final DeleteTransactionUseCase _deleteTransactionUseCase;

  /// Creates a new instance of ToggleSmsCategoryUseCase.
  ///
  /// Parameters:
  /// - [trackingRepository]: Repository for tracking SMS category assignments
  /// - [addSmsToCategoryUseCase]: Use case for adding SMS to category
  /// - [deleteTransactionUseCase]: Use case for deleting transactions
  const ToggleSmsCategoryUseCase({
    required SmsCategoryTrackingRepository trackingRepository,
    required AddSmsToCategoryUseCase addSmsToCategoryUseCase,
    required DeleteTransactionUseCase deleteTransactionUseCase,
  }) : _trackingRepository = trackingRepository,
       _addSmsToCategoryUseCase = addSmsToCategoryUseCase,
       _deleteTransactionUseCase = deleteTransactionUseCase;

  /// Executes the use case to toggle SMS category selection.
  /// This method implements single-selection behavior where only one category
  /// can be selected at a time.
  ///
  /// Parameters:
  /// - [params]: Parameters containing SMS, category, and amount information
  ///
  /// Returns:
  /// - [Right] with [ToggleSmsCategoryResult] containing the result
  /// - [Left] with [Failure] on error
  ///
  /// This method handles:
  /// - Checking if SMS is already added to the target category
  /// - Removing SMS from all other categories (single selection)
  /// - Adding SMS to the target category or removing it if already selected
  /// - Creating transactions for new category assignments
  Future<Either<Failure, ToggleSmsCategoryResult>> call(
    ToggleSmsCategoryParams params,
  ) async {
    try {
      // Check if SMS is already added to the target category
      final isAlreadyAddedResult = await _trackingRepository
          .isSmsAddedToCategory(params.sms.id, params.category);

      if (isAlreadyAddedResult.isLeft()) {
        return Left(
          isAlreadyAddedResult.fold((l) => l, (r) => throw Exception()),
        );
      }

      final isAlreadyAdded = isAlreadyAddedResult.fold(
        (l) => throw Exception(),
        (r) => r,
      );

      // If already added to this category, remove it (toggle off)
      if (isAlreadyAdded) {
        // Get the tracking entity to access the transaction ID
        final trackingResult = await _trackingRepository.getSmsCategoryTracking(
          params.sms.id,
          params.category,
        );

        if (trackingResult.isLeft()) {
          return Left(trackingResult.fold((l) => l, (r) => throw Exception()));
        }

        final tracking = trackingResult.fold(
          (l) => throw Exception(),
          (r) => r,
        );

        // Delete the associated transaction if it exists
        if (tracking?.transactionId != null) {
          final deleteTransactionResult = await _deleteTransactionUseCase.call(
            tracking!.transactionId!,
          );

          if (deleteTransactionResult.isLeft()) {
            return Left(
              deleteTransactionResult.fold((l) => l, (r) => throw Exception()),
            );
          }
        }

        // Remove from tracking
        final removeResult = await _trackingRepository.removeSmsFromCategory(
          params.sms.id,
          params.category,
        );

        return removeResult.fold(
          (failure) => Left(failure),
          (_) => Right(
            ToggleSmsCategoryResult(
              action: ToggleAction.removed,
              category: params.category,
              transaction: null,
            ),
          ),
        );
      }

      // Get all current categories for this SMS
      final currentCategoriesResult = await _trackingRepository
          .getSmsCategories(params.sms.id);

      if (currentCategoriesResult.isLeft()) {
        return Left(
          currentCategoriesResult.fold((l) => l, (r) => throw Exception()),
        );
      }

      final currentCategories = currentCategoriesResult.fold(
        (l) => throw Exception(),
        (r) => r,
      );

      // Remove SMS from all current categories (single selection)
      for (final category in currentCategories) {
        // Get the tracking entity to access the transaction ID
        final trackingResult = await _trackingRepository.getSmsCategoryTracking(
          params.sms.id,
          category,
        );

        if (trackingResult.isLeft()) {
          return Left(trackingResult.fold((l) => l, (r) => throw Exception()));
        }

        final tracking = trackingResult.fold(
          (l) => throw Exception(),
          (r) => r,
        );

        // Delete the associated transaction if it exists
        if (tracking?.transactionId != null) {
          final deleteTransactionResult = await _deleteTransactionUseCase.call(
            tracking!.transactionId!,
          );

          if (deleteTransactionResult.isLeft()) {
            return Left(
              deleteTransactionResult.fold((l) => l, (r) => throw Exception()),
            );
          }
        }

        // Remove from tracking
        final removeResult = await _trackingRepository.removeSmsFromCategory(
          params.sms.id,
          category,
        );

        if (removeResult.isLeft()) {
          return Left(removeResult.fold((l) => l, (r) => throw Exception()));
        }
      }

      // Add SMS to the new category
      final addResult = await _addSmsToCategoryUseCase.call(
        AddSmsToCategoryParams(
          sms: params.sms,
          category: params.category,
          mainCategory: params.mainCategory,
          amount: params.amount,
        ),
      );

      return addResult.fold(
        (failure) => Left(failure),
        (transaction) => Right(
          ToggleSmsCategoryResult(
            action: ToggleAction.added,
            category: params.category,
            transaction: transaction,
          ),
        ),
      );
    } catch (e) {
      return Left(
        UnknownFailure('Failed to toggle SMS category: ${e.toString()}'),
      );
    }
  }
}

/// Parameters for toggling SMS category selection.
/// This class encapsulates all the data needed to toggle an SMS category.
///
/// Usage Example:
/// ```dart
/// final params = ToggleSmsCategoryParams(
///   sms: smsEntity,
///   category: 'Income',
///   mainCategory: 'income',
///   amount: 100.0,
/// );
/// ```
class ToggleSmsCategoryParams {
  /// The SMS entity to toggle category for
  final SmsEntity sms;

  /// The category name (Income, Expenses, Charity, Investments)
  final String category;

  /// The main category (income, expenses, charity, investments)
  final String mainCategory;

  /// The transaction amount
  final double amount;

  /// Creates a new instance of ToggleSmsCategoryParams.
  ///
  /// Parameters:
  /// - [sms]: The SMS entity to toggle category for
  /// - [category]: The category name
  /// - [mainCategory]: The main category
  /// - [amount]: The transaction amount
  const ToggleSmsCategoryParams({
    required this.sms,
    required this.category,
    required this.mainCategory,
    required this.amount,
  });
}

/// Result of toggling SMS category selection.
/// This class contains the result of the toggle operation.
///
/// Usage Example:
/// ```dart
/// result.fold(
///   (failure) => handleError(failure),
///   (result) => {
///     if (result.action == ToggleAction.added) {
///       showSuccess('Added to ${result.category}');
///     } else {
///       showInfo('Removed from ${result.category}');
///     }
///   },
/// );
/// ```
class ToggleSmsCategoryResult {
  /// The action that was performed
  final ToggleAction action;

  /// The category that was affected
  final String category;

  /// The transaction that was created (null if removed)
  final TransactionEntity? transaction;

  /// Creates a new instance of ToggleSmsCategoryResult.
  ///
  /// Parameters:
  /// - [action]: The action that was performed
  /// - [category]: The category that was affected
  /// - [transaction]: The transaction that was created (null if removed)
  const ToggleSmsCategoryResult({
    required this.action,
    required this.category,
    this.transaction,
  });
}

/// Enum representing the toggle action performed.
/// This enum indicates whether a category was added or removed.
enum ToggleAction {
  /// Category was added
  added,

  /// Category was removed
  removed,
}
