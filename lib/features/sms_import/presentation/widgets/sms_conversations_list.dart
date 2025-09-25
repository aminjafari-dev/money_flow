import 'package:flutter/material.dart';
import 'package:money_flow/core/widgets/g_gap.dart';
import 'package:money_flow/features/sms_import/domain/entities/sms_entity.dart';
import 'package:money_flow/features/sms_import/presentation/bloc/sms_import_state.dart';
import 'package:money_flow/features/sms_import/presentation/widgets/conversations/sms_conversation_card_widget.dart';
import 'package:money_flow/features/sms_import/presentation/widgets/conversations/sms_load_more_indicator_widget.dart';
import 'package:money_flow/features/sms_import/presentation/widgets/shared/sms_empty_state_widget.dart';
import 'package:money_flow/features/sms_import/presentation/widgets/shared/sms_loading_state_widget.dart';
import 'package:money_flow/features/sms_import/presentation/widgets/shared/sms_error_state_widget.dart';
import 'package:money_flow/l10n/generated/app_localizations.dart';

/// Widget for displaying SMS conversations list.
/// This widget shows a list of SMS conversations grouped by sender address
/// with preview information and allows users to select conversations
/// to view their messages. It also supports pagination with automatic
/// loading when scrolling to the bottom.
///
/// The widget follows the design system by using consistent colors, fonts,
/// and spacing throughout the application.
///
/// Usage Example:
/// ```dart
/// SmsConversationsList(
///   conversationsState: state.conversations,
///   onLoadConversations: () => loadConversations(),
///   onLoadMoreConversations: () => loadMoreConversations(),
///   onLoadMessages: (address) => loadMessages(address),
/// )
/// ```
class SmsConversationsList extends StatefulWidget {
  /// The current conversations state to display.
  /// This state determines what UI elements to show and their styling.
  final ConversationsState conversationsState;

  /// Callback function to load SMS conversations.
  /// This function is called when the user needs to load conversations.
  final VoidCallback onLoadConversations;

  /// Callback function to load more SMS conversations for pagination.
  /// This function is called when the user scrolls to the bottom of the list.
  final VoidCallback onLoadMoreConversations;

  /// Callback function to load messages from a specific address.
  /// This function is called when the user selects a conversation.
  final Function(String) onLoadMessages;

  /// Creates a new instance of SmsConversationsList.
  ///
  /// Parameters:
  /// - [conversationsState]: The current conversations state to display
  /// - [onLoadConversations]: Callback function to load SMS conversations
  /// - [onLoadMoreConversations]: Callback function to load more conversations for pagination
  /// - [onLoadMessages]: Callback function to load messages from a specific address
  ///
  /// Usage Example:
  /// ```dart
  /// SmsConversationsList(
  ///   conversationsState: ConversationsState.completed(conversations, hasMore),
  ///   onLoadConversations: () => loadConversations(),
  ///   onLoadMoreConversations: () => loadMoreConversations(),
  ///   onLoadMessages: (address) => loadMessages(address),
  /// )
  /// ```
  const SmsConversationsList({
    super.key,
    required this.conversationsState,
    required this.onLoadConversations,
    required this.onLoadMoreConversations,
    required this.onLoadMessages,
  });

  @override
  State<SmsConversationsList> createState() => _SmsConversationsListState();
}

class _SmsConversationsListState extends State<SmsConversationsList> {
  late ScrollController _scrollController;
  bool _isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  /// Handles scroll events to detect when user reaches the bottom.
  /// This method triggers loading more conversations when the user
  /// scrolls near the bottom of the list.
  void _onScroll() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 200 &&
        !_isLoadingMore) {
      _isLoadingMore = true;
      widget.onLoadMoreConversations();

      // Reset loading flag after a short delay
      Future.delayed(const Duration(seconds: 1), () {
        if (mounted) {
          setState(() {
            _isLoadingMore = false;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Conversations content
        widget.conversationsState.when(
          // Initial state - show empty state
          initial: () => SmsEmptyStateWidget(
            title: l10n.noConversationsLoaded,
            subtitle: l10n.tapRefreshToLoadSmsConversations,
            icon: Icons.sms,
            actionText: l10n.loadConversations,
            onAction: widget.onLoadConversations,
          ),

          // Loading state - show loading indicator
          loading: () =>
              SmsLoadingStateWidget(message: l10n.loadingSmsConversations),

          // Completed state - show conversations list
          completed: (conversations, hasMore) => conversations.isEmpty
              ? SmsEmptyStateWidget(
                  title: l10n.noSmsConversationsFound,
                  subtitle: l10n.makeSureYouHaveSmsMessagesOnYourDevice,
                  icon: Icons.sms_failed,
                  actionText: l10n.loadConversations,
                  onAction: widget.onLoadConversations,
                )
              : _buildConversationsList(context, conversations, hasMore),

          // Loading more state - show conversations list with loading indicator
          loadingMore: (conversations) =>
              _buildConversationsList(context, conversations, true),

          // Error state - show error message
          error: (message) => SmsErrorStateWidget(
            title: l10n.errorLoadingConversations,
            message: message,
            onRetry: widget.onLoadConversations,
          ),
        ),
      ],
    );
  }

  /// Builds the conversations list when conversations are successfully loaded.
  /// This method creates a scrollable list of conversation cards
  /// with preview information, tap functionality, and pagination support.
  Widget _buildConversationsList(
    BuildContext context,
    List<SmsConversationEntity> conversations,
    bool hasMore,
  ) {
    return ListView.separated(
      controller: _scrollController,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount:
          conversations.length +
          (hasMore ? 1 : 0), // Add 1 for loading indicator
      separatorBuilder: (context, index) => GGap.small(),
      itemBuilder: (context, index) {
        // Show loading indicator at the bottom if there are more conversations
        if (index == conversations.length && hasMore) {
          return const SmsLoadMoreIndicatorWidget();
        }

        final conversation = conversations[index];
        return SmsConversationCardWidget(conversation: conversation);
      },
    );
  }
}
