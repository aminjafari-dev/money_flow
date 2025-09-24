import 'package:get_it/get_it.dart';
import 'package:money_flow/features/add_transaction/data/datasources/local/transaction_local_datasource.dart';
import 'package:money_flow/features/transactions/data/datasources/local/transactions_local_datasource.dart';
import 'package:money_flow/features/transactions/data/repositories/transactions_repository_impl.dart';
import 'package:money_flow/features/transactions/domain/repositories/transactions_repository.dart';
import 'package:money_flow/features/transactions/domain/usecases/get_all_transactions_usecase.dart';
import 'package:money_flow/features/transactions/presentation/bloc/transactions_bloc.dart';

/// Sets up dependency injection for the transactions feature
Future<void> setupTransactionsLocator(GetIt getIt) async {
  // Data sources
  getIt.registerLazySingleton<TransactionsLocalDataSource>(
    () => TransactionsLocalDataSource(getIt<TransactionLocalDataSource>()),
  );

  // Repositories
  getIt.registerLazySingleton<TransactionsRepository>(
    () => TransactionsRepositoryImpl(getIt<TransactionsLocalDataSource>()),
  );

  // Use cases
  getIt.registerLazySingleton<GetAllTransactionsUseCase>(
    () => GetAllTransactionsUseCase(getIt<TransactionsRepository>()),
  );

  // BLoC
  getIt.registerFactory<TransactionsBloc>(
    () => TransactionsBloc(
      getAllTransactionsUseCase: getIt<GetAllTransactionsUseCase>(),
    ),
  );
}
