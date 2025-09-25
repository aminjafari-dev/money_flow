import 'package:flutter/material.dart';
import 'package:money_flow/core/theme/app_colors.dart';
import 'package:money_flow/core/theme/app_fonts.dart';
import 'package:money_flow/core/widgets/g_button.dart';
import 'package:money_flow/core/widgets/g_gap.dart';
import 'package:money_flow/core/widgets/g_text.dart';

/// Widget displayed when SMS permission is denied.
/// This widget provides a user-friendly interface to guide users
/// to enable SMS permission in their device settings.
///
/// Usage Example:
/// ```dart
/// SmsPermissionDeniedWidget(
///   onRetry: () => retryPermissionRequest(),
///   onOpenSettings: () => openAppSettings(),
/// )
/// ```
class SmsPermissionDeniedWidget extends StatelessWidget {
  /// Callback function when the retry button is pressed.
  final VoidCallback onRetry;

  /// Callback function when the open settings button is pressed.
  final VoidCallback onOpenSettings;

  /// Creates a new instance of SmsPermissionDeniedWidget.
  ///
  /// Parameters:
  /// - [onRetry]: Callback function when the retry button is pressed
  /// - [onOpenSettings]: Callback function when the open settings button is pressed
  const SmsPermissionDeniedWidget({
    super.key,
    required this.onRetry,
    required this.onOpenSettings,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.backgroundLight,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border, width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Permission denied icon
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: AppColors.error.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.sms_failed,
                size: 40,
                color: AppColors.error,
              ),
            ),

            GGap.large(),

            // Title
            GText(
              'SMS Permission Required',
              style: AppFonts.headingMedium,
              color: AppColors.textPrimary,
              textAlign: TextAlign.center,
            ),

            GGap.medium(),

            // Description
            GText(
              'To import SMS messages, we need permission to read your SMS. Please enable SMS permission in your device settings.',
              style: AppFonts.bodyMedium,
              color: AppColors.textSecondary,
              textAlign: TextAlign.center,
            ),

            GGap.large(),

            // Action buttons
            Column(
              children: [
                // Open Settings button
                GButton(
                  text: 'Open Settings',
                  onPressed: onOpenSettings,
                  variant: GButtonVariant.filled,
                  isFullWidth: true,
                ),

                GGap.medium(),

                // Retry button
                GButton(
                  text: 'Try Again',
                  onPressed: onRetry,
                  variant: GButtonVariant.outlined,
                  isFullWidth: true,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
