import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:money_flow/features/transactions/domain/entities/transaction_entity.dart';
import 'package:money_flow/features/transactions/domain/repositories/transaction_repository.dart';

part 'add_transaction_state.freezed.dart';

/// State for loading categories operation.
/// This state represents the different states when loading available categories.
@freezed
class LoadCategoriesState with _$LoadCategoriesState {
  /// Initial state when categories haven't been loaded yet
  const factory LoadCategoriesState.initial() = LoadCategoriesInitial;

  /// Loading state when categories are being fetched
  const factory LoadCategoriesState.loading() = LoadCategoriesLoading;

  /// Completed state when categories are successfully loaded
  const factory LoadCategoriesState.completed(List<String> categories) =
      LoadCategoriesCompleted;

  /// Error state when category loading fails
  const factory LoadCategoriesState.error(String message) = LoadCategoriesError;
}

/// State for loading subcategories operation.
/// This state represents the different states when loading subcategories for a category.
@freezed
class LoadSubcategoriesState with _$LoadSubcategoriesState {
  /// Initial state when subcategories haven't been loaded yet
  const factory LoadSubcategoriesState.initial() = LoadSubcategoriesInitial;

  /// Loading state when subcategories are being fetched
  const factory LoadSubcategoriesState.loading() = LoadSubcategoriesLoading;

  /// Completed state when subcategories are successfully loaded
  const factory LoadSubcategoriesState.completed(List<String> subcategories) =
      LoadSubcategoriesCompleted;

  /// Error state when subcategory loading fails
  const factory LoadSubcategoriesState.error(String message) =
      LoadSubcategoriesError;
}

/// State for category suggestion operation.
/// This state represents the different states when suggesting categories.
@freezed
class SuggestCategoryState with _$SuggestCategoryState {
  /// Initial state when no suggestions have been made yet
  const factory SuggestCategoryState.initial() = SuggestCategoryInitial;

  /// Loading state when suggestions are being generated
  const factory SuggestCategoryState.loading() = SuggestCategoryLoading;

  /// Completed state when suggestions are successfully generated
  const factory SuggestCategoryState.completed(CategorySuggestion suggestion) =
      SuggestCategoryCompleted;

  /// Error state when suggestion generation fails
  const factory SuggestCategoryState.error(String message) =
      SuggestCategoryError;
}

/// State for transaction validation operation.
/// This state represents the different states when validating transaction data.
@freezed
class ValidateTransactionState with _$ValidateTransactionState {
  /// Initial state when validation hasn't been performed yet
  const factory ValidateTransactionState.initial() = ValidateTransactionInitial;

  /// Loading state when validation is being performed
  const factory ValidateTransactionState.loading() = ValidateTransactionLoading;

  /// Completed state when validation is successful
  const factory ValidateTransactionState.completed(bool isValid) =
      ValidateTransactionCompleted;

  /// Error state when validation fails
  const factory ValidateTransactionState.error(String message) =
      ValidateTransactionError;
}

/// State for adding transaction operation.
/// This state represents the different states when adding a new transaction.
@freezed
class AddTransactionState with _$AddTransactionState {
  /// Initial state when no transaction has been added yet
  const factory AddTransactionState.initial() = AddTransactionInitial;

  /// Loading state when transaction is being added
  const factory AddTransactionState.loading() = AddTransactionLoading;

  /// Completed state when transaction is successfully added
  const factory AddTransactionState.completed(TransactionEntity transaction) =
      AddTransactionCompleted;

  /// Error state when transaction addition fails
  const factory AddTransactionState.error(String message) = AddTransactionError;
}

/// Main state combining all operation states for the add transaction feature.
/// This state manages the overall state of the add transaction form and operations.
///
/// Usage Example:
/// ```dart
/// BlocBuilder<AddTransactionBloc, AddTransactionMainState>(
///   builder: (context, state) {
///     return state.loadCategories.when(
///       initial: () => const SizedBox(),
///       loading: () => const CircularProgressIndicator(),
///       completed: (categories) => CategorySelector(categories: categories),
///       error: (message) => ErrorWidget(message: message),
///     );
///   },
/// );
/// ```
@freezed
class AddTransactionMainState with _$AddTransactionMainState {
  const factory AddTransactionMainState({
    /// State for loading categories operation
    @Default(LoadCategoriesState.initial()) LoadCategoriesState loadCategories,

    /// State for loading subcategories operation
    @Default(LoadSubcategoriesState.initial())
    LoadSubcategoriesState loadSubcategories,

    /// State for category suggestion operation
    @Default(SuggestCategoryState.initial())
    SuggestCategoryState suggestCategory,

    /// State for transaction validation operation
    @Default(ValidateTransactionState.initial())
    ValidateTransactionState validateTransaction,

    /// State for adding transaction operation
    @Default(AddTransactionState.initial()) AddTransactionState addTransaction,

    /// Currently selected category
    @Default('') String selectedCategory,

    /// Currently selected subcategory
    @Default('') String selectedSubcategory,

    /// Current transaction amount
    @Default(0.0) double amount,

    /// Current transaction description
    String? description,

    /// Current transaction date and time
    DateTime? dateTime,

    /// Current transaction type
    @Default(TransactionType.expense) TransactionType type,

    /// Current merchant name
    String? merchant,

    /// Whether the form has been initialized
    @Default(false) bool isInitialized,

    /// Whether the form has unsaved changes
    @Default(false) bool hasUnsavedChanges,

    /// Whether the form is in edit mode
    @Default(false) bool isEditMode,

    /// ID of the transaction being edited (if in edit mode)
    String? editingTransactionId,
  }) = _AddTransactionMainState;
}
