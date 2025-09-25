import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';
import 'package:money_flow/features/sms_import/data/models/sms_model.dart';

/// Isolate functions for SMS data processing to prevent UI blocking.
/// These functions handle heavy computational tasks in separate isolates
/// to maintain smooth UI performance during SMS operations.

/// Parameters for SMS conversation processing in isolate.
class SmsConversationParams {
  final List<SmsMessage> messages;
  final int limit;
  final int offset;

  const SmsConversationParams({
    required this.messages,
    required this.limit,
    required this.offset,
  });
}

/// Processes SMS messages to create conversation models in a separate isolate.
/// This function groups messages by sender address, sorts them, and applies pagination
/// without blocking the main UI thread.
///
/// Parameters:
/// - [params]: SmsConversationParams containing messages and pagination info
///
/// Returns:
/// - [List<SmsConversationModel>]: Processed conversation models
///
/// Usage Example:
/// ```dart
/// final params = SmsConversationParams(
///   messages: smsMessages,
///   limit: 20,
///   offset: 0,
/// );
/// final conversations = await compute(processSmsConversations, params);
/// ```
List<SmsConversationModel> processSmsConversations(
  SmsConversationParams params,
) {
  try {
    final messages = params.messages;
    final limit = params.limit;
    final offset = params.offset;

    // Group messages by sender address to create conversations
    final Map<String, List<SmsMessage>> conversationsMap = {};

    for (final message in messages) {
      final address = message.address ?? 'Unknown';
      if (!conversationsMap.containsKey(address)) {
        conversationsMap[address] = [];
      }
      conversationsMap[address]!.add(message);
    }

    // Convert grouped messages to conversation models
    final List<SmsConversationModel> conversations = [];

    for (final entry in conversationsMap.entries) {
      final address = entry.key;
      final messages = entry.value;

      // Sort messages by date (newest first)
      messages.sort((a, b) => b.date!.compareTo(a.date!));

      // Get the last message for preview
      final lastMessage = messages.first;

      // Create conversation model
      final conversation = SmsConversationModel(
        address: address,
        lastMessage: lastMessage.body ?? '',
        messageCount: messages.length,
        lastMessageDate:
            lastMessage.date?.millisecondsSinceEpoch ??
            DateTime.now().millisecondsSinceEpoch,
      );

      conversations.add(conversation);
    }

    // Sort conversations by last message date (newest first)
    conversations.sort(
      (a, b) => b.lastMessageDate.compareTo(a.lastMessageDate),
    );

    // Apply pagination
    final int startIndex = offset;
    final int endIndex = (startIndex + limit).clamp(0, conversations.length);

    // Return paginated results
    return conversations.sublist(startIndex, endIndex);
  } catch (e) {
    // If processing fails, return empty list
    // The error will be handled by the calling function
    return [];
  }
}

/// Parameters for SMS message filtering in isolate.
class SmsMessageFilterParams {
  final List<SmsMessage> messages;
  final String targetAddress;

  const SmsMessageFilterParams({
    required this.messages,
    required this.targetAddress,
  });
}

/// Filters SMS messages by address in a separate isolate.
/// This function processes and filters messages for a specific sender
/// without blocking the main UI thread.
///
/// Parameters:
/// - [params]: SmsMessageFilterParams containing messages and target address
///
/// Returns:
/// - [List<SmsModel>]: Filtered SMS models
///
/// Usage Example:
/// ```dart
/// final params = SmsMessageFilterParams(
///   messages: allMessages,
///   targetAddress: '+1234567890',
/// );
/// final filteredMessages = await compute(filterSmsMessagesByAddress, params);
/// ```
List<SmsModel> filterSmsMessagesByAddress(SmsMessageFilterParams params) {
  try {
    final messages = params.messages;
    final targetAddress = params.targetAddress;

    // Filter messages by address and convert to SmsModel
    final List<SmsModel> filteredMessages = messages
        .where((message) => message.address == targetAddress)
        .map(
          (message) => SmsModel(
            id: message.id?.toString() ?? '',
            address: message.address ?? 'Unknown',
            body: message.body ?? '',
            date:
                message.date?.millisecondsSinceEpoch ??
                DateTime.now().millisecondsSinceEpoch,
            isRead: message.read ?? false,
          ),
        )
        .toList();

    // Sort messages by date (oldest first for conversation view)
    filteredMessages.sort((a, b) => a.date.compareTo(b.date));

    return filteredMessages;
  } catch (e) {
    // If processing fails, return empty list
    // The error will be handled by the calling function
    return [];
  }
}

/// Parameters for SMS message conversion in isolate.
class SmsMessageConversionParams {
  final List<SmsMessage> messages;

  const SmsMessageConversionParams({required this.messages});
}

/// Converts SMS messages to SmsModel objects in a separate isolate.
/// This function handles the conversion of platform-specific SMS messages
/// to our data models without blocking the main UI thread.
///
/// Parameters:
/// - [params]: SmsMessageConversionParams containing messages to convert
///
/// Returns:
/// - [List<SmsModel>]: Converted SMS models
///
/// Usage Example:
/// ```dart
/// final params = SmsMessageConversionParams(messages: smsMessages);
/// final smsModels = await compute(convertSmsMessages, params);
/// ```
List<SmsModel> convertSmsMessages(SmsMessageConversionParams params) {
  try {
    final messages = params.messages;

    // Convert messages to SmsModel objects
    final List<SmsModel> smsModels = messages
        .map(
          (message) => SmsModel(
            id: message.id?.toString() ?? '',
            address: message.address ?? 'Unknown',
            body: message.body ?? '',
            date:
                message.date?.millisecondsSinceEpoch ??
                DateTime.now().millisecondsSinceEpoch,
            isRead: message.read ?? false,
          ),
        )
        .toList();

    return smsModels;
  } catch (e) {
    // If conversion fails, return empty list
    // The error will be handled by the calling function
    return [];
  }
}
