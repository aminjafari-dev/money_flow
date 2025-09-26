import 'package:get_it/get_it.dart';
import 'package:money_flow/core/services/category_service.dart';
import 'package:money_flow/features/add_transaction/data/datasources/local/transaction_local_datasource.dart';
import 'package:money_flow/features/add_transaction/data/repositories/transaction_repository_impl.dart';
import 'package:money_flow/features/add_transaction/domain/repositories/transaction_repository.dart';
import 'package:money_flow/features/add_transaction/domain/usecases/add_transaction_usecase.dart';
import 'package:money_flow/features/add_transaction/domain/usecases/delete_transaction_usecase.dart';
import 'package:money_flow/features/add_transaction/presentation/bloc/add_transaction_bloc.dart';

/// Sets up all dependencies for the transactions feature.
/// This function initializes all transaction-related dependencies.
///
/// Parameters:
/// - [getIt]: The GetIt instance to register dependencies with
///
/// Usage Example:
/// ```dart
/// await setupTransactionLocator(getIt);
/// ```
Future<void> setupTransactionLocator(GetIt getIt) async {
  // Data sources
  // Register local data source as lazy singleton to ensure single instance
  // This is useful for maintaining consistent local storage state
  getIt.registerLazySingleton<TransactionLocalDataSource>(
    () => TransactionLocalDataSource(),
  );

  // Initialize the local data source
  // This ensures Hive boxes and adapters are properly set up before use
  final localDataSource = getIt<TransactionLocalDataSource>();
  await localDataSource.initialize();

  // Repositories
  // Register repository implementation as lazy singleton
  // This ensures consistent data access across the application
  getIt.registerLazySingleton<TransactionRepository>(
    () => TransactionRepositoryImpl(
      localDataSource: getIt<TransactionLocalDataSource>(),
      categoryService: getIt<CategoryService>(),
    ),
  );

  // Use cases
  // Register use cases as lazy singletons for consistent business logic
  // This ensures the same use case instance is used throughout the app

  // Add transaction use case
  getIt.registerLazySingleton<AddTransactionUseCase>(
    () => AddTransactionUseCase(repository: getIt<TransactionRepository>()),
  );

  // Delete transaction use case
  getIt.registerLazySingleton<DeleteTransactionUseCase>(
    () => DeleteTransactionUseCase(repository: getIt<TransactionRepository>()),
  );

  // BLoC
  // Register BLoC as singleton to maintain state across widget rebuilds
  // This is important for preserving transaction form state during navigation
  getIt.registerSingleton<AddTransactionBloc>(
    AddTransactionBloc(addTransactionUseCase: getIt<AddTransactionUseCase>()),
  );
}
