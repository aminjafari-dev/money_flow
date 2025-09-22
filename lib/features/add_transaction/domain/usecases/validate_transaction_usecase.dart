import 'package:dartz/dartz.dart';
import 'package:money_flow/core/error/failures.dart';
import 'package:money_flow/features/add_transaction/domain/entities/transaction_entity.dart';

/// Use case for validating transaction data before saving.
/// This use case ensures that transaction data meets all business rules and requirements.
///
/// Usage Example:
/// ```dart
/// final useCase = ValidateTransactionUseCase();
///
/// final result = await useCase.call(ValidateTransactionParams(
///   amount: 25.50,
///   category: 'Food',
///   subcategory: 'Groceries',
///   description: 'Weekly shopping',
///   dateTime: DateTime.now(),
///   type: TransactionType.expense,
/// ));
///
/// result.fold(
///   (failure) => print('Validation failed: ${failure.message}'),
///   (isValid) => print('Transaction is valid: $isValid'),
/// );
/// ```
class ValidateTransactionUseCase {
  /// Executes the validate transaction use case.
  /// This method validates all transaction parameters against business rules.
  ///
  /// Parameters:
  /// - [params]: Parameters containing transaction data to validate
  ///
  /// Returns:
  /// - [Either<Failure, bool>]: Success with validation result or failure
  ///
  /// This method handles:
  /// - Amount validation
  /// - Category and subcategory validation
  /// - Date validation
  /// - Description validation
  /// - Business rule validation
  Future<Either<Failure, bool>> call(ValidateTransactionParams params) async {
    try {
      // Validate all parameters
      final validationErrors = <String>[];

      // Validate amount
      final amountValidation = _validateAmount(params.amount, params.type);
      if (amountValidation != null) {
        validationErrors.add(amountValidation);
      }

      // Validate category
      final categoryValidation = _validateCategory(params.category);
      if (categoryValidation != null) {
        validationErrors.add(categoryValidation);
      }

      // Validate subcategory
      final subcategoryValidation = _validateSubcategory(params.subcategory);
      if (subcategoryValidation != null) {
        validationErrors.add(subcategoryValidation);
      }

      // Validate date
      final dateValidation = _validateDate(params.dateTime, params.type);
      if (dateValidation != null) {
        validationErrors.add(dateValidation);
      }

      // Validate description (optional but if provided, should be valid)
      final descriptionValidation = _validateDescription(params.description);
      if (descriptionValidation != null) {
        validationErrors.add(descriptionValidation);
      }

      // Validate merchant (optional but if provided, should be valid)
      final merchantValidation = _validateMerchant(params.merchant);
      if (merchantValidation != null) {
        validationErrors.add(merchantValidation);
      }

      // If there are validation errors, return failure
      if (validationErrors.isNotEmpty) {
        return Left(ValidationFailure(validationErrors.join('; ')));
      }

      // All validations passed
      return const Right(true);
    } catch (e) {
      return Left(UnknownFailure('Failed to validate transaction: $e'));
    }
  }

  /// Validates the transaction amount.
  /// This method ensures the amount meets business requirements.
  ///
  /// Parameters:
  /// - [amount]: Amount to validate
  /// - [type]: Transaction type (expense or income)
  ///
  /// Returns:
  /// - [String?]: Validation error message or null if valid
  ///
  /// This method checks:
  /// - Amount is not zero
  /// - Amount is positive for income transactions
  /// - Amount is negative for expense transactions
  /// - Amount is within reasonable limits
  String? _validateAmount(double amount, TransactionType type) {
    // Check if amount is zero
    if (amount == 0) {
      return 'Transaction amount cannot be zero';
    }

    // Check if amount is too large (prevent unrealistic amounts)
    if (amount.abs() > 1000000) {
      return 'Transaction amount is too large (maximum: \$1,000,000)';
    }

    // Check if amount is too small (prevent unrealistic amounts)
    if (amount.abs() < 0.01) {
      return 'Transaction amount is too small (minimum: \$0.01)';
    }

    // Check amount sign based on transaction type
    if (type == TransactionType.income && amount < 0) {
      return 'Income transactions must have positive amounts';
    }

    if (type == TransactionType.expense && amount > 0) {
      return 'Expense transactions must have negative amounts';
    }

    return null; // Valid
  }

