# Dashboard Feature

## Description

The **Dashboard Feature** serves as the central command center of the FinanceFlow money management app. It provides users with a comprehensive financial health overview at a glance, displaying income, expenses, charity donations, and investment progress in an intuitive, visual format. The dashboard calculates all financial metrics dynamically from stored transactions using the shared TransactionModel.

## Architecture

### Domain Layer
- **Entities**: `dashboard_entity.dart` - Pure business objects for dashboard and transaction data
- **Repositories**: `dashboard_repository.dart` - Abstract repository interface for dashboard operations
- **Use Cases**: 
  - `get_dashboard_data_usecase.dart` - Retrieves dashboard data calculated from transactions

### Data Layer
- **Models**: 
  - `dashboard_model.dart` - Data models with JSON serialization support, uses shared TransactionModel
  - `dashboard_request.dart` - Request model for API calls
- **Data Sources**: `dashboard_local_datasource.dart` - Local data source that calculates dashboard data from transactions
- **Repositories**: `dashboard_repository_impl.dart` - Repository implementation with transaction-based calculations

### Presentation Layer
- **BLoC**: 
  - `dashboard_event.dart` - BLoC events with freezed
  - `dashboard_state.dart` - BLoC states with freezed
  - `dashboard_bloc.dart` - BLoC implementation with state management
- **Widgets**:
  - `dashboard_card.dart` - Individual financial category card
  - `transaction_item.dart` - Individual transaction list item
  - `dashboard_summary.dart` - Financial summary cards section
  - `recent_transactions.dart` - Recent transactions list
  - `dashboard_header.dart` - Dashboard header with title and settings
- **Pages**: `dashboard_page.dart` - Main dashboard page with BLoC integration

### Integration Layer
- **DI**: `dashboard_di.dart` - Dependency injection setup for dashboard feature
- **Routes**: Integrated with global page router for navigation

## Use Cases

1. **Get Dashboard Data**: Calculates current financial overview from stored transactions

## Data Flow

1. **Page Load**: DashboardPage triggers GetDashboardData event
2. **BLoC Processing**: DashboardBloc processes event and calls GetDashboardDataUseCase
3. **Use Case Execution**: Use case validates input and calls DashboardRepository
4. **Repository Implementation**: RepositoryImpl calls DashboardLocalDataSource
5. **Data Calculation**: LocalDataSource calculates dashboard data from all stored transactions
6. **State Update**: BLoC emits new state with calculated dashboard data
7. **UI Update**: DashboardPage rebuilds with new financial information

## Key Components

- **Transaction-Based Calculations**: All dashboard data calculated dynamically from stored transactions
- **Shared TransactionModel**: Uses consistent transaction model across the app
- **Clean Architecture**: Proper layer separation with dependency inversion
- **BLoC Pattern**: State management with freezed for immutable states
- **Type Safety**: Strong typing throughout all layers
- **Error Handling**: Comprehensive error handling with Either pattern
- **Real-Time Financial Metrics**: Dashboard always reflects current transaction data
- **Responsive UI**: Clean, modern design with proper state management

## Dependencies

- **flutter_bloc**: State management
- **freezed**: Immutable data classes
- **dartz**: Functional programming with Either
- **hive**: Local database storage
- **get_it**: Dependency injection

## Usage

```dart
// Navigate to dashboard
Navigator.pushNamed(context, PageName.dashboard);

// Access dashboard BLoC
final dashboardBloc = getIt<DashboardBloc>();

// Trigger dashboard data calculation
dashboardBloc.add(DashboardEvent.getDashboardData(userId: 'user123'));
```