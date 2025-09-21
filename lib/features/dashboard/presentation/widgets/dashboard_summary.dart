import 'package:flutter/material.dart';
import 'package:money_flow/core/widgets/widgets.dart';
import 'package:money_flow/core/theme/app_colors.dart';
import 'package:money_flow/core/constants/image_path.dart';
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
          imagePath: ImagePath.incomeImage,
          color: AppColors.success,
        ),
        GGap.small(),
        // Expenses Card
        DashboardCard(
          title: 'Expenses',
          amount: dashboard.totalExpenses,
          description: 'Spent this month',
          imagePath: ImagePath.expenseImage,
          color: AppColors.danger,
        ),
        GGap.small(),
        // Charity Card
        DashboardCard(
          title: 'Charity',
          amount: dashboard.totalCharity,
          description: 'Donated this month',
          imagePath: ImagePath.charityImage,
          color: AppColors.categoryPink,
        ),
        GGap.small(),
        // Investments Card
        DashboardCard(
          title: 'Investments',
          amount: dashboard.totalInvestments,
          description: 'Current value',
          imagePath: ImagePath.investImage,
          color: AppColors.categoryPurple,
        ),
      ],
    );
  }
}
