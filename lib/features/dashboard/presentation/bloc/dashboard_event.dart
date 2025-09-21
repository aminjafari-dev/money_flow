import 'package:freezed_annotation/freezed_annotation.dart';

part 'dashboard_event.freezed.dart';

/// Sealed class for dashboard-related events.
/// This class defines all possible events that can be triggered for dashboard operations.
///
/// Usage Example:
/// ```dart
/// // Trigger get dashboard data event
/// context.read<DashboardBloc>().add(
///   DashboardEvent.getDashboardData(userId: 'user123'),
/// );
///
/// // Trigger refresh dashboard data event
/// context.read<DashboardBloc>().add(
///   DashboardEvent.refreshDashboardData(userId: 'user123'),
/// );
/// ```
@freezed
class DashboardEvent with _$DashboardEvent {
  /// Event to trigger getting dashboard data for a user.
  /// This event fetches the current dashboard data from local storage.
  ///
  /// Parameters:
  /// - [userId]: Unique identifier for the user
  ///
  /// Usage Example:
  /// ```dart
  /// context.read<DashboardBloc>().add(
  ///   DashboardEvent.getDashboardData(userId: 'user123'),
  /// );
  /// ```
  const factory DashboardEvent.getDashboardData({required String userId}) =
      GetDashboardData;

  /// Event to trigger refreshing dashboard data for a user.
  /// This event recalculates dashboard data from stored transactions.
  ///
  /// Parameters:
  /// - [userId]: Unique identifier for the user
  ///
  /// Usage Example:
  /// ```dart
  /// context.read<DashboardBloc>().add(
  ///   DashboardEvent.refreshDashboardData(userId: 'user123'),
  /// );
  /// ```
  const factory DashboardEvent.refreshDashboardData({required String userId}) =
      RefreshDashboardData;

  /// Event to trigger getting cached dashboard data for offline access.
  /// This event retrieves previously cached dashboard data.
  ///
  /// Parameters:
  /// - [userId]: Unique identifier for the user
  ///
  /// Usage Example:
  /// ```dart
  /// context.read<DashboardBloc>().add(
  ///   DashboardEvent.getCachedDashboardData(userId: 'user123'),
  /// );
  /// ```
  const factory DashboardEvent.getCachedDashboardData({
    required String userId,
  }) = GetCachedDashboardData;

  /// Event to trigger updating dashboard data with new information.
  /// This event saves updated dashboard data to local storage.
  ///
  /// Parameters:
  /// - [userId]: Unique identifier for the user
  /// - [dashboard]: Updated dashboard data to save
  ///
  /// Usage Example:
  /// ```dart
  /// context.read<DashboardBloc>().add(
  ///   DashboardEvent.updateDashboardData(
  ///     userId: 'user123',
  ///     dashboard: updatedDashboard,
  ///   ),
  /// );
  /// ```
  const factory DashboardEvent.updateDashboardData({
    required String userId,
    required Map<String, dynamic> dashboard,
  }) = UpdateDashboardData;
}
