import 'package:flutter/material.dart';
import 'package:money_flow/core/theme/app_colors.dart';
import 'package:money_flow/core/theme/app_fonts.dart';
import 'package:money_flow/core/widgets/g_gap.dart';
import 'package:money_flow/core/widgets/g_text.dart';
import 'package:money_flow/l10n/generated/app_localizations.dart';

/// Widget for displaying a load more indicator in the conversations list.
/// This widget shows a loading indicator at the bottom of the list
/// when there are more conversations to load.
///
/// Usage Example:
/// ```dart
/// SmsLoadMoreIndicatorWidget()
/// ```
class SmsLoadMoreIndicatorWidget extends StatelessWidget {
  /// Creates a new instance of SmsLoadMoreIndicatorWidget.
  const SmsLoadMoreIndicatorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Container(
      decoration: BoxDecoration(
        color: AppColors.backgroundLight,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border, width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
              ),
            ),
            GGap.medium(),
            GText(
              l10n.loadingMoreConversations,
              style: AppFonts.bodyMedium,
              color: AppColors.textSecondary,
            ),
          ],
        ),
      ),
    );
  }
}
