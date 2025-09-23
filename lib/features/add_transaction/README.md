# Add Transaction Feature

A comprehensive feature for adding financial transactions to the Money Flow application, following Clean Architecture principles with proper dependency injection and state management.

## Description

The Add Transaction feature allows users to create, validate, and store financial transactions with support for multiple categories, amount validation, and intelligent category suggestions. The feature uses Hive for local storage and implements a robust error handling system.

## Architecture

### Domain Layer
- **entities/**: Pure business objects
  - `transaction_entity.dart` - Core transaction entity with business logic
- **repositories/**: Abstract repository interfaces
  - `transaction_repository.dart` - Repository contract for transaction operations
- **usecases/**: Business logic operations
  - `add_transaction_usecase.dart` - Handles transaction creation
  - `get_categories_usecase.dart` - Retrieves available categories
  - `suggest_category_usecase.dart` - Provides AI-powered category suggestions
  - `validate_transaction_usecase.dart` - Validates transaction data

### Data Layer
- **models/**: Data transfer objects and serialization
  - `transaction_model.dart` - Hive-compatible data model with JSON serialization
  - `transaction_request.dart` - API request/response models
- **datasources/local/**: Local storage operations
  - `transaction_local_datasource.dart` - Hive database operations
- **repositories/**: Repository implementations
  - `transaction_repository_impl.dart` - Combines local and remote data sources

### Presentation Layer
- **bloc/**: State management
  - `add_transaction_bloc.dart` - BLoC for transaction operations
  - `add_transaction_event.dart` - Event definitions using Freezed
  - `add_transaction_state.dart` - State definitions using Freezed
- **pages/**: Screen components
  - `add_transaction_page.dart` - Main transaction form page
- **widgets/**: Reusable UI components
  - `transaction_form_widget.dart` - Main form widget
  - `amount_input_widget.dart` - Amount input component
  - `category_selector_widget.dart` - Category selection component
  - `transaction_action_buttons_widget.dart` - Action buttons

## Use Cases

1. **Add Transaction Use Case**
   - **Description**: Creates and validates new financial transactions
   - **Data Flow**: Page -> Bloc -> UseCase -> Repository -> DataSource

2. **Get Categories Use Case**
   - **Description**: Retrieves available transaction categories
   - **Data Flow**: Page -> Bloc -> UseCase -> Repository -> CategoryService

3. **Suggest Category Use Case**
   - **Description**: Provides intelligent category suggestions based on transaction details
   - **Data Flow**: Page -> Bloc -> UseCase -> Repository -> Pattern Matching

4. **Validate Transaction Use Case**
   - **Description**: Validates transaction data against business rules
   - **Data Flow**: Page -> Bloc -> UseCase -> Validation Logic

## Data Flow

1. User opens the Add Transaction page
2. BLoC initializes and loads available categories
3. User fills out the transaction form
4. User can request category suggestions based on amount/description
5. User submits the form
6. BLoC validates the transaction data
7. BLoC calls the Add Transaction Use Case
8. Use Case creates a TransactionEntity
9. Repository converts entity to model and stores in Hive
10. Success/error state is emitted back to the UI

## Key Components

- **Clean Architecture**: Strict separation of concerns with dependency inversion
- **BLoC Pattern**: Event-driven state management with Freezed for immutability
- **Hive Database**: Local storage with type-safe adapters
- **Dependency Injection**: GetIt for service location and dependency management
- **Error Handling**: Comprehensive error handling with Either pattern
- **Validation**: Multi-layer validation (UI, Use Case, Repository)
- **Category System**: 4 main categories (Income, Expenses, Charity, Investments)

## Hive Adapter Registration Fix

### Problem
The original implementation had a critical issue where the `TransactionModel` Hive adapter was not being registered during app initialization, causing the error:
```
TransactionModel @add_transaction/ did you forget to add register and adapter
```

### Root Cause
The `TransactionLocalDataSource.initialize()` method was never called during app startup, unlike other data sources that were properly initialized in their respective DI setups.

### Solution
Updated the `setupTransactionLocator()` function in `lib/features/add_transaction/di/transaction_di.dart` to:

1. **Register the data source** as a lazy singleton
2. **Initialize the data source** immediately after registration
3. **Ensure Hive adapter registration** happens before any transaction operations

### Code Changes
```dart
Future<void> setupTransactionLocator(GetIt getIt) async {
  // Data sources
  getIt.registerLazySingleton<TransactionLocalDataSource>(
    () => TransactionLocalDataSource(),
  );

  // Initialize the local data source
  // This ensures Hive boxes and adapters are properly set up before use
  final localDataSource = getIt<TransactionLocalDataSource>();
  await localDataSource.initialize();

  // ... rest of the setup
}
```

### Prevention
To prevent similar issues in the future:

1. **Always initialize data sources** in DI setup functions
2. **Follow the established pattern** used by other features (like Dashboard)
3. **Add comprehensive tests** to verify adapter registration
4. **Document initialization requirements** in feature README files

### Testing
Created comprehensive tests in `lib/features/add_transaction/test/transaction_model_adapter_test.dart` to verify:
- Adapter typeId configuration
- TransactionModel creation and serialization
- JSON conversion operations
- copyWith functionality

## Usage Example

```dart
// Initialize the feature
await setupTransactionLocator(getIt);

// Use in UI
BlocProvider(
  create: (context) => getIt<AddTransactionBloc>(),
  child: AddTransactionPage(),
)

// Add a transaction
context.read<AddTransactionBloc>().add(
  AddTransactionEvent.addTransaction(
    amount: 25.50,
    category: 'Food',
    subcategory: 'Groceries',
    description: 'Weekly shopping',
    dateTime: DateTime.now(),
    type: TransactionType.expense,
  ),
);
```

## Dependencies

- `hive_flutter`: Local database storage
- `dartz`: Functional programming with Either
- `freezed`: Immutable data classes
- `flutter_bloc`: State management
- `get_it`: Dependency injection
- `equatable`: Value equality

## Error Handling

The feature implements comprehensive error handling at multiple levels:

1. **Validation Errors**: Input validation with user-friendly messages
2. **Storage Errors**: Hive database operation failures
3. **Network Errors**: API communication failures (when implemented)
4. **Business Logic Errors**: Domain-specific rule violations

All errors are properly typed and handled using the Either pattern for functional error handling.
