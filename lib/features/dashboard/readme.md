# Dashboard Feature

## Description

The **Dashboard Feature** serves as the central command center of the FinanceFlow money management app. It provides users with a comprehensive financial health overview at a glance, displaying income, expenses, charity donations, and investment progress in an intuitive, visual format.

## Architecture

### Domain Layer
- **Entities**: `dashboard_entity.dart` - Pure business objects for dashboard and transaction data
- **Repositories**: `dashboard_repository.dart` - Abstract repository interface for dashboard operations
- **Use Cases**: 
  - `get_dashboard_data_usecase.dart` - Retrieves dashboard data
  - `refresh_dashboard_data_usecase.dart` - Refreshes dashboard data by recalculating from transactions
  - `get_cached_dashboard_data_usecase.dart` - Retrieves cached dashboard data for offline access
  - `update_dashboard_data_usecase.dart` - Updates dashboard data with new information

### Data Layer
- **Models**: 
  - `dashboard_model.dart` - Data models with JSON serialization support
  - `dashboard_request.dart` - Request model for API calls
- **Data Sources**: `dashboard_local_datasource.dart` - Local data source using Hive for offline storage
- **Repositories**: `dashboard_repository_impl.dart` - Repository implementation with local storage
- **Services**: `dashboard_calculation_service.dart` - Business logic for financial calculations

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

1. **Get Dashboard Data**: Retrieves current financial overview from local storage
2. **Refresh Dashboard Data**: Recalculates financial totals from stored transactions
3. **Get Cached Dashboard Data**: Provides offline access to previously cached data
4. **Update Dashboard Data**: Saves updated financial information to local storage

## Data Flow

1. **Page Load**: DashboardPage triggers GetDashboardData event
2. **BLoC Processing**: DashboardBloc processes event and calls GetDashboardDataUseCase
3. **Use Case Execution**: Use case validates input and calls DashboardRepository
4. **Repository Implementation**: RepositoryImpl calls DashboardLocalDataSource
5. **Data Retrieval**: LocalDataSource retrieves data from Hive database
6. **State Update**: BLoC emits new state with dashboard data
7. **UI Update**: DashboardPage rebuilds with new financial information

## Key Components

- **Offline-First Architecture**: All data stored locally using Hive database
- **Clean Architecture**: Proper layer separation with dependency inversion
- **BLoC Pattern**: State management with freezed for immutable states
- **Type Safety**: Strong typing throughout all layers
- **Error Handling**: Comprehensive error handling with Either pattern
- **Financial Calculations**: Smart business logic for financial aggregations
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
final dashboardBloc = context.read<DashboardBloc>();

// Trigger dashboard data refresh
dashboardBloc.add(DashboardEvent.refreshDashboardData(userId: 'user123'));
```