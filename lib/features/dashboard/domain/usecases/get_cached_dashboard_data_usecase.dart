import 'package:dartz/dartz.dart';
import 'package:money_flow/core/error/failures.dart';
import 'package:money_flow/features/dashboard/domain/entities/dashboard_entity.dart';
import 'package:money_flow/features/dashboard/domain/repositories/dashboard_repository.dart';

/// Use case for retrieving cached dashboard data for offline access.
/// This use case handles the business logic for fetching cached dashboard information.
///
/// Usage Example:
/// ```dart
/// final getCachedDashboardDataUseCase = GetCachedDashboardDataUseCase(
///   repository: dashboardRepository,
/// );
///
/// final result = await getCachedDashboardDataUseCase.call('user123');
/// result.fold(
///   (failure) => handleError(failure),
///   (dashboard) => updateUI(dashboard),
/// );
/// ```
class GetCachedDashboardDataUseCase {
  /// Repository for dashboard data operations
  final DashboardRepository repository;

  /// Creates a new instance of GetCachedDashboardDataUseCase.
  ///
  /// Parameters:
  /// - [repository]: Dashboard repository for data operations
  ///
  /// Usage Example:
  /// ```dart
  /// final useCase = GetCachedDashboardDataUseCase(
  ///   repository: getIt<DashboardRepository>(),
  /// );
  /// ```
  const GetCachedDashboardDataUseCase({required this.repository});

  /// Executes the use case to retrieve cached dashboard data.
  /// This method handles the business logic for fetching cached dashboard information.
  ///
  /// Parameters:
  /// - [params]: Parameters containing user ID for data retrieval
  ///
  /// Returns:
  /// - [Either<Failure, DashboardEntity>]: Either a failure or cached dashboard data
  ///
  /// Usage Example:
  /// ```dart
  /// final params = GetCachedDashboardDataParams(userId: 'user123');
  /// final result = await getCachedDashboardDataUseCase.call(params);
  ///
  /// result.fold(
  ///   (failure) => print('Error: ${failure.message}'),
  ///   (dashboard) => print('Cached Income: \$${dashboard.totalIncome}'),
  /// );
  /// ```
  Future<Either<Failure, DashboardEntity>> call(
    GetCachedDashboardDataParams params,
  ) async {
    // Validate input parameters
    if (params.userId.isEmpty) {
      return const Left(ValidationFailure('User ID cannot be empty'));
    }

    try {
      // Get cached dashboard data from repository
      final result = await repository.getCachedDashboardData(params.userId);

      return result;
    } catch (e) {
      // Handle unexpected errors
      return Left(ServerFailure('Failed to get cached dashboard data: $e'));
    }
  }
}

/// Parameters for the GetCachedDashboardDataUseCase.
/// This class encapsulates the input parameters required for the use case.
///
/// Usage Example:
/// ```dart
/// final params = GetCachedDashboardDataParams(userId: 'user123');
/// final result = await useCase.call(params);
/// ```
class GetCachedDashboardDataParams {
  /// Unique identifier for the user
  final String userId;

  /// Creates a new instance of GetCachedDashboardDataParams.
  ///
  /// Parameters:
  /// - [userId]: Unique identifier for the user
  ///
  /// Usage Example:
  /// ```dart
  /// final params = GetCachedDashboardDataParams(userId: 'user123');
  /// ```
  const GetCachedDashboardDataParams({required this.userId});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GetCachedDashboardDataParams &&
          runtimeType == other.runtimeType &&
          userId == other.userId;

  @override
  int get hashCode => userId.hashCode;

  @override
  String toString() => 'GetCachedDashboardDataParams{userId: $userId}';
}
