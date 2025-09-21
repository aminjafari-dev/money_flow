import 'package:dartz/dartz.dart';
import 'package:money_flow/core/error/failures.dart';
import 'package:money_flow/features/dashboard/domain/entities/dashboard_entity.dart';
import 'package:money_flow/features/dashboard/domain/repositories/dashboard_repository.dart';

/// Use case for updating dashboard data with new information.
/// This use case handles the business logic for updating dashboard information.
///
/// Usage Example:
/// ```dart
/// final updateDashboardDataUseCase = UpdateDashboardDataUseCase(
///   repository: dashboardRepository,
/// );
///
/// final result = await updateDashboardDataUseCase.call(params);
/// result.fold(
///   (failure) => handleError(failure),
///   (_) => showSuccessMessage('Dashboard updated successfully'),
/// );
/// ```
class UpdateDashboardDataUseCase {
  /// Repository for dashboard data operations
  final DashboardRepository repository;

  /// Creates a new instance of UpdateDashboardDataUseCase.
  ///
  /// Parameters:
  /// - [repository]: Dashboard repository for data operations
  ///
  /// Usage Example:
  /// ```dart
  /// final useCase = UpdateDashboardDataUseCase(
  ///   repository: getIt<DashboardRepository>(),
  /// );
  /// ```
  const UpdateDashboardDataUseCase({required this.repository});

  /// Executes the use case to update dashboard data.
  /// This method handles the business logic for updating dashboard information.
  ///
  /// Parameters:
  /// - [params]: Parameters containing user ID and dashboard data to update
  ///
  /// Returns:
  /// - [Either<Failure, Unit>]: Either a failure or success indication
  ///
  /// Usage Example:
  /// ```dart
  /// final params = UpdateDashboardDataParams(
  ///   userId: 'user123',
  ///   dashboard: updatedDashboard,
  /// );
  /// final result = await updateDashboardDataUseCase.call(params);
  ///
  /// result.fold(
  ///   (failure) => print('Error: ${failure.message}'),
  ///   (_) => print('Dashboard updated successfully'),
  /// );
  /// ```
  Future<Either<Failure, Unit>> call(UpdateDashboardDataParams params) async {
    // Validate input parameters
    if (params.userId.isEmpty) {
      return const Left(ValidationFailure('User ID cannot be empty'));
    }

    if (params.dashboard.totalIncome < 0) {
      return const Left(ValidationFailure('Total income cannot be negative'));
    }

    if (params.dashboard.totalExpenses < 0) {
      return const Left(ValidationFailure('Total expenses cannot be negative'));
    }

    if (params.dashboard.totalCharity < 0) {
      return const Left(ValidationFailure('Total charity cannot be negative'));
    }

    if (params.dashboard.totalInvestments < 0) {
      return const Left(
        ValidationFailure('Total investments cannot be negative'),
      );
    }

    try {
      // Update dashboard data in repository
      final result = await repository.updateDashboardData(
        params.userId,
        params.dashboard,
      );

      return result;
    } catch (e) {
      // Handle unexpected errors
      return Left(ServerFailure('Failed to update dashboard data: $e'));
    }
  }
}

/// Parameters for the UpdateDashboardDataUseCase.
/// This class encapsulates the input parameters required for the use case.
///
/// Usage Example:
/// ```dart
/// final params = UpdateDashboardDataParams(
///   userId: 'user123',
///   dashboard: updatedDashboard,
/// );
/// final result = await useCase.call(params);
/// ```
class UpdateDashboardDataParams {
  /// Unique identifier for the user
  final String userId;

  /// Dashboard data to update
  final DashboardEntity dashboard;

  /// Creates a new instance of UpdateDashboardDataParams.
  ///
  /// Parameters:
  /// - [userId]: Unique identifier for the user
  /// - [dashboard]: Dashboard data to update
  ///
  /// Usage Example:
  /// ```dart
  /// final params = UpdateDashboardDataParams(
  ///   userId: 'user123',
  ///   dashboard: updatedDashboard,
  /// );
  /// ```
  const UpdateDashboardDataParams({
    required this.userId,
    required this.dashboard,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UpdateDashboardDataParams &&
          runtimeType == other.runtimeType &&
          userId == other.userId &&
          dashboard == other.dashboard;

  @override
  int get hashCode => userId.hashCode ^ dashboard.hashCode;

  @override
  String toString() =>
      'UpdateDashboardDataParams{userId: $userId, dashboard: $dashboard}';
}
