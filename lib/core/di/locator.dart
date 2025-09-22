import 'package:get_it/get_it.dart';
import 'package:money_flow/core/services/category_service.dart';
import 'package:money_flow/core/services/category_initialization_service.dart';
import 'package:money_flow/features/dashboard/di/dashboard_di.dart';
import 'package:money_flow/features/add_transaction/di/transaction_di.dart';

/// Global service locator instance.
/// This instance manages all dependency injection throughout the app.
///
/// Usage Example:
/// ```dart
/// final dashboardBloc = getIt<DashboardBloc>();
/// ```
final GetIt getIt = GetIt.instance;

/// Sets up all dependencies for the application.
/// This function initializes all feature-specific DI modules.
///
/// Usage Example:
/// ```dart
/// await setupLocator();
/// ```
Future<void> setupLocator() async {
  // Core services - Register CategoryService first
  getIt.registerLazySingleton<CategoryService>(() => CategoryService());

  // Register category initialization service
  getIt.registerLazySingleton<CategoryInitializationService>(
    () => CategoryInitializationService(getIt<CategoryService>()),
  );

  // Initialize dashboard feature dependencies
  await setupDashboardLocator(getIt);

  // Initialize transaction feature dependencies
  await setupTransactionLocator(getIt);

  // Initialize category system
  final categoryInitService = getIt<CategoryInitializationService>();
  await categoryInitService.initialize();

  // TODO: Add other feature DI setups as they are implemented
  // await setupAuthLocator(getIt);
  // await setupAnalyticsLocator(getIt);
  // await setupSettingsLocator(getIt);
}
