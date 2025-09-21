import 'package:flutter/material.dart';

/// Application typography system following the UI/UX design rules.
/// This class provides a comprehensive font system for the Money Flow app.
///
/// Based on the design rules:
/// - Headings: Bold sans-serif font (18-24pt) for page titles
/// - Body text: Regular sans-serif (14-16pt) for labels and descriptions
/// - Values: Larger bold font (20-32pt) for key figures like amounts
/// - Consistency: Limit to 2-3 font weights for clean design
///
/// Usage Example:
/// ```dart
/// Text(
///   'Dashboard',
///   style: AppFonts.headingLarge,
/// )
/// ```
class AppFonts {
  /// Private constructor to prevent instantiation
  AppFonts._();

  // ==================== FONT FAMILY ====================

  /// Primary font family for the application
  /// Uses system default sans-serif fonts (SF Pro on iOS, Roboto on Android)
  static const String fontFamily =
      'SF Pro Display'; // iOS primary, falls back to system

  /// Secondary font family for special cases
  /// Used for: Monospace numbers, code, or special formatting
  static const String fontFamilyMono =
      'SF Mono'; // iOS monospace, falls back to system

  // ==================== FONT WEIGHTS ====================

  /// Regular font weight (400)
  static const FontWeight regular = FontWeight.w400;

  /// Medium font weight (500)
  static const FontWeight medium = FontWeight.w500;

  /// Semi-bold font weight (600)
  static const FontWeight semiBold = FontWeight.w600;

  /// Bold font weight (700)
  static const FontWeight bold = FontWeight.w700;

  // ==================== FONT SIZES ====================

  /// Extra small font size (10pt)
  static const double sizeXS = 10.0;

  /// Small font size (12pt)
  static const double sizeSM = 12.0;

  /// Medium font size (14pt)
  static const double sizeMD = 14.0;

  /// Large font size (16pt)
  static const double sizeLG = 16.0;

  /// Extra large font size (18pt)
  static const double sizeXL = 18.0;

  /// 2X large font size (20pt)
  static const double size2XL = 20.0;

  /// 3X large font size (24pt)
  static const double size3XL = 24.0;

  /// 4X large font size (28pt)
  static const double size4XL = 28.0;

  /// 5X large font size (32pt)
  static const double size5XL = 32.0;

  /// 6X large font size (36pt)
  static const double size6XL = 36.0;

  // ==================== LINE HEIGHTS ====================

  /// Tight line height for headings
  static const double lineHeightTight = 1.2;

  /// Normal line height for body text
  static const double lineHeightNormal = 1.4;

  /// Relaxed line height for large text
  static const double lineHeightRelaxed = 1.6;

  // ==================== LETTER SPACING ====================

  /// Tight letter spacing for large text
  static const double letterSpacingTight = -0.5;

  /// Normal letter spacing
  static const double letterSpacingNormal = 0.0;

  /// Wide letter spacing for small caps
  static const double letterSpacingWide = 0.5;

  // ==================== HEADING STYLES ====================

  /// Extra large heading style for main page titles
  /// Used for: Main page titles like "Dashboard", "Analytics"
  /// Size: 24pt, Weight: Bold, Line Height: Tight
  static const TextStyle headingXL = TextStyle(
    fontFamily: fontFamily,
    fontSize: size3XL,
    fontWeight: bold,
    height: lineHeightTight,
    letterSpacing: letterSpacingTight,
  );

