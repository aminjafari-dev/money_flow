import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:money_flow/features/sms_import/domain/entities/sms_entity.dart';

part 'sms_model.freezed.dart';
part 'sms_model.g.dart';

/// SMS model representing a single SMS message in the data layer.
/// This model extends the domain entity with JSON serialization capabilities
/// and handles data transformation between the data source and domain layer.
///
/// The model follows the data transfer object (DTO) pattern and provides
/// methods to convert between JSON and domain entities.
///
/// Usage Example:
/// ```dart
/// final smsModel = SmsModel.fromJson(jsonData);
/// final smsEntity = smsModel.toDomain();
/// ```
@freezed
class SmsModel with _$SmsModel {
  /// Creates an SMS model with all required fields.
  ///
  /// Parameters:
  /// - [id]: Unique identifier for the SMS message
  /// - [address]: Phone number or sender address
  /// - [body]: Content of the SMS message
  /// - [date]: Date and time when the SMS was received (as milliseconds since epoch)
  /// - [isRead]: Whether the SMS has been read (default: false)
  const factory SmsModel({
    required String id,
    required String address,
    required String body,
    required int date,
    @Default(false) bool isRead,
  }) = _SmsModel;

  /// Creates an SMS model from JSON data.
  /// This factory method deserializes JSON data into an SMS model instance.
  ///
  /// Parameters:
  /// - [json]: JSON map containing SMS data
  ///
  /// Returns:
  /// - [SmsModel]: Parsed SMS model instance
  ///
  /// Usage Example:
  /// ```dart
  /// final json = {
  ///   'id': '123',
  ///   'address': '+1234567890',
  ///   'body': 'Your account was debited $25.00',
  ///   'date': 1640995200000,
  ///   'isRead': false,
  /// };
  /// final smsModel = SmsModel.fromJson(json);
  /// ```
  factory SmsModel.fromJson(Map<String, dynamic> json) =>
      _$SmsModelFromJson(json);
}

/// Extension methods for SmsModel to provide domain conversion functionality.
/// This extension adds methods to convert between data models and domain entities,
/// maintaining separation between the data and domain layers.
///
/// Usage Example:
/// ```dart
/// final smsModel = SmsModel(...);
/// final smsEntity = smsModel.toDomain();
/// ```
extension SmsModelExtension on SmsModel {
  /// Converts the SMS model to a domain entity.
  /// This method transforms the data model into a domain entity,
  /// converting the date from milliseconds to DateTime object.
  ///
  /// Returns:
  /// - [SmsEntity]: Domain entity representation of the SMS
  ///
  /// Usage Example:
  /// ```dart
  /// final smsModel = SmsModel(...);
  /// final smsEntity = smsModel.toDomain();
  /// print('SMS from ${smsEntity.address}: ${smsEntity.body}');
  /// ```
  SmsEntity toDomain() {
    return SmsEntity(
      id: id,
      address: address,
      body: body,
      date: DateTime.fromMillisecondsSinceEpoch(date),
      isRead: isRead,
    );
  }
}

/// SMS conversation model representing a group of SMS messages from the same sender.
/// This model extends the domain entity with JSON serialization capabilities
/// and handles data transformation between the data source and domain layer.
///
/// Usage Example:
/// ```dart
/// final conversationModel = SmsConversationModel.fromJson(jsonData);
/// final conversationEntity = conversationModel.toDomain();
/// ```
@freezed
class SmsConversationModel with _$SmsConversationModel {
  /// Creates an SMS conversation model with all required fields.
  ///
  /// Parameters:
  /// - [address]: Phone number or sender address
  /// - [lastMessage]: Preview of the most recent message
  /// - [messageCount]: Total number of messages in this conversation
  /// - [lastMessageDate]: Date and time of the most recent message (as milliseconds since epoch)
  const factory SmsConversationModel({
    required String address,
    required String lastMessage,
    required int messageCount,
    required int lastMessageDate,
  }) = _SmsConversationModel;

  /// Creates an SMS conversation model from JSON data.
  /// This factory method deserializes JSON data into an SMS conversation model instance.
  ///
  /// Parameters:
  /// - [json]: JSON map containing SMS conversation data
  ///
  /// Returns:
  /// - [SmsConversationModel]: Parsed SMS conversation model instance
  ///
  /// Usage Example:
  /// ```dart
  /// final json = {
  ///   'address': '+1234567890',
  ///   'lastMessage': 'Your account was debited $25.00',
  ///   'messageCount': 5,
  ///   'lastMessageDate': 1640995200000,
  /// };
  /// final conversationModel = SmsConversationModel.fromJson(json);
  /// ```
  factory SmsConversationModel.fromJson(Map<String, dynamic> json) =>
      _$SmsConversationModelFromJson(json);
}

/// Extension methods for SmsConversationModel to provide domain conversion functionality.
/// This extension adds methods to convert between data models and domain entities,
/// maintaining separation between the data and domain layers.
///
/// Usage Example:
/// ```dart
/// final conversationModel = SmsConversationModel(...);
/// final conversationEntity = conversationModel.toDomain();
/// ```
extension SmsConversationModelExtension on SmsConversationModel {
  /// Converts the SMS conversation model to a domain entity.
  /// This method transforms the data model into a domain entity,
  /// converting the date from milliseconds to DateTime object.
  ///
  /// Returns:
  /// - [SmsConversationEntity]: Domain entity representation of the SMS conversation
  ///
  /// Usage Example:
  /// ```dart
  /// final conversationModel = SmsConversationModel(...);
  /// final conversationEntity = conversationModel.toDomain();
  /// print('Conversation with ${conversationEntity.address}: ${conversationEntity.messageCount} messages');
  /// ```
  SmsConversationEntity toDomain() {
    return SmsConversationEntity(
      address: address,
      lastMessage: lastMessage,
      messageCount: messageCount,
      lastMessageDate: DateTime.fromMillisecondsSinceEpoch(lastMessageDate),
    );
  }
}
