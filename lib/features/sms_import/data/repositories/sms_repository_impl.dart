import 'package:dartz/dartz.dart';
import 'package:money_flow/core/error/failures.dart';
import 'package:money_flow/features/sms_import/data/datasources/sms_datasource.dart';
import 'package:money_flow/features/sms_import/data/models/sms_model.dart';
import 'package:money_flow/features/sms_import/domain/entities/sms_entity.dart';
import 'package:money_flow/features/sms_import/domain/repositories/sms_repository.dart';

/// Implementation of SMS repository following Clean Architecture principles.
/// This repository acts as a bridge between the domain and data layers,
/// providing a clean abstraction over SMS data access operations.
///
/// The repository pattern allows the domain layer to be independent of
/// data source implementation details while providing a consistent interface.
///
/// Usage Example:
/// ```dart
/// final repository = SmsRepositoryImpl(smsDataSource);
/// final result = await repository.getSmsConversations();
/// result.fold(
///   (failure) => print('Error: ${failure.message}'),
///   (conversations) => print('Found ${conversations.length} conversations'),
/// );
/// ```
class SmsRepositoryImpl implements SmsRepository {
  /// The SMS data source for accessing SMS data.
  /// This data source provides platform-specific SMS access functionality
  /// and handles the actual data retrieval operations.
  final SmsDataSource _dataSource;

  /// Creates a new instance of SmsRepositoryImpl.
  ///
  /// Parameters:
  /// - [dataSource]: The SMS data source for data access operations
  ///
  /// Usage Example:
  /// ```dart
  /// final repository = SmsRepositoryImpl(smsDataSource);
  /// ```
  const SmsRepositoryImpl(this._dataSource);

  @override
  Future<Either<Failure, List<SmsConversationEntity>>> getSmsConversations({
    int limit = 20,
    int offset = 0,
  }) async {
    try {
      // Call the data source to get SMS conversations with pagination
      final result = await _dataSource.getSmsConversations(
        limit: limit,
        offset: offset,
      );

      return result.fold(
        // If data source returns failure, propagate it
        (failure) => Left(failure),
        // If data source returns success, convert models to entities
        (conversationModels) {
          final conversationEntities = conversationModels
              .map((model) => model.toDomain())
              .toList();
          return Right(conversationEntities);
        },
      );
    } catch (e) {
      // Handle unexpected errors
      return Left(
        ServerFailure(
          'Unexpected error getting SMS conversations: ${e.toString()}',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<SmsEntity>>> getSmsMessagesByAddress(
    String address,
  ) async {
    try {
      // Validate input parameters
      if (address.isEmpty) {
        return const Left(ValidationFailure('Address cannot be empty'));
      }

      // Call the data source to get SMS messages by address
      final result = await _dataSource.getSmsMessagesByAddress(address);

      return result.fold(
        // If data source returns failure, propagate it
        (failure) => Left(failure),
        // If data source returns success, convert models to entities
        (smsModels) {
          final smsEntities = smsModels
              .map((model) => model.toDomain())
              .toList();
          return Right(smsEntities);
        },
      );
    } catch (e) {
      // Handle unexpected errors
      return Left(
        ServerFailure('Unexpected error getting SMS messages: ${e.toString()}'),
      );
    }
  }

  @override
  Future<Either<Failure, bool>> hasSmsPermission() async {
    try {
      // Call the data source to check SMS permission
      final result = await _dataSource.hasSmsPermission();

      return result.fold(
        // If data source returns failure, propagate it
        (failure) => Left(failure),
        // If data source returns success, return the permission status
        (hasPermission) => Right(hasPermission),
      );
    } catch (e) {
      // Handle unexpected errors
      return Left(
        ServerFailure(
          'Unexpected error checking SMS permission: ${e.toString()}',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, bool>> requestSmsPermission() async {
    try {
      // Call the data source to request SMS permission
      final result = await _dataSource.requestSmsPermission();

      return result.fold(
        // If data source returns failure, propagate it
        (failure) => Left(failure),
        // If data source returns success, return the permission result
        (granted) => Right(granted),
      );
    } catch (e) {
      // Handle unexpected errors
      return Left(
        ServerFailure(
          'Unexpected error requesting SMS permission: ${e.toString()}',
        ),
      );
    }
  }
}
