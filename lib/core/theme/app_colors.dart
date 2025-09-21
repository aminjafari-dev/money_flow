import 'package:flutter/material.dart';

/// Application color palette following the UI/UX design rules.
/// This class provides a comprehensive color system for the Money Flow app.
///
/// Based on the design rules:
/// - Primary: Blue (#007BFF) for interactive elements
/// - Semantic: Green for positive values, Red for negative values
/// - Neutral: Grays for secondary text and borders
/// - Support for both light and dark themes
///
/// Usage Example:
/// ```dart
/// Container(
///   color: AppColors.primary,
///   child: Text('Primary button'),
/// )
/// ```
class AppColors {
  /// Private constructor to prevent instantiation
  AppColors._();

  // ==================== PRIMARY COLORS ====================

  /// Primary blue color for interactive elements like buttons and navigation highlights
  /// Used for: Save buttons, Add Category buttons, navigation highlights
  /// Color: #007BFF
  static const Color primary = Color(0xFF007BFF);

  /// Primary blue with slight transparency for overlays
  /// Used for: Loading states, disabled buttons
  static const Color primaryLight = Color(0x80007BFF);

  /// Darker shade of primary blue for pressed states
  /// Used for: Button pressed states, active navigation
  static const Color primaryDark = Color(0xFF0056B3);

  // ==================== SEMANTIC COLORS ====================

  /// Green color for positive values and success indicators
  /// Used for: Income amounts, success messages, progress indicators
  /// Color: #28A745
  static const Color success = Color(0xFF28A745);

  /// Light green for success backgrounds and subtle indicators
  /// Used for: Success card backgrounds, positive progress bars
  static const Color successLight = Color(0xFFD4EDDA);

  /// Dark green for success text and strong positive indicators
  static const Color successDark = Color(0xFF1E7E34);

  /// Red color for negative values and error states
  /// Used for: Expense amounts, error messages, warnings
  /// Color: #DC3545
  static const Color danger = Color(0xFFDC3545);

  /// Light red for error backgrounds and subtle indicators
  /// Used for: Error card backgrounds, negative progress bars
  static const Color dangerLight = Color(0xFFF8D7DA);

  /// Dark red for error text and strong negative indicators
  static const Color dangerDark = Color(0xFFC82333);

  /// Orange color for warnings and alerts
  /// Used for: Warning messages, caution indicators
  /// Color: #FD7E14
  static const Color warning = Color(0xFFFD7E14);

  /// Light orange for warning backgrounds
  /// Used for: Warning card backgrounds, caution progress bars
  static const Color warningLight = Color(0xFFFFE5D9);

  /// Dark orange for warning text
  static const Color warningDark = Color(0xFFE55A00);

  /// Yellow color for alerts and progress indicators
  /// Used for: Alert messages, progress indicators
  /// Color: #FFC107
  static const Color alert = Color(0xFFFFC107);

  /// Light yellow for alert backgrounds
  static const Color alertLight = Color(0xFFFFF3CD);

  /// Dark yellow for alert text
  static const Color alertDark = Color(0xFFE0A800);

  // ==================== NEUTRAL COLORS ====================

  /// Primary text color for main content
  /// Used for: Headings, main text content
  /// Color: #212529
  static const Color textPrimary = Color(0xFF212529);

  /// Secondary text color for subtitles and secondary content
  /// Used for: Subtitles, secondary labels, descriptions
  /// Color: #6C757D
  static const Color textSecondary = Color(0xFF6C757D);

  /// Light text color for disabled or muted content
  /// Used for: Disabled text, placeholder text
  static const Color textLight = Color(0xFFADB5BD);

  /// White text color for dark backgrounds
  static const Color textWhite = Color(0xFFFFFFFF);

  // ==================== BACKGROUND COLORS ====================

  /// Main background color for the application
  /// Used for: Main app background, scaffold background
  /// Color: #FFFFFF
  static const Color background = Color(0xFFFFFFFF);

  /// Light gray background for cards and elevated surfaces
  /// Used for: Card backgrounds, input field backgrounds
  /// Color: #F5F5F5
  static const Color backgroundLight = Color(0xFFF5F5F5);

  /// Surface color for cards and containers
  /// Used for: Card backgrounds, modal backgrounds
  static const Color surface = Color(0xFFFAFAFA);

  /// Border color for dividers and input borders
  /// Used for: Input borders, dividers, card borders
  static const Color border = Color(0xFFE9ECEF);

  /// Light border color for subtle separations
  static const Color borderLight = Color(0xFFF8F9FA);

  // ==================== CATEGORY COLORS ====================

  /// Blue color for neutral categories
  /// Used for: General categories, default category icons
  static const Color categoryBlue = Color(0xFF007BFF);

  /// Green color for income-related categories
  /// Used for: Salary, income, positive financial categories
  static const Color categoryGreen = Color(0xFF28A745);

  /// Orange color for expense categories
  /// Used for: Food, transportation, general expenses
  static const Color categoryOrange = Color(0xFFFD7E14);

  /// Pink color for charity and donation categories
  /// Used for: Charity, donations, giving categories
  static const Color categoryPink = Color(0xFFE83E8C);

  /// Purple color for investment categories
  /// Used for: Investments, savings, financial growth
  static const Color categoryPurple = Color(0xFF6F42C1);

  /// Teal color for utility categories
  /// Used for: Utilities, bills, recurring expenses
  static const Color categoryTeal = Color(0xFF20C997);

  // ==================== DARK THEME COLORS ====================