  /// Large heading style for section titles
  /// Used for: Section headings like "Recent Transactions", "Financial Summary"
  /// Size: 20pt, Weight: Bold, Line Height: Tight
  static const TextStyle headingLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: size2XL,
    fontWeight: bold,
    height: lineHeightTight,
    letterSpacing: letterSpacingTight,
  );

  /// Medium heading style for subsection titles
  /// Used for: Subsection headings, card titles
  /// Size: 18pt, Weight: Semi-bold, Line Height: Normal
  static const TextStyle headingMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: sizeXL,
    fontWeight: semiBold,
    height: lineHeightNormal,
    letterSpacing: letterSpacingNormal,
  );

  /// Small heading style for small section titles
  /// Used for: Small section headings, list headers
  /// Size: 16pt, Weight: Semi-bold, Line Height: Normal
  static const TextStyle headingSmall = TextStyle(
    fontFamily: fontFamily,
    fontSize: sizeLG,
    fontWeight: semiBold,
    height: lineHeightNormal,
    letterSpacing: letterSpacingNormal,
  );

  // ==================== BODY TEXT STYLES ====================

  /// Large body text style for main content
  /// Used for: Main content text, descriptions
  /// Size: 16pt, Weight: Regular, Line Height: Normal
  static const TextStyle bodyLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: sizeLG,
    fontWeight: regular,
    height: lineHeightNormal,
    letterSpacing: letterSpacingNormal,
  );

  /// Medium body text style for standard content
  /// Used for: Standard text content, labels
  /// Size: 14pt, Weight: Regular, Line Height: Normal
  static const TextStyle bodyMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: sizeMD,
    fontWeight: regular,
    height: lineHeightNormal,
    letterSpacing: letterSpacingNormal,
  );

  /// Small body text style for secondary content
  /// Used for: Secondary text, captions, subtitles
  /// Size: 12pt, Weight: Regular, Line Height: Normal
  static const TextStyle bodySmall = TextStyle(
    fontFamily: fontFamily,
    fontSize: sizeSM,
    fontWeight: regular,
    height: lineHeightNormal,
    letterSpacing: letterSpacingNormal,
  );

  // ==================== VALUE STYLES ====================

  /// Extra large value style for key financial figures
  /// Used for: Main financial amounts, total balances
  /// Size: 32pt, Weight: Bold, Line Height: Tight
  static const TextStyle valueXL = TextStyle(
    fontFamily: fontFamily,
    fontSize: size5XL,
    fontWeight: bold,
    height: lineHeightTight,
    letterSpacing: letterSpacingTight,
  );

  /// Large value style for important financial figures
  /// Used for: Category totals, transaction amounts
  /// Size: 24pt, Weight: Bold, Line Height: Tight
  static const TextStyle valueLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: size3XL,
    fontWeight: bold,
    height: lineHeightTight,
    letterSpacing: letterSpacingTight,
  );

  /// Medium value style for standard financial figures
  /// Used for: Standard amounts, percentages
  /// Size: 20pt, Weight: Semi-bold, Line Height: Normal
  static const TextStyle valueMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: size2XL,
    fontWeight: semiBold,
    height: lineHeightNormal,
    letterSpacing: letterSpacingNormal,
  );

  /// Small value style for secondary financial figures
  /// Used for: Small amounts, secondary values
  /// Size: 16pt, Weight: Medium, Line Height: Normal
  static const TextStyle valueSmall = TextStyle(
    fontFamily: fontFamily,
    fontSize: sizeLG,
    fontWeight: medium,
    height: lineHeightNormal,
    letterSpacing: letterSpacingNormal,
  );

  // ==================== LABEL STYLES ====================

  /// Large label style for primary labels
  /// Used for: Primary labels, important categories
  /// Size: 14pt, Weight: Medium, Line Height: Normal
  static const TextStyle labelLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: sizeMD,
    fontWeight: medium,
    height: lineHeightNormal,
    letterSpacing: letterSpacingNormal,
  );

  /// Medium label style for standard labels
  /// Used for: Standard labels, form labels
  /// Size: 12pt, Weight: Medium, Line Height: Normal
  static const TextStyle labelMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: sizeSM,
    fontWeight: medium,
    height: lineHeightNormal,
    letterSpacing: letterSpacingNormal,
  );

  /// Small label style for secondary labels
  /// Used for: Secondary labels, captions
  /// Size: 10pt, Weight: Medium, Line Height: Normal
  static const TextStyle labelSmall = TextStyle(
    fontFamily: fontFamily,
    fontSize: sizeXS,
    fontWeight: medium,
    height: lineHeightNormal,
    letterSpacing: letterSpacingWide,
  );

  // ==================== BUTTON STYLES ====================

  /// Primary button text style
  /// Used for: Primary action buttons
  /// Size: 16pt, Weight: Medium, Line Height: Normal
  static const TextStyle buttonPrimary = TextStyle(
    fontFamily: fontFamily,
    fontSize: sizeLG,
    fontWeight: medium,
    height: lineHeightNormal,
    letterSpacing: letterSpacingNormal,
  );

  /// Secondary button text style
  /// Used for: Secondary action buttons
  /// Size: 14pt, Weight: Medium, Line Height: Normal
  static const TextStyle buttonSecondary = TextStyle(
    fontFamily: fontFamily,
    fontSize: sizeMD,
    fontWeight: medium,
    height: lineHeightNormal,
    letterSpacing: letterSpacingNormal,
  );

  /// Small button text style
  /// Used for: Small action buttons, icon buttons
  /// Size: 12pt, Weight: Medium, Line Height: Normal
  static const TextStyle buttonSmall = TextStyle(
    fontFamily: fontFamily,
    fontSize: sizeSM,
    fontWeight: medium,
    height: lineHeightNormal,
    letterSpacing: letterSpacingNormal,
  );

  // ==================== NAVIGATION STYLES ====================

  /// Navigation label style for bottom navigation
  /// Used for: Bottom navigation labels
  /// Size: 12pt, Weight: Medium, Line Height: Normal
  static const TextStyle navigationLabel = TextStyle(
    fontFamily: fontFamily,
    fontSize: sizeSM,
    fontWeight: medium,
    height: lineHeightNormal,
    letterSpacing: letterSpacingNormal,
  );

  /// Tab label style for tab navigation
  /// Used for: Tab navigation labels
  /// Size: 14pt, Weight: Medium, Line Height: Normal
  static const TextStyle tabLabel = TextStyle(
    fontFamily: fontFamily,
    fontSize: sizeMD,
    fontWeight: medium,
    height: lineHeightNormal,
    letterSpacing: letterSpacingNormal,
  );

  // ==================== MONOSPACE STYLES ====================

  /// Monospace style for numbers and financial data
  /// Used for: Amounts, percentages, numerical data
  /// Size: 16pt, Weight: Medium, Monospace font
  static const TextStyle monospace = TextStyle(
    fontFamily: fontFamilyMono,
    fontSize: sizeLG,
    fontWeight: medium,
    height: lineHeightNormal,
    letterSpacing: letterSpacingNormal,
  );

  /// Small monospace style for small numerical data
  /// Used for: Small amounts, secondary numerical data
  /// Size: 14pt, Weight: Medium, Monospace font
  static const TextStyle monospaceSmall = TextStyle(
    fontFamily: fontFamilyMono,
    fontSize: sizeMD,
    fontWeight: medium,
    height: lineHeightNormal,
    letterSpacing: letterSpacingNormal,
  );

  // ==================== UTILITY METHODS ====================

  /// Create a text style with custom color
  ///
  /// Usage Example:
  /// ```dart
  /// TextStyle customStyle = AppFonts.bodyMedium.withColor(AppColors.primary);
  /// ```
  static TextStyle withColor(TextStyle style, Color color) {
    return style.copyWith(color: color);
  }

  /// Create a text style with custom weight
  ///
  /// Usage Example:
  /// ```dart
  /// TextStyle boldStyle = AppFonts.bodyMedium.withWeight(FontWeight.bold);
  /// ```
  static TextStyle withWeight(TextStyle style, FontWeight weight) {
    return style.copyWith(fontWeight: weight);
  }

  /// Create a text style with custom size
  ///
  /// Usage Example:
  /// ```dart
  /// TextStyle largeStyle = AppFonts.bodyMedium.withSize(18.0);
  /// ```
  static TextStyle withSize(TextStyle style, double size) {
    return style.copyWith(fontSize: size);
  }

  /// Get appropriate text style for amount based on size
  ///
  /// Usage Example:
  /// ```dart
  /// TextStyle amountStyle = AppFonts.getAmountStyle(1000.0); // Returns valueLarge
  /// TextStyle amountStyle = AppFonts.getAmountStyle(50.0); // Returns valueMedium
  /// ```
  static TextStyle getAmountStyle(double amount) {
    if (amount >= 1000) return valueXL;
    if (amount >= 100) return valueLarge;
    if (amount >= 10) return valueMedium;
    return valueSmall;
  }
}
