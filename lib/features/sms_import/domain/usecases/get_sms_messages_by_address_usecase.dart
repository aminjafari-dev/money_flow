import 'package:dartz/dartz.dart';
import 'package:money_flow/core/error/failures.dart';
import 'package:money_flow/features/sms_import/domain/entities/sms_entity.dart';
import 'package:money_flow/features/sms_import/domain/repositories/sms_repository.dart';

/// Use case for retrieving SMS messages from a specific sender address.
/// This use case handles the business logic for fetching SMS messages
/// from a particular phone number and provides a clean interface for the presentation layer.
///
/// The use case follows the single responsibility principle by focusing
/// solely on retrieving SMS messages by address without any UI concerns.
///
/// Usage Example:
/// ```dart
/// final useCase = GetSmsMessagesByAddressUseCase(smsRepository);
/// final result = await useCase.call(GetSmsMessagesByAddressParams(address: '+1234567890'));
/// result.fold(
///   (failure) => print('Error: ${failure.message}'),
///   (messages) => print('Found ${messages.length} messages'),
/// );
/// ```
class GetSmsMessagesByAddressUseCase {
  /// The SMS repository for data access operations.
  /// This repository provides access to SMS data sources
  /// and handles the actual data retrieval logic.
  final SmsRepository _repository;

  /// Creates a new instance of GetSmsMessagesByAddressUseCase.
  ///
  /// Parameters:
  /// - [repository]: The SMS repository for data access
  ///
  /// Usage Example:
  /// ```dart
  /// final useCase = GetSmsMessagesByAddressUseCase(smsRepository);
  /// ```
  const GetSmsMessagesByAddressUseCase(this._repository);

  /// Executes the use case to retrieve SMS messages from a specific address.
  /// This method calls the repository to fetch all SMS messages
  /// from the specified sender address in chronological order.
  ///
  /// Parameters:
  /// - [params]: Parameters containing the sender address
  ///
  /// Returns:
  /// - [Right] with [List<SmsEntity>] on success
  /// - [Left] with [Failure] on error (e.g., permission denied, address not found)
  ///
  /// Usage Example:
  /// ```dart
  /// final params = GetSmsMessagesByAddressParams(address: '+1234567890');
  /// final result = await useCase.call(params);
  /// result.fold(
  ///   (failure) => print('Error: ${failure.message}'),
  ///   (messages) => messages.forEach((message) {
  ///     print('${message.date}: ${message.body}');
  ///   }),
  /// );
  /// ```
  Future<Either<Failure, List<SmsEntity>>> call(
    GetSmsMessagesByAddressParams params,
  ) async {
    // Validate the address parameter
    if (params.address.isEmpty) {
      return const Left(ValidationFailure('Address cannot be empty'));
    }

    // Call the repository to get SMS messages by address
    // The repository handles permission checking and data retrieval
    return await _repository.getSmsMessagesByAddress(params.address);
  }
}

/// Parameter class for GetSmsMessagesByAddressUseCase.
/// This class encapsulates the parameters needed to retrieve SMS messages
/// from a specific sender address, providing type safety and clear interface.
///
/// Usage Example:
/// ```dart
/// final params = GetSmsMessagesByAddressParams(address: '+1234567890');
/// final result = await useCase.call(params);
/// ```
class GetSmsMessagesByAddressParams {
  /// The sender address (phone number) to retrieve messages from.
  /// This should be a valid phone number or SMS sender identifier.
  final String address;

  /// Creates a new instance of GetSmsMessagesByAddressParams.
  ///
  /// Parameters:
  /// - [address]: The sender address to retrieve messages from
  ///
  /// Usage Example:
  /// ```dart
  /// final params = GetSmsMessagesByAddressParams(address: '+1234567890');
  /// ```
  const GetSmsMessagesByAddressParams({required this.address});
}
