import 'package:dartz/dartz.dart';
import 'package:money_flow/core/error/failures.dart';
import 'package:money_flow/features/transactions/domain/repositories/transaction_repository.dart';

/// Use case for retrieving available categories for transaction categorization.
/// This use case provides the list of categories that can be used when adding transactions.
///
/// Usage Example:
/// ```dart
/// final useCase = GetCategoriesUseCase(repository: getIt<TransactionRepository>());
///
/// final result = await useCase.call();
/// result.fold(
///   (failure) => print('Error: ${failure.message}'),
///   (categories) => print('Available categories: $categories'),
/// );
/// ```
class GetCategoriesUseCase {
  final TransactionRepository repository;

  GetCategoriesUseCase({required this.repository});

  /// Executes the get categories use case.
  /// This method retrieves all available categories from the repository.
  ///
  /// Returns:
  /// - [Either<Failure, List<String>>]: Success with category list or failure
  ///
  /// This method handles:
  /// - Repository call for category retrieval
  /// - Fallback to default categories if none found
  /// - Error handling and failure propagation
  Future<Either<Failure, List<String>>> call() async {
    try {
      // Get categories from repository
      final result = await repository.getAvailableCategories();

      return result.fold(
        (failure) {
          // If repository fails, return default categories
          return const Right([
            'Food',
            'Transportation',
            'Entertainment',
            'Utilities',
            'Other',
          ]);
        },
        (categories) {
          // If no categories found, return default categories
          if (categories.isEmpty) {
            return const Right([
              'Food',
              'Transportation',
              'Entertainment',
              'Utilities',
              'Other',
            ]);
          }

          return Right(categories);
        },
      );
    } catch (e) {
      // Return default categories on any error
      return const Right([
        'Food',
        'Transportation',
        'Entertainment',
        'Utilities',
        'Other',
      ]);
    }
  }
}

/// Use case for retrieving available subcategories for a specific category.
/// This use case provides the list of subcategories that can be used for a given category.
///
/// Usage Example:
/// ```dart
/// final useCase = GetSubcategoriesUseCase(repository: getIt<TransactionRepository>());
///
/// final result = await useCase.call(GetSubcategoriesParams(category: 'Food'));
/// result.fold(
///   (failure) => print('Error: ${failure.message}'),
///   (subcategories) => print('Available subcategories: $subcategories'),
/// );
/// ```
class GetSubcategoriesUseCase {
  final TransactionRepository repository;

  GetSubcategoriesUseCase({required this.repository});

  /// Executes the get subcategories use case.
  /// This method retrieves all available subcategories for the given category.
  ///
  /// Parameters:
  /// - [params]: Parameters containing the category to get subcategories for
  ///
  /// Returns:
  /// - [Either<Failure, List<String>>]: Success with subcategory list or failure
  ///
  /// This method handles:
  /// - Input validation
  /// - Repository call for subcategory retrieval
  /// - Fallback to default subcategories if none found
  /// - Error handling and failure propagation
  Future<Either<Failure, List<String>>> call(
    GetSubcategoriesParams params,
  ) async {
    try {
      // Validate input parameters
      if (params.category.trim().isEmpty) {
        return Left(ValidationFailure('Category cannot be empty'));
      }

      // Get subcategories from repository
      final result = await repository.getSubcategoriesForCategory(
        params.category,
      );

      return result.fold(
        (failure) {
          // If repository fails, return default subcategories for the category
          return Right(_getDefaultSubcategories(params.category));
        },
        (subcategories) {
          // If no subcategories found, return default subcategories for the category
          if (subcategories.isEmpty) {
            return Right(_getDefaultSubcategories(params.category));
          }

          return Right(subcategories);
        },
      );
    } catch (e) {
      // Return default subcategories on any error
      return Right(_getDefaultSubcategories(params.category));
    }
  }

  /// Gets default subcategories for a specific category.
  /// This method provides fallback subcategories when none are found in storage.
  ///
  /// Parameters:
  /// - [category]: Main category to get default subcategories for
  ///
  /// Returns:
  /// - [List<String>]: List of default subcategories
  ///
  /// This method provides predefined subcategories for each main category
  /// to ensure the UI always has options to display.
  List<String> _getDefaultSubcategories(String category) {
    switch (category.toLowerCase()) {
      case 'food':
        return ['Groceries', 'Restaurant', 'Fast Food', 'Coffee', 'Snacks'];
      case 'transportation':
        return [
          'Gas',
          'Taxi',
          'Public Transport',
          'Parking',
          'Car Maintenance',
        ];
      case 'entertainment':
        return ['Movies', 'Games', 'Fitness', 'Music', 'Books', 'Streaming'];
      case 'utilities':
        return ['Electricity', 'Water', 'Internet', 'Phone', 'Gas Bill'];
      case 'other':
        return ['Misc', 'Shopping', 'Health', 'Education', 'Gifts'];
      default:
        return ['Misc', 'General'];
    }
  }
}

/// Parameters for getting subcategories for a specific category.
/// This class encapsulates the data needed to retrieve subcategories.
///
/// Usage Example:
/// ```dart
/// final params = GetSubcategoriesParams(category: 'Food');
/// ```
class GetSubcategoriesParams {
  /// The main category to get subcategories for
  final String category;

  const GetSubcategoriesParams({required this.category});

  /// Creates a copy of this params with updated fields.
  /// This is useful for updating parameters while maintaining immutability.
  ///
  /// Parameters:
  /// - [category]: Optional new category
  ///
  /// Returns:
  /// - [GetSubcategoriesParams]: Updated parameters
  GetSubcategoriesParams copyWith({String? category}) {
    return GetSubcategoriesParams(category: category ?? this.category);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is GetSubcategoriesParams && other.category == category;
  }

  @override
  int get hashCode => category.hashCode;

  @override
  String toString() => 'GetSubcategoriesParams(category: $category)';
}
