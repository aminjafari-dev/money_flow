import 'package:dartz/dartz.dart';
import 'package:money_flow/core/error/failures.dart';
import 'package:money_flow/features/sms_import/domain/entities/sms_entity.dart';
import 'package:money_flow/features/sms_import/domain/repositories/sms_repository.dart';

/// Use case for retrieving SMS conversations.
/// This use case handles the business logic for fetching SMS conversations
/// and provides a clean interface for the presentation layer.
///
/// The use case follows the single responsibility principle by focusing
/// solely on retrieving SMS conversations without any UI concerns.
///
/// Usage Example:
/// ```dart
/// final useCase = GetSmsConversationsUseCase(smsRepository);
/// final result = await useCase.call(NoParams());
/// result.fold(
///   (failure) => print('Error: ${failure.message}'),
///   (conversations) => print('Found ${conversations.length} conversations'),
/// );
/// ```
class GetSmsConversationsUseCase {
  /// The SMS repository for data access operations.
  /// This repository provides access to SMS data sources
  /// and handles the actual data retrieval logic.
  final SmsRepository _repository;

  /// Creates a new instance of GetSmsConversationsUseCase.
  ///
  /// Parameters:
  /// - [repository]: The SMS repository for data access
  ///
  /// Usage Example:
  /// ```dart
  /// final useCase = GetSmsConversationsUseCase(smsRepository);
  /// ```
  const GetSmsConversationsUseCase(this._repository);

  /// Executes the use case to retrieve SMS conversations with pagination.
  /// This method calls the repository to fetch SMS conversations
  /// grouped by sender address with preview information.
  ///
  /// Parameters:
  /// - [params]: Parameters containing limit and offset for pagination
  ///
  /// Returns:
  /// - [Right] with [List<SmsConversationEntity>] on success
  /// - [Left] with [Failure] on error (e.g., permission denied, no SMS access)
  ///
  /// Usage Example:
  /// ```dart
  /// final result = await useCase.call(GetSmsConversationsParams(limit: 20, offset: 0));
  /// result.fold(
  ///   (failure) => print('Error: ${failure.message}'),
  ///   (conversations) => conversations.forEach((conv) {
  ///     print('${conv.address}: ${conv.lastMessage}');
  ///   }),
  /// );
  /// ```
  Future<Either<Failure, List<SmsConversationEntity>>> call(
    GetSmsConversationsParams params,
  ) async {
    // Call the repository to get SMS conversations with pagination
    // The repository handles permission checking and data retrieval
    return await _repository.getSmsConversations(
      limit: params.limit,
      offset: params.offset,
    );
  }
}

/// Parameter class for SMS conversations use case with pagination.
/// This class provides pagination parameters for retrieving SMS conversations
/// in a controlled manner to improve performance and user experience.
///
/// Usage Example:
/// ```dart
/// final params = GetSmsConversationsParams(limit: 20, offset: 0);
/// final result = await useCase.call(params);
/// ```
class GetSmsConversationsParams {
  /// Maximum number of conversations to return.
  /// This helps control the amount of data loaded at once.
  final int limit;

  /// Number of conversations to skip for pagination.
  /// This allows loading the next page of conversations.
  final int offset;

  /// Creates a new instance of GetSmsConversationsParams.
  ///
  /// Parameters:
  /// - [limit]: Maximum number of conversations to return (default: 20)
  /// - [offset]: Number of conversations to skip (default: 0)
  ///
  /// Usage Example:
  /// ```dart
  /// final params = GetSmsConversationsParams(limit: 20, offset: 0);
  /// ```
  const GetSmsConversationsParams({this.limit = 20, this.offset = 0});
}
