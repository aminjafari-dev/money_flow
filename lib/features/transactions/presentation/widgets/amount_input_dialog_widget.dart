import 'package:flutter/material.dart';
import 'package:money_flow/core/widgets/g_text.dart';

/// Widget for amount input dialog.
/// This widget provides a modal dialog for entering transaction amounts.
///
/// Usage Example:
/// ```dart
/// AmountInputDialogWidget.show(
///   context: context,
///   initialAmount: 0.0,
///   onAmountConfirmed: (amount) => _updateAmount(amount),
/// )
/// ```
class AmountInputDialogWidget extends StatefulWidget {
  /// Initial amount to display in the dialog
  final double initialAmount;

  /// Callback when amount is confirmed
  final ValueChanged<double> onAmountConfirmed;

  /// Currency symbol to display
  final String currencySymbol;

  const AmountInputDialogWidget({
    super.key,
    required this.initialAmount,
    required this.onAmountConfirmed,
    this.currencySymbol = '\$',
  });

  /// Shows the amount input dialog.
  /// This static method displays the dialog and handles the result.
  static Future<void> show({
    required BuildContext context,
    required double initialAmount,
    required ValueChanged<double> onAmountConfirmed,
    String currencySymbol = '\$',
  }) {
    return showDialog<void>(
      context: context,
      builder: (context) => AmountInputDialogWidget(
        initialAmount: initialAmount,
        onAmountConfirmed: onAmountConfirmed,
        currencySymbol: currencySymbol,
      ),
    );
  }

  @override
  State<AmountInputDialogWidget> createState() =>
      _AmountInputDialogWidgetState();
}

class _AmountInputDialogWidgetState extends State<AmountInputDialogWidget> {
  late TextEditingController _amountController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _amountController = TextEditingController(
      text: widget.initialAmount == 0.0
          ? ''
          : widget.initialAmount.toStringAsFixed(2),
    );
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const GText(
        'Enter Amount',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
      ),
      content: Form(
        key: _formKey,
        child: TextFormField(
          controller: _amountController,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          decoration: InputDecoration(
            labelText: 'Amount',
            hintText: '0.00',
            prefixText: widget.currencySymbol,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.blue, width: 2),
            ),
          ),
          autofocus: true,
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Please enter an amount';
            }

            final amount = double.tryParse(value.trim());
            if (amount == null) {
              return 'Please enter a valid number';
            }

            if (amount <= 0) {
              return 'Amount must be greater than 0';
            }

            return null;
          },
          onFieldSubmitted: (_) => _confirmAmount(),
        ),
      ),
      actions: [
        // Cancel button
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: GText(
            'Cancel',
            style: TextStyle(
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),

        // Confirm button
        ElevatedButton(
          onPressed: _confirmAmount,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
          ),
          child: const GText(
            'OK',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }

  /// Confirms the entered amount and closes the dialog.
  /// This method validates the input and calls the callback if valid.
  void _confirmAmount() {
    if (_formKey.currentState?.validate() == true) {
      final amount = double.tryParse(_amountController.text.trim()) ?? 0.0;
      widget.onAmountConfirmed(amount);
      Navigator.of(context).pop();
    }
  }
}
