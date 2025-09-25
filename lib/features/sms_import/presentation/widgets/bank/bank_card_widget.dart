import 'package:flutter/material.dart';
import 'package:money_flow/core/widgets/g_text.dart';
import 'package:money_flow/core/widgets/g_gap.dart';
import 'package:money_flow/core/theme/app_colors.dart';
import 'package:money_flow/features/sms_import/domain/entities/bank_entity.dart';

/// Bank card widget for displaying selected bank information.
/// This widget shows bank details in a card format with options
/// to navigate to SMS import or delete the bank.
///
/// Usage Example:
/// ```dart
/// BankCardWidget(
///   bank: bankEntity,
///   onTap: () => navigateToSmsImport(bankEntity),
///   onDelete: () => deleteBank(bankEntity),
/// )
/// ```
class BankCardWidget extends StatelessWidget {
  /// The bank entity to display
  final BankEntity bank;

  /// Callback when the card is tapped
  final VoidCallback onTap;

  /// Callback when the delete button is pressed
  final VoidCallback onDelete;

  /// Creates a new instance of BankCardWidget.
  ///
  /// Parameters:
  /// - [bank]: The bank entity to display
  /// - [onTap]: Callback when the card is tapped
  /// - [onDelete]: Callback when the delete button is pressed
  const BankCardWidget({
    super.key,
    required this.bank,
    required this.onTap,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.zero,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              // Bank icon
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.account_balance,
                  color: AppColors.primary,
                  size: 24,
                ),
              ),

              GGap.medium(),

              // Bank info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GText(
                      bank.name,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    GGap.small(),
                    GText(
                      bank.phoneNumber,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),

              // Status indicator
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: bank.isActive ? Colors.green : Colors.grey,
                  shape: BoxShape.circle,
                ),
              ),

              GGap.small(),

              // Delete button
              IconButton(
                onPressed: onDelete,
                icon: const Icon(Icons.delete_outline, color: Colors.red),
                constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                padding: EdgeInsets.zero,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
