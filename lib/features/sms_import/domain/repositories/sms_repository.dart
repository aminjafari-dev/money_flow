import 'package:dartz/dartz.dart';
import 'package:money_flow/core/error/failures.dart';
import 'package:money_flow/features/sms_import/domain/entities/sms_entity.dart';

/// Abstract repository interface for SMS operations.
/// This interface defines the contract for SMS data access operations
/// following Clean Architecture principles.
///
/// The repository pattern provides a clean abstraction over data sources
/// and allows the domain layer to be independent of data implementation details.
///
/// Usage Example:
/// ```dart
/// class SmsRepositoryImpl implements SmsRepository {
///   @override
///   Future<Either<Failure, List<SmsConversationEntity>>> getSmsConversations() async {
///     // Implementation details
///   }
/// }
/// ```
abstract class SmsRepository {
  /// Retrieves SMS conversations grouped by sender address with pagination.
  /// This method returns a list of conversations with preview information
  /// including the last message, message count, and last message date.
  ///
  /// Parameters:
  /// - [limit]: Maximum number of conversations to return (default: 20)
  /// - [offset]: Number of conversations to skip for pagination (default: 0)
  ///
  /// Returns:
  /// - [Right] with [List<SmsConversationEntity>] on success
  /// - [Left] with [Failure] on error (e.g., permission denied, no SMS access)
  ///
  /// Usage Example:
  /// ```dart
  /// final result = await smsRepository.getSmsConversations(limit: 20, offset: 0);
  /// result.fold(
  ///   (failure) => print('Error: ${failure.message}'),
  ///   (conversations) => print('Found ${conversations.length} conversations'),
  /// );
  /// ```
  Future<Either<Failure, List<SmsConversationEntity>>> getSmsConversations({
    int limit = 20,
    int offset = 0,
  });

  /// Retrieves all SMS messages from a specific sender address.
  /// This method returns all messages from a particular phone number
  /// in chronological order (oldest first).
  ///
  /// Parameters:
  /// - [address]: The phone number or sender address to get messages from
  ///
  /// Returns:
  /// - [Right] with [List<SmsEntity>] on success
  /// - [Left] with [Failure] on error (e.g., permission denied, address not found)
  ///
  /// Usage Example:
  /// ```dart
  /// final result = await smsRepository.getSmsMessagesByAddress('+1234567890');
  /// result.fold(
  ///   (failure) => print('Error: ${failure.message}'),
  ///   (messages) => print('Found ${messages.length} messages'),
  /// );
  /// ```
  Future<Either<Failure, List<SmsEntity>>> getSmsMessagesByAddress(
    String address,
  );

  /// Checks if the app has permission to read SMS messages.
  /// This method verifies the current permission status for SMS access.
  ///
  /// Returns:
  /// - [Right] with [bool] indicating permission status (true = granted, false = denied)
  /// - [Left] with [Failure] on error checking permissions
  ///
  /// Usage Example:
  /// ```dart
  /// final result = await smsRepository.hasSmsPermission();
  /// result.fold(
  ///   (failure) => print('Error checking permission: ${failure.message}'),
  ///   (hasPermission) => print('SMS permission: $hasPermission'),
  /// );
  /// ```
  Future<Either<Failure, bool>> hasSmsPermission();

  /// Requests permission to read SMS messages.
  /// This method prompts the user to grant SMS read permission.
  ///
  /// Returns:
  /// - [Right] with [bool] indicating if permission was granted (true = granted, false = denied)
  /// - [Left] with [Failure] on error requesting permissions
  ///
  /// Usage Example:
  /// ```dart
  /// final result = await smsRepository.requestSmsPermission();
  /// result.fold(
  ///   (failure) => print('Error requesting permission: ${failure.message}'),
  ///   (granted) => print('Permission granted: $granted'),
  /// );
  /// ```
  Future<Either<Failure, bool>> requestSmsPermission();
}
