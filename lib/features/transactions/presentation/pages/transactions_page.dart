import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_flow/core/di/locator.dart';
import 'package:money_flow/core/widgets/widgets.dart';
import 'package:money_flow/features/transactions/presentation/bloc/transactions_bloc.dart';
import 'package:money_flow/features/transactions/presentation/bloc/transactions_event.dart';
import 'package:money_flow/features/transactions/presentation/bloc/transactions_state.dart';
import 'package:money_flow/features/transactions/presentation/widgets/transaction_item_widget.dart';
import 'package:money_flow/l10n/generated/app_localizations.dart';

/// Simple transactions page that displays all transactions in order
class TransactionsPage extends StatelessWidget {
  const TransactionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return BlocProvider(
      create: (context) =>
          getIt<TransactionsBloc>()
            ..add(const TransactionsEvent.loadTransactions()),
      child: GScaffold(
        title: l10n.transactions,
        body: BlocBuilder<TransactionsBloc, TransactionsState>(
          builder: (context, state) {
            return state.when(
              initial: () => const SizedBox(),
              loading: () => const Center(child: CircularProgressIndicator()),
              completed: (data) => _buildTransactionsList(data),
              error: (message) => Center(child: GText('Error: $message')),
            );
          },
        ),
      ),
    );
  }

  Widget _buildTransactionsList(data) {
    if (data.transactions.isEmpty) {
      return const Center(child: GText('No transactions found'));
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: data.transactions.length,
      itemBuilder: (context, index) {
        final transaction = data.transactions[index];
        return TransactionItemWidget(transaction: transaction);
      },
    );
  }
}
