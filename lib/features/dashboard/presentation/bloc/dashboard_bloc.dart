import 'package:bloc/bloc.dart';
import 'package:money_flow/features/dashboard/domain/usecases/get_dashboard_data_usecase.dart';
import 'package:money_flow/features/dashboard/presentation/bloc/dashboard_event.dart';
import 'package:money_flow/features/dashboard/presentation/bloc/dashboard_state.dart';

/// BLoC for managing dashboard-related operations.
/// This BLoC handles dashboard data retrieval and state management.
///
/// Usage Example:
/// ```dart
/// BlocProvider<DashboardBloc>(
///   create: (context) => getIt<DashboardBloc>(),
///   child: const DashboardPage(),
/// );
///
/// // Trigger events
/// getIt<DashboardBloc>().add(
///   DashboardEvent.getDashboardData(userId: 'user123'),
/// );
/// ```
class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  /// Use case for getting dashboard data
  final GetDashboardDataUseCase getDashboardDataUseCase;

  /// Creates a new instance of DashboardBloc.
  ///
  /// Parameters:
  /// - [getDashboardDataUseCase]: Use case for getting dashboard data
  ///
  /// Usage Example:
  /// ```dart
  /// final bloc = DashboardBloc(
  ///   getDashboardDataUseCase: getIt<GetDashboardDataUseCase>(),
  /// );
  /// ```
  DashboardBloc({required this.getDashboardDataUseCase})
    : super(
        const DashboardState(getDashboardData: GetDashboardDataState.initial()),
      ) {
    // Register event handlers
    on<DashboardEvent>((event, emit) async {
      await event.when(
        getDashboardData: (userId) => _onGetDashboardData(userId, emit),
      );
    });
  }

  /// Handles the get dashboard data event.
  /// This method processes the get dashboard data event and updates the state accordingly.
  ///
  /// Parameters:
  /// - [userId]: Unique identifier for the user
  /// - [emit]: State emitter for updating the state
  ///
  /// Usage Example:
  /// ```dart
  /// await _onGetDashboardData('user123', emit);
  /// ```
  Future<void> _onGetDashboardData(
    String userId,
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
}
