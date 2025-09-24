import 'package:dartz/dartz.dart';
import 'package:money_flow/core/error/failures.dart';
import 'package:money_flow/features/dashboard/domain/entities/dashboard_entity.dart';
import 'package:money_flow/features/dashboard/domain/repositories/dashboard_repository.dart';

/// Use case for retrieving dashboard data for a specific user.
/// This use case handles the business logic for fetching dashboard information.
///
/// Usage Example:
/// ```dart
/// final getDashboardDataUseCase = GetDashboardDataUseCase(
///   repository: dashboardRepository,
/// );
///
/// final result = await getDashboardDataUseCase.call('user123');
/// result.fold(
///   (failure) => handleError(failure),
///   (dashboard) => updateUI(dashboard),
/// );
/// ```
class GetDashboardDataUseCase {
  /// Repository for dashboard data operations
  final DashboardRepository repository;

  /// Creates a new instance of GetDashboardDataUseCase.
  ///
  /// Parameters:
  /// - [repository]: Dashboard repository for data operations
  ///
  /// Usage Example:
  /// ```dart
  /// final useCase = GetDashboardDataUseCase(
  ///   repository: getIt<DashboardRepository>(),
  /// );
  /// ```
  const GetDashboardDataUseCase({required this.repository});

  /// Executes the use case to retrieve dashboard data.
  /// This method handles the business logic for fetching dashboard information.
  ///
  /// Parameters:
  /// - [params]: Parameters containing user ID and time period for data retrieval
  ///
  /// Returns:
  /// - [Either<Failure, DashboardEntity>]: Either a failure or dashboard data
  ///
  /// Usage Example:
  /// ```dart
  /// final params = GetDashboardDataParams(userId: 'user123', timePeriod: 'weekly');
  /// final result = await getDashboardDataUseCase.call(params);
  ///
  /// result.fold(
  ///   (failure) => print('Error: ${failure.message}'),
  ///   (dashboard) => print('Income: \$${dashboard.totalIncome}'),
  /// );
  /// ```
  Future<Either<Failure, DashboardEntity>> call(
    GetDashboardDataParams params,
  ) async {
    // Validate input parameters
    if (params.userId.isEmpty) {
      return const Left(ValidationFailure('User ID cannot be empty'));
    }

    try {
      // Get dashboard data from repository
      final result = await repository.getDashboardData(
        params.userId,
        params.timePeriod,
      );

      return result;
    } catch (e) {
      // Handle unexpected errors
      return Left(ServerFailure('Failed to get dashboard data: $e'));
    }
  }
}

/// Parameters for the GetDashboardDataUseCase.
/// This class encapsulates the input parameters required for the use case.
///
/// Usage Example:
/// ```dart
/// final params = GetDashboardDataParams(userId: 'user123', timePeriod: 'weekly');
/// final result = await useCase.call(params);
/// ```
class GetDashboardDataParams {
  /// Unique identifier for the user
  final String userId;

  /// Time period for data calculation ('weekly', 'monthly', 'yearly', or 'all')
  final String timePeriod;

  /// Creates a new instance of GetDashboardDataParams.
  ///
  /// Parameters:
  /// - [userId]: Unique identifier for the user
  /// - [timePeriod]: Time period for data calculation
  ///
  /// Usage Example:
  /// ```dart
  /// final params = GetDashboardDataParams(userId: 'user123', timePeriod: 'weekly');
  /// ```
  const GetDashboardDataParams({
    required this.userId,
    required this.timePeriod,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GetDashboardDataParams &&
          runtimeType == other.runtimeType &&
          userId == other.userId &&
          timePeriod == other.timePeriod;

  @override
  int get hashCode => userId.hashCode ^ timePeriod.hashCode;

  @override
  String toString() =>
      'GetDashboardDataParams{userId: $userId, timePeriod: $timePeriod}';
}
