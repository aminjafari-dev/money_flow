import 'package:flutter/material.dart';
import 'package:money_flow/core/widgets/g_text.dart';

/// Widget for displaying and editing transaction amount.
/// This widget provides a large, prominent display of the transaction amount
/// with tap-to-edit functionality.
///
/// Usage Example:
/// ```dart
/// AmountDisplayWidget(
///   amount: 25.50,
///   onAmountTapped: () => _showAmountInputDialog(),
/// )
/// ```
class AmountDisplayWidget extends StatelessWidget {
  /// The current transaction amount
  final double amount;

  /// Callback when amount display is tapped
  final VoidCallback onAmountTapped;

  /// Whether the amount display is enabled
  final bool enabled;

  /// Currency symbol to display
  final String currencySymbol;

  const AmountDisplayWidget({
    super.key,
    required this.amount,
    required this.onAmountTapped,
    this.enabled = true,
    this.currencySymbol = '\$',
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: enabled ? onAmountTapped : null,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade200, width: 1),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Amount display
              GText(
                _formatAmount(),
                style: const TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.w300,
                  color: Colors.grey,
                ),
              ),

              // Tap to edit hint
              if (enabled)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: GText(
                    'Tap to edit',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade500,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  /// Formats the amount for display.
  /// This method formats the amount with proper currency symbol and decimal places.
  String _formatAmount() {
    final displayAmount = amount == 0 ? 0.00 : amount.abs();
    return '$currencySymbol${displayAmount.toStringAsFixed(2)}';
  }
}
