import 'package:bloc/bloc.dart';
import 'package:money_flow/features/add_transaction/domain/entities/transaction_entity.dart';
import 'package:money_flow/features/add_transaction/domain/usecases/add_transaction_usecase.dart';
import 'package:money_flow/features/add_transaction/domain/usecases/get_categories_usecase.dart';
import 'package:money_flow/features/add_transaction/domain/usecases/suggest_category_usecase.dart';
import 'package:money_flow/features/add_transaction/presentation/bloc/add_transaction_event.dart';
import 'package:money_flow/features/add_transaction/presentation/bloc/add_transaction_state.dart';

/// BLoC for managing add transaction operations.
/// This BLoC handles only business logic operations, not form state management.
/// Form state should be managed in the UI layer.
///
/// Usage Example:
/// ```dart
/// BlocProvider(
///   create: (context) => AddTransactionBloc(
///     addTransactionUseCase: getIt<AddTransactionUseCase>(),
///     getCategoriesUseCase: getIt<GetCategoriesUseCase>(),
///     getSubcategoriesUseCase: getIt<GetSubcategoriesUseCase>(),
///     suggestCategoryUseCase: getIt<SuggestCategoryUseCase>(),
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

  AddTransactionBloc({
    required this.addTransactionUseCase,
    required this.getCategoriesUseCase,
    required this.getSubcategoriesUseCase,
    required this.suggestCategoryUseCase,
  }) : super(const AddTransactionMainState()) {
    on<AddTransactionEvent>((event, emit) async {
      await event.when(
        initialize: () => _onInitialize(event, emit),
        loadCategories: () => _onLoadCategories(event, emit),
        loadSubcategories: (category) => _onLoadSubcategories(event, emit),
        suggestCategory: (amount, description, merchant) =>
            _onSuggestCategory(event, emit),
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
      if (!emit.isDone) {
        emit(state.copyWith(isInitialized: true));
      }

      // Load categories
      add(const AddTransactionEvent.loadCategories());
    } catch (e) {
      // Handle initialization error
      if (!emit.isDone) {
        emit(
          state.copyWith(
            loadCategories: LoadCategoriesState.error(
              'Failed to initialize: $e',
            ),
          ),
        );
      }
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
            // Provide default categories
            final defaultCategories = _getDefaultCategories();
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
        final defaultCategories = _getDefaultCategories();
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

  /// Gets default categories for both expense and income transactions.
  /// This method provides fallback categories when the repository fails to load them.
  ///
  /// Returns:
  /// - [List<String>]: List of default category names
  List<String> _getDefaultCategories() {
    return [
      // Expense categories
      'Food & Dining',
      'Transportation',
      'Shopping',
      'Entertainment',
      'Bills & Utilities',
      'Healthcare',
      'Education',
      'Travel',
      'Other Expenses',
      // Income categories
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
