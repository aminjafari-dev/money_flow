import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_flow/core/di/locator.dart';
import 'package:money_flow/core/widgets/g_scaffold.dart';
import 'package:money_flow/features/sms_import/presentation/bloc/sms_import_bloc.dart';
import 'package:money_flow/features/sms_import/presentation/bloc/sms_import_event.dart';
import 'package:money_flow/features/sms_import/presentation/bloc/sms_import_state.dart';
import 'package:money_flow/features/sms_import/presentation/widgets/sms_conversations_list.dart';
import 'package:money_flow/features/sms_import/presentation/widgets/sms_permission_widget.dart';

/// SMS Import page for managing SMS conversations and messages.
/// This page provides the main interface for the SMS import feature,
/// allowing users to view SMS conversations and select bank numbers
/// to view their messages.
///
/// The page follows Clean Architecture principles by using BLoC for state management
/// and separating UI concerns from business logic.
///
/// Usage Example:
/// ```dart
/// Navigator.push(
///   context,
///   MaterialPageRoute(
///     builder: (context) => const SmsImportPage(),
///   ),
/// );
/// ```
class SmsImportPage extends StatelessWidget {
  /// Creates a new instance of SmsImportPage.
  ///
  /// Usage Example:
  /// ```dart
  /// const SmsImportPage()
  /// ```
  const SmsImportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      // Create the SMS import BLoC with all required use cases
      create: (context) => SmsImportBloc(
        getSmsConversationsUseCase: getIt(),
        getSmsMessagesByAddressUseCase: getIt(),
        checkSmsPermissionUseCase: getIt(),
        requestSmsPermissionUseCase: getIt(),
      )..add(const SmsImportEvent.checkPermission()),
      child: const SmsImportView(),
    );
  }
}

/// The main view widget for SMS import functionality.
/// This widget handles the UI logic and state management for the SMS import page,
/// including permission checking and conversation loading.
///
/// The view is separated from the page to allow for better testing and
/// separation of concerns between navigation and UI logic.
///
/// Usage Example:
/// ```dart
/// const SmsImportView()
/// ```
class SmsImportView extends StatefulWidget {
  /// Creates a new instance of SmsImportView.
  const SmsImportView({super.key});

  @override
  State<SmsImportView> createState() => _SmsImportViewState();
}

class _SmsImportViewState extends State<SmsImportView> {
  @override
  void initState() {
    super.initState();
    // Check permission and load conversations when the view initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkPermissionAndLoadData();
    });
  }

  /// Checks SMS permission and loads data accordingly.
  /// This method first checks if SMS permission is granted,
  /// and if not, it will be handled by the permission widget.
  /// If permission is granted, it loads the SMS conversations.
  ///
  /// Usage Example:
  /// ```dart
  /// await _checkPermissionAndLoadData();
  /// ```
  Future<void> _checkPermissionAndLoadData() async {
    // First check permission status
    context.read<SmsImportBloc>().add(const SmsImportEvent.checkPermission());
  }

  @override
  Widget build(BuildContext context) {
    return GScaffold(
      title: 'SMS Import',
      body: BlocListener<SmsImportBloc, SmsImportState>(
        listener: (context, state) {
          // Listen for permission state changes and automatically load conversations
          // when permission is granted
          state.permission.when(
            initial: () {},
            loading: () {},
            completed: (hasPermission) {
              if (hasPermission) {
                // Permission granted, load conversations automatically
                // context.read<SmsImportBloc>().add(
                //   const SmsImportEvent.loadConversations(),
                // );
              }
            },
            error: (message) {
              // Show error message if permission check fails
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Permission error: $message'),
                  backgroundColor: Colors.red,
                ),
              );
            },
          );
        },
        child: BlocBuilder<SmsImportBloc, SmsImportState>(
          builder: (context, state) {
            return RefreshIndicator(
              // Handle pull-to-refresh functionality
              onRefresh: () async {
                context.read<SmsImportBloc>().add(
                  const SmsImportEvent.refresh(),
                );
              },
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Permission status widget
                    SmsPermissionWidget(
                      permissionState: state.permission,
                      onRequestPermission: () {
                        context.read<SmsImportBloc>().add(
                          const SmsImportEvent.requestPermission(),
                        );
                      },
                    ),

                    const SizedBox(height: 24),

                    // SMS conversations list
                    SmsConversationsList(
                      conversationsState: state.conversations,
                      onLoadConversations: () {
                        context.read<SmsImportBloc>().add(
                          const SmsImportEvent.loadConversations(),
                        );
                      },
                      onLoadMoreConversations: () {
                        context.read<SmsImportBloc>().add(
                          const SmsImportEvent.loadMoreConversations(),
                        );
                      },
                      onLoadMessages: (address) {
                        context.read<SmsImportBloc>().add(
                          SmsImportEvent.loadMessagesByAddress(
                            address: address,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
