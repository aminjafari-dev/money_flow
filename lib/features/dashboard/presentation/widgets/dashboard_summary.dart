import 'package:flutter/material.dart';
import 'package:money_flow/core/widgets/widgets.dart';
import 'package:money_flow/core/theme/app_colors.dart';
import 'package:money_flow/features/dashboard/domain/entities/dashboard_entity.dart';
import 'package:money_flow/features/dashboard/presentation/widgets/dashboard_card.dart';

/// Widget for displaying the financial summary section of the dashboard.
/// This widget shows key financial metrics in card format.
///
/// Usage Example:
/// ```dart
/// DashboardSummary(
///   dashboard: dashboardEntity,
/// ),
/// ```
class DashboardSummary extends StatelessWidget {
  /// Dashboard entity containing financial data
  final DashboardEntity dashboard;

  const DashboardSummary({super.key, required this.dashboard});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: GText(
            'Financial Overview',
            style: GTextStyle.titleMedium,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        GGap.medium(),
        // Financial Cards Grid
        _buildFinancialCards(),
        GGap.medium(),
        // Net Worth Card
        _buildNetWorthCard(),
      ],
    );
  }

  /// Builds the grid of financial cards showing income, expenses, charity, and investments.
  /// This method creates a responsive grid layout for the main financial metrics.
  ///
  /// Returns:
  /// - [Widget]: Grid of financial cards
  Widget _buildFinancialCards() {
    return Column(
      children: [
        // Income Card
        DashboardCard(
          title: 'Income',
          amount: dashboard.totalIncome,
          description: 'Received this month',
          icon: Icons.account_balance_wallet,
          color: AppColors.success,
        ),
        GGap.small(),
        // Expenses Card
        DashboardCard(
          title: 'Expenses',
          amount: dashboard.totalExpenses,
          description: 'Spent this month',
          icon: Icons.credit_card,
          color: AppColors.danger,
        ),
        GGap.small(),
        // Charity Card
        DashboardCard(
          title: 'Charity',
          amount: dashboard.totalCharity,
          description: 'Donated this month',
          icon: Icons.favorite,
          color: AppColors.categoryPink,
        ),
        GGap.small(),
        // Investments Card
        DashboardCard(
          title: 'Investments',
          amount: dashboard.totalInvestments,
          description: 'Current value',
          icon: Icons.bar_chart,
          color: AppColors.categoryPurple,
        ),
      ],
    );
  }

  /// Builds the net worth card showing overall financial health.
  /// This method creates a special card that displays the calculated net worth.
  ///
  /// Returns:
  /// - [Widget]: Net worth card
  Widget _buildNetWorthCard() {
    final netWorth = dashboard.netWorth;
    final isPositive = netWorth >= 0;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isPositive
              ? AppColors.successGradient
              : AppColors.dangerGradient,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.withOpacity(
              isPositive ? AppColors.success : AppColors.danger,
              0.3,
            ),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Left side - Net Worth info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GText(
                  'Net Worth',
                  style: GTextStyle.bodyMedium,
                  color: AppColors.textWhite.withValues(alpha: 0.9),
                  fontSize: 14,
                ),
                GGap.small(),
                GText(
                  '\$${netWorth.abs().toStringAsFixed(0)}',
                  style: GTextStyle.headlineLarge,
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                  color: AppColors.textWhite,
                ),
                GGap.small(),
                GText(
                  isPositive
                      ? 'You\'re doing great!'
                      : 'Consider reducing expenses',
                  style: GTextStyle.bodySmall,
                  color: AppColors.textWhite.withValues(alpha: 0.8),
                  fontSize: 12,
                ),
              ],
            ),
          ),
          // Right side - Icon
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: AppColors.textWhite.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(
              isPositive ? Icons.trending_up : Icons.trending_down,
              color: AppColors.textWhite,
              size: 28,
            ),
          ),
        ],
      ),
    );
  }
}
