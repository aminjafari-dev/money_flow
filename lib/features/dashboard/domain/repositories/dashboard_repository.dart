import 'package:dartz/dartz.dart';
import 'package:money_flow/core/error/failures.dart';
import 'package:money_flow/features/dashboard/domain/entities/dashboard_entity.dart';

/// Abstract repository interface for dashboard data operations.
/// This defines the contract that data layer implementations must follow.
///
/// Usage Example:
/// ```dart
/// class DashboardRepositoryImpl implements DashboardRepository {
///   @override
///   Future<Either<Failure, DashboardEntity>> getDashboardData(String userId) async {
///     // Implementation details...
///   }
/// }
/// ```
abstract class DashboardRepository {
  /// Retrieves dashboard data for a specific user.
  ///
  /// This method fetches comprehensive financial overview including:
  /// - Total income, expenses, charity, and investments
  /// - Recent transactions list
  /// - Calculated metrics like net worth and spending patterns
  ///
  /// Parameters:
  /// - [userId]: Unique identifier for the user
  ///
  /// Returns:
  /// - [Either<Failure, DashboardEntity>]: Either a failure or dashboard data
  ///
  /// Usage Example:
  /// ```dart
  /// final result = await dashboardRepository.getDashboardData('user123');
  /// result.fold(
  ///   (failure) => print('Error: ${failure.message}'),
  ///   (dashboard) => print('Income: \$${dashboard.totalIncome}'),
  /// );
  /// ```
  Future<Either<Failure, DashboardEntity>> getDashboardData(String userId);

  /// Refreshes dashboard data by fetching latest information.
  ///
  /// This method forces a fresh data fetch, bypassing any cached data.
  /// It's useful when user explicitly requests an update or when
  /// critical data changes are detected.
  ///
  /// Parameters:
  /// - [userId]: Unique identifier for the user
  ///
  /// Returns:
  /// - [Either<Failure, DashboardEntity>]: Either a failure or fresh dashboard data
  ///
  /// Usage Example:
  /// ```dart
  /// final result = await dashboardRepository.refreshDashboardData('user123');
  /// result.fold(
  ///   (failure) => handleError(failure),
  ///   (dashboard) => updateUI(dashboard),
  /// );
  /// ```
  Future<Either<Failure, DashboardEntity>> refreshDashboardData(String userId);

  /// Gets cached dashboard data for offline access.
  ///
  /// This method retrieves previously cached dashboard data when
  /// network is unavailable. It ensures the app remains functional
  /// even without internet connection.
  ///
  /// Parameters:
  /// - [userId]: Unique identifier for the user
  ///
  /// Returns:
  /// - [Either<Failure, DashboardEntity>]: Either a failure or cached dashboard data
  ///
  /// Usage Example:
  /// ```dart
  /// final result = await dashboardRepository.getCachedDashboardData('user123');
  /// if (result.isRight()) {
  ///   // Use cached data for offline functionality
  ///   final dashboard = result.getOrElse(() => throw Exception());
  /// }
  /// ```
  Future<Either<Failure, DashboardEntity>> getCachedDashboardData(
    String userId,
  );

  /// Updates dashboard data with new information.
  ///
  /// This method is used when user makes changes that affect
  /// dashboard calculations (e.g., adding new transactions).
  /// It ensures data consistency across the application.
  ///
  /// Parameters:
  /// - [userId]: Unique identifier for the user
  /// - [dashboard]: Updated dashboard data to save
  ///
  /// Returns:
  /// - [Either<Failure, Unit>]: Either a failure or success indication
  ///
  /// Usage Example:
  /// ```dart
  /// final result = await dashboardRepository.updateDashboardData('user123', updatedDashboard);
  /// result.fold(
  ///   (failure) => showErrorMessage(failure.message),
  ///   (_) => showSuccessMessage('Dashboard updated successfully'),
  /// );
  /// ```
  Future<Either<Failure, Unit>> updateDashboardData(
    String userId,
    DashboardEntity dashboard,
  );
}
