import 'package:flutter/material.dart';
import 'package:money_flow/core/theme/app_colors.dart';
import 'package:money_flow/core/widgets/widgets.dart';
import 'package:money_flow/core/constants/image_path.dart';
import 'package:money_flow/features/add_transaction/domain/entities/transaction_entity.dart';
import 'package:intl/intl.dart';

/// Simple widget to display a single transaction item
class TransactionItemWidget extends StatelessWidget {
  final TransactionEntity transaction;

  const TransactionItemWidget({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    final isExpense = transaction.type.name == 'expense';
    final amountColor = isExpense ? AppColors.error : AppColors.success;
    final amountPrefix = isExpense ? '-' : '+';

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          // Category image
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                ImagePath.getCategoryImage(transaction.category),
                width: 40,
                height: 40,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  // Fallback to icon if image fails to load
                  return Icon(
                    _getCategoryIcon(),
                    color: AppColors.primary,
                    size: 20,
                  );
                },
              ),
            ),
          ),
          const SizedBox(width: 12),

          // Transaction details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GText(
                  transaction.merchant ?? transaction.category,
                  style: GTextStyle.bodyMedium,
                  color: AppColors.textPrimary,
                ),
                const SizedBox(height: 2),
                GText(
                  DateFormat('MMM dd, yyyy').format(transaction.dateTime),
                  style: GTextStyle.bodySmall,
                  color: AppColors.textSecondary,
                ),
              ],
            ),
          ),

          // Amount
          GText(
            '$amountPrefix\$${transaction.amount.toStringAsFixed(2)}',
            style: GTextStyle.bodyMedium,
            color: amountColor,
          ),
        ],
      ),
    );
  }

  IconData _getCategoryIcon() {
    switch (transaction.category.toLowerCase()) {
      case 'food':
      case 'groceries':
        return Icons.restaurant;
      case 'transportation':
        return Icons.directions_car;
      case 'entertainment':
        return Icons.movie;
      case 'shopping':
        return Icons.shopping_bag;
      case 'health':
        return Icons.medical_services;
      case 'income':
        return Icons.attach_money;
      default:
        return Icons.receipt;
    }
  }
}
