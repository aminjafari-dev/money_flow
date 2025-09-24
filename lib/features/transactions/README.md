# Transactions Feature

A simple feature for displaying all transactions in chronological order without complex filtering or categorization.

## Description

The Transactions feature provides a clean, minimal interface for viewing all financial transactions. It displays transactions in a simple list format, sorted by date (newest first), without any complex filtering, search, or categorization features.

## Architecture

### Domain Layer
- **entities/transaction_list_entity.dart**: Domain entity representing a collection of transactions with business logic for sorting and calculations
- **repositories/transactions_repository.dart**: Abstract repository interface for transaction data operations
- **usecases/get_all_transactions_usecase.dart**: Use case for retrieving all transactions
- **usecases/get_transactions_sorted_by_date_usecase.dart**: Use case for retrieving transactions sorted by date

### Data Layer
- **models/transaction_list_model.dart**: Data model for transaction list serialization
- **datasources/local/transactions_local_datasource.dart**: Local data source leveraging existing transaction storage
- **repositories/transactions_repository_impl.dart**: Repository implementation using local data source

### Presentation Layer
- **bloc/transactions_bloc.dart**: BLoC for managing transaction state
- **bloc/transactions_event.dart**: Events for loading and refreshing transactions
- **bloc/transactions_state.dart**: States for initial, loading, completed, and error states
- **pages/transactions_page.dart**: Simple page displaying transaction list
- **widgets/transaction_item_widget.dart**: Minimal widget for displaying individual transactions

## Use Cases

1. **GetAllTransactionsUseCase**: Retrieves all available transactions from the repository
2. **GetTransactionsSortedByDateUseCase**: Retrieves transactions ordered by date (newest first)

## Data Flow

1. **Page** → **BLoC** → **UseCase** → **Repository** → **DataSource** → **Local Storage**
2. User opens transactions page
3. BLoC triggers LoadTransactions event
4. UseCase calls repository to get all transactions
5. Repository queries local data source
6. Data source retrieves from Hive storage
7. Data flows back through layers with proper error handling
8. UI displays transactions in simple list format

## Key Components

- **Clean Architecture**: Strict separation of concerns with domain, data, and presentation layers
- **BLoC Pattern**: State management using flutter_bloc with freezed for immutable states
- **Local Storage**: Leverages existing Hive-based transaction storage
- **Dependency Injection**: Uses GetIt for clean dependency management
- **Error Handling**: Proper error handling with DataStatus pattern
- **Minimal UI**: Simple, focused interface without complex features

## Usage

The transactions page is accessible through the main navigation and displays all transactions in chronological order. No additional configuration or setup is required - it simply shows all available transaction data in a clean, readable format.
