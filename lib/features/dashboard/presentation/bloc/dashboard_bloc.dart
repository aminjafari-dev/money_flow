import 'package:bloc/bloc.dart';
import 'package:money_flow/features/dashboard/domain/entities/dashboard_entity.dart';
import 'package:money_flow/features/dashboard/domain/usecases/get_cached_dashboard_data_usecase.dart';
import 'package:money_flow/features/dashboard/domain/usecases/get_dashboard_data_usecase.dart';
import 'package:money_flow/features/dashboard/domain/usecases/refresh_dashboard_data_usecase.dart';
import 'package:money_flow/features/dashboard/domain/usecases/update_dashboard_data_usecase.dart';
import 'package:money_flow/features/dashboard/presentation/bloc/dashboard_event.dart';
import 'package:money_flow/features/dashboard/presentation/bloc/dashboard_state.dart';
import 'package:money_flow/features/dashboard/presentation/widgets/time_period_selector.dart';
import 'package:money_flow/features/add_transaction/domain/entities/transaction_entity.dart';

/// BLoC for managing dashboard-related operations.
/// This BLoC handles all dashboard-related events and state management.
///
/// Usage Example:
/// ```dart
/// BlocProvider<DashboardBloc>(
///   create: (context) => getIt<DashboardBloc>(),
///   child: const DashboardPage(),
/// );
///
/// // Trigger events
/// context.read<DashboardBloc>().add(
///   DashboardEvent.getDashboardData(userId: 'user123'),
/// );
/// ```
class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  /// Use case for getting dashboard data
  final GetDashboardDataUseCase getDashboardDataUseCase;

  /// Use case for refreshing dashboard data
  final RefreshDashboardDataUseCase refreshDashboardDataUseCase;

  /// Use case for getting cached dashboard data
  final GetCachedDashboardDataUseCase getCachedDashboardDataUseCase;

  /// Use case for updating dashboard data
  final UpdateDashboardDataUseCase updateDashboardDataUseCase;

  /// Creates a new instance of DashboardBloc.
  ///
  /// Parameters:
  /// - [getDashboardDataUseCase]: Use case for getting dashboard data
  /// - [refreshDashboardDataUseCase]: Use case for refreshing dashboard data
  /// - [getCachedDashboardDataUseCase]: Use case for getting cached dashboard data
  /// - [updateDashboardDataUseCase]: Use case for updating dashboard data
  ///
  /// Usage Example:
  /// ```dart
  /// final bloc = DashboardBloc(
  ///   getDashboardDataUseCase: getIt<GetDashboardDataUseCase>(),
  ///   refreshDashboardDataUseCase: getIt<RefreshDashboardDataUseCase>(),
  ///   getCachedDashboardDataUseCase: getIt<GetCachedDashboardDataUseCase>(),
  ///   updateDashboardDataUseCase: getIt<UpdateDashboardDataUseCase>(),
  /// );
  /// ```
  DashboardBloc({
    required this.getDashboardDataUseCase,
    required this.refreshDashboardDataUseCase,
    required this.getCachedDashboardDataUseCase,
    required this.updateDashboardDataUseCase,
  }) : super(
         const DashboardState(
           getDashboardData: GetDashboardDataState.initial(),
           refreshDashboardData: RefreshDashboardDataState.initial(),
           getCachedDashboardData: GetCachedDashboardDataState.initial(),
           updateDashboardData: UpdateDashboardDataState.initial(),
           selectedTimePeriod: TimePeriod.monthly,
         ),
       ) {
    // Register event handlers
    on<DashboardEvent>((event, emit) async {
      await event.when(
        getDashboardData: (userId, timePeriod) =>
            _onGetDashboardData(userId, timePeriod, emit),
        refreshDashboardData: (userId, timePeriod) =>
            _onRefreshDashboardData(userId, timePeriod, emit),
        getCachedDashboardData: (userId) =>
            _onGetCachedDashboardData(userId, emit),
        updateDashboardData: (userId, dashboard) =>
            _onUpdateDashboardData(userId, dashboard, emit),
        changeTimePeriod: (userId, timePeriod) =>
            _onChangeTimePeriod(userId, timePeriod, emit),
      );
    });
  }

  /// Handles the get dashboard data event.
  /// This method processes the get dashboard data event and updates the state accordingly.
  ///
  /// Parameters:
  /// - [userId]: Unique identifier for the user
  /// - [timePeriod]: Time period for the data
  /// - [emit]: State emitter for updating the state
  ///
  /// Usage Example:
  /// ```dart
  /// await _onGetDashboardData('user123', TimePeriod.monthly, emit);
  /// ```
  Future<void> _onGetDashboardData(
    String userId,
    TimePeriod timePeriod,
    Emitter<DashboardState> emit,
  ) async {
    // Check if emit is still valid
    if (!emit.isDone) {
      emit(
        state.copyWith(getDashboardData: const GetDashboardDataState.loading()),
      );
    }

    try {
      // Call use case to get dashboard data
      final params = GetDashboardDataParams(userId: userId);
      final result = await getDashboardDataUseCase.call(params);

      // Check if emit is still valid
      if (!emit.isDone) {
        result.fold(
          (failure) => emit(
            state.copyWith(
              getDashboardData: GetDashboardDataState.error(
                failure.message ?? 'Unknown error',
              ),
            ),
          ),
          (dashboard) => emit(
            state.copyWith(
              getDashboardData: GetDashboardDataState.completed(dashboard),
            ),
          ),
        );
      }
    } catch (e) {
      // Check if emit is still valid
      if (!emit.isDone) {
        emit(
          state.copyWith(
            getDashboardData: GetDashboardDataState.error(
              'Unexpected error: $e',
            ),
          ),
        );
      }
    }
  }

  /// Handles the refresh dashboard data event.
  /// This method processes the refresh dashboard data event and updates the state accordingly.
  ///
  /// Parameters:
  /// - [userId]: Unique identifier for the user
  /// - [timePeriod]: Time period for the data
  /// - [emit]: State emitter for updating the state
  ///
  /// Usage Example:
  /// ```dart
  /// await _onRefreshDashboardData('user123', TimePeriod.weekly, emit);
  /// ```
  Future<void> _onRefreshDashboardData(
    String userId,
    TimePeriod timePeriod,
    Emitter<DashboardState> emit,
  ) async {
    // Check if emit is still valid
    if (!emit.isDone) {
      emit(
        state.copyWith(
          refreshDashboardData: const RefreshDashboardDataState.loading(),
        ),
      );
    }

    try {
      // Call use case to refresh dashboard data
      final params = RefreshDashboardDataParams(userId: userId);
      final result = await refreshDashboardDataUseCase.call(params);

      // Check if emit is still valid
      if (!emit.isDone) {
        result.fold(
          (failure) => emit(
            state.copyWith(
              refreshDashboardData: RefreshDashboardDataState.error(
                failure.message ?? 'Unknown error',
              ),
            ),
          ),
          (dashboard) => emit(
            state.copyWith(
              refreshDashboardData: RefreshDashboardDataState.completed(
                dashboard,
              ),
            ),
          ),
        );
      }
    } catch (e) {
      // Check if emit is still valid
      if (!emit.isDone) {
        emit(
          state.copyWith(
            refreshDashboardData: RefreshDashboardDataState.error(
              'Unexpected error: $e',
            ),
          ),
        );
      }
    }
  }

  /// Handles the get cached dashboard data event.
  /// This method processes the get cached dashboard data event and updates the state accordingly.
  ///
  /// Parameters:
  /// - [userId]: Unique identifier for the user
  /// - [emit]: State emitter for updating the state
  ///
  /// Usage Example:
  /// ```dart
  /// await _onGetCachedDashboardData('user123', emit);
  /// ```
  Future<void> _onGetCachedDashboardData(
    String userId,
    Emitter<DashboardState> emit,
  ) async {
    // Check if emit is still valid
    if (!emit.isDone) {
      emit(
        state.copyWith(
          getCachedDashboardData: const GetCachedDashboardDataState.loading(),
        ),
      );
    }

    try {
      // Call use case to get cached dashboard data
      final params = GetCachedDashboardDataParams(userId: userId);
      final result = await getCachedDashboardDataUseCase.call(params);

      // Check if emit is still valid
      if (!emit.isDone) {
        result.fold(
          (failure) => emit(
            state.copyWith(
              getCachedDashboardData: GetCachedDashboardDataState.error(
                failure.message ?? 'Unknown error',
              ),
            ),
          ),
          (dashboard) => emit(
            state.copyWith(
              getCachedDashboardData: GetCachedDashboardDataState.completed(
                dashboard,
              ),
            ),
          ),
        );
      }
    } catch (e) {
      // Check if emit is still valid
      if (!emit.isDone) {
        emit(
          state.copyWith(
            getCachedDashboardData: GetCachedDashboardDataState.error(
              'Unexpected error: $e',
            ),
          ),
        );
      }
    }
  }

  /// Handles the update dashboard data event.
  /// This method processes the update dashboard data event and updates the state accordingly.
  ///
  /// Parameters:
  /// - [userId]: Unique identifier for the user
  /// - [dashboard]: Dashboard data to update
  /// - [emit]: State emitter for updating the state
  ///
  /// Usage Example:
  /// ```dart
  /// await _onUpdateDashboardData('user123', dashboardData, emit);
  /// ```
  Future<void> _onUpdateDashboardData(
    String userId,
    Map<String, dynamic> dashboard,
    Emitter<DashboardState> emit,
  ) async {
    // Check if emit is still valid
    if (!emit.isDone) {
      emit(
        state.copyWith(
          updateDashboardData: const UpdateDashboardDataState.loading(),
        ),
      );
    }

    try {
      // Convert map to dashboard entity
      final dashboardEntity = _mapToDashboardEntity(dashboard);

      // Call use case to update dashboard data
      final params = UpdateDashboardDataParams(
        userId: userId,
        dashboard: dashboardEntity,
      );
      final result = await updateDashboardDataUseCase.call(params);

      // Check if emit is still valid
      if (!emit.isDone) {
        result.fold(
          (failure) => emit(
            state.copyWith(
              updateDashboardData: UpdateDashboardDataState.error(
                failure.message ?? 'Unknown error',
              ),
            ),
          ),
          (_) => emit(
            state.copyWith(
              updateDashboardData: const UpdateDashboardDataState.completed(),
            ),
          ),
        );
      }
    } catch (e) {
      // Check if emit is still valid
      if (!emit.isDone) {
        emit(
          state.copyWith(
            updateDashboardData: UpdateDashboardDataState.error(
              'Unexpected error: $e',
            ),
          ),
        );
      }
    }
  }

  /// Handles the change time period event.
  /// This method processes the change time period event and refreshes dashboard data.
  ///
  /// Parameters:
  /// - [userId]: Unique identifier for the user
  /// - [timePeriod]: New time period to display data for
  /// - [emit]: State emitter for updating the state
  ///
  /// Usage Example:
  /// ```dart
  /// await _onChangeTimePeriod('user123', TimePeriod.yearly, emit);
  /// ```
  Future<void> _onChangeTimePeriod(
    String userId,
    TimePeriod timePeriod,
    Emitter<DashboardState> emit,
  ) async {
    // Check if emit is still valid
    if (!emit.isDone) {
      // Update the selected time period
      emit(state.copyWith(selectedTimePeriod: timePeriod));

      // Refresh dashboard data with new time period
      await _onGetDashboardData(userId, timePeriod, emit);
    }
  }

  /// Converts a map to a DashboardEntity.
  /// This method handles the conversion of map data to domain entity.
  ///
  /// Parameters:
  /// - [dashboard]: Map containing dashboard data
  ///
  /// Returns:
  /// - [DashboardEntity]: Converted dashboard entity
  ///
  /// Usage Example:
  /// ```dart
  /// final entity = _mapToDashboardEntity(dashboardMap);
  /// ```
  DashboardEntity _mapToDashboardEntity(Map<String, dynamic> dashboard) {
    return DashboardEntity(
      totalIncome: (dashboard['totalIncome'] as num?)?.toDouble() ?? 0.0,
      totalExpenses: (dashboard['totalExpenses'] as num?)?.toDouble() ?? 0.0,
      totalCharity: (dashboard['totalCharity'] as num?)?.toDouble() ?? 0.0,
      totalInvestments:
          (dashboard['totalInvestments'] as num?)?.toDouble() ?? 0.0,
      recentTransactions:
          (dashboard['recentTransactions'] as List<dynamic>?)
              ?.map(
                (transaction) => TransactionEntity(
                  id: transaction['id']?.toString() ?? '',
                  amount: (transaction['amount'] as num?)?.toDouble() ?? 0.0,
                  mainCategory:
                      transaction['mainCategory']?.toString() ?? 'expenses',
                  category: transaction['category']?.toString() ?? '',
                  subcategory: transaction['subcategory']?.toString() ?? '',
                  description: transaction['description']?.toString(),
                  dateTime:
                      DateTime.tryParse(
                        transaction['dateTime']?.toString() ??
                            transaction['date']?.toString() ??
                            '',
                      ) ??
                      DateTime.now(),
                  type: _parseTransactionType(
                    transaction['type']?.toString() ?? 'expense',
                  ),
                  isFromSms: transaction['isFromSms'] as bool? ?? false,
                  merchant: transaction['merchant']?.toString(),
                ),
              )
              .toList() ??
          [],
    );
  }

  /// Parses transaction type string to TransactionType enum.
  /// This helper method converts string values to the appropriate enum type.
  ///
  /// Parameters:
  /// - [typeString]: String representation of transaction type
  ///
  /// Returns:
  /// - [TransactionType]: Parsed transaction type enum
  TransactionType _parseTransactionType(String typeString) {
    switch (typeString.toLowerCase()) {
      case 'expense':
        return TransactionType.expense;
      case 'income':
        return TransactionType.income;
      default:
        return TransactionType.expense; // Default to expense if unknown
    }
  }
}
