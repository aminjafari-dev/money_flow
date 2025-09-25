import 'package:flutter/material.dart';
import 'package:money_flow/core/theme/app_colors.dart';
import 'package:money_flow/core/widgets/g_text.dart';
import 'package:money_flow/core/theme/app_fonts.dart';

/// Shared loading state widget for SMS import feature.
/// This widget provides a consistent loading state UI across all SMS widgets
/// with customizable loading message.
///
/// Usage Example:
/// ```dart
/// SmsLoadingStateWidget(
///   message: 'Loading SMS conversations...',
/// )
/// ```
class SmsLoadingStateWidget extends StatelessWidget {
  /// The loading message to display.
  final String message;

  /// Creates a new instance of SmsLoadingStateWidget.
  ///
  /// Parameters:
  /// - [message]: The loading message to display
  const SmsLoadingStateWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.backgroundLight,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border, width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Center(
          child: Column(
            children: [
              const CircularProgressIndicator(),
              const SizedBox(height: 16),
              GText(
                message,
                style: AppFonts.bodyMedium,
                color: AppColors.textSecondary,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
