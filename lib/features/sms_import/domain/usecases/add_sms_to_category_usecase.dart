import 'package:dartz/dartz.dart';
import 'package:money_flow/core/error/failures.dart';
import 'package:money_flow/features/add_transaction/domain/entities/transaction_entity.dart';
import 'package:money_flow/features/add_transaction/domain/usecases/add_transaction_usecase.dart';
import 'package:money_flow/features/sms_import/domain/entities/sms_category_tracking_entity.dart';
import 'package:money_flow/features/sms_import/domain/entities/sms_entity.dart';
import 'package:money_flow/features/sms_import/domain/repositories/sms_category_tracking_repository.dart';

/// Use case for adding an SMS message to a specific category.
/// This use case handles the business logic for:
/// 1. Creating a transaction from the SMS message
/// 2. Tracking that the SMS was added to the category
/// 3. Preventing duplicate additions
///
/// Usage Example:
/// ```dart
/// final useCase = AddSmsToCategoryUseCase(
///   trackingRepository: getIt<SmsCategoryTrackingRepository>(),
///   addTransactionUseCase: getIt<AddTransactionUseCase>(),
/// );
///
/// final result = await useCase.call(AddSmsToCategoryParams(
///   sms: smsEntity,
///   category: 'Income',
///   mainCategory: 'income',
///   amount: 100.0,
/// ));
/// ```
class AddSmsToCategoryUseCase {
  /// Repository for SMS category tracking operations
  final SmsCategoryTrackingRepository _trackingRepository;

  /// Use case for adding transactions
  final AddTransactionUseCase _addTransactionUseCase;

  /// Creates a new instance of AddSmsToCategoryUseCase.
  ///
  /// Parameters:
  /// - [trackingRepository]: Repository for tracking SMS category assignments
  /// - [addTransactionUseCase]: Use case for creating transactions
  const AddSmsToCategoryUseCase({
    required SmsCategoryTrackingRepository trackingRepository,
    required AddTransactionUseCase addTransactionUseCase,
  }) : _trackingRepository = trackingRepository,
       _addTransactionUseCase = addTransactionUseCase;

  /// Executes the use case to add an SMS message to a specific category.
  /// This method creates a transaction from the SMS and tracks the assignment.
  ///
  /// Parameters:
  /// - [params]: Parameters containing SMS, category, and amount information
  ///
  /// Returns:
  /// - [Right] with [TransactionEntity] on success
  /// - [Left] with [Failure] on error
  ///
  /// This method handles:
  /// - Checking if SMS is already added to the category
  /// - Creating a transaction from the SMS message
  /// - Tracking the SMS-category assignment
  Future<Either<Failure, TransactionEntity>> call(
    AddSmsToCategoryParams params,
  ) async {
    try {
      // Check if SMS is already added to this category
      final isAlreadyAdded = await _trackingRepository.isSmsAddedToCategory(
        params.sms.id,
        params.category,
      );

      if (isAlreadyAdded.isLeft()) {
        return Left(isAlreadyAdded.fold((l) => l, (r) => throw Exception()));
      }

      final alreadyAdded = isAlreadyAdded.fold(
        (l) => throw Exception(),
        (r) => r,
      );
      if (alreadyAdded) {
        return const Left(
          ValidationFailure('SMS already added to this category'),
        );
      }

      // Create transaction from SMS
      final transactionParams = AddTransactionParams(
        amount: params.amount,
        mainCategory: params.mainCategory,
        category: params.category,
        description: params.sms.body,
        dateTime: params.sms.date,
        type: _getTransactionType(params.mainCategory),
        isFromSms: true,
        merchant: _extractMerchantFromSms(params.sms.body),
      );

      final transactionResult = await _addTransactionUseCase.call(
        transactionParams,
      );

      return transactionResult.fold((failure) => Left(failure), (
        transaction,
      ) async {
        // Track the SMS-category assignment
        final tracking = SmsCategoryTrackingEntity(
          smsId: params.sms.id,
          category: params.category,
          mainCategory: params.mainCategory,
          addedAt: DateTime.now(),
          transactionId: transaction.id,
        );

        final trackingResult = await _trackingRepository.addSmsToCategory(
          tracking,
        );

        return trackingResult.fold(
          (failure) => Left(failure),
          (_) => Right(transaction),
        );
      });
    } catch (e) {
      return Left(
        UnknownFailure('Failed to add SMS to category: ${e.toString()}'),
      );
    }
  }

  /// Determines the transaction type based on the main category.
  /// This method maps main categories to transaction types.
  ///
  /// Parameters:
  /// - [mainCategory]: The main category (income, expenses, charity, investments)
  ///
  /// Returns:
  /// - [TransactionType]: The corresponding transaction type
  TransactionType _getTransactionType(String mainCategory) {
    switch (mainCategory.toLowerCase()) {
      case 'income':
        return TransactionType.income;
      case 'expenses':
        return TransactionType.expense;
      case 'charity':
        return TransactionType.charity;
      case 'investments':
        return TransactionType.investments;
      default:
        return TransactionType.expense;
    }
  }

  /// Extracts merchant information from SMS body.
  /// This method attempts to identify merchant names from SMS content.
  ///
  /// Parameters:
  /// - [smsBody]: The SMS message body
  ///
  /// Returns:
  /// - [String?]: Extracted merchant name or null if not found
  String? _extractMerchantFromSms(String smsBody) {
    // Simple merchant extraction logic
    // This could be enhanced with more sophisticated parsing
    final body = smsBody.toLowerCase();

    // Common merchant patterns
    final patterns = [
      r'at\s+([a-zA-Z\s]+)',
      r'from\s+([a-zA-Z\s]+)',
      r'to\s+([a-zA-Z\s]+)',
    ];

    for (final pattern in patterns) {
      final regex = RegExp(pattern);
      final match = regex.firstMatch(body);
      if (match != null && match.group(1) != null) {
        final merchant = match.group(1)!.trim();
        if (merchant.length > 2 && merchant.length < 50) {
          return merchant;
        }
      }
    }

    return null;
  }
}

/// Parameters for adding an SMS message to a category.
/// This class encapsulates all the data needed to add an SMS to a category.
///
/// Usage Example:
/// ```dart
/// final params = AddSmsToCategoryParams(
///   sms: smsEntity,
///   category: 'Income',
///   mainCategory: 'income',
///   amount: 100.0,
/// );
/// ```
class AddSmsToCategoryParams {
  /// The SMS entity to add to the category
  final SmsEntity sms;

  /// The category name (Income, Expenses, Charity, Investments)
  final String category;

  /// The main category (income, expenses, charity, investments)
  final String mainCategory;

  /// The transaction amount
  final double amount;

  /// Creates a new instance of AddSmsToCategoryParams.
  ///
  /// Parameters:
  /// - [sms]: The SMS entity to add to the category
  /// - [category]: The category name
  /// - [mainCategory]: The main category
  /// - [amount]: The transaction amount
  const AddSmsToCategoryParams({
    required this.sms,
    required this.category,
    required this.mainCategory,
    required this.amount,
  });
}
