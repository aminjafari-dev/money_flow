import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:money_flow/core/error/failures.dart';
import 'package:money_flow/features/sms_import/data/datasources/sms_datasource.dart';
import 'package:money_flow/features/sms_import/data/models/sms_model.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';

/// Real implementation of SMS data source using platform-specific SMS access.
/// This implementation provides concrete SMS data access functionality
/// using platform channels for actual SMS operations.
///
/// The implementation handles platform-specific SMS access while providing
/// a consistent interface for the repository layer.
///
/// Usage Example:
/// ```dart
/// final dataSource = SmsRealDataSourceImpl();
/// final result = await dataSource.getSmsConversations();
/// result.fold(
///   (failure) => print('Error: ${failure.message}'),
///   (conversations) => print('Found ${conversations.length} conversations'),
/// );
/// ```
class SmsRealDataSourceImpl implements SmsDataSource {
  /// Tracks the current permission state.
  /// This is used to maintain permission state between requests.
  bool _hasPermission = false;

  /// Creates a new instance of SmsRealDataSourceImpl.
  ///
  /// Usage Example:
  /// ```dart
  /// final dataSource = SmsRealDataSourceImpl();
  /// ```
  SmsRealDataSourceImpl();

  @override
  Future<Either<Failure, List<SmsConversationModel>>> getSmsConversations({
    int limit = 20,
    int offset = 0,
  }) async {
    try {
      // Check if we have SMS permission
      final hasPermission = await _hasSmsPermission();
      if (!hasPermission) {
        return const Left(PermissionFailure('SMS permission not granted'));
      }

      // Get all SMS messages from the device using flutter_sms_inbox package
      final SmsQuery query = SmsQuery();
      final List<SmsMessage> messages = await query.querySms(
        kinds: [SmsQueryKind.inbox],
        count: 10000, // Limit to prevent performance issues
      );

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
      final List<SmsConversationModel> paginatedConversations = conversations
          .sublist(startIndex, endIndex);

      return Right(paginatedConversations);
    } catch (e) {
      return Left(
        ServerFailure('Failed to get SMS conversations: ${e.toString()}'),
      );
    }
  }

  @override
  Future<Either<Failure, List<SmsModel>>> getSmsMessagesByAddress(
    String address,
  ) async {
    // Temporarily disabled - focusing on conversations only
    // TODO: Implement this method when needed
    return const Left(
      ServerFailure('SMS messages by address not implemented yet'),
    );
  }

  @override
  Future<Either<Failure, bool>> hasSmsPermission() async {
    try {
      if (Platform.isAndroid) {
        // Check real SMS permission status
        final status = await Permission.sms.status;
        _hasPermission = status.isGranted;
        return Right(_hasPermission);
      } else {
        // iOS doesn't support SMS reading
        _hasPermission = false;
        return const Right(false);
      }
    } catch (e) {
      return Left(
        ServerFailure('Failed to check SMS permission: ${e.toString()}'),
      );
    }
  }

  @override
  Future<Either<Failure, bool>> requestSmsPermission() async {
    try {
      if (Platform.isAndroid) {
        // Request real SMS permission from the user
        final status = await Permission.sms.request();
        _hasPermission = status.isGranted;

        if (status.isDenied) {
          return const Right(false);
        } else if (status.isPermanentlyDenied) {
          // Permission is permanently denied, user needs to go to settings
          return Left(
            PermissionFailure(
              'SMS permission is permanently denied. Please enable it in app settings.',
            ),
          );
        } else if (status.isGranted) {
          return const Right(true);
        } else {
          return const Right(false);
        }
      } else {
        // iOS doesn't support SMS reading
        return const Right(false);
      }
    } catch (e) {
      return Left(
        ServerFailure('Failed to request SMS permission: ${e.toString()}'),
      );
    }
  }

  /// Private method to check SMS permission.
  /// This method checks if the app has permission to read SMS messages.
  ///
  /// Returns:
  /// - [true] if permission is granted
  /// - [false] if permission is denied
  ///
  /// Usage Example:
  /// ```dart
  /// final hasPermission = await _hasSmsPermission();
  /// if (hasPermission) {
  ///   // Proceed with SMS operations
  /// }
  /// ```
  Future<bool> _hasSmsPermission() async {
    try {
      if (Platform.isAndroid) {
        // Check real SMS permission status
        final status = await Permission.sms.status;
        _hasPermission = status.isGranted;
        return _hasPermission;
      } else {
        // iOS doesn't support SMS reading
        return false;
      }
    } catch (e) {
      // If there's an error checking permission, assume it's not granted
      return false;
    }
  }
}
