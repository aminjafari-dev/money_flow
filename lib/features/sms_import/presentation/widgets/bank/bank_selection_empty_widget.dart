import 'package:flutter/material.dart';
import 'package:money_flow/core/widgets/g_text.dart';
import 'package:money_flow/core/widgets/g_button.dart';
import 'package:money_flow/core/widgets/g_gap.dart';
import 'package:money_flow/core/theme/app_colors.dart';

/// Empty state widget for bank selection when no banks are selected.
/// This widget displays a friendly message and an add button to guide
/// users to add their first bank for SMS tracking.
///
/// Usage Example:
/// ```dart
/// BankSelectionEmptyWidget(
///   onAddBank: () => showAddBankDialog(),
/// )
/// ```
class BankSelectionEmptyWidget extends StatelessWidget {
  /// Callback when the add bank button is pressed
  final VoidCallback onAddBank;

  /// Creates a new instance of BankSelectionEmptyWidget.
  ///
  /// Parameters:
  /// - [onAddBank]: Callback when the add bank button is pressed
  const BankSelectionEmptyWidget({super.key, required this.onAddBank});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Illustration icon
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.account_balance_outlined,
                size: 60,
                color: AppColors.primary,
              ),
            ),

            GGap.large(),

            // Title
            GText(
              'No Banks Selected',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
              textAlign: TextAlign.center,
            ),

            GGap.medium(),

            // Description
            GText(
              'Add banks to track SMS messages for automatic transaction import. '
              'You can add multiple banks to monitor.',
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(color: AppColors.textSecondary),
              textAlign: TextAlign.center,
            ),

            GGap.extraExtraLarge(),

            // Add bank button
            GButton(
              text: 'Add Your First Bank',
              icon: Icons.add,
              onPressed: onAddBank,
              isFullWidth: true,
              size: GButtonSize.large,
            ),

            GGap.medium(),

            // Help text
            GText(
              'You can add banks by entering their SMS sender phone numbers',
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: AppColors.textSecondary),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
