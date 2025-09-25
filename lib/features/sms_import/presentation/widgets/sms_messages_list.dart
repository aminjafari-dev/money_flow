import 'package:flutter/material.dart';
import 'package:money_flow/core/widgets/g_gap.dart';
import 'package:money_flow/features/sms_import/domain/entities/sms_entity.dart';
import 'package:money_flow/features/sms_import/presentation/bloc/sms_import_state.dart';
import 'package:money_flow/features/sms_import/presentation/widgets/messages/sms_message_card_widget.dart';
import 'package:money_flow/features/sms_import/presentation/widgets/messages/sms_category_grid_widget.dart';
import 'package:money_flow/features/sms_import/presentation/widgets/shared/sms_empty_state_widget.dart';
import 'package:money_flow/features/sms_import/presentation/widgets/shared/sms_loading_state_widget.dart';
import 'package:money_flow/features/sms_import/presentation/widgets/shared/sms_error_state_widget.dart';
import 'package:money_flow/l10n/generated/app_localizations.dart';

import '../../../../core/theme/app_colors.dart';

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

  /// Callback when a category is successfully added to an SMS message.
  final Function(String category)? onCategoryAdded;

  /// Creates a new instance of SmsMessagesList.
  ///
  /// Parameters:
  /// - [messagesState]: The current messages state to display
  /// - [onLoadMessages]: Callback function to load SMS messages
  /// - [onCategoryAdded]: Callback when a category is successfully added
  ///
  /// Usage Example:
  /// ```dart
  /// SmsMessagesList(
  ///   messagesState: MessagesState.completed(messages),
  ///   onLoadMessages: () => loadMessages(),
  ///   onCategoryAdded: (category) => print('Added to $category'),
  /// )
  /// ```
  const SmsMessagesList({
    super.key,
    required this.messagesState,
    required this.onLoadMessages,
    this.onCategoryAdded,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Messages content
        messagesState.when(
          // Initial state - show empty state
          initial: () => SmsEmptyStateWidget(
            title: l10n.noMessagesLoaded,
            subtitle: l10n.tapRefreshToLoadSmsMessages,
            icon: Icons.sms,
            actionText: l10n.loadMessages,
            onAction: onLoadMessages,
          ),

          // Loading state - show loading indicator
          loading: () =>
              SmsLoadingStateWidget(message: l10n.loadingSmsMessages),

          // Completed state - show messages list
          completed: (messages) => messages.isEmpty
              ? SmsEmptyStateWidget(
                  title: l10n.noSmsMessagesFound,
                  subtitle: l10n.makeSureYouHaveSmsMessagesFromThisSender,
                  icon: Icons.sms_failed,
                  actionText: l10n.loadMessages,
                  onAction: onLoadMessages,
                )
              : _buildMessagesList(messages),

          // Error state - show error message
          error: (message) => SmsErrorStateWidget(
            title: l10n.errorLoadingMessages,
            message: message,
            onRetry: onLoadMessages,
          ),
        ),
      ],
    );
  }

  /// Builds the messages list when messages are successfully loaded.
  /// This method creates a scrollable list of message cards with category grids
  /// displayed side by side for each message.
  Widget _buildMessagesList(List<SmsEntity> messages) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 20,
      separatorBuilder: (context, index) => GGap.medium(),
      itemBuilder: (context, index) {
        final message = messages[index];
        return _buildMessageWithCategoryGrid(message);
      },
    );
  }

  /// Builds a message card with its corresponding category grid side by side.
  /// This method creates a horizontal layout with the message card on the left
  /// and the category grid on the right.
  Widget _buildMessageWithCategoryGrid(SmsEntity message) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.backgroundLight,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border, width: 1),
      ),
      padding: const EdgeInsets.all(16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Message card (flexible to take remaining space)
          Expanded(child: SmsMessageCardWidget(message: message)),

          // Small gap between card and grid
          GGap.small(),

          // Category grid (fixed width)
          Expanded(
            child: SmsCategoryGridWidget(
              message: message,
              onCategoryAdded: onCategoryAdded,
            ),
          ),
        ],
      ),
    );
  }
}
