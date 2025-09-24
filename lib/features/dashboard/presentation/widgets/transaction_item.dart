import 'package:flutter/material.dart';
import 'package:money_flow/core/widgets/widgets.dart';
import 'package:money_flow/core/theme/app_colors.dart';
import 'package:money_flow/features/add_transaction/domain/entities/transaction_entity.dart';

/// Widget for displaying individual transaction items in the recent transactions list.
/// This widget shows transaction details in a clean list item format.
///
/// Usage Example:
/// ```dart
/// TransactionItem(
///   transaction: transactionEntity,
/// ),
/// ```
class TransactionItem extends StatelessWidget {
  /// Transaction entity to display
  final TransactionEntity transaction;

  const TransactionItem({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          // Left side - Icon with light blue background
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: const Color(
                0xFFE3F2FD,
              ), // Light blue background like in the image
              borderRadius: BorderRadius.circular(24),
            ),
            child: Icon(
              _getIconForCategory(transaction.category),
              color: const Color(0xFF1976D2), // Blue color like in the image
              size: 24,
            ),
          ),
          GGap.large(),
          // Center - Transaction details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GText(
                  transaction.merchant ??
                      transaction.description ??
                      'Transaction',
                  style: GTextStyle.bodyMedium,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: AppColors.textPrimary,
                ),
                GGap.small(),
                GText(
                  transaction.category,
                  style: GTextStyle.bodySmall,
                  color: AppColors.textSecondary,
                  fontSize: 14,
                ),
              ],
            ),
          ),
          // Right side - Amount
          GText(
            '${transaction.amount >= 0 ? '+' : ''}\$${transaction.absoluteAmount.toStringAsFixed(2)}',
            style: GTextStyle.bodyMedium,
            fontWeight: FontWeight.w600,
            color: transaction.isIncome
                ? AppColors.success
                : AppColors.textPrimary,
            fontSize: 16,
          ),
        ],
      ),
    );
  }

  /// Gets appropriate icon for transaction category.
  /// This method returns the most suitable icon based on the category.
  ///
  /// Parameters:
  /// - [category]: Transaction category
  ///
  /// Returns:
  /// - [IconData]: Appropriate icon for the category
  IconData _getIconForCategory(String category) {
    final lowerCategory = category.toLowerCase();

    if (lowerCategory.contains('grocer') || lowerCategory.contains('food')) {
      return Icons.shopping_cart;
    } else if (lowerCategory.contains('salary') ||
        lowerCategory.contains('income')) {
      return Icons.attach_money;
    } else if (lowerCategory.contains('dining') ||
        lowerCategory.contains('restaurant')) {
      return Icons.restaurant;
    } else if (lowerCategory.contains('donation') ||
        lowerCategory.contains('charity')) {
      return Icons.favorite;
    } else if (lowerCategory.contains('transport') ||
        lowerCategory.contains('gas')) {
      return Icons.directions_car;
    } else if (lowerCategory.contains('entertainment') ||
        lowerCategory.contains('movie')) {
      return Icons.movie;
    } else {
      return Icons.receipt;
    }
  }
}
