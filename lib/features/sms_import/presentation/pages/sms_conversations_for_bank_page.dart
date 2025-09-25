import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_flow/core/di/locator.dart';
import 'package:money_flow/core/theme/app_colors.dart';
import 'package:money_flow/core/theme/app_fonts.dart';
import 'package:money_flow/core/widgets/g_scaffold.dart';
import 'package:money_flow/core/widgets/g_gap.dart';
import 'package:money_flow/core/widgets/g_text.dart';
import 'package:money_flow/features/sms_import/domain/entities/bank_entity.dart';
import 'package:money_flow/features/sms_import/domain/entities/sms_entity.dart';
import 'package:money_flow/features/sms_import/presentation/bloc/sms_import_bloc.dart';
import 'package:money_flow/features/sms_import/presentation/bloc/sms_import_event.dart';
import 'package:money_flow/features/sms_import/presentation/bloc/sms_import_state.dart';
import 'package:money_flow/features/sms_import/presentation/widgets/shared/sms_loading_state_widget.dart';
import 'package:money_flow/features/sms_import/presentation/widgets/shared/sms_error_state_widget.dart';
import 'package:money_flow/features/sms_import/presentation/widgets/shared/sms_empty_state_widget.dart';
import 'package:money_flow/features/sms_import/presentation/widgets/conversations/sms_load_more_indicator_widget.dart';
import 'package:money_flow/l10n/generated/app_localizations.dart';

/// SMS Conversations for Bank Selection page.
/// This page allows users to select an existing SMS conversation
/// to use as their bank account for SMS tracking.
///
/// Usage Example:
/// ```dart
/// Navigator.pushNamed(context, '/sms-conversations-for-bank');
/// ```
class SmsConversationsForBankPage extends StatelessWidget {
  /// Creates a new instance of SmsConversationsForBankPage.
  const SmsConversationsForBankPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      // Create the SMS import BLoC with all required use cases
      create: (context) => SmsImportBloc(
        getSmsConversationsUseCase: getIt(),
        getSmsMessagesByAddressUseCase: getIt(),
        checkSmsPermissionUseCase: getIt(),
        requestSmsPermissionUseCase: getIt(),
      )..add(const SmsImportEvent.initialize()),
      child: const SmsConversationsForBankView(),
    );
  }
}

/// The main view widget for SMS conversations for bank selection.
class SmsConversationsForBankView extends StatefulWidget {
  /// Creates a new instance of SmsConversationsForBankView.
  const SmsConversationsForBankView({super.key});

  @override
  State<SmsConversationsForBankView> createState() =>
      _SmsConversationsForBankViewState();
}

