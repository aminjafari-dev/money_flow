import 'package:bloc/bloc.dart';
import 'package:money_flow/core/data_status.dart';
import 'package:money_flow/features/transactions/domain/usecases/get_all_transactions_usecase.dart';
import 'package:money_flow/features/transactions/presentation/bloc/transactions_event.dart';
import 'package:money_flow/features/transactions/presentation/bloc/transactions_state.dart';

/// BLoC for managing transactions operations
class TransactionsBloc extends Bloc<TransactionsEvent, TransactionsState> {
  final GetAllTransactionsUseCase getAllTransactionsUseCase;

  TransactionsBloc({required this.getAllTransactionsUseCase})
    : super(const TransactionsState.initial()) {
    on<TransactionsEvent>((event, emit) async {
      await event.when(
        loadTransactions: () => _onLoadTransactions(emit),
        refreshTransactions: () => _onRefreshTransactions(emit),
      );
    });
  }

  Future<void> _onLoadTransactions(Emitter<TransactionsState> emit) async {
    if (!emit.isDone) emit(const TransactionsState.loading());

    try {
      final result = await getAllTransactionsUseCase.call();
      if (!emit.isDone) {
        if (result is DataSuccess) {
          emit(TransactionsState.completed(result.data!));
        } else {
          emit(
            TransactionsState.error(
              result.error ?? 'Failed to load transactions',
            ),
          );
        }
      }
    } catch (e) {
      if (!emit.isDone) emit(TransactionsState.error(e.toString()));
    }
  }

  Future<void> _onRefreshTransactions(Emitter<TransactionsState> emit) async {
    if (!emit.isDone) emit(const TransactionsState.loading());

    try {
      final result = await getAllTransactionsUseCase.call();
      if (!emit.isDone) {
        if (result is DataSuccess) {
          emit(TransactionsState.completed(result.data!));
        } else {
          emit(
            TransactionsState.error(
              result.error ?? 'Failed to refresh transactions',
            ),
          );
        }
      }
    } catch (e) {
      if (!emit.isDone) emit(TransactionsState.error(e.toString()));
    }
  }
}
