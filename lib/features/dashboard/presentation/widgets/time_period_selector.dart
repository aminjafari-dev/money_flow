import 'package:flutter/material.dart';
import 'package:money_flow/core/widgets/widgets.dart';
import 'package:money_flow/core/theme/app_colors.dart';

/// Enum for different time periods that can be selected in the dashboard.
/// This enum defines the available time periods for viewing financial data.
///
/// Usage Example:
/// ```dart
/// TimePeriod.weekly // Shows weekly data
/// TimePeriod.monthly // Shows monthly data
/// TimePeriod.yearly // Shows yearly data
/// ```
enum TimePeriod {
  /// Weekly time period - shows data for the current week
  weekly,

  /// Monthly time period - shows data for the current month
  monthly,

  /// Yearly time period - shows data for the current year
  yearly,
}

/// Extension on TimePeriod to provide display names and other utilities.
/// This extension adds convenient methods for working with TimePeriod enum.
///
/// Usage Example:
/// ```dart
/// TimePeriod.weekly.displayName // Returns "Weekly"
/// TimePeriod.monthly.getShortName() // Returns "Monthly"
/// ```
extension TimePeriodExtension on TimePeriod {
  /// Gets the display name for the time period.
  /// This method returns a user-friendly string representation of the time period.
  ///
  /// Returns:
  /// - [String]: Display name of the time period
  String get displayName {
    switch (this) {
      case TimePeriod.weekly:
        return 'Weekly';
      case TimePeriod.monthly:
        return 'Monthly';
      case TimePeriod.yearly:
        return 'Yearly';
    }
  }

  /// Gets the short name for the time period.
  /// This method returns a shorter string representation of the time period.
  ///
  /// Returns:
  /// - [String]: Short name of the time period
  String getShortName() {
    switch (this) {
      case TimePeriod.weekly:
        return 'Week';
      case TimePeriod.monthly:
        return 'Month';
      case TimePeriod.yearly:
        return 'Year';
    }
  }
}

/// Widget for selecting time periods in the dashboard.
/// This widget displays a segmented control allowing users to switch between
/// Weekly, Monthly, and Yearly views of their financial data.
///
/// Usage Example:
/// ```dart
/// TimePeriodSelector(
///   selectedPeriod: TimePeriod.monthly,
///   onPeriodChanged: (period) {
///     // Handle period change
///     print('Selected period: ${period.displayName}');
///   },
/// )
/// ```
class TimePeriodSelector extends StatelessWidget {
  /// Currently selected time period
  final TimePeriod selectedPeriod;

  /// Callback function called when time period changes
  final ValueChanged<TimePeriod> onPeriodChanged;

  const TimePeriodSelector({
    super.key,
    required this.selectedPeriod,
    required this.onPeriodChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border, width: 1),
      ),
      child: Row(
        children: TimePeriod.values.map((period) {
          // Check if this period is currently selected
          final isSelected = period == selectedPeriod;

          return Expanded(
            child: GestureDetector(
              onTap: () {
                // Only trigger callback if period actually changed
                if (!isSelected) {
                  onPeriodChanged(period);
                }
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.primary : Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: GText(
                    period.displayName,
                    style: GTextStyle.bodyMedium,
                    fontWeight: FontWeight.w600,
                    color: isSelected
                        ? AppColors.textWhite
                        : AppColors.textSecondary,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
