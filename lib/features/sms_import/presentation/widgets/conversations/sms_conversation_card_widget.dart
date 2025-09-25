import 'package:flutter/material.dart';
import 'package:money_flow/core/router/page_name.dart';
import 'package:money_flow/core/theme/app_colors.dart';
import 'package:money_flow/core/theme/app_fonts.dart';
import 'package:money_flow/core/widgets/g_gap.dart';
import 'package:money_flow/core/widgets/g_text.dart';
import 'package:money_flow/features/sms_import/domain/entities/sms_entity.dart';
import 'package:money_flow/l10n/generated/app_localizations.dart';

/// Card widget for displaying a single SMS conversation.
/// This widget shows conversation information including sender address,
/// last message preview, message count, and date.
///
/// Usage Example:
/// ```dart
/// SmsConversationCardWidget(
///   conversation: conversation,
/// )
/// ```
class SmsConversationCardWidget extends StatelessWidget {
  /// The conversation entity to display.
  final SmsConversationEntity conversation;

  /// Creates a new instance of SmsConversationCardWidget.
  ///
  /// Parameters:
  /// - [conversation]: The conversation entity to display
  const SmsConversationCardWidget({super.key, required this.conversation});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Container(
      decoration: BoxDecoration(
        color: AppColors.backgroundLight,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border, width: 1),
      ),
      child: InkWell(
        onTap: () => _navigateToMessages(context, conversation.address),
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              // Conversation icon
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(Icons.sms, color: AppColors.primary, size: 24),
              ),

              GGap.medium(),

              // Conversation details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Sender address
                    GText(
                      conversation.address,
                      style: AppFonts.titleMedium,
                      color: AppColors.textPrimary,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),

                    GGap.extraSmall(),

                    // Last message preview
                    GText(
                      conversation.lastMessage,
                      style: AppFonts.bodySmall,
                      color: AppColors.textSecondary,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),

                    GGap.extraSmall(),

                    // Message count and date
                    Row(
                      children: [
                        GText(
                          '${conversation.messageCount} ${l10n.messages}',
                          style: AppFonts.labelSmall,
                          color: AppColors.textSecondary,
                        ),

                        GGap.small(),

                        GText(
                          '•',
                          style: AppFonts.labelSmall,
                          color: AppColors.textSecondary,
                        ),

                        GGap.small(),

                        GText(
                          _formatDate(conversation.lastMessageDate, l10n),
                          style: AppFonts.labelSmall,
                          color: AppColors.textSecondary,
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Arrow icon
              Icon(
                Icons.arrow_forward_ios,
                color: AppColors.textSecondary,
                size: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Navigates to the SMS messages page for the specified address.
  /// This method navigates to the messages page showing all SMS messages
  /// from the selected sender address.
  ///
  /// Parameters:
  /// - [context]: The build context for navigation
  /// - [address]: The sender address to display messages for
  void _navigateToMessages(BuildContext context, String address) {
    // Navigate to the SMS messages page with the address as argument
    Navigator.pushNamed(context, PageName.smsMessages, arguments: address);
  }

  /// Formats a date for display in the conversation list.
  /// This method formats the date in a user-friendly format
  /// showing relative time (e.g., "2 hours ago", "1 day ago").
  String _formatDate(DateTime date, AppLocalizations l10n) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays > 0) {
      final dayText = difference.inDays == 1 ? l10n.day : l10n.days;
      return '${difference.inDays} $dayText ${l10n.ago}';
    } else if (difference.inHours > 0) {
      final hourText = difference.inHours == 1 ? l10n.hour : l10n.hours;
      return '${difference.inHours} $hourText ${l10n.ago}';
    } else if (difference.inMinutes > 0) {
      final minuteText = difference.inMinutes == 1 ? l10n.minute : l10n.minutes;
      return '${difference.inMinutes} $minuteText ${l10n.ago}';
    } else {
      return l10n.justNow;
    }
  }
}
