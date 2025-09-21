import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

/// GGap class provides predefined spacing widgets for consistent spacing throughout the app.
///
/// This class follows the design system approach by providing standardized spacing values
/// that can be used across the application to maintain visual consistency.
///
/// Usage examples:
/// ```dart
/// // For small spacing between widgets
/// GGap.small
///
/// // For medium spacing in forms
/// GGap.medium
///
/// // For large spacing between sections
/// GGap.large
///
/// // For custom spacing
/// GGap.custom(24.0)
///
/// // For horizontal spacing in rows
/// GGap.horizontal(16.0)
///
/// // For vertical spacing in columns
/// GGap.vertical(20.0)
/// ```
class GGap {
  // Private constructor to prevent instantiation
  GGap._();

  // Standard spacing values following Material Design guidelines
  static const double _xs = 4.0; // Extra small spacing
  static const double _sm = 8.0; // Small spacing
  static const double _md = 16.0; // Medium spacing (default)
  static const double _lg = 24.0; // Large spacing
  static const double _xl = 32.0; // Extra large spacing
  static const double _xxl = 48.0; // Extra extra large spacing

  /// Creates a small gap widget (8.0 pixels).
  ///
  /// Used for minimal spacing between closely related elements
  /// like icons and text, or small UI components.
  ///
  /// Example:
  /// ```dart
  /// Row(
  ///   children: [
  ///     Icon(Icons.star),
  ///     GGap.small, // 8.0px gap
  ///     Text('Rating'),
  ///   ],
  /// )
  /// ```
  static const Widget small = Gap(_sm);

  /// Creates a medium gap widget (16.0 pixels).
  ///
  /// This is the default spacing used between form elements,
  /// list items, and general UI components.
  ///
  /// Example:
  /// ```dart
  /// Column(
  ///   children: [
  ///     TextFormField(),
  ///     GGap.medium, // 16.0px gap
  ///     ElevatedButton(),
  ///   ],
  /// )
  /// ```
  static const Widget medium = Gap(_md);

  /// Creates a large gap widget (24.0 pixels).
  ///
  /// Used for spacing between major sections or groups of content.
  ///
  /// Example:
  /// ```dart
  /// Column(
  ///   children: [
  ///     HeaderWidget(),
  ///     GGap.large, // 24.0px gap
  ///     ContentWidget(),
  ///   ],
  /// )
  /// ```
  static const Widget large = Gap(_lg);

  /// Creates an extra large gap widget (32.0 pixels).
  ///
  /// Used for significant spacing between major page sections.
  ///
  /// Example:
  /// ```dart
  /// Column(
  ///   children: [
  ///     TopSection(),
  ///     GGap.extraLarge, // 32.0px gap
  ///     BottomSection(),
  ///   ],
  /// )
  /// ```
  static const Widget extraLarge = Gap(_xl);

  /// Creates an extra extra large gap widget (48.0 pixels).
  ///
  /// Used for maximum spacing, typically between major page sections
  /// or when you need significant visual separation.
  ///
  /// Example:
  /// ```dart
  /// Column(
  ///   children: [
  ///     HeroSection(),
  ///     GGap.extraExtraLarge, // 48.0px gap
  ///     FeaturesSection(),
  ///   ],
  /// )
  /// ```
  static const Widget extraExtraLarge = Gap(_xxl);

  /// Creates a custom gap widget with the specified size.
  ///
  /// Use this when you need spacing that doesn't match the predefined sizes.
  ///
  /// Example:
  /// ```dart
  /// Column(
  ///   children: [
  ///     Widget1(),
  ///     GGap.custom(20.0), // Custom 20.0px gap
  ///     Widget2(),
  ///   ],
  /// )
  /// ```
  ///
  /// [size] The size of the gap in pixels. Must be a positive number.
  static Widget custom(double size) {
    // Validate that size is positive
    assert(size >= 0, 'Gap size must be non-negative');
    return Gap(size);
  }

  /// Creates a horizontal gap widget.
  ///
  /// This is specifically for use in Row widgets to create horizontal spacing.
  /// It's equivalent to using Gap() but makes the intent clearer.
  ///
  /// Example:
  /// ```dart
  /// Row(
  ///   children: [
  ///     Icon(Icons.home),
  ///     GGap.horizontal(12.0), // 12.0px horizontal gap
  ///     Text('Home'),
  ///   ],
  /// )
  /// ```
  ///
  /// [size] The horizontal size of the gap in pixels. Must be a positive number.
  static Widget horizontal(double size) {
    // Validate that size is positive
    assert(size >= 0, 'Horizontal gap size must be non-negative');
    return Gap(size);
  }

  /// Creates a vertical gap widget.
  ///
  /// This is specifically for use in Column widgets to create vertical spacing.
  /// It's equivalent to using Gap() but makes the intent clearer.
  ///
  /// Example:
  /// ```dart
  /// Column(
  ///   children: [
  ///     Text('Title'),
  ///     GGap.vertical(16.0), // 16.0px vertical gap
  ///     Text('Subtitle'),
  ///   ],
  /// )
  /// ```
  ///
  /// [size] The vertical size of the gap in pixels. Must be a positive number.
  static Widget vertical(double size) {
    // Validate that size is positive
    assert(size >= 0, 'Vertical gap size must be non-negative');
    return Gap(size);
  }

  /// Creates an extra small gap widget (4.0 pixels).
  ///
  /// Used for very minimal spacing, typically between inline elements
  /// or when you need the smallest possible gap.
  ///
  /// Example:
  /// ```dart
  /// Row(
  ///   children: [
  ///     Icon(Icons.favorite, size: 12),
  ///     GGap.extraSmall, // 4.0px gap
  ///     Icon(Icons.share, size: 12),
  ///   ],
  /// )
  /// ```
  static const Widget extraSmall = Gap(_xs);

  /// Creates a zero gap widget (0.0 pixels).
  ///
  /// This can be useful for conditional spacing or when you need
  /// to maintain consistent widget structure but without actual spacing.
  ///
  /// Example:
  /// ```dart
  /// Column(
  ///   children: [
  ///     Widget1(),
  ///     condition ? GGap.medium : GGap.zero, // Conditional spacing
  ///     Widget2(),
  ///   ],
  /// )
  /// ```
  static const Widget zero = Gap(0.0);

  // Predefined gap sizes as constants for reference
  /// Extra small spacing constant (4.0 pixels)
  static const double xs = _xs;

  /// Small spacing constant (8.0 pixels)
  static const double sm = _sm;

  /// Medium spacing constant (16.0 pixels)
  static const double md = _md;

  /// Large spacing constant (24.0 pixels)
  static const double lg = _lg;

  /// Extra large spacing constant (32.0 pixels)
  static const double xl = _xl;

  /// Extra extra large spacing constant (48.0 pixels)
  static const double xxl = _xxl;
}
