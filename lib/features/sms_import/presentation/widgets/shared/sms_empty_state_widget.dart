import 'package:flutter/material.dart';
import 'package:money_flow/core/theme/app_colors.dart';
import 'package:money_flow/core/theme/app_fonts.dart';
import 'package:money_flow/core/widgets/g_button.dart';
import 'package:money_flow/core/widgets/g_gap.dart';
import 'package:money_flow/core/widgets/g_text.dart';

/// Shared empty state widget for SMS import feature.
/// This widget provides a consistent empty state UI across all SMS widgets
/// with customizable title, subtitle, icon, and action button.
///
/// Usage Example:
/// ```dart
/// SmsEmptyStateWidget(
///   title: 'No conversations found',
///   subtitle: 'Make sure you have SMS messages on your device',
///   icon: Icons.sms_failed,
///   actionText: 'Load Conversations',
///   onAction: () => loadConversations(),
/// )
/// ```
class SmsEmptyStateWidget extends StatelessWidget {
  /// The title text to display in the empty state.
  final String title;

  /// The subtitle text to display in the empty state.
  final String subtitle;

  /// The icon to display in the empty state.
  final IconData icon;

  /// The text for the action button.
  final String actionText;

  /// Callback function when the action button is pressed.
  final VoidCallback onAction;

  /// Creates a new instance of SmsEmptyStateWidget.
  ///
  /// Parameters:
  /// - [title]: The title text to display
  /// - [subtitle]: The subtitle text to display
  /// - [icon]: The icon to display
  /// - [actionText]: The text for the action button
  /// - [onAction]: Callback function when the action button is pressed
  const SmsEmptyStateWidget({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.actionText,
    required this.onAction,
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
          children: [
            Icon(icon, size: 64, color: AppColors.textSecondary),

            GGap.medium(),

            GText(
              title,
              style: AppFonts.titleMedium,
              color: AppColors.textPrimary,
              textAlign: TextAlign.center,
            ),

            GGap.small(),

            GText(
              subtitle,
              style: AppFonts.bodySmall,
              color: AppColors.textSecondary,
              textAlign: TextAlign.center,
            ),

            GGap.medium(),

            GButton(
              text: actionText,
              onPressed: onAction,
              variant: GButtonVariant.filled,
              icon: Icons.refresh,
            ),
          ],
        ),
      ),
    );
  }
}
