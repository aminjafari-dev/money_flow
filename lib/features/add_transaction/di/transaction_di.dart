import 'package:get_it/get_it.dart';
import 'package:money_flow/features/add_transaction/data/datasources/local/transaction_local_datasource.dart';
import 'package:money_flow/features/add_transaction/data/repositories/transaction_repository_impl.dart';
import 'package:money_flow/features/add_transaction/domain/repositories/transaction_repository.dart';
import 'package:money_flow/features/add_transaction/domain/usecases/add_transaction_usecase.dart';
import 'package:money_flow/features/add_transaction/domain/usecases/get_categories_usecase.dart';
import 'package:money_flow/features/add_transaction/domain/usecases/suggest_category_usecase.dart';
import 'package:money_flow/features/add_transaction/domain/usecases/validate_transaction_usecase.dart';
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
  getIt.registerLazySingleton<TransactionLocalDataSource>(
    () => TransactionLocalDataSource(),
  );

  // Repositories
  getIt.registerLazySingleton<TransactionRepository>(
    () => TransactionRepositoryImpl(
      localDataSource: getIt<TransactionLocalDataSource>(),
    ),
  );

  // Use cases
  getIt.registerLazySingleton<AddTransactionUseCase>(
    () => AddTransactionUseCase(repository: getIt<TransactionRepository>()),
  );

  getIt.registerLazySingleton<GetCategoriesUseCase>(
    () => GetCategoriesUseCase(repository: getIt<TransactionRepository>()),
  );

  getIt.registerLazySingleton<GetSubcategoriesUseCase>(
    () => GetSubcategoriesUseCase(repository: getIt<TransactionRepository>()),
  );

  getIt.registerLazySingleton<SuggestCategoryUseCase>(
    () => SuggestCategoryUseCase(repository: getIt<TransactionRepository>()),
  );

  getIt.registerLazySingleton<ValidateTransactionUseCase>(
    () => ValidateTransactionUseCase(),
  );

  // BLoCs
  getIt.registerSingleton<AddTransactionBloc>(
    AddTransactionBloc(
      addTransactionUseCase: getIt<AddTransactionUseCase>(),
      getCategoriesUseCase: getIt<GetCategoriesUseCase>(),
      getSubcategoriesUseCase: getIt<GetSubcategoriesUseCase>(),
      suggestCategoryUseCase: getIt<SuggestCategoryUseCase>(),
      // validateTransactionUseCase: getIt<ValidateTransactionUseCase>(),
    ),
  );
}
