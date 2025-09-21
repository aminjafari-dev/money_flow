import 'package:flutter/material.dart';
import 'package:money_flow/core/theme/app_colors.dart';
import 'package:money_flow/core/theme/app_fonts.dart';

/// GButton widget provides consistent button styling throughout the app.
/// This widget follows the design system approach with predefined variants.
///
/// Usage Example:
/// ```dart
/// GButton(
///   text: 'Save',
///   onPressed: () => print('Button pressed'),
///   variant: GButtonVariant.filled,
/// )
/// ```
class GButton extends StatelessWidget {
  /// The text to display on the button
  final String text;

  /// Callback when button is pressed
  final VoidCallback? onPressed;

  /// Button variant style
  final GButtonVariant variant;

  /// Whether the button is in loading state
  final bool isLoading;

  /// Icon to display before the text
  final IconData? icon;

  /// Whether the button should take full width
  final bool isFullWidth;

  /// Custom button size
  final GButtonSize size;

  const GButton({
    super.key,
    required this.text,
    this.onPressed,
    this.variant = GButtonVariant.filled,
    this.isLoading = false,
    this.icon,
    this.isFullWidth = false,
    this.size = GButtonSize.medium,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: isFullWidth ? double.infinity : null,
      child: _buildButton(context),
    );
  }

  /// Builds the appropriate button widget based on variant.
  Widget _buildButton(BuildContext context) {
    switch (variant) {
      case GButtonVariant.filled:
        return _buildFilledButton(context);
      case GButtonVariant.outlined:
        return _buildOutlinedButton(context);
      case GButtonVariant.text:
        return _buildTextButton(context);
    }
  }

  /// Builds a filled button.
  Widget _buildFilledButton(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.textWhite,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: _getPadding(),
        textStyle: _getTextStyle(),
      ),
      child: _buildButtonContent(),
    );
  }

  /// Builds an outlined button.
  Widget _buildOutlinedButton(BuildContext context) {
    return OutlinedButton(
      onPressed: isLoading ? null : onPressed,
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.primary,
        side: const BorderSide(color: AppColors.primary),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: _getPadding(),
        textStyle: _getTextStyle(),
      ),
      child: _buildButtonContent(),
    );
  }

  /// Builds a text button.
  Widget _buildTextButton(BuildContext context) {
    return TextButton(
      onPressed: isLoading ? null : onPressed,
      style: TextButton.styleFrom(
        foregroundColor: AppColors.primary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: _getPadding(),
        textStyle: _getTextStyle(),
      ),
      child: _buildButtonContent(),
    );
  }

  /// Builds the button content with icon and text.
  Widget _buildButtonContent() {
    if (isLoading) {
      return SizedBox(
        height: _getIconSize(),
        width: _getIconSize(),
        child: const CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(AppColors.textWhite),
        ),
      );
    }

    if (icon != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: _getIconSize()),
          const SizedBox(width: 8),
          Text(text),
        ],
      );
    }

    return Text(text);
  }

  /// Gets the appropriate padding based on button size.
  EdgeInsets _getPadding() {
    switch (size) {
      case GButtonSize.small:
        return const EdgeInsets.symmetric(horizontal: 16, vertical: 8);
      case GButtonSize.medium:
        return const EdgeInsets.symmetric(horizontal: 24, vertical: 12);
      case GButtonSize.large:
        return const EdgeInsets.symmetric(horizontal: 32, vertical: 16);
    }
  }

  /// Gets the appropriate text style based on button size.
  TextStyle _getTextStyle() {
    switch (size) {
      case GButtonSize.small:
        return AppFonts.labelMedium;
      case GButtonSize.medium:
        return AppFonts.labelLarge;
      case GButtonSize.large:
        return AppFonts.titleSmall;
    }
  }

  /// Gets the appropriate icon size based on button size.
  double _getIconSize() {
    switch (size) {
      case GButtonSize.small:
        return 16;
      case GButtonSize.medium:
        return 20;
      case GButtonSize.large:
        return 24;
    }
  }
}

/// Enum for button variants.
enum GButtonVariant {
  /// Filled button with background color
  filled,

  /// Outlined button with border
  outlined,

  /// Text button without background
  text,
}

/// Enum for button sizes.
enum GButtonSize {
  /// Small button size
  small,

  /// Medium button size (default)
  medium,

  /// Large button size
  large,
}
