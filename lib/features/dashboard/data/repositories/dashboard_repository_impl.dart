import 'package:dartz/dartz.dart';
import 'package:money_flow/core/error/exceptions.dart';
import 'package:money_flow/core/error/failures.dart';
import 'package:money_flow/features/dashboard/data/datasources/local/dashboard_local_datasource.dart';
import 'package:money_flow/features/dashboard/data/models/dashboard_model.dart';
import 'package:money_flow/features/dashboard/domain/entities/dashboard_entity.dart';
import 'package:money_flow/features/dashboard/domain/repositories/dashboard_repository.dart';

import '../../../../shared/models/transaction_model.dart';

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
        // Return empty dashboard if no data exists
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

  /// Refreshes dashboard data by recalculating from stored transactions.
  /// Since this is an offline app, "refresh" means recalculating totals from local data.
  ///
  /// Parameters:
  /// - [userId]: Unique identifier for the user
  ///
  /// Returns:
  /// - [Either<Failure, DashboardEntity>]: Either a failure or refreshed dashboard data
  ///
  /// Usage Example:
  /// ```dart
  /// final result = await repository.refreshDashboardData('user123');
  /// result.fold(
  ///   (failure) => handleError(failure),
  ///   (dashboard) => updateUI(dashboard),
  /// );
  /// ```
  @override
  Future<Either<Failure, DashboardEntity>> refreshDashboardData(
    String userId,
  ) async {
    try {
      // Get recent transactions to recalculate dashboard data
      final recentTransactions = await localDataSource.getRecentTransactions(
        userId,
        limit: 50,
      );

      // Calculate totals from transactions
      final calculatedTotals = _calculateTotalsFromTransactions(
        recentTransactions,
      );

      // Create updated dashboard model
      final updatedDashboard = DashboardModel(
        totalIncome: calculatedTotals['income'] ?? 0.0,
        totalExpenses: calculatedTotals['expenses'] ?? 0.0,
        totalCharity: calculatedTotals['charity'] ?? 0.0,
        totalInvestments: calculatedTotals['investments'] ?? 0.0,
        recentTransactions: recentTransactions,
      );

      // Cache the updated dashboard data
      await localDataSource.cacheDashboardData(userId, updatedDashboard);

      // Convert to domain entity and return
      final dashboardEntity = updatedDashboard.toDomain();
      return Right(dashboardEntity);
    } on CacheException catch (e) {
      // Handle cache-specific errors
      return Left(CacheFailure(e.message));
    } catch (e) {
      // Handle unexpected errors
      return Left(ServerFailure('Failed to refresh dashboard data: $e'));
    }
  }

  /// Gets cached dashboard data for offline access.
  /// This method is the same as getDashboardData since we're offline-only.
  ///
  /// Parameters:
  /// - [userId]: Unique identifier for the user
  ///
  /// Returns:
  /// - [Either<Failure, DashboardEntity>]: Either a failure or cached dashboard data
  ///
  /// Usage Example:
  /// ```dart
  /// final result = await repository.getCachedDashboardData('user123');
  /// if (result.isRight()) {
  ///   // Use cached data for offline functionality
  ///   final dashboard = result.getOrElse(() => throw Exception());
  /// }
  /// ```
  @override
  Future<Either<Failure, DashboardEntity>> getCachedDashboardData(
    String userId,
  ) async {
    // Since we're offline-only, this is the same as getDashboardData
    return await getDashboardData(userId);
  }

  /// Updates dashboard data with new information.
  /// This method saves updated dashboard data to local storage.
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
  /// final result = await repository.updateDashboardData('user123', updatedDashboard);
  /// result.fold(
  ///   (failure) => showErrorMessage(failure.message),
  ///   (_) => showSuccessMessage('Dashboard updated successfully'),
  /// );
  /// ```
  @override
  Future<Either<Failure, Unit>> updateDashboardData(
    String userId,
    DashboardEntity dashboard,
  ) async {
    try {
      // Convert entity to model
      final dashboardModel = DashboardModel.fromEntity(dashboard);

      // Update data in local storage
      await localDataSource.updateDashboardData(userId, dashboardModel);

      return const Right(unit);
    } on CacheException catch (e) {
      // Handle cache-specific errors
      return Left(CacheFailure(e.message));
    } catch (e) {
      // Handle unexpected errors
      return Left(ServerFailure('Failed to update dashboard data: $e'));
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

  /// Calculates financial totals from a list of transactions.
  /// This method processes transactions and sums them by category.
  ///
  /// Parameters:
  /// - [transactions]: List of transaction models to process
  ///
  /// Returns:
  /// - [Map<String, double>]: Map with category totals
  ///
  /// Usage Example:
  /// ```dart
  /// final totals = _calculateTotalsFromTransactions(transactions);
  /// final income = totals['income'] ?? 0.0;
  /// final expenses = totals['expenses'] ?? 0.0;
  /// ```
  Map<String, double> _calculateTotalsFromTransactions(
    List<TransactionModel> transactions,
  ) {
    double income = 0.0;
    double expenses = 0.0;
    double charity = 0.0;
    double investments = 0.0;

    // Process each transaction and categorize
    for (final transaction in transactions) {
      final amount = transaction.amount;
      final category = transaction.category.toLowerCase();

      if (amount > 0) {
        // Positive amounts are income
        income += amount;
      } else {
        // Negative amounts are expenses, categorize by type
        final absAmount = amount.abs();

        if (category.contains('charity') || category.contains('donation')) {
          charity += absAmount;
        } else if (category.contains('investment') ||
            category.contains('saving')) {
          investments += absAmount;
        } else {
          expenses += absAmount;
        }
      }
    }

    return {
      'income': income,
      'expenses': expenses,
      'charity': charity,
      'investments': investments,
    };
  }

  /// Clears all dashboard data for a user.
  /// This method is useful for data cleanup or user logout scenarios.
  ///
  /// Parameters:
  /// - [userId]: Unique identifier for the user
  ///
  /// Returns:
  /// - [Either<Failure, Unit>]: Either a failure or success indication
  ///
  /// Usage Example:
  /// ```dart
  /// final result = await repository.clearDashboardData('user123');
  /// result.fold(
  ///   (failure) => handleError(failure),
  ///   (_) => showSuccessMessage('Data cleared successfully'),
  /// );
  /// ```
  Future<Either<Failure, Unit>> clearDashboardData(String userId) async {
    try {
      // Clear all cached data for the user
      await localDataSource.clearCachedData(userId);

      return const Right(unit);
    } on CacheException catch (e) {
      // Handle cache-specific errors
      return Left(CacheFailure(e.message));
    } catch (e) {
      // Handle unexpected errors
      return Left(ServerFailure('Failed to clear dashboard data: $e'));
    }
  }
}
