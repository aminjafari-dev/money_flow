import 'package:dartz/dartz.dart';
import 'package:money_flow/core/error/failures.dart';
import 'package:money_flow/features/sms_import/domain/repositories/sms_category_tracking_repository.dart';

/// Use case for getting SMS category status.
/// This use case handles the business logic for checking which categories
/// an SMS message has been added to.
///
/// Usage Example:
/// ```dart
/// final useCase = GetSmsCategoryStatusUseCase(
///   trackingRepository: getIt<SmsCategoryTrackingRepository>(),
/// );
///
/// final result = await useCase.call(GetSmsCategoryStatusParams(smsId: 'sms_123'));
/// ```
class GetSmsCategoryStatusUseCase {
  /// Repository for SMS category tracking operations
  final SmsCategoryTrackingRepository _trackingRepository;

  /// Creates a new instance of GetSmsCategoryStatusUseCase.
  ///
  /// Parameters:
  /// - [trackingRepository]: Repository for tracking SMS category assignments
  const GetSmsCategoryStatusUseCase({
    required SmsCategoryTrackingRepository trackingRepository,
  }) : _trackingRepository = trackingRepository;

  /// Executes the use case to get SMS category status.
  /// This method returns information about which categories the SMS has been added to.
  ///
  /// Parameters:
  /// - [params]: Parameters containing the SMS ID
  ///
  /// Returns:
  /// - [Right] with [SmsCategoryStatus] on success
  /// - [Left] with [Failure] on error
  ///
  /// This method handles:
  /// - Getting all categories the SMS has been added to
  /// - Checking status for each of the 4 main categories
  Future<Either<Failure, SmsCategoryStatus>> call(
    GetSmsCategoryStatusParams params,
  ) async {
    try {
      // Get all categories this SMS has been added to
      final categoriesResult = await _trackingRepository.getSmsCategories(
        params.smsId,
      );

      return categoriesResult.fold((failure) => Left(failure), (categories) {
        // Create status object with all 4 main categories
        final status = SmsCategoryStatus(
          smsId: params.smsId,
          isAddedToIncome: categories.contains('Income'),
          isAddedToExpenses: categories.contains('Expenses'),
          isAddedToCharity: categories.contains('Charity'),
          isAddedToInvestments: categories.contains('Investments'),
          addedCategories: categories,
        );

        return Right(status);
      });
    } catch (e) {
      return Left(
        UnknownFailure('Failed to get SMS category status: ${e.toString()}'),
      );
    }
  }
}

/// Parameters for getting SMS category status.
/// This class encapsulates the data needed to check SMS category status.
///
/// Usage Example:
/// ```dart
/// final params = GetSmsCategoryStatusParams(smsId: 'sms_123');
/// ```
class GetSmsCategoryStatusParams {
  /// The SMS message ID to check
  final String smsId;

  /// Creates a new instance of GetSmsCategoryStatusParams.
  ///
  /// Parameters:
  /// - [smsId]: The SMS message ID to check
  const GetSmsCategoryStatusParams({required this.smsId});
}

/// Status information for SMS category assignments.
/// This class provides information about which categories an SMS has been added to.
///
/// Usage Example:
/// ```dart
/// final status = SmsCategoryStatus(
///   smsId: 'sms_123',
///   isAddedToIncome: true,
///   isAddedToExpenses: false,
///   isAddedToCharity: false,
///   isAddedToInvestments: false,
///   addedCategories: ['Income'],
/// );
/// ```
class SmsCategoryStatus {
  /// The SMS message ID
  final String smsId;

  /// Whether the SMS has been added to Income category
  final bool isAddedToIncome;

  /// Whether the SMS has been added to Expenses category
  final bool isAddedToExpenses;

  /// Whether the SMS has been added to Charity category
  final bool isAddedToCharity;

  /// Whether the SMS has been added to Investments category
  final bool isAddedToInvestments;

  /// List of all categories this SMS has been added to
  final List<String> addedCategories;

  /// Creates a new instance of SmsCategoryStatus.
  ///
  /// Parameters:
  /// - [smsId]: The SMS message ID
  /// - [isAddedToIncome]: Whether added to Income category
  /// - [isAddedToExpenses]: Whether added to Expenses category
  /// - [isAddedToCharity]: Whether added to Charity category
  /// - [isAddedToInvestments]: Whether added to Investments category
  /// - [addedCategories]: List of all added categories
  const SmsCategoryStatus({
    required this.smsId,
    required this.isAddedToIncome,
    required this.isAddedToExpenses,
    required this.isAddedToCharity,
    required this.isAddedToInvestments,
    required this.addedCategories,
  });

  /// Checks if the SMS has been added to any category
  bool get hasAnyCategory => addedCategories.isNotEmpty;

  /// Gets the count of categories this SMS has been added to
  int get categoryCount => addedCategories.length;

  /// Checks if the SMS has been added to a specific category
  bool isAddedToCategory(String category) {
    return addedCategories.contains(category);
  }

  @override
  String toString() {
    return 'SmsCategoryStatus(smsId: $smsId, isAddedToIncome: $isAddedToIncome, isAddedToExpenses: $isAddedToExpenses, isAddedToCharity: $isAddedToCharity, isAddedToInvestments: $isAddedToInvestments, addedCategories: $addedCategories)';
  }
}
