import 'package:dartz/dartz.dart';
import 'package:money_flow/core/constants/no_params.dart';
import 'package:money_flow/core/error/failures.dart';
import 'package:money_flow/features/sms_import/domain/repositories/sms_repository.dart';

/// Use case for checking SMS permission status.
/// This use case handles the business logic for verifying SMS read permission
/// and provides a clean interface for the presentation layer.
///
/// The use case follows the single responsibility principle by focusing
/// solely on permission checking without any UI concerns.
///
/// Usage Example:
/// ```dart
/// final useCase = CheckSmsPermissionUseCase(smsRepository);
/// final result = await useCase.call(NoParams());
/// result.fold(
///   (failure) => print('Error: ${failure.message}'),
///   (hasPermission) => print('SMS permission: $hasPermission'),
/// );
/// ```
class CheckSmsPermissionUseCase {
  /// The SMS repository for data access operations.
  /// This repository provides access to permission checking functionality
  /// and handles the actual permission verification logic.
  final SmsRepository _repository;

  /// Creates a new instance of CheckSmsPermissionUseCase.
  ///
  /// Parameters:
  /// - [repository]: The SMS repository for data access
  ///
  /// Usage Example:
  /// ```dart
  /// final useCase = CheckSmsPermissionUseCase(smsRepository);
  /// ```
  const CheckSmsPermissionUseCase(this._repository);

  /// Executes the use case to check SMS permission status.
  /// This method calls the repository to verify the current SMS read permission
  /// status without requesting permission from the user.
  ///
  /// Parameters:
  /// - [params]: No parameters needed for this use case (use NoParams())
  ///
  /// Returns:
  /// - [Right] with [bool] indicating permission status (true = granted, false = denied)
  /// - [Left] with [Failure] on error checking permissions
  ///
  /// Usage Example:
  /// ```dart
  /// final result = await useCase.call(NoParams());
  /// result.fold(
  ///   (failure) => print('Error checking permission: ${failure.message}'),
  ///   (hasPermission) {
  ///     if (hasPermission) {
  ///       print('SMS permission is granted');
  ///     } else {
  ///       print('SMS permission is not granted');
  ///     }
  ///   },
  /// );
  /// ```
  Future<Either<Failure, bool>> call(NoParams params) async {
    // Call the repository to check SMS permission
    // The repository handles the actual permission checking logic
    return await _repository.hasSmsPermission();
  }
}
