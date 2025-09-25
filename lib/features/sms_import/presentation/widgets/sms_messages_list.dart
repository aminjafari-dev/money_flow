import 'package:flutter/material.dart';
import 'package:money_flow/core/widgets/g_gap.dart';
import 'package:money_flow/features/sms_import/domain/entities/sms_entity.dart';
import 'package:money_flow/features/sms_import/presentation/bloc/sms_import_state.dart';
import 'package:money_flow/features/sms_import/presentation/widgets/messages/sms_messages_header_widget.dart';
import 'package:money_flow/features/sms_import/presentation/widgets/messages/sms_message_card_widget.dart';
import 'package:money_flow/features/sms_import/presentation/widgets/shared/sms_empty_state_widget.dart';
import 'package:money_flow/features/sms_import/presentation/widgets/shared/sms_loading_state_widget.dart';
import 'package:money_flow/features/sms_import/presentation/widgets/shared/sms_error_state_widget.dart';

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
        SmsMessagesHeaderWidget(onRefresh: onLoadMessages),

        GGap.medium(),

        // Messages content
        messagesState.when(
          // Initial state - show empty state
          initial: () => SmsEmptyStateWidget(
            title: 'No messages loaded',
            subtitle: 'Tap refresh to load SMS messages',
            icon: Icons.sms,
            actionText: 'Load Messages',
            onAction: onLoadMessages,
          ),

          // Loading state - show loading indicator
          loading: () =>
              const SmsLoadingStateWidget(message: 'Loading SMS messages...'),

          // Completed state - show messages list
          completed: (messages) => messages.isEmpty
              ? SmsEmptyStateWidget(
                  title: 'No SMS messages found',
                  subtitle: 'Make sure you have SMS messages from this sender',
                  icon: Icons.sms_failed,
                  actionText: 'Load Messages',
                  onAction: onLoadMessages,
                )
              : _buildMessagesList(messages),

          // Error state - show error message
          error: (message) => SmsErrorStateWidget(
            title: 'Error Loading Messages',
            message: message,
            onRetry: onLoadMessages,
          ),
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
        return SmsMessageCardWidget(message: message);
      },
    );
  }
}
