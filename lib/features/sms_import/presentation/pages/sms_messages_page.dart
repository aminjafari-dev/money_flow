import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_flow/core/di/locator.dart';
import 'package:money_flow/core/widgets/g_scaffold.dart';
import 'package:money_flow/features/sms_import/presentation/bloc/sms_import_bloc.dart';
import 'package:money_flow/features/sms_import/presentation/bloc/sms_import_event.dart';
import 'package:money_flow/features/sms_import/presentation/bloc/sms_import_state.dart';
import 'package:money_flow/features/sms_import/presentation/widgets/sms_messages_list.dart';

/// SMS Messages page for displaying messages from a specific sender address.
/// This page shows all SMS messages from a particular phone number
/// in chronological order, allowing users to review the messages.
///
/// The page follows Clean Architecture principles by using BLoC for state management
/// and separating UI concerns from business logic.
///
/// Usage Example:
/// ```dart
/// Navigator.push(
///   context,
///   MaterialPageRoute(
///     builder: (context) => SmsMessagesPage(address: '+1234567890'),
///   ),
/// );
/// ```
class SmsMessagesPage extends StatelessWidget {
  /// The sender address to display messages for.
  /// This should be a valid phone number or SMS sender identifier.
  final String address;

  /// Creates a new instance of SmsMessagesPage.
  ///
  /// Parameters:
  /// - [address]: The sender address to display messages for
  ///
  /// Usage Example:
  /// ```dart
  /// SmsMessagesPage(address: '+1234567890')
  /// ```
  const SmsMessagesPage({super.key, required this.address});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      // Create the SMS import BLoC with all required use cases
      create: (context) => SmsImportBloc(
        getSmsConversationsUseCase: getIt(),
        getSmsMessagesByAddressUseCase: getIt(),
        checkSmsPermissionUseCase: getIt(),
        requestSmsPermissionUseCase: getIt(),
      )..add(SmsImportEvent.loadMessagesByAddress(address: address)),
      child: SmsMessagesView(address: address),
    );
  }
}

/// The main view widget for SMS messages functionality.
/// This widget handles the UI logic and state management for the SMS messages page,
/// including loading messages from the specified address.
///
/// The view is separated from the page to allow for better testing and
/// separation of concerns between navigation and UI logic.
///
/// Usage Example:
/// ```dart
/// SmsMessagesView(address: '+1234567890')
/// ```
class SmsMessagesView extends StatefulWidget {
  /// The sender address to display messages for.
  final String address;

  /// Creates a new instance of SmsMessagesView.
  ///
  /// Parameters:
  /// - [address]: The sender address to display messages for
  ///
  /// Usage Example:
  /// ```dart
  /// SmsMessagesView(address: '+1234567890')
  /// ```
  const SmsMessagesView({super.key, required this.address});

  @override
  State<SmsMessagesView> createState() => _SmsMessagesViewState();
}

class _SmsMessagesViewState extends State<SmsMessagesView> {
  @override
  void initState() {
    super.initState();
    // Load messages when the view initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SmsImportBloc>().add(
        SmsImportEvent.loadMessagesByAddress(address: widget.address),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return GScaffold(
      title: widget.address,
      body: BlocBuilder<SmsImportBloc, SmsImportState>(
        builder: (context, state) {
          return RefreshIndicator(
            // Handle pull-to-refresh functionality
            onRefresh: () async {
              context.read<SmsImportBloc>().add(
                SmsImportEvent.loadMessagesByAddress(address: widget.address),
              );
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // SMS messages list
                  SmsMessagesList(
                    messagesState: state.messages,
                    onLoadMessages: () {
                      context.read<SmsImportBloc>().add(
                        SmsImportEvent.loadMessagesByAddress(
                          address: widget.address,
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
    );
  }
}