class _SmsConversationsForBankViewState
    extends State<SmsConversationsForBankView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent * 0.8) {
      context.read<SmsImportBloc>().add(
        const SmsImportEvent.loadMoreConversations(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return GScaffold(
      title: 'Select Bank SMS Conversation',
      body: BlocListener<SmsImportBloc, SmsImportState>(
        listener: (context, state) {
          // Listen for permission state changes and show error messages
          state.permission.when(
            initial: () {},
            loading: () {},
            completed: (hasPermission) {
              // Permission granted - conversations will be loaded automatically
            },
            error: (message) {
              // Show error message if permission check fails
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(l10n.permissionError(message)),
                  backgroundColor: Colors.red,
                ),
              );
            },
            denied: () {
              // Permission denied - handled by the UI
            },
          );
        },
        child: BlocBuilder<SmsImportBloc, SmsImportState>(
          builder: (context, state) {
            return state.conversations.when(
              initial: () =>
                  SmsLoadingStateWidget(message: l10n.initializingSmsImport),
              loading: () =>
                  SmsLoadingStateWidget(message: l10n.loadingSmsConversations),
              loadingMore: (conversations) =>
                  _buildConversationsList(conversations, isLoadingMore: true),
              completed: (conversations, hasMore) =>
                  _buildConversationsList(conversations, hasMore: hasMore),
              error: (message) => SmsErrorStateWidget(
                title: 'Error Loading Conversations',
                message: message,
                onRetry: () => context.read<SmsImportBloc>().add(
                  const SmsImportEvent.loadConversations(),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  /// Builds the conversations list widget.
  Widget _buildConversationsList(
    List<SmsConversationEntity> conversations, {
    bool hasMore = false,
    bool isLoadingMore = false,
  }) {
    if (conversations.isEmpty) {
      return SmsEmptyStateWidget(
        title: 'No SMS Conversations Found',
        subtitle: 'Make sure you have SMS messages on your device',
        icon: Icons.sms_failed,
        actionText: 'Refresh',
        onAction: () => context.read<SmsImportBloc>().add(
          const SmsImportEvent.loadConversations(),
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () async {
        context.read<SmsImportBloc>().add(const SmsImportEvent.refresh());
      },
      child: ListView.builder(
        controller: _scrollController,
        padding: const EdgeInsets.all(16.0),
        itemCount: conversations.length + (hasMore ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == conversations.length) {
            // Load more indicator
            return const SmsLoadMoreIndicatorWidget();
          }

          final conversation = conversations[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: _BankSelectionConversationCard(
              conversation: conversation,
              onTap: () => _selectConversationAsBank(conversation),
            ),
          );
        },
      ),
    );
  }

  /// Handles conversation selection as bank.
  void _selectConversationAsBank(SmsConversationEntity conversation) {
    // Create a bank entity from the conversation
    final bank = BankEntity(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: _extractBankName(conversation.address),
      phoneNumber: conversation.address,
    );

    // Return the bank to the previous page
    Navigator.of(context).pop(bank);
  }

  /// Extracts a friendly bank name from the phone number.
  String _extractBankName(String phoneNumber) {
    // Remove common prefixes and format the number
    String cleanNumber = phoneNumber
        .replaceAll(RegExp(r'[^\d]'), '') // Remove non-digits
        .replaceFirst(RegExp(r'^1'), '') // Remove leading 1 for US numbers
        .replaceFirst(RegExp(r'^0'), ''); // Remove leading 0

    // Format as (XXX) XXX-XXXX
    if (cleanNumber.length == 10) {
      return '(${cleanNumber.substring(0, 3)}) ${cleanNumber.substring(3, 6)}-${cleanNumber.substring(6)}';
    }

    // Return original if we can't format it nicely
    return phoneNumber;
  }
}

/// Custom conversation card widget for bank selection.
/// This widget shows conversation information with a selection style
/// instead of navigation to messages.
class _BankSelectionConversationCard extends StatelessWidget {
  /// The conversation entity to display.
  final SmsConversationEntity conversation;

  /// Callback when the card is tapped.
  final VoidCallback onTap;

  /// Creates a new instance of _BankSelectionConversationCard.
  const _BankSelectionConversationCard({
    required this.conversation,
    required this.onTap,
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
      child: InkWell(
        onTap: onTap,
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
                child: Icon(
                  Icons.account_balance,
                  color: AppColors.primary,
                  size: 24,
                ),
              ),

              GGap.medium(),

              // Conversation info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GText(
                      _formatPhoneNumber(conversation.address),
                      style: AppFonts.titleSmall,
                      color: AppColors.textPrimary,
                    ),
                    GGap.small(),
                    GText(
                      conversation.lastMessage,
                      style: AppFonts.bodySmall,
                      color: AppColors.textSecondary,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    GGap.small(),
                    Row(
                      children: [
                        GText(
                          '${conversation.messageCount} ${l10n.messages}',
                          style: AppFonts.bodySmall,
                          color: AppColors.textSecondary,
                        ),
                        GGap.small(),
                        GText(
                          '•',
                          style: AppFonts.bodySmall,
                          color: AppColors.textSecondary,
                        ),
                        GGap.small(),
                        GText(
                          _formatDate(conversation.lastMessageDate),
                          style: AppFonts.bodySmall,
                          color: AppColors.textSecondary,
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Selection indicator
              Icon(
                Icons.check_circle_outline,
                color: AppColors.primary,
                size: 24,
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Formats a phone number for display.
  String _formatPhoneNumber(String phoneNumber) {
    // Remove common prefixes and format the number
    String cleanNumber = phoneNumber
        .replaceAll(RegExp(r'[^\d]'), '') // Remove non-digits
        .replaceFirst(RegExp(r'^1'), '') // Remove leading 1 for US numbers
        .replaceFirst(RegExp(r'^0'), ''); // Remove leading 0

    // Format as (XXX) XXX-XXXX
    if (cleanNumber.length == 10) {
      return '(${cleanNumber.substring(0, 3)}) ${cleanNumber.substring(3, 6)}-${cleanNumber.substring(6)}';
    }

    // Return original if we can't format it nicely
    return phoneNumber;
  }

  /// Formats a date for display.
  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      if (difference.inHours == 0) {
        if (difference.inMinutes == 0) {
          return 'Just now';
        }
        return '${difference.inMinutes}m ago';
      }
      return '${difference.inHours}h ago';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d ago';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }
}
