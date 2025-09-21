import 'package:flutter/material.dart';

/// Global Text widget for consistent app-wide text styling and behavior.
/// This widget provides standardized text with common configurations and theming.
///
/// Usage Example:
/// ```dart
/// GText(
///   'Hello World',
///   style: GTextStyle.headlineLarge,
///   color: Colors.blue,
/// )
/// ```
class GText extends StatelessWidget {
  /// The text content to display
  final String text;

  /// The text style to apply
  final TextStyle? style;

  /// The text color
  final Color? color;

  /// The font size
  final double? fontSize;

  /// The font weight
  final FontWeight? fontWeight;

  /// Text alignment
  final TextAlign? textAlign;

  /// Maximum number of lines
  final int? maxLines;

  /// How to handle text overflow
  final TextOverflow? overflow;

  /// Whether the text should be selectable
  final bool selectable;

  /// Text direction
  final TextDirection? textDirection;

  /// Locale for the text
  final Locale? locale;

  /// Text scale factor
  final double? textScaleFactor;

  /// Text height
  final double? height;

  /// Letter spacing
  final double? letterSpacing;

  /// Word spacing
  final double? wordSpacing;

  /// Text baseline
  final TextBaseline? textBaseline;

  /// Creates a new instance of GText.
  ///
  /// Parameters:
  /// - [text]: The text content to display
  /// - [style]: The text style to apply
  /// - [color]: The text color
  /// - [fontSize]: The font size
  /// - [fontWeight]: The font weight
  /// - [textAlign]: Text alignment
  /// - [maxLines]: Maximum number of lines
  /// - [overflow]: How to handle text overflow
  /// - [selectable]: Whether the text should be selectable
  /// - [textDirection]: Text direction
  /// - [locale]: Locale for the text
  /// - [textScaleFactor]: Text scale factor
  /// - [height]: Text height
  /// - [letterSpacing]: Letter spacing
  /// - [wordSpacing]: Word spacing
  /// - [textBaseline]: Text baseline
  ///
  /// Usage Example:
  /// ```dart
  /// GText(
  ///   'Welcome to Money Flow',
  ///   style: GTextStyle.headlineMedium,
  ///   color: Colors.primary,
  ///   textAlign: TextAlign.center,
  /// )
  /// ```
  const GText(
    this.text, {
    super.key,
    this.style,
    this.color,
    this.fontSize,
    this.fontWeight,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.selectable = false,
    this.textDirection,
    this.locale,
    this.textScaleFactor,
    this.height,
    this.letterSpacing,
    this.wordSpacing,
    this.textBaseline,
  });

  @override
  Widget build(BuildContext context) {
    // Create the base text style
    final baseStyle = style ?? Theme.of(context).textTheme.bodyMedium;

    // Merge custom properties with base style
    final textStyle = baseStyle?.copyWith(
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
      height: height,
      letterSpacing: letterSpacing,
      wordSpacing: wordSpacing,
      textBaseline: textBaseline,
    );

    // Create the text widget
    final textWidget = Text(
      text,
      style: textStyle,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      textDirection: textDirection,
      locale: locale,
      textScaleFactor: textScaleFactor,
    );

    // Return selectable text if requested
    if (selectable) {
      return SelectableText(
        text,
        style: textStyle,
        textAlign: textAlign,
        textDirection: textDirection,
        textScaleFactor: textScaleFactor,
      );
    }

    return textWidget;
  }
}

/// Predefined text styles for consistent app-wide typography.
/// This class provides standardized text styles following Material Design guidelines.
///
/// Usage Example:
/// ```dart
/// GText(
///   'Title',
///   style: GTextStyle.headlineLarge,
/// )
/// ```
class GTextStyle {
  /// Private constructor to prevent instantiation
  GTextStyle._();

  /// Display large text style
  /// Used for the largest text on the screen, typically for hero text
  static const TextStyle displayLarge = TextStyle(
    fontSize: 57,
    fontWeight: FontWeight.w400,
    letterSpacing: -0.25,
    height: 1.12,
  );

  /// Display medium text style
  /// Used for large headings and important text
  static const TextStyle displayMedium = TextStyle(
    fontSize: 45,
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
    height: 1.16,
  );

  /// Display small text style
  /// Used for medium headings
  static const TextStyle displaySmall = TextStyle(
    fontSize: 36,
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
    height: 1.22,
  );

  /// Headline large text style
  /// Used for page titles and major headings
  static const TextStyle headlineLarge = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
    height: 1.25,
  );

  /// Headline medium text style
  /// Used for section headings
  static const TextStyle headlineMedium = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
    height: 1.29,
  );

  /// Headline small text style
  /// Used for subsection headings
  static const TextStyle headlineSmall = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
    height: 1.33,
  );

  /// Title large text style
  /// Used for card titles and important labels
  static const TextStyle titleLarge = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
    height: 1.27,
  );

  /// Title medium text style
  /// Used for list item titles
  static const TextStyle titleMedium = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.15,
    height: 1.50,
  );

  /// Title small text style
  /// Used for small labels and captions
  static const TextStyle titleSmall = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
    height: 1.43,
  );

  /// Body large text style
  /// Used for main content text
  static const TextStyle bodyLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.5,
    height: 1.50,
  );

  /// Body medium text style
  /// Used for secondary content text
  static const TextStyle bodyMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
    height: 1.43,
  );

  /// Body small text style
  /// Used for small content text
  static const TextStyle bodySmall = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.4,
    height: 1.33,
  );

  /// Label large text style
  /// Used for large labels and buttons
  static const TextStyle labelLarge = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
    height: 1.43,
  );

  /// Label medium text style
  /// Used for medium labels
  static const TextStyle labelMedium = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
    height: 1.33,
  );

  /// Label small text style
  /// Used for small labels
  static const TextStyle labelSmall = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
    height: 1.45,
  );
}

