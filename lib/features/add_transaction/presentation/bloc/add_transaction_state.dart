import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:money_flow/features/add_transaction/domain/entities/transaction_entity.dart';

part 'add_transaction_state.freezed.dart';

/// State for adding transaction operation.
/// This state represents the different states when adding a new transaction.
@freezed
class AddTransactionState with _$AddTransactionState {
  /// Initial state when no transaction has been added yet
  const factory AddTransactionState.initial() = AddTransactionInitial;

  /// Loading state when transaction is being added
  const factory AddTransactionState.loading() = AddTransactionLoading;

  /// Completed state when transaction is successfully added
  const factory AddTransactionState.completed(TransactionEntity transaction) =
      AddTransactionCompleted;

  /// Error state when transaction addition fails
  const factory AddTransactionState.error(String message) = AddTransactionError;
}

/// Main state for the add transaction feature.
/// This state manages the add transaction operation.
///
/// Usage Example:
/// ```dart
/// BlocBuilder<AddTransactionBloc, AddTransactionState>(
///   builder: (context, state) {
///     return state.when(
///       initial: () => const SizedBox(),
///       loading: () => const CircularProgressIndicator(),
///       completed: (transaction) => SuccessWidget(transaction: transaction),
///       error: (message) => ErrorWidget(message: message),
///     );
///   },
/// );
/// ```
@freezed
class AddTransactionMainState with _$AddTransactionMainState {
  const factory AddTransactionMainState({
    /// State for adding transaction operation
    @Default(AddTransactionState.initial()) AddTransactionState addTransaction,
  }) = _AddTransactionMainState;
}
