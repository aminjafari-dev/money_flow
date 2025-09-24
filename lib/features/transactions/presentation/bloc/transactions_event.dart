import 'package:freezed_annotation/freezed_annotation.dart';

part 'transactions_event.freezed.dart';

/// Sealed class for transactions-related events
@freezed
class TransactionsEvent with _$TransactionsEvent {
  /// Event to load all transactions
  const factory TransactionsEvent.loadTransactions() = LoadTransactions;

  /// Event to refresh transactions
  const factory TransactionsEvent.refreshTransactions() = RefreshTransactions;
}
