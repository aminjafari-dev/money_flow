import 'package:flutter/material.dart';
import 'package:money_flow/core/theme/app_colors.dart';
import 'package:money_flow/core/theme/app_fonts.dart';
import 'package:money_flow/core/widgets/g_button.dart';
import 'package:money_flow/core/widgets/g_gap.dart';
import 'package:money_flow/core/widgets/g_text.dart';
import 'package:money_flow/features/sms_import/domain/entities/sms_entity.dart';
import 'package:money_flow/features/sms_import/presentation/bloc/sms_import_state.dart';

/// Widget for displaying SMS messages list.
/// This widget shows a list of SMS messages from a specific sender address
/// in chronological order, allowing users to review the messages.
///
/// The widget follows the design system by using consistent colors, fonts,
/// and spacing throughout the application.
///
/// Usage Example:
/// ```dart
/// SmsMessagesList(
///   messagesState: state.messages,
///   onLoadMessages: () => loadMessages(),
/// )
/// ```
class SmsMessagesList extends StatelessWidget {
  /// The current messages state to display.
  /// This state determines what UI elements to show and their styling.
  final MessagesState messagesState;

  /// Callback function to load SMS messages.
  /// This function is called when the user needs to load messages.
  final VoidCallback onLoadMessages;

  /// Creates a new instance of SmsMessagesList.
  ///
  /// Parameters:
  /// - [messagesState]: The current messages state to display
  /// - [onLoadMessages]: Callback function to load SMS messages
  ///
  /// Usage Example:
  /// ```dart
  /// SmsMessagesList(
  ///   messagesState: MessagesState.completed(messages),
  ///   onLoadMessages: () => loadMessages(),
  /// )
  /// ```
  const SmsMessagesList({
    super.key,
    required this.messagesState,
    required this.onLoadMessages,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Messages header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GText(
              'SMS Messages',
              style: AppFonts.titleLarge,
              color: AppColors.textPrimary,
            ),
            GButton(
              text: 'Refresh',
              onPressed: onLoadMessages,
              variant: GButtonVariant.outlined,
              size: GButtonSize.small,
              icon: Icons.refresh,
            ),
          ],
        ),

        GGap.medium(),

        // Messages content
        messagesState.when(
          // Initial state - show empty state
          initial: () => _buildEmptyState(
            'No messages loaded',
            'Tap refresh to load SMS messages',
            Icons.sms,
            onLoadMessages,
          ),

          // Loading state - show loading indicator
          loading: () => _buildLoadingState(),

          // Completed state - show messages list
          completed: (messages) => messages.isEmpty
              ? _buildEmptyState(
                  'No SMS messages found',
                  'Make sure you have SMS messages from this sender',
                  Icons.sms_failed,
                  onLoadMessages,
                )
              : _buildMessagesList(messages),

          // Error state - show error message
          error: (message) => _buildErrorState(message, onLoadMessages),
        ),
      ],
    );
  }

  /// Builds the messages list when messages are successfully loaded.
  /// This method creates a scrollable list of message cards
  /// with message content and timestamp information.
  Widget _buildMessagesList(List<SmsEntity> messages) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: messages.length,
      separatorBuilder: (context, index) => GGap.small(),
      itemBuilder: (context, index) {
        final message = messages[index];
        return _buildMessageCard(message);
      },
    );
  }

  /// Builds a message card for a single SMS message.
  /// This method creates a card with message information
  /// including content, timestamp, and read status.
  Widget _buildMessageCard(SmsEntity message) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
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
                  _formatDateTime(message.date),
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
                    message.isRead ? 'Read' : 'Unread',
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

  /// Builds the loading state widget.
  /// This method shows a loading indicator while messages are being fetched.
  Widget _buildLoadingState() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: const Padding(
        padding: EdgeInsets.all(32.0),
        child: Center(
          child: Column(
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text('Loading SMS messages...'),
            ],
          ),
        ),
      ),
    );
  }

  /// Builds the empty state widget.
  /// This method shows an empty state message when no messages are found
  /// or when messages haven't been loaded yet.
  Widget _buildEmptyState(
    String title,
    String subtitle,
    IconData icon,
    VoidCallback onAction,
  ) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
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
              text: 'Load Messages',
              onPressed: onAction,
              variant: GButtonVariant.filled,
              icon: Icons.refresh,
            ),
          ],
        ),
      ),
    );
  }

  /// Builds the error state widget.
  /// This method shows an error message when loading messages fails
  /// and provides a retry button.
  Widget _buildErrorState(String message, VoidCallback onRetry) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          children: [
            Icon(Icons.error_outline, size: 64, color: AppColors.danger),

            GGap.medium(),

            GText(
              'Error Loading Messages',
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
              text: 'Retry',
              onPressed: onRetry,
              variant: GButtonVariant.outlined,
              icon: Icons.refresh,
            ),
          ],
        ),
      ),
    );
  }

  /// Formats a date and time for display in the messages list.
  /// This method formats the date and time in a user-friendly format
  /// showing both date and time information.
  String _formatDateTime(DateTime dateTime) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final messageDate = DateTime(dateTime.year, dateTime.month, dateTime.day);

    if (messageDate == today) {
      // Show time for today's messages
      return '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
    } else if (messageDate == today.subtract(const Duration(days: 1))) {
      // Show "Yesterday" for yesterday's messages
      return 'Yesterday ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
    } else {
      // Show date and time for older messages
      return '${dateTime.day}/${dateTime.month}/${dateTime.year} ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
    }
  }
}