  /// Validates the transaction category.
  /// This method ensures the category is valid and not empty.
  ///
  /// Parameters:
  /// - [category]: Category to validate
  ///
  /// Returns:
  /// - [String?]: Validation error message or null if valid
  ///
  /// This method checks:
  /// - Category is not empty
  /// - Category is not too long
  /// - Category contains only valid characters
  String? _validateCategory(String category) {
    // Check if category is empty
    if (category.trim().isEmpty) {
      return 'Category is required';
    }

    // Check if category is too long
    if (category.length > 50) {
      return 'Category name is too long (maximum: 50 characters)';
    }

    // Check if category contains only valid characters
    if (!RegExp(r'^[a-zA-Z0-9\s\-_]+$').hasMatch(category)) {
      return 'Category contains invalid characters (only letters, numbers, spaces, hyphens, and underscores allowed)';
    }

    return null; // Valid
  }

  /// Validates the transaction subcategory.
  /// This method ensures the subcategory is valid and not empty.
  ///
  /// Parameters:
  /// - [subcategory]: Subcategory to validate
  ///
  /// Returns:
  /// - [String?]: Validation error message or null if valid
  ///
  /// This method checks:
  /// - Subcategory is not empty
  /// - Subcategory is not too long
  /// - Subcategory contains only valid characters
  String? _validateSubcategory(String subcategory) {
    // Check if subcategory is empty
    if (subcategory.trim().isEmpty) {
      return 'Subcategory is required';
    }

    // Check if subcategory is too long
    if (subcategory.length > 50) {
      return 'Subcategory name is too long (maximum: 50 characters)';
    }

    // Check if subcategory contains only valid characters
    if (!RegExp(r'^[a-zA-Z0-9\s\-_]+$').hasMatch(subcategory)) {
      return 'Subcategory contains invalid characters (only letters, numbers, spaces, hyphens, and underscores allowed)';
    }

    return null; // Valid
  }

  /// Validates the transaction date.
  /// This method ensures the date is valid and within acceptable ranges.
  ///
  /// Parameters:
  /// - [dateTime]: Date to validate
  /// - [type]: Transaction type (expense or income)
  ///
  /// Returns:
  /// - [String?]: Validation error message or null if valid
  ///
  /// This method checks:
  /// - Date is not too far in the past
  /// - Date is not too far in the future
  /// - Date is valid
  String? _validateDate(DateTime dateTime, TransactionType type) {
    final now = DateTime.now();
    final oneYearAgo = now.subtract(const Duration(days: 365));
    final oneDayFromNow = now.add(const Duration(days: 1));

    // Check if date is too far in the past
    if (dateTime.isBefore(oneYearAgo)) {
      return 'Transaction date cannot be more than 1 year in the past';
    }

    // Check if date is too far in the future
    if (dateTime.isAfter(oneDayFromNow)) {
      return 'Transaction date cannot be more than 1 day in the future';
    }

    return null; // Valid
  }

  /// Validates the transaction description.
  /// This method ensures the description is valid if provided.
  ///
  /// Parameters:
  /// - [description]: Description to validate (optional)
  ///
  /// Returns:
  /// - [String?]: Validation error message or null if valid
  ///
  /// This method checks:
  /// - Description is not too long if provided
  /// - Description contains only valid characters if provided
  String? _validateDescription(String? description) {
    // Description is optional, so null is valid
    if (description == null || description.trim().isEmpty) {
      return null;
    }

    // Check if description is too long
    if (description.length > 500) {
      return 'Description is too long (maximum: 500 characters)';
    }

    // Check if description contains only valid characters
    // Allow letters, numbers, spaces, and common punctuation
    // Use a simpler validation approach - just check for basic printable characters
    final hasControlChars = description.codeUnits.any(
      (char) => char < 32 && char != 9 && char != 10 && char != 13,
    );
    if (hasControlChars) {
      return 'Description contains invalid control characters';
    }

    return null; // Valid
  }

