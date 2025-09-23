import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:money_flow/features/add_transaction/domain/entities/transaction_entity.dart';

part 'add_transaction_event.freezed.dart';

/// Sealed class for add transaction-related events.
/// This class defines all possible events that can be triggered in the add transaction flow.
///
/// Usage Example:
/// ```dart
/// // Add transaction
/// getIt<AddTransactionBloc>().add(
///   AddTransactionEvent.addTransaction(
///     amount: 25.50,
///     mainCategory: 'expenses',
///     category: 'Food',
///     description: 'Weekly shopping',
///     dateTime: DateTime.now(),
///     type: TransactionType.expense,
///   ),
/// );
/// ```
@freezed
class AddTransactionEvent with _$AddTransactionEvent {
  /// Event to add a new transaction to the system.
  /// This event creates and saves a new transaction.
  ///
  /// Parameters:
  /// - [amount]: The transaction amount
  /// - [mainCategory]: The main category (income, expenses, charity, investments)
  /// - [category]: The specific category
  /// - [description]: Optional transaction description
  /// - [dateTime]: The transaction date and time
  /// - [type]: The transaction type (expense or income)
  /// - [merchant]: Optional merchant name
  /// - [isFromSms]: Whether this transaction was created from SMS import
  const factory AddTransactionEvent.addTransaction({
    required double amount,
    required String mainCategory,
    required String category,
    String? description,
    required DateTime dateTime,
    required TransactionType type,
    String? merchant,
    @Default(false) bool isFromSms,
  }) = AddTransaction;
}
