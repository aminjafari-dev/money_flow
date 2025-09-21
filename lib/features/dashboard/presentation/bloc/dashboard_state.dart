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

/// State for refreshing dashboard data operation.
/// This state represents the different states of the refresh dashboard data operation.
///
/// Usage Example:
/// ```dart
/// state.refreshDashboardData.when(
///   initial: () => const SizedBox(),
///   loading: () => const CircularProgressIndicator(),
///   completed: (dashboard) => DashboardWidget(dashboard: dashboard),
///   error: (message) => ErrorWidget(message: message),
/// );
/// ```
@freezed
class RefreshDashboardDataState with _$RefreshDashboardDataState {
  /// Initial state when no refresh operation has been triggered yet.
  const factory RefreshDashboardDataState.initial() =
      RefreshDashboardDataInitial;

  /// Loading state when dashboard data is being refreshed.
  const factory RefreshDashboardDataState.loading() =
      RefreshDashboardDataLoading;

  /// Completed state when dashboard data has been successfully refreshed.
  ///
  /// Parameters:
  /// - [dashboard]: The refreshed dashboard data
  const factory RefreshDashboardDataState.completed(DashboardEntity dashboard) =
      RefreshDashboardDataCompleted;

  /// Error state when dashboard data refresh failed.
  ///
  /// Parameters:
  /// - [message]: Error message describing what went wrong
  const factory RefreshDashboardDataState.error(String message) =
      RefreshDashboardDataError;
}

/// State for getting cached dashboard data operation.
/// This state represents the different states of the get cached dashboard data operation.
///
/// Usage Example:
/// ```dart
/// state.getCachedDashboardData.when(
///   initial: () => const SizedBox(),
///   loading: () => const CircularProgressIndicator(),
///   completed: (dashboard) => DashboardWidget(dashboard: dashboard),
///   error: (message) => ErrorWidget(message: message),
/// );
/// ```
@freezed
class GetCachedDashboardDataState with _$GetCachedDashboardDataState {
  /// Initial state when no cached data operation has been triggered yet.
  const factory GetCachedDashboardDataState.initial() =
      GetCachedDashboardDataInitial;

  /// Loading state when cached dashboard data is being retrieved.
  const factory GetCachedDashboardDataState.loading() =
      GetCachedDashboardDataLoading;

  /// Completed state when cached dashboard data has been successfully retrieved.
  ///
  /// Parameters:
  /// - [dashboard]: The retrieved cached dashboard data
  const factory GetCachedDashboardDataState.completed(
    DashboardEntity dashboard,
  ) = GetCachedDashboardDataCompleted;

  /// Error state when cached dashboard data retrieval failed.
  ///
  /// Parameters:
  /// - [message]: Error message describing what went wrong
  const factory GetCachedDashboardDataState.error(String message) =
      GetCachedDashboardDataError;
}

/// State for updating dashboard data operation.
/// This state represents the different states of the update dashboard data operation.
///
/// Usage Example:
/// ```dart
/// state.updateDashboardData.when(
///   initial: () => const SizedBox(),
///   loading: () => const CircularProgressIndicator(),
///   completed: () => const SuccessMessage('Dashboard updated successfully'),
///   error: (message) => ErrorWidget(message: message),
/// );
/// ```
@freezed
class UpdateDashboardDataState with _$UpdateDashboardDataState {
  /// Initial state when no update operation has been triggered yet.
  const factory UpdateDashboardDataState.initial() = UpdateDashboardDataInitial;

  /// Loading state when dashboard data is being updated.
  const factory UpdateDashboardDataState.loading() = UpdateDashboardDataLoading;

  /// Completed state when dashboard data has been successfully updated.
  const factory UpdateDashboardDataState.completed() =
      UpdateDashboardDataCompleted;

  /// Error state when dashboard data update failed.
  ///
  /// Parameters:
  /// - [message]: Error message describing what went wrong
  const factory UpdateDashboardDataState.error(String message) =
      UpdateDashboardDataError;
}

/// Main state combining all dashboard operation states.
/// This state class combines all individual operation states into a single state object.
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
  /// - [refreshDashboardData]: State for refresh dashboard data operation
  /// - [getCachedDashboardData]: State for get cached dashboard data operation
  /// - [updateDashboardData]: State for update dashboard data operation
  ///
  /// Usage Example:
  /// ```dart
  /// const initialState = DashboardState(
  ///   getDashboardData: GetDashboardDataState.initial(),
  ///   refreshDashboardData: RefreshDashboardDataState.initial(),
  ///   getCachedDashboardData: GetCachedDashboardDataState.initial(),
  ///   updateDashboardData: UpdateDashboardDataState.initial(),
  /// );
  /// ```
  const factory DashboardState({
    required GetDashboardDataState getDashboardData,
    required RefreshDashboardDataState refreshDashboardData,
    required GetCachedDashboardDataState getCachedDashboardData,
    required UpdateDashboardDataState updateDashboardData,
  }) = _DashboardState;
}
