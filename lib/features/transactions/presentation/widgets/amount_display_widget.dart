import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:money_flow/core/widgets/g_text.dart';

/// Widget for displaying and editing transaction amount.
/// This widget provides a large, prominent display of the transaction amount
/// with direct text field editing functionality.
///
/// Usage Example:
/// ```dart
/// AmountDisplayWidget(
///   amount: 25.50,
///   onAmountChanged: (newAmount) => _updateAmount(newAmount),
/// )
/// ```
class AmountDisplayWidget extends StatefulWidget {
  /// The current transaction amount
  final double amount;

  /// Callback when amount is changed
  final ValueChanged<double> onAmountChanged;

  /// Whether the amount display is enabled
  final bool enabled;

  /// Currency symbol to display
  final String currencySymbol;

  const AmountDisplayWidget({
    super.key,
    required this.amount,
    required this.onAmountChanged,
    this.enabled = true,
    this.currencySymbol = '\$',
  });

  @override
  State<AmountDisplayWidget> createState() => _AmountDisplayWidgetState();
}

class _AmountDisplayWidgetState extends State<AmountDisplayWidget> {
  late TextEditingController _controller;
  late FocusNode _focusNode;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _focusNode = FocusNode();
    _updateControllerText();

    _focusNode.addListener(() {
      if (!_focusNode.hasFocus && _isEditing) {
        _finishEditing();
      }
    });
  }

  @override
  void didUpdateWidget(AmountDisplayWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.amount != widget.amount && !_isEditing) {
      _updateControllerText();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _updateControllerText() {
    final displayAmount = widget.amount == 0 ? '' : widget.amount.toString();
    _controller.text = displayAmount;
  }

  void _startEditing() {
    if (!widget.enabled) return;

    setState(() {
      _isEditing = true;
    });

    // Clear the controller and focus
    _controller.text = widget.amount == 0 ? '' : widget.amount.toString();
    _focusNode.requestFocus();
  }

  void _finishEditing() {
    setState(() {
      _isEditing = false;
    });

    final text = _controller.text.trim();
    if (text.isEmpty) {
      widget.onAmountChanged(0.0);
    } else {
      final amount = double.tryParse(text) ?? 0.0;
      widget.onAmountChanged(amount);
    }

    _updateControllerText();
  }

  void _onSubmitted(String value) {
    _finishEditing();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: _isEditing ? _buildTextField() : _buildDisplayText(),
      ),
    );
  }

  /// Builds the text field for editing mode.
  /// This creates a transparent text field that matches the display style.
  Widget _buildTextField() {
    return SizedBox(
      width: double.infinity,
      child: TextField(
        controller: _controller,
        focusNode: _focusNode,
        textAlign: TextAlign.center,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
        ],
        style: TextStyle(
          fontSize: 64,
          fontWeight: FontWeight.w300,
          color: Colors.grey.shade600,
          letterSpacing: -1.0,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: '0.00',
          hintStyle: TextStyle(
            fontSize: 64,
            fontWeight: FontWeight.w300,
            color: Colors.grey.shade400,
            letterSpacing: -1.0,
          ),
          prefix: GText(
            widget.currencySymbol,
            style: TextStyle(
              fontSize: 64,
              fontWeight: FontWeight.w300,
              color: Colors.grey.shade600,
              letterSpacing: -1.0,
            ),
          ),
        ),
        onSubmitted: _onSubmitted,
        onTapOutside: (event) => _finishEditing(),
      ),
    );
  }

  /// Builds the display text for view mode.
  /// This shows the formatted amount that can be tapped to edit.
  Widget _buildDisplayText() {
    return GestureDetector(
      onTap: _startEditing,
      child: GText(
        _formatAmount(),
        style: TextStyle(
          fontSize: 64,
          fontWeight: FontWeight.w300,
          color: Colors.grey.shade600,
          letterSpacing: -1.0,
        ),
      ),
    );
  }

  /// Formats the amount for display.
  /// This method formats the amount with proper currency symbol and decimal places.
  String _formatAmount() {
    final displayAmount = widget.amount == 0 ? 0.00 : widget.amount.abs();
    return '${widget.currencySymbol}${displayAmount.toStringAsFixed(2)}';
  }
}
