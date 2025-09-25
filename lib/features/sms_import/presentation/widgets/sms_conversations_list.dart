import 'package:flutter/material.dart';
import 'package:money_flow/core/router/page_name.dart';
import 'package:money_flow/core/theme/app_colors.dart';
import 'package:money_flow/core/theme/app_fonts.dart';
import 'package:money_flow/core/widgets/g_button.dart';
import 'package:money_flow/core/widgets/g_gap.dart';
import 'package:money_flow/core/widgets/g_text.dart';
import 'package:money_flow/features/sms_import/domain/entities/sms_entity.dart';
import 'package:money_flow/features/sms_import/presentation/bloc/sms_import_state.dart';

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Conversations header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GText(
              'SMS Conversations',
              style: AppFonts.titleLarge,
              color: AppColors.textPrimary,
            ),
            GButton(
              text: 'Refresh',
              onPressed: widget.onLoadConversations,
              variant: GButtonVariant.outlined,
              size: GButtonSize.small,
              icon: Icons.refresh,
            ),
          ],
        ),

        GGap.medium(),

        // Conversations content
        widget.conversationsState.when(
          // Initial state - show empty state
          initial: () => _buildEmptyState(
            'No conversations loaded',
            'Tap refresh to load SMS conversations',
            Icons.sms,
            widget.onLoadConversations,
          ),

          // Loading state - show loading indicator
          loading: () => _buildLoadingState(),

          // Completed state - show conversations list
          completed: (conversations, hasMore) => conversations.isEmpty
              ? _buildEmptyState(
                  'No SMS conversations found',
                  'Make sure you have SMS messages on your device',
                  Icons.sms_failed,
                  widget.onLoadConversations,
                )
              : _buildConversationsList(context, conversations, hasMore),

          // Loading more state - show conversations list with loading indicator
          loadingMore: (conversations) =>
              _buildConversationsList(context, conversations, true),

          // Error state - show error message
          error: (message) =>
              _buildErrorState(message, widget.onLoadConversations),
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
          return _buildLoadMoreIndicator();
        }

        final conversation = conversations[index];
        return _buildConversationCard(context, conversation);
      },
    );
  }

  /// Builds a conversation card for a single conversation.
  /// This method creates a card with conversation information
  /// including sender address, last message preview, and message count.
  Widget _buildConversationCard(
    BuildContext context,
    SmsConversationEntity conversation,
  ) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
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
                          '${conversation.messageCount} messages',
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
                          _formatDate(conversation.lastMessageDate),
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

  /// Builds the loading state widget.
  /// This method shows a loading indicator while conversations are being fetched.
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
              Text('Loading SMS conversations...'),
            ],
          ),
        ),
      ),
    );
  }

  /// Builds the empty state widget.
  /// This method shows an empty state message when no conversations are found
  /// or when conversations haven't been loaded yet.
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
              text: 'Load Conversations',
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
  /// This method shows an error message when loading conversations fails
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
              'Error Loading Conversations',
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

  /// Builds the load more indicator widget.
  /// This method shows a loading indicator at the bottom of the list
  /// when there are more conversations to load.
  Widget _buildLoadMoreIndicator() {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
              ),
            ),
            GGap.medium(),
            GText(
              'Loading more conversations...',
              style: AppFonts.bodyMedium,
              color: AppColors.textSecondary,
            ),
          ],
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
  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays > 0) {
      return '${difference.inDays} day${difference.inDays == 1 ? '' : 's'} ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hour${difference.inHours == 1 ? '' : 's'} ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minute${difference.inMinutes == 1 ? '' : 's'} ago';
    } else {
      return 'Just now';
    }
  }
}
