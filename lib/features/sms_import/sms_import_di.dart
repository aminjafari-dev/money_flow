import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_flow/features/sms_import/data/models/sms_category_tracking_model.dart';
import 'package:money_flow/features/sms_import/data/datasources/sms_datasource.dart';
import 'package:money_flow/features/sms_import/data/datasources/sms_real_datasource_impl.dart';
import 'package:money_flow/features/sms_import/data/repositories/bank_repository_impl.dart';
import 'package:money_flow/features/sms_import/data/repositories/sms_repository_impl.dart';
import 'package:money_flow/features/sms_import/data/repositories/sms_category_tracking_repository_impl.dart';
import 'package:money_flow/features/sms_import/domain/repositories/bank_repository.dart';
import 'package:money_flow/features/sms_import/domain/repositories/sms_repository.dart';
import 'package:money_flow/features/sms_import/domain/repositories/sms_category_tracking_repository.dart';
import 'package:money_flow/features/sms_import/domain/usecases/check_sms_permission_usecase.dart';
import 'package:money_flow/features/sms_import/domain/usecases/delete_bank_usecase.dart';
import 'package:money_flow/features/sms_import/domain/usecases/get_all_banks_usecase.dart';
import 'package:money_flow/features/sms_import/domain/usecases/get_sms_conversations_usecase.dart';
import 'package:money_flow/features/sms_import/domain/usecases/get_sms_messages_by_address_usecase.dart';
import 'package:money_flow/features/sms_import/domain/usecases/request_sms_permission_usecase.dart';
import 'package:money_flow/features/sms_import/domain/usecases/save_bank_usecase.dart';
import 'package:money_flow/features/sms_import/domain/usecases/add_sms_to_category_usecase.dart';
import 'package:money_flow/features/sms_import/domain/usecases/get_sms_category_status_usecase.dart';
import 'package:money_flow/features/sms_import/domain/usecases/toggle_sms_category_usecase.dart';

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
  if (!Hive.isAdapterRegistered(4)) {
    Hive.registerAdapter(SmsCategoryTrackingModelAdapter());
  }

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

  /// Bank repository implementation for data access operations.
  /// This repository acts as a bridge between domain and data layers,
  /// providing a clean abstraction over bank data access using Hive.
  ///
  /// Registration: Lazy singleton to ensure single instance and lazy initialization.
  /// This is appropriate for repositories as they don't maintain state
  /// and can be shared across the application.
  getIt.registerLazySingleton<BankRepository>(() => BankRepositoryImpl());

  /// SMS category tracking repository implementation for data access operations.
  /// This repository acts as a bridge between domain and data layers,
  /// providing a clean abstraction over SMS category tracking data access using Hive.
  ///
  /// Registration: Lazy singleton to ensure single instance and lazy initialization.
  /// This is appropriate for repositories as they don't maintain state
  /// and can be shared across the application.
  getIt.registerLazySingleton<SmsCategoryTrackingRepository>(
    () => SmsCategoryTrackingRepositoryImpl(),
  );

  // Initialize the SMS category tracking repository
  final trackingRepository =
      getIt<SmsCategoryTrackingRepository>()
          as SmsCategoryTrackingRepositoryImpl;
  await trackingRepository.init();

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

  /// Use case for getting all banks.
  /// This use case handles the business logic for retrieving all saved banks
  /// from the repository.
  ///
  /// Registration: Lazy singleton to ensure single instance and lazy initialization.
  /// This is appropriate for use cases as they don't maintain state
  /// and can be shared across the application.
  getIt.registerLazySingleton<GetAllBanksUseCase>(
    () => GetAllBanksUseCase(getIt<BankRepository>()),
  );

  /// Use case for saving a bank.
  /// This use case handles the business logic for persisting a bank entity
  /// to the repository.
  ///
  /// Registration: Lazy singleton to ensure single instance and lazy initialization.
  /// This is appropriate for use cases as they don't maintain state
  /// and can be shared across the application.
  getIt.registerLazySingleton<SaveBankUseCase>(
    () => SaveBankUseCase(getIt<BankRepository>()),
  );

  /// Use case for deleting a bank.
  /// This use case handles the business logic for removing a bank
  /// from the repository.
  ///
  /// Registration: Lazy singleton to ensure single instance and lazy initialization.
  /// This is appropriate for use cases as they don't maintain state
  /// and can be shared across the application.
  getIt.registerLazySingleton<DeleteBankUseCase>(
    () => DeleteBankUseCase(getIt<BankRepository>()),
  );

  /// Use case for adding SMS to category.
  /// This use case handles the business logic for adding an SMS message
  /// to a specific transaction category and creating a transaction.
  ///
  /// Registration: Lazy singleton to ensure single instance and lazy initialization.
  /// This is appropriate for use cases as they don't maintain state
  /// and can be shared across the application.
  getIt.registerLazySingleton<AddSmsToCategoryUseCase>(
    () => AddSmsToCategoryUseCase(
      trackingRepository: getIt<SmsCategoryTrackingRepository>(),
      addTransactionUseCase: getIt(),
    ),
  );

  /// Use case for getting SMS category status.
  /// This use case handles the business logic for checking which categories
  /// an SMS message has been added to.
  ///
  /// Registration: Lazy singleton to ensure single instance and lazy initialization.
  /// This is appropriate for use cases as they don't maintain state
  /// and can be shared across the application.
  getIt.registerLazySingleton<GetSmsCategoryStatusUseCase>(
    () => GetSmsCategoryStatusUseCase(
      trackingRepository: getIt<SmsCategoryTrackingRepository>(),
    ),
  );

  /// Use case for toggling SMS category selection with single-selection behavior.
  /// This use case handles the business logic for single category selection
  /// where only one category can be selected at a time, and tapping the same
  /// category again will deselect it.
  ///
  /// Registration: Lazy singleton to ensure single instance and lazy initialization.
  /// This is appropriate for use cases as they don't maintain state
  /// and can be shared across the application.
  getIt.registerLazySingleton<ToggleSmsCategoryUseCase>(
    () => ToggleSmsCategoryUseCase(
      trackingRepository: getIt<SmsCategoryTrackingRepository>(),
      addSmsToCategoryUseCase: getIt<AddSmsToCategoryUseCase>(),
      deleteTransactionUseCase: getIt(),
    ),
  );
}
