import 'package:flutter/material.dart';
import '../widgets/g_gap.dart';
import 'app_colors.dart';
import 'app_fonts.dart';

/// Example usage of the Money Flow app theme system.
/// This file demonstrates how to use AppColors and AppFonts throughout the application.
///
/// Based on UI/UX design rules:
/// - Use AppColors for all color references
/// - Use AppFonts for all text styling
/// - Follow the design system for consistent UI
///
/// Usage Example:
/// ```dart
/// import 'package:money_flow/core/theme/theme_examples.dart';
///
/// // Use in your widgets
/// ThemeExampleWidget()
/// ```
class ThemeExampleWidget extends StatelessWidget {
  const ThemeExampleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          'Theme Examples',
          style: AppFonts.headingLarge.copyWith(color: AppColors.textWhite),
        ),
        backgroundColor: AppColors.primary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Typography Examples
            _buildTypographySection(),
            GGap.large(),

            // Color Examples
            _buildColorSection(),
            GGap.large(),

            // Button Examples
            _buildButtonSection(),
            GGap.large(),

            // Card Examples
            _buildCardSection(),
            GGap.large(),

            // Financial Data Examples
            _buildFinancialDataSection(),
          ],
        ),
      ),
    );
  }

  /// Typography section demonstrating different text styles
  Widget _buildTypographySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Typography Examples',
          style: AppFonts.headingLarge.copyWith(color: AppColors.textPrimary),
        ),
        GGap.medium(),

        // Headings
        Text(
          'Extra Large Heading (24pt)',
          style: AppFonts.headingXL.copyWith(color: AppColors.textPrimary),
        ),
        GGap.small(),
        Text(
          'Large Heading (20pt)',
          style: AppFonts.headingLarge.copyWith(color: AppColors.textPrimary),
        ),
        GGap.small(),
        Text(
          'Medium Heading (18pt)',
          style: AppFonts.headingMedium.copyWith(color: AppColors.textPrimary),
        ),
        GGap.small(),
        Text(
          'Small Heading (16pt)',
          style: AppFonts.headingSmall.copyWith(color: AppColors.textPrimary),
        ),
        GGap.medium(),

        // Body Text
        Text(
          'Large Body Text (16pt) - Used for main content and descriptions',
          style: AppFonts.bodyLarge.copyWith(color: AppColors.textPrimary),
        ),
        GGap.small(),
        Text(
          'Medium Body Text (14pt) - Used for standard text content and labels',
          style: AppFonts.bodyMedium.copyWith(color: AppColors.textPrimary),
        ),
          GGap.small(),
        Text(
          'Small Body Text (12pt) - Used for secondary text and captions',
          style: AppFonts.bodySmall.copyWith(color: AppColors.textSecondary),
        ),
        GGap.medium(),

        // Values
        Text(
          'Extra Large Value (32pt) - For main financial amounts',
          style: AppFonts.valueXL.copyWith(color: AppColors.textPrimary),
        ),
        const SizedBox(height: 8),
        Text(
          'Large Value (24pt) - For category totals',
          style: AppFonts.valueLarge.copyWith(color: AppColors.textPrimary),
        ),
        const SizedBox(height: 8),
        Text(
          'Medium Value (20pt) - For standard amounts',
          style: AppFonts.valueMedium.copyWith(color: AppColors.textPrimary),
        ),
        const SizedBox(height: 8),
        Text(
          'Small Value (16pt) - For secondary values',
          style: AppFonts.valueSmall.copyWith(color: AppColors.textPrimary),
        ),
      ],
    );
  }

  /// Color section demonstrating different color usage
  Widget _buildColorSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Color Examples',
          style: AppFonts.headingLarge.copyWith(color: AppColors.textPrimary),
        ),
        const SizedBox(height: 16),

        // Primary Colors
        _buildColorRow('Primary', AppColors.primary, AppColors.textWhite),
        _buildColorRow(
          'Primary Light',
          AppColors.primaryLight,
          AppColors.textPrimary,
        ),
        _buildColorRow(
          'Primary Dark',
          AppColors.primaryDark,
          AppColors.textWhite,
        ),
        const SizedBox(height: 16),

        // Semantic Colors
        _buildColorRow('Success', AppColors.success, AppColors.textWhite),
        _buildColorRow(
          'Success Light',
          AppColors.successLight,
          AppColors.textPrimary,
        ),
        _buildColorRow('Danger', AppColors.danger, AppColors.textWhite),
        _buildColorRow(
          'Danger Light',
          AppColors.dangerLight,
          AppColors.textPrimary,
        ),
        _buildColorRow('Warning', AppColors.warning, AppColors.textWhite),
        _buildColorRow(
          'Warning Light',
          AppColors.warningLight,
          AppColors.textPrimary,
        ),
        const SizedBox(height: 16),

        // Text Colors
        _buildColorRow(
          'Text Primary',
          AppColors.textPrimary,
          AppColors.textWhite,
        ),
        _buildColorRow(
          'Text Secondary',
          AppColors.textSecondary,
          AppColors.textWhite,
        ),
        _buildColorRow(
          'Text Light',
          AppColors.textLight,
          AppColors.textPrimary,
        ),
        const SizedBox(height: 16),

        // Background Colors
        _buildColorRow(
          'Background',
          AppColors.background,
          AppColors.textPrimary,
        ),
        _buildColorRow(
          'Background Light',
          AppColors.backgroundLight,
          AppColors.textPrimary,
        ),
        _buildColorRow('Surface', AppColors.surface, AppColors.textPrimary),
        _buildColorRow('Border', AppColors.border, AppColors.textPrimary),
      ],
    );
  }

  /// Button section demonstrating different button styles
  Widget _buildButtonSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Button Examples',
          style: AppFonts.headingLarge.copyWith(color: AppColors.textPrimary),
        ),
        const SizedBox(height: 16),

        // Primary Button
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: AppColors.textWhite,
              textStyle: AppFonts.buttonPrimary,
            ),
            child: const Text('Primary Button'),
          ),
        ),
        const SizedBox(height: 12),

        // Secondary Button
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.surface,
              foregroundColor: AppColors.textPrimary,
              textStyle: AppFonts.buttonSecondary,
            ),
            child: const Text('Secondary Button'),
          ),
        ),
        const SizedBox(height: 12),

        // Small Button
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.success,
              foregroundColor: AppColors.textWhite,
              textStyle: AppFonts.buttonSmall,
            ),
            child: const Text('Small Button'),
          ),
        ),
      ],
    );
  }

  /// Card section demonstrating card styling
  Widget _buildCardSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Card Examples',
          style: AppFonts.headingLarge.copyWith(color: AppColors.textPrimary),
        ),
        const SizedBox(height: 16),

        // Standard Card
        Card(
          color: AppColors.surface,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Standard Card',
                  style: AppFonts.headingSmall.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'This is a standard card with surface color background.',
                  style: AppFonts.bodyMedium.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),

        // Success Card
        Card(
          color: AppColors.successLight,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Success Card',
                  style: AppFonts.headingSmall.copyWith(
                    color: AppColors.successDark,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'This card uses success light background for positive feedback.',
                  style: AppFonts.bodyMedium.copyWith(
                    color: AppColors.successDark,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),

        // Warning Card
        Card(
          color: AppColors.warningLight,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Warning Card',
                  style: AppFonts.headingSmall.copyWith(
                    color: AppColors.warningDark,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'This card uses warning light background for caution messages.',
                  style: AppFonts.bodyMedium.copyWith(
                    color: AppColors.warningDark,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  /// Financial data section demonstrating financial-specific styling
  Widget _buildFinancialDataSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Financial Data Examples',
          style: AppFonts.headingLarge.copyWith(color: AppColors.textPrimary),
        ),
        const SizedBox(height: 16),

        // Income Example
        _buildFinancialCard(
          'Income',
          '\$2,500.00',
          'Received this month',
          AppColors.success,
          AppColors.successLight,
        ),
        const SizedBox(height: 12),

        // Expense Example
        _buildFinancialCard(
          'Expenses',
          '\$1,200.00',
          'Spent this month',
          AppColors.danger,
          AppColors.dangerLight,
        ),
        const SizedBox(height: 12),

        // Investment Example
        _buildFinancialCard(
          'Investments',
          '\$5,000.00',
          'Current value',
          AppColors.primary,
          AppColors.primaryLight,
        ),
        const SizedBox(height: 12),

        // Charity Example
        _buildFinancialCard(
          'Charity',
          '\$100.00',
          'Donated this month',
          AppColors.warning,
          AppColors.warningLight,
        ),
      ],
    );
  }

  /// Helper method to build color demonstration rows
  Widget _buildColorRow(String name, Color color, Color textColor) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              name,
              style: AppFonts.bodyMedium.copyWith(color: textColor),
            ),
          ),
          Text(
            '#${color.value.toRadixString(16).substring(2).toUpperCase()}',
            style: AppFonts.bodySmall.copyWith(color: textColor),
          ),
        ],
      ),
    );
  }

  /// Helper method to build financial data cards
  Widget _buildFinancialCard(
    String title,
    String amount,
    String subtitle,
    Color amountColor,
    Color cardColor,
  ) {
    return Card(
      color: cardColor,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppFonts.labelLarge.copyWith(
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: AppFonts.bodySmall.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              amount,
              style: AppFonts.valueLarge.copyWith(color: amountColor),
            ),
          ],
        ),
      ),
    );
  }
}
