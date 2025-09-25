import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_flow/core/di/locator.dart';
import 'package:money_flow/core/widgets/widgets.dart';
import 'package:money_flow/core/theme/app_colors.dart';
import 'package:money_flow/core/router/page_name.dart';
import 'package:money_flow/features/transactions/presentation/bloc/transactions_bloc.dart';
import 'package:money_flow/features/transactions/presentation/bloc/transactions_event.dart';
import 'package:money_flow/features/transactions/presentation/bloc/transactions_state.dart';
import 'package:money_flow/features/transactions/presentation/widgets/transaction_item_widget.dart';
import 'package:money_flow/l10n/generated/app_localizations.dart';

/// Transactions page that displays all transactions in order.
/// Shows an empty state with action buttons when no transactions exist.
///
/// Usage Example:
/// ```dart
/// Navigator.pushNamed(context, PageName.transactions);
/// ```
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
        automaticallyImplyLeading: false,
        body: BlocBuilder<TransactionsBloc, TransactionsState>(
          builder: (context, state) {
            return state.when(
              initial: () => const SizedBox(),
              loading: () => const Center(child: CircularProgressIndicator()),
              completed: (data) => _buildTransactionsList(context, data, l10n),
              error: (message) => Center(child: GText('Error: $message')),
            );
          },
        ),
      ),
    );
  }

  /// Builds the transactions list or empty state.
  /// Shows empty state with action buttons when no transactions exist.
  ///
  /// Parameters:
  /// - [context]: Build context for navigation
  /// - [data]: Transaction list data
  /// - [l10n]: Localization instance for localized strings
  Widget _buildTransactionsList(
    BuildContext context,
    data,
    AppLocalizations l10n,
  ) {
    // Show empty state when no transactions exist
    if (data.transactions.isEmpty) {
      return _EmptyTransactionsState(l10n: l10n);
    }

    // Show transactions list when transactions exist
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

/// Empty state widget for when no transactions exist.
/// Displays a message and action buttons for adding transactions manually or via SMS.
///
/// Usage Example:
/// ```dart
/// _EmptyTransactionsState(l10n: l10n)
/// ```
class _EmptyTransactionsState extends StatelessWidget {
  /// Localization instance for localized strings
  final AppLocalizations l10n;

  const _EmptyTransactionsState({required this.l10n});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Empty state illustration
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(60),
              ),
              child: Icon(
                Icons.receipt_long_outlined,
                size: 60,
                color: AppColors.primary.withOpacity(0.6),
              ),
            ),

            GGap.large(),

            // Title message
            GText(
              l10n.noTransactionsRightNow,
              style: GTextStyle.titleMedium,
              color: AppColors.textPrimary,
              textAlign: TextAlign.center,
            ),

            GGap.medium(),

            // Subtitle message
            GText(
              l10n.startByAddingFirstTransaction,
              style: GTextStyle.bodyMedium,
              color: AppColors.textSecondary,
              textAlign: TextAlign.center,
            ),

            GGap.extraLarge(),

            // Action buttons
            Column(
              children: [
                // Add Transaction Manually Button
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton.icon(
                    onPressed: () => _onAddTransactionTap(context),
                    icon: const Icon(
                      Icons.add_circle_outline,
                      color: AppColors.textWhite,
                    ),
                    label: GText(
                      l10n.addTransactionManually,
                      color: AppColors.textWhite,
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: AppColors.textWhite,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),

                GGap.medium(),

                // Import from SMS Button
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: OutlinedButton.icon(
                    onPressed: () => _onSmsImportTap(context),
                    icon: Icon(Icons.sms_outlined, color: AppColors.primary),
                    label: GText(l10n.importFromSms, color: AppColors.primary),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.primary,
                      side: BorderSide(color: AppColors.primary, width: 2),
                      backgroundColor: AppColors.surface,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Handles add transaction button tap.
  /// This method navigates to the add transaction page.
  void _onAddTransactionTap(BuildContext context) async {
    // Navigate to the Add Transaction page using named routes
    final result = await Navigator.of(
      context,
    ).pushNamed(PageName.addTransaction);

    // If a transaction was added (result is not null), refresh the transactions
    if (result != null && context.mounted) {
      // Trigger a refresh of the transactions list
      context.read<TransactionsBloc>().add(
        const TransactionsEvent.refreshTransactions(),
      );
    }
  }

  /// Handles SMS import button tap.
  /// This method navigates to the bank selection page first.
  void _onSmsImportTap(BuildContext context) {
    Navigator.pushNamed(context, PageName.bankSelection);
  }
}
