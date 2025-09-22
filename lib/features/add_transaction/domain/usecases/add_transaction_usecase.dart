import 'package:dartz/dartz.dart';
import 'package:money_flow/core/error/failures.dart';
import 'package:money_flow/features/add_transaction/domain/entities/transaction_entity.dart';
import 'package:money_flow/features/add_transaction/domain/repositories/transaction_repository.dart';

/// Use case for adding a new transaction to the system.
/// This use case handles the business logic for creating transactions,
/// including validation, ID generation, and data persistence.
///
/// Usage Example:
/// ```dart
/// final useCase = AddTransactionUseCase(repository: getIt<TransactionRepository>());
///
/// final result = await useCase.call(AddTransactionParams(
///   amount: 25.50,
///   category: 'Food',
///   subcategory: 'Groceries',
///   description: 'Weekly shopping',
///   dateTime: DateTime.now(),
///   type: TransactionType.expense,
///   merchant: 'SuperMart',
/// ));
///
/// result.fold(
///   (failure) => print('Error: ${failure.message}'),
///   (transaction) => print('Transaction added: ${transaction.id}'),
/// );
/// ```
class AddTransactionUseCase {
  final TransactionRepository repository;

  AddTransactionUseCase({required this.repository});

  /// Executes the add transaction use case.
  /// This method validates the input parameters and creates a new transaction.
  ///
  /// Parameters:
  /// - [params]: Parameters containing transaction data
  ///
  /// Returns:
  /// - [Either<Failure, TransactionEntity>]: Success with created transaction or failure
  ///
  /// This method handles:
  /// - Input validation
  /// - Transaction ID generation
  /// - Transaction entity creation
  /// - Repository call for persistence
  Future<Either<Failure, TransactionEntity>> call(
    AddTransactionParams params,
  ) async {
    try {
      // Validate input parameters
      final validationResult = _validateParams(params);
      if (validationResult != null) {
        return Left(ValidationFailure(validationResult));
      }

      // Generate unique transaction ID
      final transactionId = _generateTransactionId();

      // Create transaction entity
      final transaction = TransactionEntity(
        id: transactionId,
        amount: params.amount,
        mainCategory: params.mainCategory,
        category: params.category,
        subcategory: params.subcategory,
        description: params.description,
        dateTime: params.dateTime,
        type: params.type,
        isFromSms: params.isFromSms,
        merchant: params.merchant,
      );

      // Add transaction through repository
      return await repository.addTransaction(transaction);
    } catch (e) {
      return Left(UnknownFailure('Failed to add transaction: $e'));
    }
  }

  /// Validates the input parameters for transaction creation.
  /// This method ensures all required fields are present and valid.
  ///
  /// Parameters:
  /// - [params]: Parameters to validate
  ///
  /// Returns:
  /// - [String?]: Validation error message or null if valid
  ///
  /// This method checks:
  /// - Amount is not zero
  /// - Category is not empty
  /// - Subcategory is not empty
  /// - Date is not in the future (for most transactions)
  String? _validateParams(AddTransactionParams params) {
    // Validate amount
    if (params.amount == 0) {
      return 'Transaction amount cannot be zero';
    }

    // Validate category
    if (params.category.trim().isEmpty) {
      return 'Category is required';
    }

    // Validate subcategory
    if (params.subcategory.trim().isEmpty) {
      return 'Subcategory is required';
    }

    // Validate date (prevent future dates for most transactions)
    if (params.dateTime.isAfter(DateTime.now().add(const Duration(days: 1)))) {
      return 'Transaction date cannot be more than 1 day in the future';
    }

    return null; // Valid
  }

  /// Generates a unique transaction ID.
  /// This method creates a unique identifier for the transaction.
  ///
  /// Returns:
  /// - [String]: Unique transaction ID
  ///
  /// The ID format is: txn_[timestamp]_[random]
  /// This ensures uniqueness and provides some chronological ordering.
  String _generateTransactionId() {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final random = (timestamp % 10000).toString().padLeft(4, '0');
    return 'txn_${timestamp}_$random';
  }
}

/// Parameters for adding a new transaction.
/// This class encapsulates all the data needed to create a transaction.
///
/// Usage Example:
/// ```dart
/// final params = AddTransactionParams(
///   amount: 25.50,
///   category: 'Food',
///   subcategory: 'Groceries',
///   description: 'Weekly shopping',
///   dateTime: DateTime.now(),
///   type: TransactionType.expense,
///   merchant: 'SuperMart',
/// );
/// ```
class AddTransactionParams {
  /// Transaction amount (positive for income, negative for expense)
  final double amount;

  /// Main category of the transaction (income, expenses, charity, investments)
  final String mainCategory;

  /// Category of the transaction
  final String category;

  /// Specific subcategory within the main category
  final String subcategory;

  /// Optional description or notes about the transaction
  final String? description;

  /// Date and time when the transaction occurred
  final DateTime dateTime;

  /// Type of transaction (expense or income)
  final TransactionType type;

  /// Whether this transaction was created from SMS import
  final bool isFromSms;

  /// Merchant or vendor name
  final String? merchant;

  const AddTransactionParams({
    required this.amount,
    required this.mainCategory,
    required this.category,
    required this.subcategory,
    this.description,
    required this.dateTime,
    required this.type,
    this.isFromSms = false,
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
  /// - [isFromSms]: Optional new SMS flag
  /// - [merchant]: Optional new merchant
  ///
  /// Returns:
  /// - [AddTransactionParams]: Updated parameters
  AddTransactionParams copyWith({
    double? amount,
    String? mainCategory,
    String? category,
    String? subcategory,
    String? description,
    DateTime? dateTime,
    TransactionType? type,
    bool? isFromSms,
    String? merchant,
  }) {
    return AddTransactionParams(
      amount: amount ?? this.amount,
      mainCategory: mainCategory ?? this.mainCategory,
      category: category ?? this.category,
      subcategory: subcategory ?? this.subcategory,
      description: description ?? this.description,
      dateTime: dateTime ?? this.dateTime,
      type: type ?? this.type,
      isFromSms: isFromSms ?? this.isFromSms,
      merchant: merchant ?? this.merchant,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is AddTransactionParams &&
        other.amount == amount &&
        other.mainCategory == mainCategory &&
        other.category == category &&
        other.subcategory == subcategory &&
        other.description == description &&
        other.dateTime == dateTime &&
        other.type == type &&
        other.isFromSms == isFromSms &&
        other.merchant == merchant;
  }

  @override
  int get hashCode {
    return Object.hash(
      amount,
      mainCategory,
      category,
      subcategory,
      description,
      dateTime,
      type,
      isFromSms,
      merchant,
    );
  }

  @override
  String toString() {
    return 'AddTransactionParams(amount: $amount, mainCategory: $mainCategory, category: $category, subcategory: $subcategory, description: $description, dateTime: $dateTime, type: $type, isFromSms: $isFromSms, merchant: $merchant)';
  }
}
