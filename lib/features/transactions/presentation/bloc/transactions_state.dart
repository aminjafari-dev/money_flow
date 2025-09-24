import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:money_flow/features/transactions/domain/entities/transaction_list_entity.dart';

part 'transactions_state.freezed.dart';

/// State for transactions loading
@freezed
class TransactionsState with _$TransactionsState {
  const factory TransactionsState.initial() = TransactionsInitial;
  const factory TransactionsState.loading() = TransactionsLoading;
  const factory TransactionsState.completed(TransactionListEntity data) =
      TransactionsCompleted;
  const factory TransactionsState.error(String message) = TransactionsError;
}
