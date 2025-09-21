import 'package:flutter/material.dart';
import 'package:money_flow/core/widgets/g_text.dart';

/// Widget for transaction form input fields.
/// This widget provides a consistent styled text field for transaction forms.
///
/// Usage Example:
/// ```dart
/// TransactionFormFieldWidget(
///   controller: _descriptionController,
///   labelText: 'Description',
///   hintText: 'Enter description',
///   onChanged: (value) => _onDescriptionChanged(value),
/// )
/// ```
class TransactionFormFieldWidget extends StatelessWidget {
  /// Text editing controller for the field
  final TextEditingController controller;

  /// Label text for the field
  final String labelText;

  /// Hint text for the field
  final String? hintText;

  /// Callback when field value changes
  final ValueChanged<String>? onChanged;

  /// Callback when field is tapped
  final VoidCallback? onTap;

  /// Whether the field is read-only
  final bool readOnly;

  /// Whether the field is enabled
  final bool enabled;

  /// Icon to display at the end of the field
  final Widget? suffixIcon;

  /// Keyboard type for the field
  final TextInputType? keyboardType;

  /// Maximum number of lines for the field
  final int? maxLines;

  const TransactionFormFieldWidget({
    super.key,
    required this.controller,
    required this.labelText,
    this.hintText,
    this.onChanged,
    this.onTap,
    this.readOnly = false,
    this.enabled = true,
    this.suffixIcon,
    this.keyboardType,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Field label
        GText(
          labelText,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),

        const SizedBox(height: 8),

        // Text field
        TextField(
          controller: controller,
          onChanged: onChanged,
          onTap: onTap,
          readOnly: readOnly,
          enabled: enabled,
          keyboardType: keyboardType,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.grey.shade500, fontSize: 16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.blue, width: 2),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey.shade200),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
            suffixIcon: suffixIcon,
            filled: true,
            fillColor: enabled ? Colors.white : Colors.grey.shade50,
          ),
          style: TextStyle(
            fontSize: 16,
            color: enabled ? Colors.black87 : Colors.grey.shade600,
          ),
        ),
      ],
    );
  }
}
