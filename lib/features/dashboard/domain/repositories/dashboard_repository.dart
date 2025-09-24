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
  /// Retrieves dashboard data for a specific user and time period.
  ///
  /// This method fetches comprehensive financial overview including:
  /// - Total income, expenses, charity, and investments
  /// - Recent transactions list
  ///
  /// Parameters:
  /// - [userId]: Unique identifier for the user
  /// - [timePeriod]: Time period for data calculation ('weekly', 'monthly', 'yearly', or 'all')
  ///
  /// Returns:
  /// - [Either<Failure, DashboardEntity>]: Either a failure or dashboard data
  ///
  /// Usage Example:
  /// ```dart
  /// final result = await dashboardRepository.getDashboardData('user123', 'weekly');
  /// result.fold(
  ///   (failure) => print('Error: ${failure.message}'),
  ///   (dashboard) => print('Income: \$${dashboard.totalIncome}'),
  /// );
  /// ```
  Future<Either<Failure, DashboardEntity>> getDashboardData(
    String userId,
    String timePeriod,
  );
}
