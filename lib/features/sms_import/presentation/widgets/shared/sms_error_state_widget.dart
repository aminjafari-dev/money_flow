import 'package:flutter/material.dart';
import 'package:money_flow/core/theme/app_colors.dart';
import 'package:money_flow/core/theme/app_fonts.dart';
import 'package:money_flow/core/widgets/g_button.dart';
import 'package:money_flow/core/widgets/g_gap.dart';
import 'package:money_flow/core/widgets/g_text.dart';
import 'package:money_flow/l10n/generated/app_localizations.dart';

/// Shared error state widget for SMS import feature.
/// This widget provides a consistent error state UI across all SMS widgets
/// with customizable error message and retry functionality.
///
/// Usage Example:
/// ```dart
/// SmsErrorStateWidget(
///   title: 'Error Loading Conversations',
///   message: 'Failed to load conversations',
///   onRetry: () => retryLoading(),
/// )
/// ```
class SmsErrorStateWidget extends StatelessWidget {
  /// The error title to display.
  final String title;

  /// The error message to display.
  final String message;

  /// Callback function when the retry button is pressed.
  final VoidCallback onRetry;

  /// Creates a new instance of SmsErrorStateWidget.
  ///
  /// Parameters:
  /// - [title]: The error title to display
  /// - [message]: The error message to display
  /// - [onRetry]: Callback function when the retry button is pressed
  const SmsErrorStateWidget({
    super.key,
    required this.title,
    required this.message,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Container(
      decoration: BoxDecoration(
        color: AppColors.backgroundLight,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border, width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          children: [
            Icon(Icons.error_outline, size: 64, color: AppColors.danger),

            GGap.medium(),

            GText(
              title,
              style: AppFonts.titleMedium,
              color: AppColors.textPrimary,
              textAlign: TextAlign.center,
            ),

            GGap.small(),

            GText(
              message,
              style: AppFonts.bodySmall,
              color: AppColors.textSecondary,
              textAlign: TextAlign.center,
            ),

            GGap.medium(),

            GButton(
              text: l10n.retry,
              onPressed: onRetry,
              variant: GButtonVariant.outlined,
              icon: Icons.refresh,
            ),
          ],
        ),
      ),
    );
  }
}
