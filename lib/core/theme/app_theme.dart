import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_fonts.dart';

/// Application theme configuration for Money Flow app.
/// This class provides consistent theming throughout the application.
///
/// Based on UI/UX design rules:
/// - Clean, minimalist design with proper contrast
/// - Blue primary color (#007BFF) for interactive elements
/// - Semantic colors for financial data (green/red)
/// - Consistent typography with 2-3 font weights
/// - Support for both light and dark themes
///
/// Usage Example:
/// ```dart
/// MaterialApp(
///   theme: AppTheme.lightTheme,
///   darkTheme: AppTheme.darkTheme,
/// )
/// ```
class AppTheme {
  /// Private constructor to prevent instantiation
  AppTheme._();

  /// Light theme configuration for the application.
  /// This theme is used in light mode and provides a clean, modern look.
  ///
  /// Features:
  /// - Blue primary color (#007BFF) for interactive elements
  /// - Semantic colors for financial data (green/red)
  /// - Clean typography with proper contrast
  /// - Consistent spacing and elevation
  /// - Material Design 3 principles
  ///
  /// Usage Example:
  /// ```dart
  /// MaterialApp(
  ///   theme: AppTheme.lightTheme,
  /// )
  /// ```
  static ThemeData get lightTheme {
    return ThemeData(
      // Use Material 3 design system
      useMaterial3: true,

      // Set the brightness to light
      brightness: Brightness.light,

      // Configure color scheme using AppColors
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        brightness: Brightness.light,
        primary: AppColors.primary,
        secondary: AppColors.textSecondary,
        error: AppColors.danger,
        surface: AppColors.surface,
        background: AppColors.background,
        onPrimary: AppColors.textWhite,
        onSecondary: AppColors.textWhite,
        onError: AppColors.textWhite,
        onSurface: AppColors.textPrimary,
        onBackground: AppColors.textPrimary,
      ),

      // Configure primary color
      primaryColor: AppColors.primary,

      // Configure scaffold background
      scaffoldBackgroundColor: AppColors.background,

      // Configure app bar theme using AppColors and AppFonts
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.textWhite,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: AppFonts.headingLarge.copyWith(
          color: AppColors.textWhite,
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
        ),
      ),

