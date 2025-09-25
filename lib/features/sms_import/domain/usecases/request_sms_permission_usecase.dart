import 'package:dartz/dartz.dart';
import 'package:money_flow/core/constants/no_params.dart';
import 'package:money_flow/core/error/failures.dart';
import 'package:money_flow/features/sms_import/domain/repositories/sms_repository.dart';

/// Use case for requesting SMS permission.
/// This use case handles the business logic for requesting SMS read permission
/// from the user and provides a clean interface for the presentation layer.
///
/// The use case follows the single responsibility principle by focusing
/// solely on permission requesting without any UI concerns.
///
/// Usage Example:
/// ```dart
/// final useCase = RequestSmsPermissionUseCase(smsRepository);
/// final result = await useCase.call(NoParams());
/// result.fold(
///   (failure) => print('Error: ${failure.message}'),
///   (granted) => print('Permission granted: $granted'),
/// );
/// ```
class RequestSmsPermissionUseCase {
  /// The SMS repository for data access operations.
  /// This repository provides access to permission requesting functionality
  /// and handles the actual permission request logic.
  final SmsRepository _repository;

  /// Creates a new instance of RequestSmsPermissionUseCase.
  ///
  /// Parameters:
  /// - [repository]: The SMS repository for data access
  ///
  /// Usage Example:
  /// ```dart
  /// final useCase = RequestSmsPermissionUseCase(smsRepository);
  /// ```
  const RequestSmsPermissionUseCase(this._repository);

  /// Executes the use case to request SMS permission.
  /// This method calls the repository to prompt the user for SMS read permission
  /// and returns whether the permission was granted or denied.
  ///
  /// Parameters:
  /// - [params]: No parameters needed for this use case (use NoParams())
  ///
  /// Returns:
  /// - [Right] with [bool] indicating if permission was granted (true = granted, false = denied)
  /// - [Left] with [Failure] on error requesting permissions
  ///
  /// Usage Example:
  /// ```dart
  /// final result = await useCase.call(NoParams());
  /// result.fold(
  ///   (failure) => print('Error requesting permission: ${failure.message}'),
  ///   (granted) {
  ///     if (granted) {
  ///       print('SMS permission was granted');
  ///       // Proceed with SMS operations
  ///     } else {
  ///       print('SMS permission was denied');
  ///       // Show alternative options or instructions
  ///     }
  ///   },
  /// );
  /// ```
  Future<Either<Failure, bool>> call(NoParams params) async {
    // Call the repository to request SMS permission
    // The repository handles the actual permission request logic
    return await _repository.requestSmsPermission();
  }
}
