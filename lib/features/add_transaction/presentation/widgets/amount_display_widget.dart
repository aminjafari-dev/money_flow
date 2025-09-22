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
  double? _lastEditedAmount;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _focusNode = FocusNode();
    _updateControllerText();

    _focusNode.addListener(() {
      if (!_focusNode.hasFocus && _isEditing) {
        // Use a post frame callback to ensure the value is saved
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted && _isEditing) {
            _finishEditing();
          }
        });
      }
    });
  }

  @override
  void didUpdateWidget(AmountDisplayWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Only update controller text if the amount changed from external source
    // and we're not currently editing, and it's not our own change
    if (oldWidget.amount != widget.amount &&
        !_isEditing &&
        _lastEditedAmount != widget.amount) {
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
    // Only update controller text if we're not editing to prevent overriding user input
    if (!_isEditing && mounted) {
      final displayAmount = widget.amount == 0 ? '' : widget.amount.toString();
      // Only update if the text actually changed
      if (_controller.text != displayAmount) {
        _controller.text = displayAmount;
      }
    }
  }

  void _startEditing() {
    if (!widget.enabled) return;

    setState(() {
      _isEditing = true;
    });

    // Set the controller text to current amount for editing
    _controller.text = widget.amount == 0 ? '' : widget.amount.toString();
    _focusNode.requestFocus();

    // Select all text when starting to edit
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_controller.text.isNotEmpty) {
        _controller.selection = TextSelection(
          baseOffset: 0,
          extentOffset: _controller.text.length,
        );
      }
    });
  }

  void _finishEditing() {
    if (!_isEditing) return; // Prevent multiple calls

    final text = _controller.text.trim();
    final amount = text.isEmpty ? 0.0 : (double.tryParse(text) ?? 0.0);

    // Store the amount we're about to save
    _lastEditedAmount = amount;

    // Update state first to prevent rebuilds
    setState(() {
      _isEditing = false;
    });

    // Then notify parent of the change
    widget.onAmountChanged(amount);
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
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          focusedErrorBorder: InputBorder.none,
          fillColor: Colors.transparent,
          filled: true,
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
          contentPadding: EdgeInsets.zero,
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
