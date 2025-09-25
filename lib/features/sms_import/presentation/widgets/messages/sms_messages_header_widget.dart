import 'package:flutter/material.dart';
import 'package:money_flow/core/theme/app_colors.dart';
import 'package:money_flow/core/theme/app_fonts.dart';
import 'package:money_flow/core/widgets/g_button.dart';
import 'package:money_flow/core/widgets/g_text.dart';
import 'package:money_flow/l10n/generated/app_localizations.dart';

/// Header widget for SMS messages list.
/// This widget displays the title and refresh button for the messages section.
///
/// Usage Example:
/// ```dart
/// SmsMessagesHeaderWidget(
///   onRefresh: () => refreshMessages(),
/// )
/// ```
class SmsMessagesHeaderWidget extends StatelessWidget {
  /// Callback function when the refresh button is pressed.
  final VoidCallback onRefresh;

  /// Creates a new instance of SmsMessagesHeaderWidget.
  ///
  /// Parameters:
  /// - [onRefresh]: Callback function when the refresh button is pressed
  const SmsMessagesHeaderWidget({super.key, required this.onRefresh});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GText(
          l10n.smsMessages,
          style: AppFonts.titleLarge,
          color: AppColors.textPrimary,
        ),
        GButton(
          text: l10n.refresh,
          onPressed: onRefresh,
          variant: GButtonVariant.outlined,
          size: GButtonSize.small,
          icon: Icons.refresh,
        ),
      ],
    );
  }
}
