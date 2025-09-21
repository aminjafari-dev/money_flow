# Money Flow App Theme System

This directory contains the comprehensive theme system for the Money Flow app, following the UI/UX design rules for a clean, minimalist financial application.

## Overview

The theme system is built on three main components:
- **AppColors**: Comprehensive color palette following design rules
- **AppFonts**: Typography system with consistent font weights and sizes
- **AppTheme**: Main theme configuration using Material Design 3

## Design Principles

Based on the UI/UX design rules:

### Color Scheme
- **Primary**: Blue (#007BFF) for interactive elements like buttons and navigation
- **Semantic**: Green (#28A745) for positive values, Red (#DC3545) for negative values
- **Neutral**: Grays for secondary text and borders
- **Support**: Both light and dark themes with proper contrast

### Typography
- **Headings**: Bold sans-serif (18-24pt) for page titles
- **Body**: Regular sans-serif (14-16pt) for labels and descriptions
- **Values**: Larger bold font (20-32pt) for key financial figures
- **Consistency**: Limited to 2-3 font weights for clean design

## File Structure

```
lib/core/theme/
├── app_colors.dart          # Color palette and semantic colors
├── app_fonts.dart           # Typography system and text styles
├── app_theme.dart           # Main theme configuration
├── theme_examples.dart      # Usage examples and demonstrations
└── README.md               # This documentation
```

## Usage Examples

### Using Colors

```dart
import 'package:money_flow/core/theme/app_colors.dart';

// Direct color usage
Container(
  color: AppColors.primary,
  child: Text('Primary button'),
)

// Semantic colors for financial data
Text(
  '\$2,500.00',
  style: TextStyle(color: AppColors.success), // Green for income
)

Text(
  '\$1,200.00',
  style: TextStyle(color: AppColors.danger), // Red for expenses
)

// Category colors
Container(
  color: AppColors.categoryBlue,
  child: Icon(Icons.shopping_cart),
)
```

### Using Fonts

```dart
import 'package:money_flow/core/theme/app_fonts.dart';

// Heading styles
Text(
  'Dashboard',
  style: AppFonts.headingLarge, // 20pt, bold
)

Text(
  'Recent Transactions',
  style: AppFonts.headingMedium, // 18pt, semi-bold
)

// Body text styles
Text(
  'This is the main content text.',
  style: AppFonts.bodyLarge, // 16pt, regular
)

Text(
  'Secondary information',
  style: AppFonts.bodySmall, // 12pt, regular
)

// Value styles for financial data
Text(
  '\$2,500.00',
  style: AppFonts.valueLarge, // 24pt, bold
)

Text(
  '\$85.50',
  style: AppFonts.valueMedium, // 20pt, semi-bold
)

// Button styles
ElevatedButton(
  onPressed: () {},
  style: ElevatedButton.styleFrom(
    textStyle: AppFonts.buttonPrimary, // 16pt, medium
  ),
  child: Text('Save'),
)
```

### Using Theme Extension

```dart
import 'package:money_flow/core/theme/app_theme.dart';

// Using the theme extension
Widget build(BuildContext context) {
  return Container(
    color: context.primary, // AppColors.primary
    child: Text(
      'Hello World',
      style: context.appFonts.bodyLarge,
    ),
  );
}
```

### Complete Widget Example

```dart
import 'package:flutter/material.dart';
import 'package:money_flow/core/theme/app_colors.dart';
import 'package:money_flow/core/theme/app_fonts.dart';

class FinancialCard extends StatelessWidget {
  final String title;
  final String amount;
  final String subtitle;
  final bool isPositive;

  const FinancialCard({
    super.key,
    required this.title,
    required this.amount,
    required this.subtitle,
    required this.isPositive,
  });

  @override
  Widget build(BuildContext context) {
    final amountColor = isPositive ? AppColors.success : AppColors.danger;
    final cardColor = isPositive ? AppColors.successLight : AppColors.dangerLight;

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
```

## Color Categories

### Primary Colors
- `AppColors.primary` - Main blue (#007BFF)
- `AppColors.primaryLight` - Light blue with transparency
- `AppColors.primaryDark` - Darker blue for pressed states

### Semantic Colors
- `AppColors.success` - Green for positive values (#28A745)
- `AppColors.danger` - Red for negative values (#DC3545)
- `AppColors.warning` - Orange for warnings (#FD7E14)
- `AppColors.alert` - Yellow for alerts (#FFC107)

### Text Colors
- `AppColors.textPrimary` - Main text color (#212529)
- `AppColors.textSecondary` - Secondary text color (#6C757D)
- `AppColors.textLight` - Light text for disabled content
- `AppColors.textWhite` - White text for dark backgrounds

### Background Colors
- `AppColors.background` - Main background (#FFFFFF)
- `AppColors.backgroundLight` - Light gray background (#F5F5F5)
- `AppColors.surface` - Surface color for cards (#FAFAFA)
- `AppColors.border` - Border color (#E9ECEF)

### Category Colors
- `AppColors.categoryBlue` - General categories
- `AppColors.categoryGreen` - Income categories
- `AppColors.categoryOrange` - Expense categories
- `AppColors.categoryPink` - Charity categories
- `AppColors.categoryPurple` - Investment categories
- `AppColors.categoryTeal` - Utility categories

### Dark Theme Colors
- `AppColors.darkBackground` - Dark background (#121212)
- `AppColors.darkSurface` - Dark surface (#1E1E1E)
- `AppColors.darkBorder` - Dark border (#404040)
- `AppColors.darkTextPrimary` - Dark text primary
- `AppColors.darkTextSecondary` - Dark text secondary

## Font Styles

### Heading Styles
- `AppFonts.headingXL` - Extra large (24pt, bold)
- `AppFonts.headingLarge` - Large (20pt, bold)
- `AppFonts.headingMedium` - Medium (18pt, semi-bold)
- `AppFonts.headingSmall` - Small (16pt, semi-bold)

### Body Styles
- `AppFonts.bodyLarge` - Large (16pt, regular)
- `AppFonts.bodyMedium` - Medium (14pt, regular)
- `AppFonts.bodySmall` - Small (12pt, regular)

### Value Styles
- `AppFonts.valueXL` - Extra large (32pt, bold)
- `AppFonts.valueLarge` - Large (24pt, bold)
- `AppFonts.valueMedium` - Medium (20pt, semi-bold)
- `AppFonts.valueSmall` - Small (16pt, medium)

### Label Styles
- `AppFonts.labelLarge` - Large (14pt, medium)
- `AppFonts.labelMedium` - Medium (12pt, medium)
- `AppFonts.labelSmall` - Small (10pt, medium)

### Button Styles
- `AppFonts.buttonPrimary` - Primary (16pt, medium)
- `AppFonts.buttonSecondary` - Secondary (14pt, medium)
- `AppFonts.buttonSmall` - Small (12pt, medium)

### Navigation Styles
- `AppFonts.navigationLabel` - Bottom nav (12pt, medium)
- `AppFonts.tabLabel` - Tab nav (14pt, medium)

### Monospace Styles
- `AppFonts.monospace` - Numbers (16pt, medium)
- `AppFonts.monospaceSmall` - Small numbers (14pt, medium)

## Utility Methods

### Color Utilities
```dart
// Get color with opacity
Color semiTransparent = AppColors.withOpacity(AppColors.primary, 0.5);

// Get color for amount based on positive/negative
Color amountColor = AppColors.getAmountColor(100.0); // Returns success color
Color amountColor = AppColors.getAmountColor(-50.0); // Returns danger color

// Get category color by index
Color categoryColor = AppColors.getCategoryColor(0); // Returns categoryBlue
```

### Font Utilities
```dart
// Create text style with custom color
TextStyle customStyle = AppFonts.withColor(AppFonts.bodyMedium, AppColors.primary);

// Create text style with custom weight
TextStyle boldStyle = AppFonts.withWeight(AppFonts.bodyMedium, FontWeight.bold);

// Create text style with custom size
TextStyle largeStyle = AppFonts.withSize(AppFonts.bodyMedium, 18.0);

// Get appropriate text style for amount based on size
TextStyle amountStyle = AppFonts.getAmountStyle(1000.0); // Returns valueLarge
```

## Best Practices

1. **Always use AppColors and AppFonts** instead of hardcoded colors and text styles
2. **Use semantic colors** for financial data (green for income, red for expenses)
3. **Follow the typography hierarchy** for consistent text styling
4. **Use appropriate font sizes** based on content importance
5. **Test both light and dark themes** to ensure proper contrast
6. **Use category colors** for consistent visual categorization
7. **Leverage utility methods** for dynamic color and font selection

## Testing

To see the theme system in action, you can use the `ThemeExampleWidget`:

```dart
import 'package:money_flow/core/theme/theme_examples.dart';

// Add to your app for testing
MaterialApp(
  home: ThemeExampleWidget(),
)
```

This widget demonstrates all the colors, fonts, and styling options available in the theme system.

## Migration Guide

If you're updating existing code to use the new theme system:

1. Replace hardcoded colors with `AppColors` references
2. Replace hardcoded text styles with `AppFonts` references
3. Update color references to use semantic naming
4. Test both light and dark themes
5. Use the theme extension for easier access

## Contributing

When adding new colors or fonts:

1. Follow the existing naming conventions
2. Add comprehensive documentation
3. Include usage examples
4. Test in both light and dark themes
5. Update this README with new additions
