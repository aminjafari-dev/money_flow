import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:money_flow/core/error/failures.dart';
import 'package:money_flow/features/sms_import/data/datasources/sms_datasource.dart';
import 'package:money_flow/features/sms_import/data/datasources/sms_isolate_functions.dart';
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

      // Process messages in a separate isolate to prevent UI blocking
      final conversations = await compute(
        processSmsConversations,
        SmsConversationParams(messages: messages, limit: limit, offset: offset),
      );

      // Check if processing failed (empty list might indicate an error)
      if (conversations.isEmpty && messages.isNotEmpty) {
        return const Left(ServerFailure('Failed to process SMS conversations'));
      }

      return Right(conversations);
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

      // Filter messages by address in a separate isolate to prevent UI blocking
      final filteredMessages = await compute(
        filterSmsMessagesByAddress,
        SmsMessageFilterParams(messages: messages, targetAddress: address),
      );

      return Right(filteredMessages);
    } catch (e) {
      return Left(
        ServerFailure('Failed to get SMS messages by address: ${e.toString()}'),
      );
    }
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
