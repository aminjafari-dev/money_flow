import 'package:flutter/material.dart';
import 'package:money_flow/core/theme/app_colors.dart';
import 'package:money_flow/core/theme/app_fonts.dart';
import 'package:money_flow/core/widgets/g_gap.dart';
import 'package:money_flow/core/widgets/g_text.dart';
import 'package:money_flow/features/sms_import/domain/entities/sms_entity.dart';
import 'package:money_flow/l10n/generated/app_localizations.dart';

/// Card widget for displaying a single SMS message.
/// This widget shows message information including content, timestamp, and read status.
///
/// Usage Example:
/// ```dart
/// SmsMessageCardWidget(
///   message: message,
/// )
/// ```
class SmsMessageCardWidget extends StatelessWidget {
  /// The SMS entity to display.
  final SmsEntity message;

  /// Creates a new instance of SmsMessageCardWidget.
  ///
  /// Parameters:
  /// - [message]: The SMS entity to display
  const SmsMessageCardWidget({super.key, required this.message});

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
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Message header with timestamp and read status
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Timestamp
                GText(
                  _formatDateTime(message.date, l10n),
                  style: AppFonts.labelSmall,
                  color: AppColors.textSecondary,
                ),

                // Read status indicator
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: message.isRead
                        ? AppColors.success.withOpacity(0.1)
                        : AppColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: GText(
                    message.isRead ? l10n.read : l10n.unread,
                    style: AppFonts.labelSmall,
                    color: message.isRead
                        ? AppColors.success
                        : AppColors.primary,
                  ),
                ),
              ],
            ),

            GGap.small(),

            // Message content
            GText(
              message.body,
              style: AppFonts.bodyMedium,
              color: AppColors.textPrimary,
            ),
          ],
        ),
      ),
    );
  }

  /// Formats a date and time for display in the messages list.
  /// This method formats the date and time in a user-friendly format
  /// showing both date and time information.
  String _formatDateTime(DateTime dateTime, AppLocalizations l10n) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final messageDate = DateTime(dateTime.year, dateTime.month, dateTime.day);

    if (messageDate == today) {
      // Show time for today's messages
      return '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
    } else if (messageDate == today.subtract(const Duration(days: 1))) {
      // Show "Yesterday" for yesterday's messages
      return '${l10n.yesterday} ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
    } else {
      // Show date and time for older messages
      return '${dateTime.day}/${dateTime.month}/${dateTime.year} ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
    }
  }
}