/// Extension on GText for common configurations.
/// This provides convenient methods for common text setups.
extension GTextExtensions on GText {
  /// Creates a GText with bold font weight.
  /// This is useful for emphasizing important text.
  ///
  /// Usage Example:
  /// ```dart
  /// GText.bold('Important Text')
  /// ```
  static GText bold(String text, {TextStyle? style, Color? color}) {
    return GText(text, style: style, color: color, fontWeight: FontWeight.bold);
  }

  /// Creates a GText with italic font style.
  /// This is useful for emphasizing or styling text.
  ///
  /// Usage Example:
  /// ```dart
  /// GText.italic('Emphasized Text')
  /// ```
  static GText italic(String text, {TextStyle? style, Color? color}) {
    return GText(
      text,
      style:
          style?.copyWith(fontStyle: FontStyle.italic) ??
          const TextStyle(fontStyle: FontStyle.italic),
      color: color,
    );
  }

  /// Creates a GText with primary color.
  /// This is useful for important text that should stand out.
  ///
  /// Usage Example:
  /// ```dart
  /// GText.primary('Primary Text')
  /// ```
  static GText primary(String text, {TextStyle? style, BuildContext? context}) {
    return GText(
      text,
      style: style,
      color: context != null ? Theme.of(context).primaryColor : null,
    );
  }

  /// Creates a GText with secondary color.
  /// This is useful for less important text.
  ///
  /// Usage Example:
  /// ```dart
  /// GText.secondary('Secondary Text')
  /// ```
  static GText secondary(
    String text, {
    TextStyle? style,
    BuildContext? context,
  }) {
    return GText(
      text,
      style: style,
      color: context != null ? Theme.of(context).colorScheme.secondary : null,
    );
  }

  /// Creates a GText with error color.
  /// This is useful for error messages and warnings.
  ///
  /// Usage Example:
  /// ```dart
  /// GText.error('Error Message')
  /// ```
  static GText error(String text, {TextStyle? style, BuildContext? context}) {
    return GText(
      text,
      style: style,
      color: context != null ? Theme.of(context).colorScheme.error : null,
    );
  }

  /// Creates a GText with success color.
  /// This is useful for success messages and positive feedback.
  ///
  /// Usage Example:
  /// ```dart
  /// GText.success('Success Message')
  /// ```
  static GText success(String text, {TextStyle? style, BuildContext? context}) {
    return GText(
      text,
      style: style,
      color: context != null ? Colors.green : null,
    );
  }

  /// Creates a GText with center alignment.
  /// This is useful for titles and centered content.
  ///
  /// Usage Example:
  /// ```dart
  /// GText.center('Centered Text')
  /// ```
  static GText center(String text, {TextStyle? style, Color? color}) {
    return GText(text, style: style, color: color, textAlign: TextAlign.center);
  }

  /// Creates a GText with ellipsis overflow.
  /// This is useful for text that might be too long for its container.
  ///
  /// Usage Example:
  /// ```dart
  /// GText.ellipsis('Long text that might overflow...')
  /// ```
  static GText ellipsis(
    String text, {
    TextStyle? style,
    Color? color,
    int? maxLines,
  }) {
    return GText(
      text,
      style: style,
      color: color,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
    );
  }

  /// Creates a GText with fade overflow.
  /// This is useful for text that should fade out when too long.
  ///
  /// Usage Example:
  /// ```dart
  /// GText.fade('Long text that fades out...')
  /// ```
  static GText fade(
    String text, {
    TextStyle? style,
    Color? color,
    int? maxLines,
  }) {
    return GText(
      text,
      style: style,
      color: color,
      maxLines: maxLines,
      overflow: TextOverflow.fade,
    );
  }

  /// Creates a GText with clip overflow.
  /// This is useful for text that should be clipped when too long.
  ///
  /// Usage Example:
  /// ```dart
  /// GText.clip('Long text that gets clipped...')
  /// ```
  static GText clip(
    String text, {
    TextStyle? style,
    Color? color,
    int? maxLines,
  }) {
    return GText(
      text,
      style: style,
      color: color,
      maxLines: maxLines,
      overflow: TextOverflow.clip,
    );
  }

  /// Creates a GText that is selectable.
  /// This is useful for text that users should be able to copy.
  ///
  /// Usage Example:
  /// ```dart
  /// GText.selectable('Selectable text content')
  /// ```
  static GText selectable(String text, {TextStyle? style, Color? color}) {
    return GText(text, style: style, color: color, selectable: true);
  }
}