      // Configure elevated button theme using AppColors and AppFonts
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.textWhite,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          textStyle: AppFonts.buttonPrimary.copyWith(
            color: AppColors.textWhite,
          ),
        ),
      ),

      // Configure floating action button theme using AppColors
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.textWhite,
        elevation: 4,
        shape: CircleBorder(),
      ),

      // Configure card theme using AppColors
      cardTheme: CardThemeData(
        color: AppColors.surface,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        margin: const EdgeInsets.all(8),
      ),

      // Configure input decoration theme using AppColors
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.background,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.danger),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
      ),

      // Configure text theme using AppFonts
      textTheme: TextTheme(
        // Display styles for large headings
        displayLarge: AppFonts.valueXL.copyWith(color: AppColors.textPrimary),
        displayMedium: AppFonts.valueLarge.copyWith(
          color: AppColors.textPrimary,
        ),
        displaySmall: AppFonts.valueMedium.copyWith(
          color: AppColors.textPrimary,
        ),

        // Headline styles for page titles
        headlineLarge: AppFonts.headingXL.copyWith(
          color: AppColors.textPrimary,
        ),
        headlineMedium: AppFonts.headingLarge.copyWith(
          color: AppColors.textPrimary,
        ),
        headlineSmall: AppFonts.headingMedium.copyWith(
          color: AppColors.textPrimary,
        ),

        // Title styles for section headings
        titleLarge: AppFonts.headingMedium.copyWith(
          color: AppColors.textPrimary,
        ),
        titleMedium: AppFonts.headingSmall.copyWith(
          color: AppColors.textPrimary,
        ),
        titleSmall: AppFonts.labelLarge.copyWith(color: AppColors.textPrimary),

        // Body styles for content text
        bodyLarge: AppFonts.bodyLarge.copyWith(color: AppColors.textPrimary),
        bodyMedium: AppFonts.bodyMedium.copyWith(color: AppColors.textPrimary),
        bodySmall: AppFonts.bodySmall.copyWith(color: AppColors.textSecondary),

        // Label styles for form labels and small text
        labelLarge: AppFonts.labelLarge.copyWith(color: AppColors.textPrimary),
        labelMedium: AppFonts.labelMedium.copyWith(
          color: AppColors.textSecondary,
        ),
        labelSmall: AppFonts.labelSmall.copyWith(
          color: AppColors.textSecondary,
        ),
      ),

      // Configure divider theme using AppColors
      dividerTheme: const DividerThemeData(
        color: AppColors.border,
        thickness: 1,
        space: 1,
      ),

      // Configure list tile theme using AppColors
      listTileTheme: const ListTileThemeData(
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
      ),
    );
  }

  /// Dark theme configuration for the application.
  /// This theme is used in dark mode and provides a modern dark interface.
  ///
  /// Features:
  /// - Dark background with proper contrast
  /// - Blue primary color (#007BFF) for interactive elements
  /// - Semantic colors for financial data (green/red)
  /// - Consistent with Material Design 3 dark theme
  /// - Proper text contrast for accessibility
  ///
  /// Usage Example:
  /// ```dart
  /// MaterialApp(
  ///   darkTheme: AppTheme.darkTheme,
  ///   themeMode: ThemeMode.dark,
  /// )
  /// ```
  static ThemeData get darkTheme {
    return ThemeData(
      // Use Material 3 design system
      useMaterial3: true,

      // Set the brightness to dark
      brightness: Brightness.dark,

      // Configure color scheme using AppColors dark theme colors
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        brightness: Brightness.dark,
        primary: AppColors.primary,
        secondary: AppColors.darkTextSecondary,
        error: AppColors.danger,
        surface: AppColors.darkSurface,
        background: AppColors.darkBackground,
        onPrimary: AppColors.textWhite,
        onSecondary: AppColors.textWhite,
        onError: AppColors.textWhite,
        onSurface: AppColors.darkTextPrimary,
        onBackground: AppColors.darkTextPrimary,
      ),

      // Configure primary color
      primaryColor: AppColors.primary,

      // Configure scaffold background
      scaffoldBackgroundColor: AppColors.darkBackground,

      // Configure app bar theme using AppColors and AppFonts
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.darkSurface,
        foregroundColor: AppColors.darkTextPrimary,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: AppFonts.headingLarge.copyWith(
          color: AppColors.darkTextPrimary,
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
        ),
      ),

      // Configure elevated button theme using AppColors and AppFonts
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.textWhite,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          textStyle: AppFonts.buttonPrimary.copyWith(
            color: AppColors.textWhite,
          ),
        ),
      ),

      // Configure floating action button theme using AppColors
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.textWhite,
        elevation: 4,
        shape: CircleBorder(),
      ),

      // Configure card theme using AppColors
      cardTheme: CardThemeData(
        color: AppColors.darkSurface,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        margin: const EdgeInsets.all(8),
      ),

      // Configure input decoration theme using AppColors
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.darkSurface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.darkBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.danger),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
      ),

      // Configure text theme using AppFonts with dark theme colors
      textTheme: TextTheme(
        // Display styles for large headings
        displayLarge: AppFonts.valueXL.copyWith(
          color: AppColors.darkTextPrimary,
        ),
        displayMedium: AppFonts.valueLarge.copyWith(
          color: AppColors.darkTextPrimary,
        ),
        displaySmall: AppFonts.valueMedium.copyWith(
          color: AppColors.darkTextPrimary,
        ),

        // Headline styles for page titles
        headlineLarge: AppFonts.headingXL.copyWith(
          color: AppColors.darkTextPrimary,
        ),
        headlineMedium: AppFonts.headingLarge.copyWith(
          color: AppColors.darkTextPrimary,
        ),
        headlineSmall: AppFonts.headingMedium.copyWith(
          color: AppColors.darkTextPrimary,
        ),

        // Title styles for section headings
        titleLarge: AppFonts.headingMedium.copyWith(
          color: AppColors.darkTextPrimary,
        ),
        titleMedium: AppFonts.headingSmall.copyWith(
          color: AppColors.darkTextPrimary,
        ),
        titleSmall: AppFonts.labelLarge.copyWith(
          color: AppColors.darkTextPrimary,
        ),

        // Body styles for content text
        bodyLarge: AppFonts.bodyLarge.copyWith(
          color: AppColors.darkTextPrimary,
        ),
        bodyMedium: AppFonts.bodyMedium.copyWith(
          color: AppColors.darkTextPrimary,
        ),
        bodySmall: AppFonts.bodySmall.copyWith(
          color: AppColors.darkTextSecondary,
        ),

        // Label styles for form labels and small text
        labelLarge: AppFonts.labelLarge.copyWith(
          color: AppColors.darkTextPrimary,
        ),
        labelMedium: AppFonts.labelMedium.copyWith(
          color: AppColors.darkTextSecondary,
        ),
        labelSmall: AppFonts.labelSmall.copyWith(
          color: AppColors.darkTextSecondary,
        ),
      ),

      // Configure divider theme using AppColors
      dividerTheme: const DividerThemeData(
        color: AppColors.darkBorder,
        thickness: 1,
        space: 1,
      ),

      // Configure list tile theme using AppColors
      listTileTheme: const ListTileThemeData(
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
      ),
    );
  }
}

/// Theme extensions for easy access to app colors and fonts.
/// This extension provides convenient access to app-specific colors and fonts.
///
/// Usage Example:
/// ```dart
/// Container(
///   color: context.primary,
///   child: Text('Success message', style: context.appFonts.bodyLarge),
/// )
/// ```
extension AppThemeExtension on BuildContext {
  /// Get the current theme's color scheme
  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  /// Get the primary color
  Color get primary => AppColors.primary;

  /// Get the secondary color
  Color get secondary => AppColors.textSecondary;

  /// Get the error color
  Color get error => AppColors.danger;

  /// Get the success color
  Color get success => AppColors.success;

  /// Get the warning color
  Color get warning => AppColors.warning;

  /// Get the info color
  Color get info => AppColors.primary;

  /// Get the surface color
  Color get surface => AppColors.surface;

  /// Get the background color
  Color get background => AppColors.background;
}
