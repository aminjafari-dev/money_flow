import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:money_flow/core/theme/app_colors.dart';
import 'package:money_flow/core/theme/app_fonts.dart';
import 'package:money_flow/core/widgets/g_text.dart';
import 'package:money_flow/features/add_transaction/domain/entities/transaction_entity.dart';
import 'package:money_flow/core/widgets/g_gap.dart';

/// Widget for inputting transaction amount with currency formatting.
/// This widget provides a user-friendly interface for entering transaction amounts
/// with proper validation and formatting.
///
/// Usage Example:
/// ```dart
/// AmountInputWidget(
///   amount: 25.50,
///   onAmountChanged: (amount) {
///     getIt<AddTransactionBloc>().add(
///       AddTransactionEvent.updateAmount(amount: amount),
///     );
///   },
///   transactionType: TransactionType.expense,
/// )
/// ```
class AmountInputWidget extends StatefulWidget {
  /// Current amount value
  final double amount;

  /// Callback when amount changes
  final ValueChanged<double> onAmountChanged;

  /// Transaction type (expense or income)
  final TransactionType transactionType;

  /// Whether the input is enabled
  final bool enabled;

  /// Whether to show currency symbol
  final bool showCurrencySymbol;

  const AmountInputWidget({
    super.key,
    required this.amount,
    required this.onAmountChanged,
    required this.transactionType,
    this.enabled = true,
    this.showCurrencySymbol = true,
  });

  @override
  State<AmountInputWidget> createState() => _AmountInputWidgetState();
}

class _AmountInputWidgetState extends State<AmountInputWidget> {
  late TextEditingController _controller;
  late FocusNode _focusNode;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _focusNode = FocusNode();
    _updateController();

    _focusNode.addListener(() {
      setState(() {
        _isEditing = _focusNode.hasFocus;
      });
    });
  }

  @override
  void didUpdateWidget(AmountInputWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.amount != widget.amount) {
      _updateController();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  /// Updates the controller with the current amount value.
  /// This method formats the amount for display in the text field.
  void _updateController() {
    if (!_isEditing) {
      final formattedAmount = _formatAmount(widget.amount);
      _controller.text = formattedAmount;
    }
  }

  /// Formats the amount for display.
  /// This method formats the amount with proper currency formatting.
  ///
  /// Parameters:
  /// - [amount]: The amount to format
  ///
  /// Returns:
  /// - [String]: Formatted amount string
  String _formatAmount(double amount) {
    if (amount == 0) return '0.00';
    return amount.abs().toStringAsFixed(2);
  }

  /// Handles text changes in the input field.
  /// This method parses the input and updates the amount.
  ///
  /// Parameters:
  /// - [value]: The new text value
  void _onTextChanged(String value) {
    // Remove any non-numeric characters except decimal point
    final cleanValue = value.replaceAll(RegExp(r'[^\d.]'), '');

    // Parse the amount
    final amount = double.tryParse(cleanValue) ?? 0.0;

    // Apply transaction type (negative for expenses, positive for income)
    final finalAmount = widget.transactionType == TransactionType.expense
        ? -amount
        : amount;

    widget.onAmountChanged(finalAmount);
  }

  /// Handles when the user finishes editing.
  /// This method updates the display and removes focus.
  void _onEditingComplete() {
    _focusNode.unfocus();
    setState(() {
      _isEditing = false;
    });
    _updateController();
  }

  /// Handles when the user taps on the amount display.
  /// This method enables editing mode.
  void _onTap() {
    if (widget.enabled) {
      setState(() {
        _isEditing = true;
      });
      _focusNode.requestFocus();

      // Select all text for easy editing
      _controller.selection = TextSelection(
        baseOffset: 0,
        extentOffset: _controller.text.length,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(
          color: _isEditing ? AppColors.primary : AppColors.outline,
          width: _isEditing ? 2.0 : 1.0,
        ),
        boxShadow: _isEditing
            ? [
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.1),
                  blurRadius: 8.0,
                  offset: const Offset(0, 4),
                ),
              ]
            : null,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Currency symbol and amount display
          GestureDetector(
            onTap: _onTap,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                // Currency symbol
                if (widget.showCurrencySymbol) ...[
                  GText(
                    '\$',
                    style: AppFonts.headlineLarge.copyWith(
                      color: AppColors.onSurface,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  GGap.small(),
                ],

                // Amount input field
                Expanded(
                  child: TextField(
                    controller: _controller,
                    focusNode: _focusNode,
                    enabled: widget.enabled,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                      signed: false,
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                        RegExp(r'^\d*\.?\d{0,2}'),
                      ),
                    ],
                    textAlign: TextAlign.center,
                    style: AppFonts.headlineLarge.copyWith(
                      color: AppColors.onSurface,
                      fontWeight: FontWeight.w600,
                    ),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.zero,
                      isDense: true,
                    ),
                    onChanged: _onTextChanged,
                    onEditingComplete: _onEditingComplete,
                    onSubmitted: (_) => _onEditingComplete(),
                  ),
                ),
              ],
            ),
          ),

          GGap.medium(),

          // Transaction type indicator
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 12.0,
              vertical: 6.0,
            ),
            decoration: BoxDecoration(
              color: widget.transactionType == TransactionType.expense
                  ? AppColors.errorContainer
                  : AppColors.primaryContainer,
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: GText(
              widget.transactionType == TransactionType.expense
                  ? 'Expense'
                  : 'Income',
              style: AppFonts.labelMedium.copyWith(
                color: widget.transactionType == TransactionType.expense
                    ? AppColors.onErrorContainer
                    : AppColors.onPrimaryContainer,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          GGap.small(),

          // Helper text
          GText(
            _isEditing
                ? 'Enter amount and tap outside to confirm'
                : 'Tap to edit amount',
            style: AppFonts.bodySmall.copyWith(
              color: AppColors.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
