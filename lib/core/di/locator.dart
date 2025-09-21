import 'package:get_it/get_it.dart';
import 'package:money_flow/features/dashboard/di/dashboard_di.dart';
import 'package:money_flow/features/transactions/di/transaction_di.dart';

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
  // Initialize dashboard feature dependencies
  await setupDashboardLocator(getIt);

  // Initialize transaction feature dependencies
  await setupTransactionLocator(getIt);

  // TODO: Add other feature DI setups as they are implemented
  // await setupAuthLocator(getIt);
  // await setupAnalyticsLocator(getIt);
  // await setupSettingsLocator(getIt);
}
