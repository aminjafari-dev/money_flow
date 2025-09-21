import 'package:flutter/material.dart';
import 'package:money_flow/core/widgets/widgets.dart';
import 'package:money_flow/core/theme/app_colors.dart';
import 'package:money_flow/features/dashboard/domain/entities/dashboard_entity.dart';
import 'package:money_flow/features/dashboard/presentation/widgets/transaction_item.dart';

/// Widget for displaying the recent transactions section.
/// This widget shows a list of recent transactions with a header.
///
/// Usage Example:
/// ```dart
/// RecentTransactions(
///   transactions: dashboard.recentTransactions,
/// ),
/// ```
class RecentTransactions extends StatelessWidget {
  /// List of recent transactions to display
  final List<TransactionEntity> transactions;

  const RecentTransactions({super.key, required this.transactions});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: GText(
            'Recent Transactions',
            style: GTextStyle.titleMedium,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        const SizedBox(height: 16),
        // Transactions List
        if (transactions.isEmpty)
          _buildEmptyState()
        else
          _buildTransactionsList(),
      ],
    );
  }

  /// Builds the empty state when no transactions are available.
  /// This method shows a placeholder message when the transactions list is empty.
  ///
  /// Returns:
  /// - [Widget]: Empty state widget
  Widget _buildEmptyState() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.backgroundLight,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(Icons.receipt_long, size: 48, color: AppColors.textLight),
          GGap.medium(),
          GText(
            'No transactions yet',
            style: GTextStyle.bodyLarge,
            color: AppColors.textSecondary,
            fontWeight: FontWeight.w500,
          ),
          GGap.small(),
          GText(
            'Your recent transactions will appear here',
            style: GTextStyle.bodyMedium,
            color: AppColors.textLight,
          ),
        ],
      ),
    );
  }

  /// Builds the list of transactions.
  /// This method creates a scrollable list of transaction items with proper spacing.
  ///
  /// Returns:
  /// - [Widget]: Transactions list widget
  Widget _buildTransactionsList() {
    return Column(
      children: transactions.map((transaction) {
        return TransactionItem(transaction: transaction);
      }).toList(),
    );
  }
}