  /// Dark background color for dark theme
  /// Used for: Main dark background
  /// Color: #121212
  static const Color darkBackground = Color(0xFF121212);

  /// Dark surface color for dark theme cards
  /// Used for: Card backgrounds in dark mode
  /// Color: #1E1E1E
  static const Color darkSurface = Color(0xFF1E1E1E);

  /// Dark border color for dark theme
  /// Used for: Borders and dividers in dark mode
  /// Color: #404040
  static const Color darkBorder = Color(0xFF404040);

  /// Dark text color for dark theme
  /// Used for: Primary text in dark mode
  static const Color darkTextPrimary = Color(0xFFFFFFFF);

  /// Dark secondary text color for dark theme
  /// Used for: Secondary text in dark mode
  static const Color darkTextSecondary = Color(0xFFB3B3B3);

  // ==================== SHADOW COLORS ====================

  /// Subtle shadow color for cards and elevated elements
  /// Used for: Card shadows, button shadows
  static const Color shadow = Color(0x1A000000);

  /// Light shadow color for subtle elevations
  static const Color shadowLight = Color(0x0D000000);

  /// Dark shadow color for strong elevations
  static const Color shadowDark = Color(0x33000000);

  // ==================== MATERIAL DESIGN 3 COLORS ====================

  /// Surface variant color for Material Design 3
  static const Color surfaceVariant = Color(0xFFF1F3F4);

  /// On surface variant color for Material Design 3
  static const Color onSurfaceVariant = Color(0xFF5F6368);

  /// Primary container color for Material Design 3
  static const Color primaryContainer = Color(0xFFE3F2FD);

  /// On primary container color for Material Design 3
  static const Color onPrimaryContainer = Color(0xFF0D47A1);

  /// Secondary container color for Material Design 3
  static const Color secondaryContainer = Color(0xFFE8F5E8);

  /// On secondary container color for Material Design 3
  static const Color onSecondaryContainer = Color(0xFF1B5E20);

  /// Error container color for Material Design 3
  static const Color errorContainer = Color(0xFFFFEBEE);

  /// On error container color for Material Design 3
  static const Color onErrorContainer = Color(0xFFB71C1C);

  /// Success container color for Material Design 3
  static const Color successContainer = Color(0xFFE8F5E8);

  /// On success container color for Material Design 3
  static const Color onSuccessContainer = Color(0xFF1B5E20);

  /// On surface color for Material Design 3
  static const Color onSurface = Color(0xFF1C1B1F);

  /// On primary color for Material Design 3
  static const Color onPrimary = Color(0xFFFFFFFF);

  /// On secondary color for Material Design 3
  static const Color onSecondary = Color(0xFFFFFFFF);

  /// On error color for Material Design 3
  static const Color onError = Color(0xFFFFFFFF);

  /// On success color for Material Design 3
  static const Color onSuccess = Color(0xFFFFFFFF);

  /// Outline color for Material Design 3
  static const Color outline = Color(0xFF79747E);

  /// Secondary color for Material Design 3
  static const Color secondary = Color(0xFF4CAF50);

  /// Error color for Material Design 3 (alias for danger)
  static const Color error = danger;

  /// Color scheme for Material Design 3
  static ColorScheme get colorScheme => ColorScheme.fromSeed(
    seedColor: primary,
    brightness: Brightness.light,
    primary: primary,
    secondary: secondary,
    error: error,
    surface: surface,
    background: background,
    onPrimary: onPrimary,
    onSecondary: onSecondary,
    onError: onError,
    onSurface: onSurface,
    onBackground: onSurface,
    surfaceVariant: surfaceVariant,
    onSurfaceVariant: onSurfaceVariant,
    primaryContainer: primaryContainer,
    onPrimaryContainer: onPrimaryContainer,
    secondaryContainer: secondaryContainer,
    onSecondaryContainer: onSecondaryContainer,
    errorContainer: errorContainer,
    onErrorContainer: onErrorContainer,
    outline: outline,
  );

  // ==================== GRADIENT COLORS ====================

  /// Primary gradient colors for special elements
  static const List<Color> primaryGradient = [
    Color(0xFF007BFF),
    Color(0xFF0056B3),
  ];

  /// Success gradient colors for positive elements
  static const List<Color> successGradient = [
    Color(0xFF28A745),
    Color(0xFF1E7E34),
  ];

  /// Danger gradient colors for negative elements
  static const List<Color> dangerGradient = [
    Color(0xFFDC3545),
    Color(0xFFC82333),
  ];

  // ==================== UTILITY METHODS ====================

  /// Get color with opacity
  ///
  /// Usage Example:
  /// ```dart
  /// Color semiTransparent = AppColors.primary.withOpacity(0.5);
  /// ```
  static Color withOpacity(Color color, double opacity) {
    return color.withOpacity(opacity);
  }

  /// Get color for amount based on positive/negative value
  ///
  /// Usage Example:
  /// ```dart
  /// Color amountColor = AppColors.getAmountColor(100.0); // Returns success color
  /// Color amountColor = AppColors.getAmountColor(-50.0); // Returns danger color
  /// ```
  static Color getAmountColor(double amount) {
    return amount >= 0 ? success : danger;
  }

  /// Get category color by index
  ///
  /// Usage Example:
  /// ```dart
  /// Color categoryColor = AppColors.getCategoryColor(0); // Returns categoryBlue
  /// ```
  static Color getCategoryColor(int index) {
    final colors = [
      categoryBlue,
      categoryGreen,
      categoryOrange,
      categoryPink,
      categoryPurple,
      categoryTeal,
    ];
    return colors[index % colors.length];
  }
}
