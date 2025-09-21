import 'package:get_it/get_it.dart';
import 'package:money_flow/features/dashboard/data/datasources/local/dashboard_local_datasource.dart';
import 'package:money_flow/features/dashboard/data/repositories/dashboard_repository_impl.dart';
import 'package:money_flow/features/dashboard/domain/repositories/dashboard_repository.dart';
import 'package:money_flow/features/dashboard/domain/usecases/get_cached_dashboard_data_usecase.dart';
import 'package:money_flow/features/dashboard/domain/usecases/get_dashboard_data_usecase.dart';
import 'package:money_flow/features/dashboard/domain/usecases/refresh_dashboard_data_usecase.dart';
import 'package:money_flow/features/dashboard/domain/usecases/update_dashboard_data_usecase.dart';
import 'package:money_flow/features/dashboard/presentation/bloc/dashboard_bloc.dart';

/// Dependency injection setup for the Dashboard feature.
/// This file registers all dashboard-related dependencies with the GetIt locator.
///
/// Usage Example:
/// ```dart
/// // Setup dashboard dependencies
/// await setupDashboardLocator(getIt);
///
/// // Get dashboard bloc
/// final dashboardBloc = getIt<DashboardBloc>();
/// ```
Future<void> setupDashboardLocator(GetIt getIt) async {
  // Data Sources
  // Register local data source as lazy singleton to ensure single instance
  // This is useful for maintaining consistent local storage state
  getIt.registerLazySingleton<DashboardLocalDataSource>(
    () => DashboardLocalDataSource(),
  );

  // Initialize the local data source
  // This ensures Hive boxes are properly set up before use
  final localDataSource = getIt<DashboardLocalDataSource>();
  await localDataSource.initialize();

  // Repository
  // Register repository implementation as lazy singleton
  // This ensures consistent data access across the application
  getIt.registerLazySingleton<DashboardRepository>(
    () => DashboardRepositoryImpl(
      localDataSource: getIt<DashboardLocalDataSource>(),
    ),
  );

  // Use Cases
  // Register use cases as lazy singletons for consistent business logic
  // This ensures the same use case instance is used throughout the app

  // Get dashboard data use case
  getIt.registerLazySingleton<GetDashboardDataUseCase>(
    () => GetDashboardDataUseCase(repository: getIt<DashboardRepository>()),
  );

  // Refresh dashboard data use case
  getIt.registerLazySingleton<RefreshDashboardDataUseCase>(
    () => RefreshDashboardDataUseCase(repository: getIt<DashboardRepository>()),
  );

  // Get cached dashboard data use case
  getIt.registerLazySingleton<GetCachedDashboardDataUseCase>(
    () =>
        GetCachedDashboardDataUseCase(repository: getIt<DashboardRepository>()),
  );

  // Update dashboard data use case
  getIt.registerLazySingleton<UpdateDashboardDataUseCase>(
    () => UpdateDashboardDataUseCase(repository: getIt<DashboardRepository>()),
  );

  // BLoC
  // Register BLoC as singleton to maintain state across widget rebuilds
  // This is important for preserving dashboard state during navigation
  getIt.registerSingleton<DashboardBloc>(
    DashboardBloc(
      getDashboardDataUseCase: getIt<GetDashboardDataUseCase>(),
      refreshDashboardDataUseCase: getIt<RefreshDashboardDataUseCase>(),
      getCachedDashboardDataUseCase: getIt<GetCachedDashboardDataUseCase>(),
      updateDashboardDataUseCase: getIt<UpdateDashboardDataUseCase>(),
    ),
  );
}

/// Disposes of dashboard-related dependencies.
/// This method cleans up resources when the dashboard feature is no longer needed.
///
/// Usage Example:
/// ```dart
/// // Clean up dashboard resources
/// await disposeDashboardLocator(getIt);
/// ```
Future<void> disposeDashboardLocator(GetIt getIt) async {
  // Dispose of local data source
  if (getIt.isRegistered<DashboardLocalDataSource>()) {
    final localDataSource = getIt<DashboardLocalDataSource>();
    await localDataSource.dispose();
  }

  // Unregister all dashboard dependencies
  if (getIt.isRegistered<DashboardBloc>()) {
    getIt.unregister<DashboardBloc>();
  }

  if (getIt.isRegistered<UpdateDashboardDataUseCase>()) {
    getIt.unregister<UpdateDashboardDataUseCase>();
  }

  if (getIt.isRegistered<GetCachedDashboardDataUseCase>()) {
    getIt.unregister<GetCachedDashboardDataUseCase>();
  }

  if (getIt.isRegistered<RefreshDashboardDataUseCase>()) {
    getIt.unregister<RefreshDashboardDataUseCase>();
  }

  if (getIt.isRegistered<GetDashboardDataUseCase>()) {
    getIt.unregister<GetDashboardDataUseCase>();
  }

  if (getIt.isRegistered<DashboardRepository>()) {
    getIt.unregister<DashboardRepository>();
  }

  if (getIt.isRegistered<DashboardLocalDataSource>()) {
    getIt.unregister<DashboardLocalDataSource>();
  }
}
