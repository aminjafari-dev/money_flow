import 'package:flutter/material.dart';
import 'package:money_flow/core/widgets/widgets.dart';
import 'package:money_flow/core/theme/app_colors.dart';

/// Widget for displaying individual dashboard financial cards.
/// This widget shows financial information in a clean card format.
///
/// Usage Example:
/// ```dart
/// DashboardCard(
///   title: 'Income',
///   amount: 2500.0,
///   description: 'Received this month',
///   imagePath: ImagePath.incomeImage,
///   color: Colors.green,
/// ),
/// ```
class DashboardCard extends StatelessWidget {
  /// Title of the financial category
  final String title;

  /// Amount value to display
  final double amount;

  /// Description text below the amount
  final String description;

  /// Image path to display on the right side
  final String imagePath;

  /// Color for the image background
  final Color color;

  const DashboardCard({
    super.key,
    required this.title,
    required this.amount,
    required this.description,
    required this.imagePath,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Left side - Text content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GText(
                  title,
                  style: GTextStyle.bodyMedium,
                  color: AppColors.textSecondary,
                  fontSize: 14,
                ),
                GGap.small(),
                GText(
                  '\$${amount.toStringAsFixed(0)}',
                  style: GTextStyle.headlineMedium,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: AppColors.textPrimary,
                ),
                GGap.small(),
                GText(
                  description,
                  style: GTextStyle.bodySmall,
                  color: AppColors.textLight,
                  fontSize: 12,
                ),
              ],
            ),
          ),
          // Right side - Image
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.withOpacity(color, 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                imagePath,
                width: 48,
                height: 48,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
