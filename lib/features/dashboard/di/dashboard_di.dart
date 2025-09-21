import 'package:get_it/get_it.dart';
import 'package:money_flow/features/dashboard/data/datasources/local/dashboard_local_datasource.dart';
import 'package:money_flow/features/dashboard/data/repositories/dashboard_repository_impl.dart';
import 'package:money_flow/features/dashboard/domain/repositories/dashboard_repository.dart';
import 'package:money_flow/features/dashboard/domain/usecases/get_cached_dashboard_data_usecase.dart';
import 'package:money_flow/features/dashboard/domain/usecases/get_dashboard_data_usecase.dart';
import 'package:money_flow/features/dashboard/domain/usecases/refresh_dashboard_data_usecase.dart';
import 'package:money_flow/features/dashboard/domain/usecases/update_dashboard_data_usecase.dart';
import 'package:money_flow/features/dashboard/presentation/bloc/dashboard_bloc.dart';

/// Dependency injection setup for dashboard feature.
/// This function registers all dashboard-related dependencies.
///
/// Usage Example:
/// ```dart
/// await setupDashboardLocator(getIt);
/// ```
Future<void> setupDashboardLocator(GetIt getIt) async {
  // Data sources
  getIt.registerLazySingleton<DashboardLocalDataSource>(
    () => DashboardLocalDataSource(),
  );

  // Repositories
  getIt.registerLazySingleton<DashboardRepository>(
    () => DashboardRepositoryImpl(
      localDataSource: getIt<DashboardLocalDataSource>(),
    ),
  );

  // Use cases
  getIt.registerLazySingleton<GetDashboardDataUseCase>(
    () => GetDashboardDataUseCase(repository: getIt<DashboardRepository>()),
  );

  getIt.registerLazySingleton<RefreshDashboardDataUseCase>(
    () => RefreshDashboardDataUseCase(repository: getIt<DashboardRepository>()),
  );

  getIt.registerLazySingleton<GetCachedDashboardDataUseCase>(
    () =>
        GetCachedDashboardDataUseCase(repository: getIt<DashboardRepository>()),
  );

  getIt.registerLazySingleton<UpdateDashboardDataUseCase>(
    () => UpdateDashboardDataUseCase(repository: getIt<DashboardRepository>()),
  );

  // BLoCs
  getIt.registerSingleton<DashboardBloc>(
    DashboardBloc(
      getDashboardDataUseCase: getIt<GetDashboardDataUseCase>(),
      refreshDashboardDataUseCase: getIt<RefreshDashboardDataUseCase>(),
      getCachedDashboardDataUseCase: getIt<GetCachedDashboardDataUseCase>(),
      updateDashboardDataUseCase: getIt<UpdateDashboardDataUseCase>(),
    ),
  );
}
