import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:money_flow/features/add_transaction/domain/entities/transaction_entity.dart';

part 'add_transaction_event.freezed.dart';

/// Sealed class for add transaction-related events.
/// This class defines all possible events that can be triggered in the add transaction flow.
/// Form state management is handled in the UI, not in the BLoC.
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
}
