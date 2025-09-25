import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:money_flow/features/sms_import/domain/entities/sms_entity.dart';

part 'sms_import_state.freezed.dart';

/// State for SMS conversations loading operation.
/// This state represents the different states of loading SMS conversations
/// including initial, loading, completed, and error states.
///
/// Usage Example:
/// ```dart
/// state.conversations.when(
///   initial: () => const SizedBox(),
///   loading: () => const CircularProgressIndicator(),
///   completed: (conversations) => ConversationsList(conversations: conversations),
///   error: (message) => ErrorWidget(message: message),
/// );
/// ```
@freezed
class ConversationsState with _$ConversationsState {
  /// Initial state when conversations haven't been loaded yet.
  const factory ConversationsState.initial() = ConversationsInitial;

  /// Loading state when conversations are being fetched for the first time.
  const factory ConversationsState.loading() = ConversationsLoading;

  /// Loading more state when additional conversations are being fetched for pagination.
  ///
  /// Parameters:
  /// - [conversations]: Current list of SMS conversation entities
  const factory ConversationsState.loadingMore(
    List<SmsConversationEntity> conversations,
  ) = ConversationsLoadingMore;

  /// Completed state when conversations have been successfully loaded.
  ///
  /// Parameters:
  /// - [conversations]: List of SMS conversation entities
  /// - [hasMore]: Whether there are more conversations to load
  const factory ConversationsState.completed(
    List<SmsConversationEntity> conversations,
    bool hasMore,
  ) = ConversationsCompleted;

  /// Error state when loading conversations failed.
  ///
  /// Parameters:
  /// - [message]: Error message describing what went wrong
  const factory ConversationsState.error(String message) = ConversationsError;
}

/// State for SMS messages loading operation.
/// This state represents the different states of loading SMS messages
/// from a specific address including initial, loading, completed, and error states.
///
/// Usage Example:
/// ```dart
/// state.messages.when(
///   initial: () => const SizedBox(),
///   loading: () => const CircularProgressIndicator(),
///   completed: (messages) => MessagesList(messages: messages),
///   error: (message) => ErrorWidget(message: message),
/// );
/// ```
@freezed
class MessagesState with _$MessagesState {
  /// Initial state when messages haven't been loaded yet.
  const factory MessagesState.initial() = MessagesInitial;

  /// Loading state when messages are being fetched.
  const factory MessagesState.loading() = MessagesLoading;

  /// Completed state when messages have been successfully loaded.
  ///
  /// Parameters:
  /// - [messages]: List of SMS entities from the selected address
  const factory MessagesState.completed(List<SmsEntity> messages) =
      MessagesCompleted;

  /// Error state when loading messages failed.
  ///
  /// Parameters:
  /// - [message]: Error message describing what went wrong
  const factory MessagesState.error(String message) = MessagesError;
}

/// State for SMS permission checking operation.
/// This state represents the different states of checking SMS permission
/// including initial, loading, completed, and error states.
///
/// Usage Example:
/// ```dart
/// state.permission.when(
///   initial: () => const SizedBox(),
///   loading: () => const CircularProgressIndicator(),
///   completed: (hasPermission) => hasPermission ? PermissionGranted() : PermissionDenied(),
///   error: (message) => ErrorWidget(message: message),
/// );
/// ```
@freezed
class PermissionState with _$PermissionState {
  /// Initial state when permission status hasn't been checked yet.
  const factory PermissionState.initial() = PermissionInitial;

  /// Loading state when permission status is being checked.
  const factory PermissionState.loading() = PermissionLoading;

  /// Completed state when permission status has been successfully checked.
  ///
  /// Parameters:
  /// - [hasPermission]: Whether SMS permission is granted (true) or denied (false)
  const factory PermissionState.completed(bool hasPermission) =
      PermissionCompleted;

  /// Error state when checking permission failed.
  ///
  /// Parameters:
  /// - [message]: Error message describing what went wrong
  const factory PermissionState.error(String message) = PermissionError;

  /// Permission denied state when user has explicitly denied SMS permission.
  /// This state is shown when the user has denied permission and we should
  /// show a UI to guide them to enable it in settings.
  const factory PermissionState.denied() = PermissionDenied;
}

/// Main state combining all SMS import operation states.
/// This state combines all the individual operation states into a single
/// state object that can be managed by the BLoC and consumed by the UI.
///
/// The state uses copyWith to update only the relevant operation's state
/// while keeping other operation states unchanged.
///
/// Usage Example:
/// ```dart
/// BlocBuilder<SmsImportBloc, SmsImportState>(
///   builder: (context, state) {
///     return Column(
///       children: [
///         // Conversations section
///         state.conversations.when(
///           initial: () => const SizedBox(),
///           loading: () => const CircularProgressIndicator(),
///           completed: (conversations) => ConversationsList(conversations: conversations),
///           error: (message) => ErrorWidget(message: message),
///         ),
///         // Messages section
///         state.messages.when(
///           initial: () => const SizedBox(),
///           loading: () => const CircularProgressIndicator(),
///           completed: (messages) => MessagesList(messages: messages),
///           error: (message) => ErrorWidget(message: message),
///         ),
///       ],
///     );
///   },
/// );
/// ```
@freezed
class SmsImportState with _$SmsImportState {
  /// Creates the main SMS import state with all operation states.
  ///
  /// Parameters:
  /// - [conversations]: State for SMS conversations loading operation
  /// - [messages]: State for SMS messages loading operation
  /// - [permission]: State for SMS permission checking operation
  const factory SmsImportState({
    @Default(ConversationsState.initial()) ConversationsState conversations,
    @Default(MessagesState.initial()) MessagesState messages,
    @Default(PermissionState.initial()) PermissionState permission,
  }) = _SmsImportState;
}
