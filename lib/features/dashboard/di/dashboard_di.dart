import 'package:get_it/get_it.dart';
import 'package:money_flow/features/dashboard/data/datasources/local/dashboard_local_datasource.dart';
import 'package:money_flow/features/dashboard/data/repositories/dashboard_repository_impl.dart';
import 'package:money_flow/features/dashboard/domain/repositories/dashboard_repository.dart';
import 'package:money_flow/features/dashboard/domain/usecases/get_dashboard_data_usecase.dart';
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

  // Initialize the local data source
  final localDataSource = getIt<DashboardLocalDataSource>();
  await localDataSource.initialize();

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

  // BLoCs
  getIt.registerSingleton<DashboardBloc>(
    DashboardBloc(getDashboardDataUseCase: getIt<GetDashboardDataUseCase>()),
  );
}
