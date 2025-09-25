import 'package:freezed_annotation/freezed_annotation.dart';

part 'sms_entity.freezed.dart';

/// SMS entity representing a single SMS message.
/// This entity contains the core data structure for SMS messages
/// used throughout the SMS Import feature.
///
/// Usage Example:
/// ```dart
/// final sms = SmsEntity(
///   id: '123',
///   address: '+1234567890',
///   body: 'Your account was debited $25.00',
///   date: DateTime.now(),
/// );
/// ```
@freezed
class SmsEntity with _$SmsEntity {
  /// Creates an SMS entity with all required fields.
  ///
  /// Parameters:
  /// - [id]: Unique identifier for the SMS message
  /// - [address]: Phone number or sender address
  /// - [body]: Content of the SMS message
  /// - [date]: Date and time when the SMS was received
  /// - [isRead]: Whether the SMS has been read (default: false)
  const factory SmsEntity({
    required String id,
    required String address,
    required String body,
    required DateTime date,
    @Default(false) bool isRead,
  }) = _SmsEntity;
}

/// SMS conversation entity representing a group of SMS messages from the same sender.
/// This entity groups SMS messages by sender address for better organization.
///
/// Usage Example:
/// ```dart
/// final conversation = SmsConversationEntity(
///   address: '+1234567890',
///   lastMessage: 'Your account was debited $25.00',
///   messageCount: 5,
///   lastMessageDate: DateTime.now(),
/// );
/// ```
@freezed
class SmsConversationEntity with _$SmsConversationEntity {
  /// Creates an SMS conversation entity with all required fields.
  ///
  /// Parameters:
  /// - [address]: Phone number or sender address
  /// - [lastMessage]: Preview of the most recent message
  /// - [messageCount]: Total number of messages in this conversation
  /// - [lastMessageDate]: Date and time of the most recent message
  const factory SmsConversationEntity({
    required String address,
    required String lastMessage,
    required int messageCount,
    required DateTime lastMessageDate,
  }) = _SmsConversationEntity;
}
