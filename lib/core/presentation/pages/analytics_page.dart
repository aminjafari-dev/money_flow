import 'package:flutter/material.dart';
import 'package:money_flow/core/theme/app_colors.dart';
import 'package:money_flow/core/widgets/widgets.dart';
import 'package:money_flow/l10n/generated/app_localizations.dart';

/// Analytics page for displaying financial insights and charts.
/// This page provides detailed analytics about spending patterns, income trends, and financial goals.
///
/// Features:
/// - Interactive charts and graphs
/// - Spending category breakdown
/// - Income vs expense trends
/// - Budget tracking and alerts
/// - Export analytics reports
///
/// Usage Example:
/// ```dart
/// Navigator.push(
///   context,
///   MaterialPageRoute(builder: (context) => const AnalyticsPage()),
/// );
/// ```
class AnalyticsPage extends StatefulWidget {
  const AnalyticsPage({super.key});

  @override
  State<AnalyticsPage> createState() => _AnalyticsPageState();
}

class _AnalyticsPageState extends State<AnalyticsPage> {
  String _selectedTimeRange = 'monthly'; // Default time range

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return GScaffold(
      title: l10n.analytics,
      backgroundColor: AppColors.background,
      actions: [
        // Time range selector
        PopupMenuButton<String>(
          icon: Icon(Icons.date_range, color: AppColors.textSecondary),
          onSelected: _onTimeRangeChanged,
          itemBuilder: (context) => [
            PopupMenuItem(value: 'weekly', child: Text('Weekly')),
            PopupMenuItem(value: 'monthly', child: Text('Monthly')),
            PopupMenuItem(value: 'yearly', child: Text('Yearly')),
          ],
        ),
        // Export button for analytics reports
        IconButton(
          onPressed: _onExportTap,
          icon: Icon(Icons.file_download, color: AppColors.textSecondary),
          tooltip: 'Export analytics',
        ),
      ],
      body: _buildAnalyticsContent(l10n),
    );
  }

  /// Builds the main analytics content.
  /// This method creates the analytics charts and insights widgets.
  ///
  /// Parameters:
  /// - [l10n]: Localization instance for strings
  ///
  /// Returns:
  /// - [Widget]: Main analytics content widget
  Widget _buildAnalyticsContent(AppLocalizations l10n) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Time range indicator
          _buildTimeRangeIndicator(l10n),
          GGap.large(),

          // Analytics overview cards
          _buildOverviewCards(l10n),
          GGap.large(),

          // Charts section
          _buildChartsSection(l10n),
          GGap.large(),

          // Insights section
          _buildInsightsSection(l10n),
        ],
      ),
    );
  }

  /// Builds the time range indicator.
  /// This method shows the currently selected time range.
  ///
  /// Parameters:
  /// - [l10n]: Localization instance for strings
  ///
  /// Returns:
  /// - [Widget]: Time range indicator widget
  Widget _buildTimeRangeIndicator(AppLocalizations l10n) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.timeline, size: 16, color: AppColors.primary),
          GGap.small(),
          GText(
            'Showing $_selectedTimeRange data',
            style: GTextStyle.bodyMedium,
            color: AppColors.primary,
          ),
        ],
      ),
    );
  }

  /// Builds the overview cards section.
  /// This method creates summary cards with key financial metrics.
  ///
  /// Parameters:
  /// - [l10n]: Localization instance for strings
  ///
  /// Returns:
  /// - [Widget]: Overview cards widget
  Widget _buildOverviewCards(AppLocalizations l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GText('Financial Overview', style: GTextStyle.titleMedium),
        GGap.medium(),
        Row(
          children: [
            Expanded(
              child: _buildOverviewCard(
                title: 'Total Income',
                value: '\$0.00',
                icon: Icons.trending_up,
                color: Colors.green,
              ),
            ),
            GGap.medium(),
            Expanded(
              child: _buildOverviewCard(
                title: 'Total Expenses',
                value: '\$0.00',
                icon: Icons.trending_down,
                color: Colors.red,
              ),
            ),
          ],
        ),
      ],
    );
  }

  /// Builds an individual overview card.
  /// This method creates a single metric card with title, value, and icon.
  ///
  /// Parameters:
  /// - [title]: Card title
  /// - [value]: Card value
  /// - [icon]: Card icon
  /// - [color]: Card color theme
  ///
  /// Returns:
  /// - [Widget]: Overview card widget
  Widget _buildOverviewCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 20),
              GGap.small(),
              Expanded(
                child: GText(
                  title,
                  style: GTextStyle.bodySmall,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
          GGap.small(),
          GText(
            value,
            style: GTextStyle.titleLarge,
            color: AppColors.textPrimary,
          ),
        ],
      ),
    );
  }

  /// Builds the charts section.
  /// This method creates placeholder chart widgets.
  ///
  /// Parameters:
  /// - [l10n]: Localization instance for strings
  ///
  /// Returns:
  /// - [Widget]: Charts section widget
  Widget _buildChartsSection(AppLocalizations l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GText('Spending Analysis', style: GTextStyle.titleMedium),
        GGap.medium(),
        Container(
          height: 200,
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.border),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.bar_chart_outlined,
                  size: 48,
                  color: AppColors.textLight,
                ),
                GGap.small(),
                GText(
                  'Charts coming soon!',
                  style: GTextStyle.bodyMedium,
                  color: AppColors.textSecondary,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  /// Builds the insights section.
  /// This method creates placeholder insights widgets.
  ///
  /// Parameters:
  /// - [l10n]: Localization instance for strings
  ///
  /// Returns:
  /// - [Widget]: Insights section widget
  Widget _buildInsightsSection(AppLocalizations l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GText('Financial Insights', style: GTextStyle.titleMedium),
        GGap.medium(),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.border),
          ),
          child: Row(
            children: [
              Icon(Icons.lightbulb_outline, color: AppColors.warning, size: 24),
              GGap.medium(),
              Expanded(
                child: GText(
                  'Start adding transactions to see personalized insights!',
                  style: GTextStyle.bodyMedium,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// Handles time range selection change.
  /// This method updates the selected time range and refreshes analytics data.
  ///
  /// Parameters:
  /// - [timeRange]: Selected time range ('weekly', 'monthly', 'yearly')
  void _onTimeRangeChanged(String timeRange) {
    setState(() {
      _selectedTimeRange = timeRange;
    });

    // TODO: Refresh analytics data based on new time range
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Time range changed to $timeRange')));
  }

  /// Handles export button tap.
  /// This method exports analytics data as a report.
  void _onExportTap() {
    // TODO: Implement analytics export functionality
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Export functionality coming soon!')),
    );
  }
}
