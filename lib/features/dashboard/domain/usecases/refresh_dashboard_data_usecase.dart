import 'package:dartz/dartz.dart';
import 'package:money_flow/core/error/failures.dart';
import 'package:money_flow/features/dashboard/domain/entities/dashboard_entity.dart';
import 'package:money_flow/features/dashboard/domain/repositories/dashboard_repository.dart';

/// Use case for refreshing dashboard data by recalculating from stored transactions.
/// This use case handles the business logic for refreshing dashboard information.
///
/// Usage Example:
/// ```dart
/// final refreshDashboardDataUseCase = RefreshDashboardDataUseCase(
///   repository: dashboardRepository,
/// );
///
/// final result = await refreshDashboardDataUseCase.call('user123');
/// result.fold(
///   (failure) => handleError(failure),
///   (dashboard) => updateUI(dashboard),
/// );
/// ```
class RefreshDashboardDataUseCase {
  /// Repository for dashboard data operations
  final DashboardRepository repository;

  /// Creates a new instance of RefreshDashboardDataUseCase.
  ///
  /// Parameters:
  /// - [repository]: Dashboard repository for data operations
  ///
  /// Usage Example:
  /// ```dart
  /// final useCase = RefreshDashboardDataUseCase(
  ///   repository: getIt<DashboardRepository>(),
  /// );
  /// ```
  const RefreshDashboardDataUseCase({required this.repository});

  /// Executes the use case to refresh dashboard data.
  /// This method handles the business logic for refreshing dashboard information.
  ///
  /// Parameters:
  /// - [params]: Parameters containing user ID for data refresh
  ///
  /// Returns:
  /// - [Either<Failure, DashboardEntity>]: Either a failure or refreshed dashboard data
  ///
  /// Usage Example:
  /// ```dart
  /// final params = RefreshDashboardDataParams(userId: 'user123');
  /// final result = await refreshDashboardDataUseCase.call(params);
  ///
  /// result.fold(
  ///   (failure) => print('Error: ${failure.message}'),
  ///   (dashboard) => print('Refreshed Income: \$${dashboard.totalIncome}'),
  /// );
  /// ```
  Future<Either<Failure, DashboardEntity>> call(
    RefreshDashboardDataParams params,
  ) async {
    // Validate input parameters
    if (params.userId.isEmpty) {
      return const Left(ValidationFailure('User ID cannot be empty'));
    }

    try {
      // Refresh dashboard data from repository
      final result = await repository.refreshDashboardData(params.userId);

      return result;
    } catch (e) {
      // Handle unexpected errors
      return Left(ServerFailure('Failed to refresh dashboard data: $e'));
    }
  }
}

/// Parameters for the RefreshDashboardDataUseCase.
/// This class encapsulates the input parameters required for the use case.
///
/// Usage Example:
/// ```dart
/// final params = RefreshDashboardDataParams(userId: 'user123');
/// final result = await useCase.call(params);
/// ```
class RefreshDashboardDataParams {
  /// Unique identifier for the user
  final String userId;

  /// Creates a new instance of RefreshDashboardDataParams.
  ///
  /// Parameters:
  /// - [userId]: Unique identifier for the user
  ///
  /// Usage Example:
  /// ```dart
  /// final params = RefreshDashboardDataParams(userId: 'user123');
  /// ```
  const RefreshDashboardDataParams({required this.userId});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RefreshDashboardDataParams &&
          runtimeType == other.runtimeType &&
          userId == other.userId;

  @override
  int get hashCode => userId.hashCode;

  @override
  String toString() => 'RefreshDashboardDataParams{userId: $userId}';
}
