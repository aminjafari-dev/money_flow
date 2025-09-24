import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_flow/core/di/locator.dart';
import 'package:money_flow/core/widgets/widgets.dart';
import 'package:money_flow/core/theme/app_colors.dart';
import 'package:money_flow/core/router/page_name.dart';
import 'package:money_flow/l10n/generated/app_localizations.dart';
import 'package:money_flow/features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:money_flow/features/dashboard/presentation/bloc/dashboard_event.dart';
import 'package:money_flow/features/dashboard/presentation/bloc/dashboard_state.dart';
import 'package:money_flow/features/dashboard/presentation/widgets/dashboard_summary.dart';
import 'package:money_flow/features/dashboard/presentation/widgets/recent_transactions.dart';
import 'package:money_flow/features/dashboard/domain/entities/dashboard_entity.dart';

/// Main dashboard page for displaying financial overview.
/// This page serves as the central command center for the finance app.
///
/// Usage Example:
/// ```dart
/// Navigator.push(
///   context,
///   MaterialPageRoute(builder: (context) => const DashboardPage()),
/// );
/// ```
class DashboardPage extends StatefulWidget {
  /// User ID for dashboard data retrieval
  final String userId;

  const DashboardPage({super.key, required this.userId});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late final DashboardBloc _dashboardBloc;

  @override
  void initState() {
    super.initState();
    // Get the BLoC instance once and reuse it
    _dashboardBloc = getIt<DashboardBloc>();
    // Load dashboard data when page initializes
    _dashboardBloc.add(DashboardEvent.getDashboardData(userId: widget.userId));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return BlocProvider.value(
      value: _dashboardBloc,
      child: GScaffold(
        title: l10n.dashboard,
        backgroundColor: AppColors.background,
        actions: [
          IconButton(
            onPressed: _onSettingsTap,
            icon: Icon(Icons.settings, color: AppColors.textSecondary),
          ),
        ],
        body: BlocBuilder<DashboardBloc, DashboardState>(
          builder: (context, state) {
            return state.getDashboardData.when(
              initial: () => _InitialWidget(l10n: l10n),
              loading: () => const _LoadingWidget(),
              completed: (dashboard) =>
                  _DashboardContent(dashboard: dashboard, l10n: l10n),
              error: (message) => _ErrorWidget(
                message: message,
                l10n: l10n,
                onRetry: () => _dashboardBloc.add(
                  DashboardEvent.getDashboardData(userId: widget.userId),
                ),
              ),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _onAddTransactionTap,
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.textWhite,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  /// Handles settings icon tap.
  /// This method navigates to the settings page.
  void _onSettingsTap() {
    final l10n = AppLocalizations.of(context);
    // TODO: Navigate to settings page
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: GText(l10n.settingsComingSoon)));
  }

  /// Handles add transaction button tap.
  /// This method navigates to the add transaction page and refreshes dashboard on return.
  void _onAddTransactionTap() async {
    // Navigate to the Add Transaction page using named routes
    final result = await Navigator.of(
      context,
    ).pushNamed(PageName.addTransaction);

    // If a transaction was added (result is not null), refresh the dashboard
    if (result != null) {
      _dashboardBloc.add(
        DashboardEvent.getDashboardData(userId: widget.userId),
      );
    }
  }
}

/// Widget for displaying the initial state.
/// This widget is shown when no data has been loaded yet.
class _InitialWidget extends StatelessWidget {
  final AppLocalizations? l10n;

  const _InitialWidget({this.l10n});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GText(l10n?.welcomeToDashboard ?? 'Welcome to your dashboard!'),
    );
  }
}

/// Widget for displaying the loading state.
/// This widget is shown while dashboard data is being fetched.
class _LoadingWidget extends StatelessWidget {
  const _LoadingWidget();

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}

/// Widget for displaying the error state.
/// This widget is shown when there's an error loading dashboard data.
class _ErrorWidget extends StatelessWidget {
  /// Error message to display
  final String message;

  /// Localization instance for localized strings
  final AppLocalizations? l10n;

  /// Callback function to retry the operation
  final VoidCallback onRetry;

  const _ErrorWidget({required this.message, this.l10n, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 64, color: AppColors.textLight),
          const SizedBox(height: 16),
          GText(
            l10n?.somethingWentWrong ?? 'Something went wrong',
            style: GTextStyle.titleLarge,
          ),
          const SizedBox(height: 8),
          GText(
            message,
            style: GTextStyle.bodyMedium,
            color: AppColors.textSecondary,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: onRetry,
            child: GText(l10n?.retry ?? 'Retry'),
          ),
        ],
      ),
    );
  }
}

/// Widget for displaying the dashboard content.
/// This widget shows the main dashboard content when data is loaded.
class _DashboardContent extends StatelessWidget {
  /// Dashboard data to display
  final DashboardEntity dashboard;

  /// Localization instance for localized strings
  final AppLocalizations? l10n;

  const _DashboardContent({required this.dashboard, this.l10n});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Financial Summary Cards
          DashboardSummary(dashboard: dashboard, l10n: l10n),
          const SizedBox(height: 24),
          // Recent Transactions
          RecentTransactions(
            transactions: dashboard.recentTransactions,
            l10n: l10n,
          ),
          const SizedBox(height: 80), // Space for FAB
        ],
      ),
    );
  }
}
