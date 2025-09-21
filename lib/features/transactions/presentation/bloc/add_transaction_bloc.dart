import 'package:bloc/bloc.dart';
import 'package:money_flow/features/transactions/domain/entities/transaction_entity.dart';
import 'package:money_flow/features/transactions/domain/usecases/add_transaction_usecase.dart';
import 'package:money_flow/features/transactions/domain/usecases/get_categories_usecase.dart';
import 'package:money_flow/features/transactions/domain/usecases/suggest_category_usecase.dart';
import 'package:money_flow/features/transactions/domain/usecases/validate_transaction_usecase.dart';
import 'package:money_flow/features/transactions/presentation/bloc/add_transaction_event.dart';
import 'package:money_flow/features/transactions/presentation/bloc/add_transaction_state.dart';

/// BLoC for managing add transaction operations and form state.
/// This BLoC handles all business logic for the add transaction feature,
/// including form management, validation, and transaction creation.
///
/// Usage Example:
/// ```dart
/// BlocProvider(
///   create: (context) => AddTransactionBloc(
///     addTransactionUseCase: getIt<AddTransactionUseCase>(),
///     getCategoriesUseCase: getIt<GetCategoriesUseCase>(),
///     getSubcategoriesUseCase: getIt<GetSubcategoriesUseCase>(),
///     suggestCategoryUseCase: getIt<SuggestCategoryUseCase>(),
///     validateTransactionUseCase: getIt<ValidateTransactionUseCase>(),
///   ),
///   child: AddTransactionPage(),
/// )
/// ```
class AddTransactionBloc
    extends Bloc<AddTransactionEvent, AddTransactionMainState> {
  final AddTransactionUseCase addTransactionUseCase;
  final GetCategoriesUseCase getCategoriesUseCase;
  final GetSubcategoriesUseCase getSubcategoriesUseCase;
  final SuggestCategoryUseCase suggestCategoryUseCase;
  final ValidateTransactionUseCase validateTransactionUseCase;

  AddTransactionBloc({
    required this.addTransactionUseCase,
    required this.getCategoriesUseCase,
    required this.getSubcategoriesUseCase,
    required this.suggestCategoryUseCase,
    required this.validateTransactionUseCase,
  }) : super(const AddTransactionMainState()) {
    on<AddTransactionEvent>((event, emit) async {
      await event.when(
        initialize: () => _onInitialize(event, emit),
        loadCategories: () => _onLoadCategories(event, emit),
        loadSubcategories: (category) => _onLoadSubcategories(event, emit),
        suggestCategory: (amount, description, merchant) =>
            _onSuggestCategory(event, emit),
        validateTransaction:
            (
              amount,
              category,
              subcategory,
              description,
              dateTime,
              type,
              merchant,
            ) => _onValidateTransaction(event, emit),
        addTransaction:
            (
              amount,
              category,
              subcategory,
              description,
              dateTime,
              type,
              merchant,
              isFromSms,
            ) => _onAddTransaction(event, emit),
        updateCategory: (category) => _onUpdateCategory(event, emit),
        updateSubcategory: (subcategory) => _onUpdateSubcategory(event, emit),
        updateAmount: (amount) => _onUpdateAmount(event, emit),
        updateDescription: (description) => _onUpdateDescription(event, emit),
        updateDateTime: (dateTime) => _onUpdateDateTime(event, emit),
        updateType: (type) => _onUpdateType(event, emit),
        updateMerchant: (merchant) => _onUpdateMerchant(event, emit),
        clearForm: () => _onClearForm(event, emit),
        resetForm: () => _onResetForm(event, emit),
      );
    });
  }

  /// Handles the initialize event.
  /// This method sets up the initial state and loads default data.
  Future<void> _onInitialize(
    AddTransactionEvent event,
    Emitter<AddTransactionMainState> emit,
  ) async {
    try {
      // Set initial state
      emit(
        state.copyWith(
          isInitialized: true,
          dateTime: DateTime.now(),
          type: TransactionType.expense,
        ),
      );

      // Load categories
      add(const AddTransactionEvent.loadCategories());
    } catch (e) {
      // Handle initialization error
      emit(
        state.copyWith(
          loadCategories: LoadCategoriesState.error('Failed to initialize: $e'),
        ),
      );
    }
  }

  /// Handles the load categories event.
  /// This method retrieves available categories from the repository.
  Future<void> _onLoadCategories(
    AddTransactionEvent event,
    Emitter<AddTransactionMainState> emit,
  ) async {
    try {
      // Check if emit is still active
      if (!emit.isDone) {
        emit(
          state.copyWith(loadCategories: const LoadCategoriesState.loading()),
        );
      }

      // Load categories
      final result = await getCategoriesUseCase.call();

      if (!emit.isDone) {
        result.fold(
          (failure) {
            // Provide default categories based on transaction type
            final defaultCategories = _getDefaultCategories(state.type);
            emit(
              state.copyWith(
                loadCategories: LoadCategoriesState.completed(
                  defaultCategories,
                ),
              ),
            );
          },
          (categories) {
            emit(
              state.copyWith(
                loadCategories: LoadCategoriesState.completed(categories),
              ),
            );
          },
        );
      }
    } catch (e) {
      if (!emit.isDone) {
        // Provide default categories even on error
        final defaultCategories = _getDefaultCategories(state.type);
        emit(
          state.copyWith(
            loadCategories: LoadCategoriesState.completed(defaultCategories),
          ),
        );
      }
    }
  }

  /// Handles the load subcategories event.
  /// This method retrieves subcategories for the selected category.
  Future<void> _onLoadSubcategories(
    AddTransactionEvent event,
    Emitter<AddTransactionMainState> emit,
  ) async {
    // Extract category from event using pattern matching
    final category = event.when(
      initialize: () => '',
      loadCategories: () => '',
      loadSubcategories: (category) => category,
      suggestCategory: (amount, description, merchant) => '',
      validateTransaction:
          (
            amount,
            category,
            subcategory,
            description,
            dateTime,
            type,
            merchant,
          ) => '',
      addTransaction:
          (
            amount,
            category,
            subcategory,
            description,
            dateTime,
            type,
            merchant,
            isFromSms,
          ) => '',
      updateCategory: (category) => '',
      updateSubcategory: (subcategory) => '',
      updateAmount: (amount) => '',
      updateDescription: (description) => '',
      updateDateTime: (dateTime) => '',
      updateType: (type) => '',
      updateMerchant: (merchant) => '',
      clearForm: () => '',
      resetForm: () => '',
    );

    try {
      // Check if emit is still active
      if (!emit.isDone) {
        emit(
          state.copyWith(
            loadSubcategories: const LoadSubcategoriesState.loading(),
          ),
        );
      }

      // Load subcategories
      final result = await getSubcategoriesUseCase.call(
        GetSubcategoriesParams(category: category),
      );

      if (!emit.isDone) {
        result.fold(
          (failure) {
            // Provide default subcategories if loading fails
            final defaultSubcategories = _getDefaultSubcategories(category);
            emit(
              state.copyWith(
                loadSubcategories: LoadSubcategoriesState.completed(
                  defaultSubcategories,
                ),
              ),
            );
          },
          (subcategories) {
            emit(
              state.copyWith(
                loadSubcategories: LoadSubcategoriesState.completed(
                  subcategories,
                ),
              ),
            );
          },
        );
      }
    } catch (e) {
      if (!emit.isDone) {
        // Provide default subcategories even on error
        final defaultSubcategories = _getDefaultSubcategories(category);
        emit(
          state.copyWith(
            loadSubcategories: LoadSubcategoriesState.completed(
              defaultSubcategories,
            ),
          ),
        );
      }
    }
  }

  /// Handles the suggest category event.
  /// This method generates category suggestions based on transaction details.
  Future<void> _onSuggestCategory(
    AddTransactionEvent event,
    Emitter<AddTransactionMainState> emit,
  ) async {
    try {
      // Check if emit is still active
      if (!emit.isDone) {
        emit(
          state.copyWith(suggestCategory: const SuggestCategoryState.loading()),
        );
      }

      // Extract parameters from event using pattern matching
      final params = event.when(
        initialize: () => SuggestCategoryParams(amount: 0.0),
        loadCategories: () => SuggestCategoryParams(amount: 0.0),
        loadSubcategories: (category) => SuggestCategoryParams(amount: 0.0),
        suggestCategory: (amount, description, merchant) =>
            SuggestCategoryParams(
              amount: amount,
              description: description,
              merchant: merchant,
            ),
        validateTransaction:
            (
              amount,
              category,
              subcategory,
              description,
              dateTime,
              type,
              merchant,
            ) => SuggestCategoryParams(amount: 0.0),
        addTransaction:
            (
              amount,
              category,
              subcategory,
              description,
              dateTime,
              type,
              merchant,
              isFromSms,
            ) => SuggestCategoryParams(amount: 0.0),
        updateCategory: (category) => SuggestCategoryParams(amount: 0.0),
        updateSubcategory: (subcategory) => SuggestCategoryParams(amount: 0.0),
        updateAmount: (amount) => SuggestCategoryParams(amount: 0.0),
        updateDescription: (description) => SuggestCategoryParams(amount: 0.0),
        updateDateTime: (dateTime) => SuggestCategoryParams(amount: 0.0),
        updateType: (type) => SuggestCategoryParams(amount: 0.0),
        updateMerchant: (merchant) => SuggestCategoryParams(amount: 0.0),
        clearForm: () => SuggestCategoryParams(amount: 0.0),
        resetForm: () => SuggestCategoryParams(amount: 0.0),
      );

      // Get category suggestions
      final result = await suggestCategoryUseCase.call(params);

      if (!emit.isDone) {
        result.fold(
          (failure) {
            emit(
              state.copyWith(
                suggestCategory: SuggestCategoryState.error(
                  failure.message ?? 'Failed to suggest category',
                ),
              ),
            );
          },
          (suggestion) {
            emit(
              state.copyWith(
                suggestCategory: SuggestCategoryState.completed(suggestion),
              ),
            );
          },
        );
      }
    } catch (e) {
      if (!emit.isDone) {
        emit(
          state.copyWith(
            suggestCategory: SuggestCategoryState.error(
              'Failed to suggest category: $e',
            ),
          ),
        );
      }
    }
  }

  /// Handles the validate transaction event.
  /// This method validates transaction data against business rules.
  Future<void> _onValidateTransaction(
    AddTransactionEvent event,
    Emitter<AddTransactionMainState> emit,
  ) async {
    try {
      // Check if emit is still active
      if (!emit.isDone) {
        emit(
          state.copyWith(
            validateTransaction: const ValidateTransactionState.loading(),
          ),
        );
      }

      // Extract parameters from event using pattern matching
      final params = event.when(
        initialize: () => ValidateTransactionParams(
          amount: 0.0,
          category: '',
          subcategory: '',
          dateTime: DateTime.now(),
          type: TransactionType.expense,
        ),
        loadCategories: () => ValidateTransactionParams(
          amount: 0.0,
          category: '',
          subcategory: '',
          dateTime: DateTime.now(),
          type: TransactionType.expense,
        ),
        loadSubcategories: (category) => ValidateTransactionParams(
          amount: 0.0,
          category: '',
          subcategory: '',
          dateTime: DateTime.now(),
          type: TransactionType.expense,
        ),
        suggestCategory: (amount, description, merchant) =>
            ValidateTransactionParams(
              amount: 0.0,
              category: '',
              subcategory: '',
              dateTime: DateTime.now(),
              type: TransactionType.expense,
            ),
        validateTransaction:
            (
              amount,
              category,
              subcategory,
              description,
              dateTime,
              type,
              merchant,
            ) => ValidateTransactionParams(
              amount: amount,
              category: category,
              subcategory: subcategory,
              description: description,
              dateTime: dateTime,
              type: type,
              merchant: merchant,
            ),
        addTransaction:
            (
              amount,
              category,
              subcategory,
              description,
              dateTime,
              type,
              merchant,
              isFromSms,
            ) => ValidateTransactionParams(
              amount: 0.0,
              category: '',
              subcategory: '',
              dateTime: DateTime.now(),
              type: TransactionType.expense,
            ),
        updateCategory: (category) => ValidateTransactionParams(
          amount: 0.0,
          category: '',
          subcategory: '',
          dateTime: DateTime.now(),
          type: TransactionType.expense,
        ),
        updateSubcategory: (subcategory) => ValidateTransactionParams(
          amount: 0.0,
          category: '',
          subcategory: '',
          dateTime: DateTime.now(),
          type: TransactionType.expense,
        ),
        updateAmount: (amount) => ValidateTransactionParams(
          amount: 0.0,
          category: '',
          subcategory: '',
          dateTime: DateTime.now(),
          type: TransactionType.expense,
        ),
        updateDescription: (description) => ValidateTransactionParams(
          amount: 0.0,
          category: '',
          subcategory: '',
          dateTime: DateTime.now(),
          type: TransactionType.expense,
        ),
        updateDateTime: (dateTime) => ValidateTransactionParams(
          amount: 0.0,
          category: '',
          subcategory: '',
          dateTime: DateTime.now(),
          type: TransactionType.expense,
        ),
        updateType: (type) => ValidateTransactionParams(
          amount: 0.0,
          category: '',
          subcategory: '',
          dateTime: DateTime.now(),
          type: TransactionType.expense,
        ),
        updateMerchant: (merchant) => ValidateTransactionParams(
          amount: 0.0,
          category: '',
          subcategory: '',
          dateTime: DateTime.now(),
          type: TransactionType.expense,
        ),
        clearForm: () => ValidateTransactionParams(
          amount: 0.0,
          category: '',
          subcategory: '',
          dateTime: DateTime.now(),
          type: TransactionType.expense,
        ),
        resetForm: () => ValidateTransactionParams(
          amount: 0.0,
          category: '',
          subcategory: '',
          dateTime: DateTime.now(),
          type: TransactionType.expense,
        ),
      );

      // Validate transaction
      final result = await validateTransactionUseCase.call(params);

      if (!emit.isDone) {
        result.fold(
          (failure) {
            emit(
              state.copyWith(
                validateTransaction: ValidateTransactionState.error(
                  failure.message ?? 'Failed to validate transaction',
                ),
              ),
            );
          },
          (isValid) {
            emit(
              state.copyWith(
                validateTransaction: ValidateTransactionState.completed(
                  isValid,
                ),
              ),
            );
          },
        );
      }
    } catch (e) {
      if (!emit.isDone) {
        emit(
          state.copyWith(
            validateTransaction: ValidateTransactionState.error(
              'Failed to validate transaction: $e',
            ),
          ),
        );
      }
    }
  }

  /// Handles the add transaction event.
  /// This method creates and saves a new transaction.
  Future<void> _onAddTransaction(
    AddTransactionEvent event,
    Emitter<AddTransactionMainState> emit,
  ) async {
    try {
      // Check if emit is still active
      if (!emit.isDone) {
        emit(
          state.copyWith(addTransaction: const AddTransactionState.loading()),
        );
      }

      // Extract parameters from event using pattern matching
      final params = event.when(
        initialize: () => AddTransactionParams(
          amount: 0.0,
          category: '',
          subcategory: '',
          dateTime: DateTime.now(),
          type: TransactionType.expense,
        ),
        loadCategories: () => AddTransactionParams(
          amount: 0.0,
          category: '',
          subcategory: '',
          dateTime: DateTime.now(),
          type: TransactionType.expense,
        ),
        loadSubcategories: (category) => AddTransactionParams(
          amount: 0.0,
          category: '',
          subcategory: '',
          dateTime: DateTime.now(),
          type: TransactionType.expense,
        ),
        suggestCategory: (amount, description, merchant) =>
            AddTransactionParams(
              amount: 0.0,
              category: '',
              subcategory: '',
              dateTime: DateTime.now(),
              type: TransactionType.expense,
            ),
        validateTransaction:
            (
              amount,
              category,
              subcategory,
              description,
              dateTime,
              type,
              merchant,
            ) => AddTransactionParams(
              amount: 0.0,
              category: '',
              subcategory: '',
              dateTime: DateTime.now(),
              type: TransactionType.expense,
            ),
        addTransaction:
            (
              amount,
              category,
              subcategory,
              description,
              dateTime,
              type,
              merchant,
              isFromSms,
            ) => AddTransactionParams(
              amount: amount,
              category: category,
              subcategory: subcategory,
              description: description,
              dateTime: dateTime,
              type: type,
              merchant: merchant,
              isFromSms: isFromSms,
            ),
        updateCategory: (category) => AddTransactionParams(
          amount: 0.0,
          category: '',
          subcategory: '',
          dateTime: DateTime.now(),
          type: TransactionType.expense,
        ),
        updateSubcategory: (subcategory) => AddTransactionParams(
          amount: 0.0,
          category: '',
          subcategory: '',
          dateTime: DateTime.now(),
          type: TransactionType.expense,
        ),
        updateAmount: (amount) => AddTransactionParams(
          amount: 0.0,
          category: '',
          subcategory: '',
          dateTime: DateTime.now(),
          type: TransactionType.expense,
        ),
        updateDescription: (description) => AddTransactionParams(
          amount: 0.0,
          category: '',
          subcategory: '',
          dateTime: DateTime.now(),
          type: TransactionType.expense,
        ),
        updateDateTime: (dateTime) => AddTransactionParams(
          amount: 0.0,
          category: '',
          subcategory: '',
          dateTime: DateTime.now(),
          type: TransactionType.expense,
        ),
        updateType: (type) => AddTransactionParams(
          amount: 0.0,
          category: '',
          subcategory: '',
          dateTime: DateTime.now(),
          type: TransactionType.expense,
        ),
        updateMerchant: (merchant) => AddTransactionParams(
          amount: 0.0,
          category: '',
          subcategory: '',
          dateTime: DateTime.now(),
          type: TransactionType.expense,
        ),
        clearForm: () => AddTransactionParams(
          amount: 0.0,
          category: '',
          subcategory: '',
          dateTime: DateTime.now(),
          type: TransactionType.expense,
        ),
        resetForm: () => AddTransactionParams(
          amount: 0.0,
          category: '',
          subcategory: '',
          dateTime: DateTime.now(),
          type: TransactionType.expense,
        ),
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
                hasUnsavedChanges: false,
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

  /// Handles the update category event.
  /// This method updates the selected category and clears subcategory.
  Future<void> _onUpdateCategory(
    AddTransactionEvent event,
    Emitter<AddTransactionMainState> emit,
  ) async {
    try {
      // Extract category from event using pattern matching
      final category = event.when(
        initialize: () => '',
        loadCategories: () => '',
        loadSubcategories: (category) => '',
        suggestCategory: (amount, description, merchant) => '',
        validateTransaction:
            (
              amount,
              category,
              subcategory,
              description,
              dateTime,
              type,
              merchant,
            ) => '',
        addTransaction:
            (
              amount,
              category,
              subcategory,
              description,
              dateTime,
              type,
              merchant,
              isFromSms,
            ) => '',
        updateCategory: (category) => category,
        updateSubcategory: (subcategory) => '',
        updateAmount: (amount) => '',
        updateDescription: (description) => '',
        updateDateTime: (dateTime) => '',
        updateType: (type) => '',
        updateMerchant: (merchant) => '',
        clearForm: () => '',
        resetForm: () => '',
      );

      if (!emit.isDone) {
        emit(
          state.copyWith(
            selectedCategory: category,
            selectedSubcategory: '', // Clear subcategory when category changes
            hasUnsavedChanges: true,
            loadSubcategories: const LoadSubcategoriesState.initial(),
          ),
        );

        // Load subcategories for the new category
        add(AddTransactionEvent.loadSubcategories(category: category));
      }
    } catch (e) {
      // Handle update error
      if (!emit.isDone) {
        emit(
          state.copyWith(
            loadSubcategories: LoadSubcategoriesState.error(
              'Failed to update category: $e',
            ),
          ),
        );
      }
    }
  }

  /// Handles the update subcategory event.
  /// This method updates the selected subcategory.
  Future<void> _onUpdateSubcategory(
    AddTransactionEvent event,
    Emitter<AddTransactionMainState> emit,
  ) async {
    try {
      // Extract subcategory from event using pattern matching
      final subcategory = event.when(
        initialize: () => '',
        loadCategories: () => '',
        loadSubcategories: (category) => '',
        suggestCategory: (amount, description, merchant) => '',
        validateTransaction:
            (
              amount,
              category,
              subcategory,
              description,
              dateTime,
              type,
              merchant,
            ) => '',
        addTransaction:
            (
              amount,
              category,
              subcategory,
              description,
              dateTime,
              type,
              merchant,
              isFromSms,
            ) => '',
        updateCategory: (category) => '',
        updateSubcategory: (subcategory) => subcategory,
        updateAmount: (amount) => '',
        updateDescription: (description) => '',
        updateDateTime: (dateTime) => '',
        updateType: (type) => '',
        updateMerchant: (merchant) => '',
        clearForm: () => '',
        resetForm: () => '',
      );

      if (!emit.isDone) {
        emit(
          state.copyWith(
            selectedSubcategory: subcategory,
            hasUnsavedChanges: true,
          ),
        );
      }
    } catch (e) {
      // Handle update error
      if (!emit.isDone) {
        emit(
          state.copyWith(
            loadSubcategories: LoadSubcategoriesState.error(
              'Failed to update subcategory: $e',
            ),
          ),
        );
      }
    }
  }

  /// Handles the update amount event.
  /// This method updates the transaction amount.
  Future<void> _onUpdateAmount(
    AddTransactionEvent event,
    Emitter<AddTransactionMainState> emit,
  ) async {
    try {
      // Extract amount from event using pattern matching
      final amount = event.when(
        initialize: () => 0.0,
        loadCategories: () => 0.0,
        loadSubcategories: (category) => 0.0,
        suggestCategory: (amount, description, merchant) => 0.0,
        validateTransaction:
            (
              amount,
              category,
              subcategory,
              description,
              dateTime,
              type,
              merchant,
            ) => 0.0,
        addTransaction:
            (
              amount,
              category,
              subcategory,
              description,
              dateTime,
              type,
              merchant,
              isFromSms,
            ) => 0.0,
        updateCategory: (category) => 0.0,
        updateSubcategory: (subcategory) => 0.0,
        updateAmount: (amount) => amount,
        updateDescription: (description) => 0.0,
        updateDateTime: (dateTime) => 0.0,
        updateType: (type) => 0.0,
        updateMerchant: (merchant) => 0.0,
        clearForm: () => 0.0,
        resetForm: () => 0.0,
      );

      if (!emit.isDone) {
        emit(state.copyWith(amount: amount, hasUnsavedChanges: true));
      }
    } catch (e) {
      // Handle update error
      if (!emit.isDone) {
        emit(
          state.copyWith(
            addTransaction: AddTransactionState.error(
              'Failed to update amount: $e',
            ),
          ),
        );
      }
    }
  }

  /// Handles the update description event.
  /// This method updates the transaction description.
  Future<void> _onUpdateDescription(
    AddTransactionEvent event,
    Emitter<AddTransactionMainState> emit,
  ) async {
    try {
      // Extract description from event using pattern matching
      final description = event.when(
        initialize: () => null,
        loadCategories: () => null,
        loadSubcategories: (category) => null,
        suggestCategory: (amount, description, merchant) => null,
        validateTransaction:
            (
              amount,
              category,
              subcategory,
              description,
              dateTime,
              type,
              merchant,
            ) => null,
        addTransaction:
            (
              amount,
              category,
              subcategory,
              description,
              dateTime,
              type,
              merchant,
              isFromSms,
            ) => null,
        updateCategory: (category) => null,
        updateSubcategory: (subcategory) => null,
        updateAmount: (amount) => null,
        updateDescription: (description) => description,
        updateDateTime: (dateTime) => null,
        updateType: (type) => null,
        updateMerchant: (merchant) => null,
        clearForm: () => null,
        resetForm: () => null,
      );

      if (!emit.isDone) {
        emit(state.copyWith(description: description, hasUnsavedChanges: true));
      }
    } catch (e) {
      // Handle update error
      if (!emit.isDone) {
        emit(
          state.copyWith(
            addTransaction: AddTransactionState.error(
              'Failed to update description: $e',
            ),
          ),
        );
      }
    }
  }

  /// Handles the update date time event.
  /// This method updates the transaction date and time.
  Future<void> _onUpdateDateTime(
    AddTransactionEvent event,
    Emitter<AddTransactionMainState> emit,
  ) async {
    try {
      // Extract dateTime from event using pattern matching
      final dateTime = event.when(
        initialize: () => DateTime.now(),
        loadCategories: () => DateTime.now(),
        loadSubcategories: (category) => DateTime.now(),
        suggestCategory: (amount, description, merchant) => DateTime.now(),
        validateTransaction:
            (
              amount,
              category,
              subcategory,
              description,
              dateTime,
              type,
              merchant,
            ) => DateTime.now(),
        addTransaction:
            (
              amount,
              category,
              subcategory,
              description,
              dateTime,
              type,
              merchant,
              isFromSms,
            ) => DateTime.now(),
        updateCategory: (category) => DateTime.now(),
        updateSubcategory: (subcategory) => DateTime.now(),
        updateAmount: (amount) => DateTime.now(),
        updateDescription: (description) => DateTime.now(),
        updateDateTime: (dateTime) => dateTime,
        updateType: (type) => DateTime.now(),
        updateMerchant: (merchant) => DateTime.now(),
        clearForm: () => DateTime.now(),
        resetForm: () => DateTime.now(),
      );

      if (!emit.isDone) {
        emit(state.copyWith(dateTime: dateTime, hasUnsavedChanges: true));
      }
    } catch (e) {
      // Handle update error
      if (!emit.isDone) {
        emit(
          state.copyWith(
            addTransaction: AddTransactionState.error(
              'Failed to update date time: $e',
            ),
          ),
        );
      }
    }
  }

  /// Handles the update type event.
  /// This method updates the transaction type.
  Future<void> _onUpdateType(
    AddTransactionEvent event,
    Emitter<AddTransactionMainState> emit,
  ) async {
    try {
      // Extract type from event using pattern matching
      final type = event.when(
        initialize: () => TransactionType.expense,
        loadCategories: () => TransactionType.expense,
        loadSubcategories: (category) => TransactionType.expense,
        suggestCategory: (amount, description, merchant) =>
            TransactionType.expense,
        validateTransaction:
            (
              amount,
              category,
              subcategory,
              description,
              dateTime,
              type,
              merchant,
            ) => TransactionType.expense,
        addTransaction:
            (
              amount,
              category,
              subcategory,
              description,
              dateTime,
              type,
              merchant,
              isFromSms,
            ) => TransactionType.expense,
        updateCategory: (category) => TransactionType.expense,
        updateSubcategory: (subcategory) => TransactionType.expense,
        updateAmount: (amount) => TransactionType.expense,
        updateDescription: (description) => TransactionType.expense,
        updateDateTime: (dateTime) => TransactionType.expense,
        updateType: (type) => type,
        updateMerchant: (merchant) => TransactionType.expense,
        clearForm: () => TransactionType.expense,
        resetForm: () => TransactionType.expense,
      );

      if (!emit.isDone) {
        emit(
          state.copyWith(
            type: type,
            hasUnsavedChanges: true,
            // Clear selected category and subcategory when type changes
            selectedCategory: '',
            selectedSubcategory: '',
            // Reset subcategories state
            loadSubcategories: const LoadSubcategoriesState.initial(),
          ),
        );

        // Reload categories for the new transaction type
        add(const AddTransactionEvent.loadCategories());
      }
    } catch (e) {
      // Handle update error
      if (!emit.isDone) {
        emit(
          state.copyWith(
            addTransaction: AddTransactionState.error(
              'Failed to update type: $e',
            ),
          ),
        );
      }
    }
  }

  /// Handles the update merchant event.
  /// This method updates the merchant name.
  Future<void> _onUpdateMerchant(
    AddTransactionEvent event,
    Emitter<AddTransactionMainState> emit,
  ) async {
    try {
      // Extract merchant from event using pattern matching
      final merchant = event.when(
        initialize: () => null,
        loadCategories: () => null,
        loadSubcategories: (category) => null,
        suggestCategory: (amount, description, merchant) => null,
        validateTransaction:
            (
              amount,
              category,
              subcategory,
              description,
              dateTime,
              type,
              merchant,
            ) => null,
        addTransaction:
            (
              amount,
              category,
              subcategory,
              description,
              dateTime,
              type,
              merchant,
              isFromSms,
            ) => null,
        updateCategory: (category) => null,
        updateSubcategory: (subcategory) => null,
        updateAmount: (amount) => null,
        updateDescription: (description) => null,
        updateDateTime: (dateTime) => null,
        updateType: (type) => null,
        updateMerchant: (merchant) => merchant,
        clearForm: () => null,
        resetForm: () => null,
      );

      if (!emit.isDone) {
        emit(state.copyWith(merchant: merchant, hasUnsavedChanges: true));
      }
    } catch (e) {
      // Handle update error
      if (!emit.isDone) {
        emit(
          state.copyWith(
            addTransaction: AddTransactionState.error(
              'Failed to update merchant: $e',
            ),
          ),
        );
      }
    }
  }

  /// Handles the clear form event.
  /// This method resets the form to its initial state.
  Future<void> _onClearForm(
    AddTransactionEvent event,
    Emitter<AddTransactionMainState> emit,
  ) async {
    try {
      if (!emit.isDone) {
        emit(
          const AddTransactionMainState(
            isInitialized: true,
            dateTime: null,
            type: TransactionType.expense,
          ),
        );
      }
    } catch (e) {
      // Handle clear error
      if (!emit.isDone) {
        emit(
          state.copyWith(
            addTransaction: AddTransactionState.error(
              'Failed to clear form: $e',
            ),
          ),
        );
      }
    }
  }

  /// Handles the reset form event.
  /// This method resets the form without clearing loaded data.
  Future<void> _onResetForm(
    AddTransactionEvent event,
    Emitter<AddTransactionMainState> emit,
  ) async {
    try {
      if (!emit.isDone) {
        emit(
          state.copyWith(
            selectedCategory: '',
            selectedSubcategory: '',
            amount: 0.0,
            description: null,
            dateTime: DateTime.now(),
            type: TransactionType.expense,
            merchant: null,
            hasUnsavedChanges: false,
            validateTransaction: const ValidateTransactionState.initial(),
            addTransaction: const AddTransactionState.initial(),
          ),
        );
      }
    } catch (e) {
      // Handle reset error
      if (!emit.isDone) {
        emit(
          state.copyWith(
            addTransaction: AddTransactionState.error(
              'Failed to reset form: $e',
            ),
          ),
        );
      }
    }
  }

  /// Gets default categories based on transaction type.
  /// This method provides fallback categories when the repository fails to load them.
  ///
  /// Parameters:
  /// - [type]: The transaction type (expense or income)
  ///
  /// Returns:
  /// - [List<String>]: List of default category names
  List<String> _getDefaultCategories(TransactionType type) {
    switch (type) {
      case TransactionType.expense:
        return [
          'Food & Dining',
          'Transportation',
          'Shopping',
          'Entertainment',
          'Bills & Utilities',
          'Healthcare',
          'Education',
          'Travel',
          'Other Expenses',
        ];
      case TransactionType.income:
        return [
          'Salary',
          'Freelance',
          'Business',
          'Investment',
          'Gift',
          'Bonus',
          'Rental',
          'Refund',
          'Other Income',
        ];
    }
  }

  /// Gets default subcategories for a given category.
  /// This method provides fallback subcategories when the repository fails to load them.
  ///
  /// Parameters:
  /// - [category]: The selected category name
  ///
  /// Returns:
  /// - [List<String>]: List of default subcategory names
  List<String> _getDefaultSubcategories(String category) {
    switch (category.toLowerCase()) {
      // Expense subcategories
      case 'food & dining':
        return ['Restaurant', 'Groceries', 'Fast Food', 'Coffee', 'Other'];
      case 'transportation':
        return [
          'Gas',
          'Public Transport',
          'Taxi/Uber',
          'Parking',
          'Maintenance',
        ];
      case 'shopping':
        return ['Clothing', 'Electronics', 'Home & Garden', 'Books', 'Other'];
      case 'entertainment':
        return ['Movies', 'Games', 'Sports', 'Music', 'Other'];
      case 'bills & utilities':
        return ['Electricity', 'Water', 'Internet', 'Phone', 'Insurance'];
      case 'healthcare':
        return ['Doctor', 'Pharmacy', 'Dental', 'Vision', 'Other'];
      case 'education':
        return ['Tuition', 'Books', 'Supplies', 'Courses', 'Other'];
      case 'travel':
        return ['Flights', 'Hotels', 'Food', 'Activities', 'Other'];

      // Income subcategories
      case 'salary':
        return ['Base Salary', 'Overtime', 'Commission', 'Tips', 'Other'];
      case 'freelance':
        return ['Consulting', 'Design', 'Writing', 'Programming', 'Other'];
      case 'business':
        return ['Sales', 'Services', 'Products', 'Partnerships', 'Other'];
      case 'investment':
        return ['Stocks', 'Bonds', 'Real Estate', 'Crypto', 'Other'];
      case 'gift':
        return ['Birthday', 'Holiday', 'Wedding', 'Anniversary', 'Other'];
      case 'bonus':
        return ['Performance', 'Holiday', 'Signing', 'Retention', 'Other'];
      case 'rental':
        return ['Property', 'Car', 'Equipment', 'Storage', 'Other'];
      case 'refund':
        return [
          'Tax Refund',
          'Purchase Return',
          'Insurance',
          'Overpayment',
          'Other',
        ];

      default:
        return ['General', 'Miscellaneous', 'Other'];
    }
  }
}
