import 'package:bloc/bloc.dart';
import 'package:money_flow/features/add_transaction/domain/entities/transaction_entity.dart';
import 'package:money_flow/features/add_transaction/domain/usecases/add_transaction_usecase.dart';
import 'package:money_flow/features/add_transaction/presentation/bloc/add_transaction_event.dart';
import 'package:money_flow/features/add_transaction/presentation/bloc/add_transaction_state.dart';

/// BLoC for managing add transaction operations.
/// This BLoC handles only the add transaction business logic.
///
/// Usage Example:
/// ```dart
/// BlocProvider(
///   create: (context) => AddTransactionBloc(
///     addTransactionUseCase: getIt<AddTransactionUseCase>(),
///   ),
///   child: AddTransactionPage(),
/// )
/// ```
class AddTransactionBloc
    extends Bloc<AddTransactionEvent, AddTransactionMainState> {
  final AddTransactionUseCase addTransactionUseCase;

  AddTransactionBloc({required this.addTransactionUseCase})
    : super(const AddTransactionMainState()) {
    on<AddTransactionEvent>((event, emit) async {
      await event.when(
        addTransaction:
            (
              amount,
              mainCategory,
              category,
              description,
              dateTime,
              type,
              merchant,
              isFromSms,
            ) => _onAddTransaction(
              amount,
              mainCategory,
              category,
              description,
              dateTime,
              type,
              merchant,
              isFromSms,
              emit,
            ),
      );
    });
  }

  /// Handles the add transaction event.
  /// This method creates and saves a new transaction.
  Future<void> _onAddTransaction(
    double amount,
    String mainCategory,
    String category,
    String? description,
    DateTime dateTime,
    TransactionType type,
    String? merchant,
    bool isFromSms,
    Emitter<AddTransactionMainState> emit,
  ) async {
    try {
      // Check if emit is still active
      if (!emit.isDone) {
        emit(
          state.copyWith(addTransaction: const AddTransactionState.loading()),
        );
      }

      // Create parameters for the use case
      final params = AddTransactionParams(
        amount: amount,
        mainCategory: mainCategory,
        category: category,
        subcategory: '', // No subcategories in simplified version
        description: description,
        dateTime: dateTime,
        type: type,
        merchant: merchant,
        isFromSms: isFromSms,
      );

      // Add transaction
      final result = await addTransactionUseCase.call(params);

      if (!emit.isDone) {
        result.fold(
          (failure) {
            emit(
              state.copyWith(
                addTransaction: AddTransactionState.error(
                  failure.message ?? 'Failed to add transaction',
                ),
              ),
            );
          },
          (transaction) {
            emit(
              state.copyWith(
                addTransaction: AddTransactionState.completed(transaction),
              ),
            );
          },
        );
      }
    } catch (e) {
      if (!emit.isDone) {
        emit(
          state.copyWith(
            addTransaction: AddTransactionState.error(
              'Failed to add transaction: $e',
            ),
          ),
        );
      }
    }
  }
}
