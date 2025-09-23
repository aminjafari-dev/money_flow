import 'package:dartz/dartz.dart';
import 'package:money_flow/core/error/exceptions.dart';
import 'package:money_flow/core/error/failures.dart';
import 'package:money_flow/features/dashboard/data/datasources/local/dashboard_local_datasource.dart';
import 'package:money_flow/features/dashboard/domain/entities/dashboard_entity.dart';
import 'package:money_flow/features/dashboard/domain/repositories/dashboard_repository.dart';

/// Repository implementation for dashboard data operations.
/// This class handles all dashboard-related data operations using local storage only.
///
/// Usage Example:
/// ```dart
/// final repository = DashboardRepositoryImpl(
///   localDataSource: localDataSource,
/// );
///
/// final result = await repository.getDashboardData('user123');
/// result.fold(
///   (failure) => handleError(failure),
///   (dashboard) => updateUI(dashboard),
/// );
/// ```
class DashboardRepositoryImpl implements DashboardRepository {
  /// Local data source for dashboard data operations
  final DashboardLocalDataSource localDataSource;

  /// Creates a new instance of DashboardRepositoryImpl.
  ///
  /// Parameters:
  /// - [localDataSource]: Local data source for dashboard operations
  ///
  /// Usage Example:
  /// ```dart
  /// final repository = DashboardRepositoryImpl(
  ///   localDataSource: getIt<DashboardLocalDataSource>(),
  /// );
  /// ```
  const DashboardRepositoryImpl({required this.localDataSource});

  /// Retrieves dashboard data for a specific user from local storage.
  /// This method gets the most recent dashboard data cached locally.
  ///
  /// Parameters:
  /// - [userId]: Unique identifier for the user
  ///
  /// Returns:
  /// - [Either<Failure, DashboardEntity>]: Either a failure or dashboard data
  ///
  /// Usage Example:
  /// ```dart
  /// final result = await repository.getDashboardData('user123');
  /// result.fold(
  ///   (failure) => print('Error: ${failure.message}'),
  ///   (dashboard) => print('Income: \$${dashboard.totalIncome}'),
  /// );
  /// ```
  @override
  Future<Either<Failure, DashboardEntity>> getDashboardData(
    String userId,
  ) async {
    try {
      // Get dashboard data from local storage
      final dashboardModel = await localDataSource.getCachedDashboardData(
        userId,
      );

      if (dashboardModel == null) {
        // If no cached dashboard exists, create empty dashboard
        return Right(_createEmptyDashboard());
      }

      // Convert model to domain entity
      final dashboardEntity = dashboardModel.toDomain();
      return Right(dashboardEntity);
    } on CacheException catch (e) {
      // Handle cache-specific errors
      return Left(CacheFailure(e.message));
    } catch (e) {
      // Handle unexpected errors
      return Left(ServerFailure('Unexpected error: $e'));
    }
  }

  /// Creates an empty dashboard entity for new users.
  /// This method provides default values when no data exists.
  ///
  /// Returns:
  /// - [DashboardEntity]: Empty dashboard with zero values
  ///
  /// Usage Example:
  /// ```dart
  /// final emptyDashboard = _createEmptyDashboard();
  /// // All values will be 0.0 and recentTransactions will be empty
  /// ```
  DashboardEntity _createEmptyDashboard() {
    return const DashboardEntity(
      totalIncome: 0.0,
      totalExpenses: 0.0,
      totalCharity: 0.0,
      totalInvestments: 0.0,
      recentTransactions: [],
    );
  }
}
