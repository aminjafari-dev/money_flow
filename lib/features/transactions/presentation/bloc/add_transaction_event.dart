import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:money_flow/features/transactions/domain/entities/transaction_entity.dart';

part 'add_transaction_event.freezed.dart';

/// Sealed class for add transaction-related events.
/// This class defines all possible events that can be triggered in the add transaction flow.
///
/// Usage Example:
/// ```dart
/// // Initialize the form
/// context.read<AddTransactionBloc>().add(
///   const AddTransactionEvent.initialize(),
/// );
///
/// // Load categories
/// context.read<AddTransactionBloc>().add(
///   const AddTransactionEvent.loadCategories(),
/// );
///
/// // Add transaction
/// context.read<AddTransactionBloc>().add(
///   AddTransactionEvent.addTransaction(
///     amount: 25.50,
///     category: 'Food',
///     subcategory: 'Groceries',
///     description: 'Weekly shopping',
///     dateTime: DateTime.now(),
///     type: TransactionType.expense,
///   ),
/// );
/// ```
@freezed
class AddTransactionEvent with _$AddTransactionEvent {
  /// Event to initialize the add transaction form.
  /// This event sets up the initial state and loads default data.
  const factory AddTransactionEvent.initialize() = Initialize;

  /// Event to load available categories for transaction categorization.
  /// This event retrieves all available categories from the repository.
  const factory AddTransactionEvent.loadCategories() = LoadCategories;

  /// Event to load subcategories for a specific category.
  /// This event retrieves subcategories based on the selected main category.
  ///
  /// Parameters:
  /// - [category]: The main category to get subcategories for
  const factory AddTransactionEvent.loadSubcategories({
    required String category,
  }) = LoadSubcategories;

  /// Event to suggest category and subcategory based on transaction details.
  /// This event uses AI/ML to suggest appropriate categories.
  ///
  /// Parameters:
  /// - [amount]: The transaction amount
  /// - [description]: Optional transaction description
  /// - [merchant]: Optional merchant name
  const factory AddTransactionEvent.suggestCategory({
    required double amount,
    String? description,
    String? merchant,
  }) = SuggestCategory;

  /// Event to validate transaction data before saving.
  /// This event validates all transaction fields against business rules.
  ///
  /// Parameters:
  /// - [amount]: The transaction amount
  /// - [category]: The main category
  /// - [subcategory]: The subcategory
  /// - [description]: Optional transaction description
  /// - [dateTime]: The transaction date and time
  /// - [type]: The transaction type (expense or income)
  /// - [merchant]: Optional merchant name
  const factory AddTransactionEvent.validateTransaction({
    required double amount,
    required String category,
    required String subcategory,
    String? description,
    required DateTime dateTime,
    required TransactionType type,
    String? merchant,
  }) = ValidateTransaction;

  /// Event to add a new transaction to the system.
  /// This event creates and saves a new transaction.
  ///
  /// Parameters:
  /// - [amount]: The transaction amount
  /// - [category]: The main category
  /// - [subcategory]: The subcategory
  /// - [description]: Optional transaction description
  /// - [dateTime]: The transaction date and time
  /// - [type]: The transaction type (expense or income)
  /// - [merchant]: Optional merchant name
  /// - [isFromSms]: Whether this transaction was created from SMS import
  const factory AddTransactionEvent.addTransaction({
    required double amount,
    required String category,
    required String subcategory,
    String? description,
    required DateTime dateTime,
    required TransactionType type,
    String? merchant,
    @Default(false) bool isFromSms,
  }) = AddTransaction;

  /// Event to update the selected category.
  /// This event updates the currently selected category and clears subcategory.
  ///
  /// Parameters:
  /// - [category]: The new selected category
  const factory AddTransactionEvent.updateCategory({required String category}) =
      UpdateCategory;

  /// Event to update the selected subcategory.
  /// This event updates the currently selected subcategory.
  ///
  /// Parameters:
  /// - [subcategory]: The new selected subcategory
  const factory AddTransactionEvent.updateSubcategory({
    required String subcategory,
  }) = UpdateSubcategory;

  /// Event to update the transaction amount.
  /// This event updates the transaction amount field.
  ///
  /// Parameters:
  /// - [amount]: The new transaction amount
  const factory AddTransactionEvent.updateAmount({required double amount}) =
      UpdateAmount;

  /// Event to update the transaction description.
  /// This event updates the transaction description field.
  ///
  /// Parameters:
  /// - [description]: The new transaction description
  const factory AddTransactionEvent.updateDescription({String? description}) =
      UpdateDescription;

  /// Event to update the transaction date and time.
  /// This event updates the transaction date and time field.
  ///
  /// Parameters:
  /// - [dateTime]: The new transaction date and time
  const factory AddTransactionEvent.updateDateTime({
    required DateTime dateTime,
  }) = UpdateDateTime;

  /// Event to update the transaction type.
  /// This event updates the transaction type (expense or income).
  ///
  /// Parameters:
  /// - [type]: The new transaction type
  const factory AddTransactionEvent.updateType({
    required TransactionType type,
  }) = UpdateType;

  /// Event to update the merchant name.
  /// This event updates the merchant name field.
  ///
  /// Parameters:
  /// - [merchant]: The new merchant name
  const factory AddTransactionEvent.updateMerchant({String? merchant}) =
      UpdateMerchant;

  /// Event to clear all form data.
  /// This event resets the form to its initial state.
  const factory AddTransactionEvent.clearForm() = ClearForm;

  /// Event to reset the form to initial state.
  /// This event resets the form without clearing loaded data.
  const factory AddTransactionEvent.resetForm() = ResetForm;
}
