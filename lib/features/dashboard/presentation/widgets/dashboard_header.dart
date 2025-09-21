import 'package:flutter/material.dart';
import 'package:money_flow/core/widgets/widgets.dart';
import 'package:money_flow/core/theme/app_colors.dart';

/// Widget for displaying the dashboard header with title and settings icon.
/// This widget provides the top section of the dashboard page.
///
/// Usage Example:
/// ```dart
/// DashboardHeader(
///   onSettingsTap: () => Navigator.pushNamed(context, '/settings'),
/// ),
/// ```
class DashboardHeader extends StatelessWidget {
  /// Callback function when settings icon is tapped
  final VoidCallback? onSettingsTap;

  const DashboardHeader({super.key, this.onSettingsTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Title
          GText(
            'Dashboard',
            style: GTextStyle.titleLarge,
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: AppColors.textPrimary,
          ),
          // Settings Icon
          IconButton(
            onPressed: onSettingsTap,
            icon: Icon(
              Icons.settings,
              color: AppColors.textSecondary,
              size: 24,
            ),
          ),
        ],
      ),
    );
  }
}
