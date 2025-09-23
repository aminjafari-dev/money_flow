import 'package:freezed_annotation/freezed_annotation.dart';

part 'dashboard_event.freezed.dart';

/// Sealed class for dashboard-related events.
/// This class defines all possible events that can be triggered for dashboard operations.
///
/// Usage Example:
/// ```dart
/// // Trigger get dashboard data event
/// getIt<DashboardBloc>().add(
///   DashboardEvent.getDashboardData(userId: 'user123'),
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
  /// getIt<DashboardBloc>().add(
  ///   DashboardEvent.getDashboardData(userId: 'user123'),
  /// );
  /// ```
  const factory DashboardEvent.getDashboardData({required String userId}) =
      GetDashboardData;
}
