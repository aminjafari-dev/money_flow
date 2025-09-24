import 'package:flutter/material.dart';
import 'package:money_flow/core/widgets/widgets.dart';
import 'package:money_flow/core/theme/app_colors.dart';

/// Widget for selecting time period (Weekly, Monthly, Yearly).
/// This widget provides a segmented control for time period selection.
///
/// Usage Example:
/// ```dart
/// TimePeriodSelector(
///   selectedPeriod: 'weekly',
///   onPeriodChanged: (period) => print('Selected: $period'),
/// ),
/// ```
class TimePeriodSelector extends StatelessWidget {
  /// Currently selected time period
  final String selectedPeriod;

  /// Callback function when time period changes
  final Function(String) onPeriodChanged;

  const TimePeriodSelector({
    super.key,
    required this.selectedPeriod,
    required this.onPeriodChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.backgroundLight,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border, width: 1),
      ),
      child: Row(
        children: [
          _buildPeriodButton('weekly', 'Weekly'),
          _buildPeriodButton('monthly', 'Monthly'),
          _buildPeriodButton('yearly', 'Yearly'),
        ],
      ),
    );
  }

  /// Builds individual period selection button.
  /// This method creates a button for each time period option.
  ///
  /// Parameters:
  /// - [period]: Time period value ('weekly', 'monthly', 'yearly')
  /// - [label]: Display label for the button
  ///
  /// Returns:
  /// - [Widget]: Period selection button
  Widget _buildPeriodButton(String period, String label) {
    final isSelected = selectedPeriod == period;

    return Expanded(
      child: GestureDetector(
        onTap: () => onPeriodChanged(period),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: GText(
            label,
            style: GTextStyle.bodyMedium,
            color: isSelected ? AppColors.textWhite : AppColors.textSecondary,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
