import 'package:get_it/get_it.dart';
import 'package:money_flow/features/sms_import/data/datasources/sms_datasource.dart';
import 'package:money_flow/features/sms_import/data/datasources/sms_real_datasource_impl.dart';
import 'package:money_flow/features/sms_import/data/repositories/sms_repository_impl.dart';
import 'package:money_flow/features/sms_import/domain/repositories/sms_repository.dart';
import 'package:money_flow/features/sms_import/domain/usecases/check_sms_permission_usecase.dart';
import 'package:money_flow/features/sms_import/domain/usecases/get_sms_conversations_usecase.dart';
import 'package:money_flow/features/sms_import/domain/usecases/get_sms_messages_by_address_usecase.dart';
import 'package:money_flow/features/sms_import/domain/usecases/request_sms_permission_usecase.dart';

/// Dependency injection setup for SMS Import feature.
/// This function registers all SMS Import related dependencies
/// in the GetIt service locator following Clean Architecture principles.
///
/// The function organizes dependencies by layer:
/// - Data sources (platform-specific implementations)
/// - Repositories (data layer implementations)
/// - Use cases (domain layer business logic)
///
/// Usage Example:
/// ```dart
/// await setupSmsImportLocator(getIt);
/// ```
Future<void> setupSmsImportLocator(GetIt getIt) async {
  // ==================== DATA SOURCES ====================

  /// SMS data source implementation for platform-specific SMS access.
  /// This data source handles the actual SMS operations using the telephony package.
  ///
  /// Registration: Lazy singleton to ensure single instance and lazy initialization.
  /// This is appropriate for data sources as they don't maintain state
  /// and can be shared across the application.
  getIt.registerLazySingleton<SmsDataSource>(() => SmsRealDataSourceImpl());

  // ==================== REPOSITORIES ====================

  /// SMS repository implementation for data access operations.
  /// This repository acts as a bridge between domain and data layers,
  /// providing a clean abstraction over SMS data access.
  ///
  /// Registration: Lazy singleton to ensure single instance and lazy initialization.
  /// This is appropriate for repositories as they don't maintain state
  /// and can be shared across the application.
  getIt.registerLazySingleton<SmsRepository>(
    () => SmsRepositoryImpl(getIt<SmsDataSource>()),
  );

  // ==================== USE CASES ====================

  /// Use case for getting SMS conversations.
  /// This use case handles the business logic for retrieving SMS conversations
  /// grouped by sender address with preview information.
  ///
  /// Registration: Lazy singleton to ensure single instance and lazy initialization.
  /// This is appropriate for use cases as they don't maintain state
  /// and can be shared across the application.
  getIt.registerLazySingleton<GetSmsConversationsUseCase>(
    () => GetSmsConversationsUseCase(getIt<SmsRepository>()),
  );

  /// Use case for getting SMS messages by address.
  /// This use case handles the business logic for retrieving SMS messages
  /// from a specific sender address in chronological order.
  ///
  /// Registration: Lazy singleton to ensure single instance and lazy initialization.
  /// This is appropriate for use cases as they don't maintain state
  /// and can be shared across the application.
  getIt.registerLazySingleton<GetSmsMessagesByAddressUseCase>(
    () => GetSmsMessagesByAddressUseCase(getIt<SmsRepository>()),
  );

  /// Use case for checking SMS permission.
  /// This use case handles the business logic for verifying SMS read permission
  /// status without requesting permission from the user.
  ///
  /// Registration: Lazy singleton to ensure single instance and lazy initialization.
  /// This is appropriate for use cases as they don't maintain state
  /// and can be shared across the application.
  getIt.registerLazySingleton<CheckSmsPermissionUseCase>(
    () => CheckSmsPermissionUseCase(getIt<SmsRepository>()),
  );

  /// Use case for requesting SMS permission.
  /// This use case handles the business logic for requesting SMS read permission
  /// from the user, showing the system permission dialog.
  ///
  /// Registration: Lazy singleton to ensure single instance and lazy initialization.
  /// This is appropriate for use cases as they don't maintain state
  /// and can be shared across the application.
  getIt.registerLazySingleton<RequestSmsPermissionUseCase>(
    () => RequestSmsPermissionUseCase(getIt<SmsRepository>()),
  );
}
