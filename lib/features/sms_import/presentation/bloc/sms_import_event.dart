import 'package:freezed_annotation/freezed_annotation.dart';

part 'sms_import_event.freezed.dart';

/// Sealed class for SMS import-related events.
/// This class defines all possible events that can be triggered
/// in the SMS import feature, following the BLoC pattern.
///
/// Events are immutable and represent user actions or system triggers
/// that cause state changes in the SMS import feature.
///
/// Usage Example:
/// ```dart
/// context.read<SmsImportBloc>().add(const SmsImportEvent.loadConversations());
/// context.read<SmsImportBloc>().add(SmsImportEvent.loadMessagesByAddress(address: '+1234567890'));
/// ```
@freezed
class SmsImportEvent with _$SmsImportEvent {
  /// Event to load SMS conversations.
  /// This event triggers the loading of SMS conversations
  /// grouped by sender address with preview information.
  /// This loads the first page of conversations.
  ///
  /// Usage Example:
  /// ```dart
  /// context.read<SmsImportBloc>().add(const SmsImportEvent.loadConversations());
  /// ```
  const factory SmsImportEvent.loadConversations() = LoadConversations;

  /// Event to load more SMS conversations for pagination.
  /// This event triggers the loading of additional SMS conversations
  /// for pagination when the user scrolls to the bottom of the list.
  ///
  /// Usage Example:
  /// ```dart
  /// context.read<SmsImportBloc>().add(const SmsImportEvent.loadMoreConversations());
  /// ```
  const factory SmsImportEvent.loadMoreConversations() = LoadMoreConversations;

  /// Event to load SMS messages from a specific address.
  /// This event triggers the loading of all SMS messages
  /// from a particular sender address in chronological order.
  ///
  /// Parameters:
  /// - [address]: The phone number or sender address to load messages from
  ///
  /// Usage Example:
  /// ```dart
  /// context.read<SmsImportBloc>().add(
  ///   SmsImportEvent.loadMessagesByAddress(address: '+1234567890'),
  /// );
  /// ```
  const factory SmsImportEvent.loadMessagesByAddress({
    required String address,
  }) = LoadMessagesByAddress;

  /// Event to check SMS permission status.
  /// This event triggers the checking of current SMS read permission
  /// status without requesting permission from the user.
  ///
  /// Usage Example:
  /// ```dart
  /// context.read<SmsImportBloc>().add(const SmsImportEvent.checkPermission());
  /// ```
  const factory SmsImportEvent.checkPermission() = CheckPermission;

  /// Event to request SMS permission.
  /// This event triggers the request for SMS read permission
  /// from the user, showing the system permission dialog.
  ///
  /// Usage Example:
  /// ```dart
  /// context.read<SmsImportBloc>().add(const SmsImportEvent.requestPermission());
  /// ```
  const factory SmsImportEvent.requestPermission() = RequestPermission;

  /// Event to refresh SMS data.
  /// This event triggers a refresh of the current SMS data,
  /// useful for pulling to refresh or manual refresh actions.
  ///
  /// Usage Example:
  /// ```dart
  /// context.read<SmsImportBloc>().add(const SmsImportEvent.refresh());
  /// ```
  const factory SmsImportEvent.refresh() = Refresh;

  /// Event to initialize SMS import flow.
  /// This event handles the complete initialization flow:
  /// 1. Check SMS permission
  /// 2. If permission granted, load conversations
  /// 3. If permission denied, request permission
  /// 4. If permission still denied after request, show permission denied state
  ///
  /// Usage Example:
  /// ```dart
  /// context.read<SmsImportBloc>().add(const SmsImportEvent.initialize());
  /// ```
  const factory SmsImportEvent.initialize() = Initialize;
}