  /// Validates the merchant name.
  /// This method ensures the merchant name is valid if provided.
  ///
  /// Parameters:
  /// - [merchant]: Merchant name to validate (optional)
  ///
  /// Returns:
  /// - [String?]: Validation error message or null if valid
  ///
  /// This method checks:
  /// - Merchant name is not too long if provided
  /// - Merchant name contains only valid characters if provided
  String? _validateMerchant(String? merchant) {
    // Merchant is optional, so null is valid
    if (merchant == null || merchant.trim().isEmpty) {
      return null;
    }

    // Check if merchant name is too long
    if (merchant.length > 100) {
      return 'Merchant name is too long (maximum: 100 characters)';
    }

    // Check if merchant name contains only valid characters
    if (!RegExp(r'^[a-zA-Z0-9\s\-_.,&]+$').hasMatch(merchant)) {
      return 'Merchant name contains invalid characters (only letters, numbers, spaces, hyphens, underscores, periods, commas, and ampersands allowed)';
    }

    return null; // Valid
  }
}

/// Parameters for validating transaction data.
/// This class encapsulates all the data needed to validate a transaction.
///
/// Usage Example:
/// ```dart
/// final params = ValidateTransactionParams(
///   amount: 25.50,
///   category: 'Food',
///   subcategory: 'Groceries',
///   description: 'Weekly shopping',
///   dateTime: DateTime.now(),
///   type: TransactionType.expense,
///   merchant: 'SuperMart',
/// );
/// ```
class ValidateTransactionParams {
  /// Transaction amount
  final double amount;

  /// Main category of the transaction
  final String category;

  /// Specific subcategory within the main category
  final String subcategory;

  /// Optional description or notes about the transaction
  final String? description;

  /// Date and time when the transaction occurred
  final DateTime dateTime;

  /// Type of transaction (expense or income)
  final TransactionType type;

  /// Optional merchant or vendor name
  final String? merchant;

  const ValidateTransactionParams({
    required this.amount,
    required this.category,
    required this.subcategory,
    this.description,
    required this.dateTime,
    required this.type,
    this.merchant,
  });

  /// Creates a copy of this params with updated fields.
  /// This is useful for updating parameters while maintaining immutability.
  ///
  /// Parameters:
  /// - [amount]: Optional new amount
  /// - [category]: Optional new category
  /// - [subcategory]: Optional new subcategory
  /// - [description]: Optional new description
  /// - [dateTime]: Optional new date time
  /// - [type]: Optional new type
  /// - [merchant]: Optional new merchant
  ///
  /// Returns:
  /// - [ValidateTransactionParams]: Updated parameters
  ValidateTransactionParams copyWith({
    double? amount,
    String? category,
    String? subcategory,
    String? description,
    DateTime? dateTime,
    TransactionType? type,
    String? merchant,
  }) {
    return ValidateTransactionParams(
      amount: amount ?? this.amount,
      category: category ?? this.category,
      subcategory: subcategory ?? this.subcategory,
      description: description ?? this.description,
      dateTime: dateTime ?? this.dateTime,
      type: type ?? this.type,
      merchant: merchant ?? this.merchant,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ValidateTransactionParams &&
        other.amount == amount &&
        other.category == category &&
        other.subcategory == subcategory &&
        other.description == description &&
        other.dateTime == dateTime &&
        other.type == type &&
        other.merchant == merchant;
  }

  @override
  int get hashCode {
    return Object.hash(
      amount,
      category,
      subcategory,
      description,
      dateTime,
      type,
      merchant,
    );
  }

  @override
  String toString() {
    return 'ValidateTransactionParams(amount: $amount, category: $category, subcategory: $subcategory, description: $description, dateTime: $dateTime, type: $type, merchant: $merchant)';
  }
}
