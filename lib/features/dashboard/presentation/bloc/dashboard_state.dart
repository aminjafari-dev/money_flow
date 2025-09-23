import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:money_flow/features/dashboard/domain/entities/dashboard_entity.dart';

part 'dashboard_state.freezed.dart';

/// State for getting dashboard data operation.
/// This state represents the different states of the get dashboard data operation.
///
/// Usage Example:
/// ```dart
/// state.getDashboardData.when(
///   initial: () => const SizedBox(),
///   loading: () => const CircularProgressIndicator(),
///   completed: (dashboard) => DashboardWidget(dashboard: dashboard),
///   error: (message) => ErrorWidget(message: message),
/// );
/// ```
@freezed
class GetDashboardDataState with _$GetDashboardDataState {
  /// Initial state when no operation has been triggered yet.
  const factory GetDashboardDataState.initial() = GetDashboardDataInitial;

  /// Loading state when dashboard data is being fetched.
  const factory GetDashboardDataState.loading() = GetDashboardDataLoading;

  /// Completed state when dashboard data has been successfully retrieved.
  ///
  /// Parameters:
  /// - [dashboard]: The retrieved dashboard data
  const factory GetDashboardDataState.completed(DashboardEntity dashboard) =
      GetDashboardDataCompleted;

  /// Error state when dashboard data retrieval failed.
  ///
  /// Parameters:
  /// - [message]: Error message describing what went wrong
  const factory GetDashboardDataState.error(String message) =
      GetDashboardDataError;
}

/// Main state for dashboard operations.
/// This state class manages the dashboard data state.
///
/// Usage Example:
/// ```dart
/// BlocBuilder<DashboardBloc, DashboardState>(
///   builder: (context, state) {
///     return state.getDashboardData.when(
///       initial: () => const InitialWidget(),
///       loading: () => const LoadingWidget(),
///       completed: (dashboard) => DashboardWidget(dashboard: dashboard),
///       error: (message) => ErrorWidget(message: message),
///     );
///   },
/// );
/// ```
@freezed
class DashboardState with _$DashboardState {
  /// Creates a new instance of DashboardState.
  ///
  /// Parameters:
  /// - [getDashboardData]: State for get dashboard data operation
  ///
  /// Usage Example:
  /// ```dart
  /// const initialState = DashboardState(
  ///   getDashboardData: GetDashboardDataState.initial(),
  /// );
  /// ```
  const factory DashboardState({
    required GetDashboardDataState getDashboardData,
  }) = _DashboardState;
}
