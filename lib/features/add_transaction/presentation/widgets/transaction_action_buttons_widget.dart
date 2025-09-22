import 'package:flutter/material.dart';
import 'package:money_flow/core/widgets/g_text.dart';

/// Widget for transaction action buttons (Cancel and Save).
/// This widget provides consistent action buttons for transaction forms.
///
/// Usage Example:
/// ```dart
/// TransactionActionButtonsWidget(
///   onCancel: () => Navigator.of(context).pop(),
///   onSave: () => _saveTransaction(),
///   isLoading: false,
///   canSave: true,
/// )
/// ```
class TransactionActionButtonsWidget extends StatelessWidget {
  /// Callback when cancel button is pressed
  final VoidCallback onCancel;

  /// Callback when save button is pressed
  final VoidCallback onSave;

  /// Whether the save operation is in progress
  final bool isLoading;

  /// Whether the save button should be enabled
  final bool canSave;

  /// Text for the cancel button
  final String cancelText;

  /// Text for the save button
  final String saveText;

  const TransactionActionButtonsWidget({
    super.key,
    required this.onCancel,
    required this.onSave,
    this.isLoading = false,
    this.canSave = true,
    this.cancelText = 'Cancel',
    this.saveText = 'Save',
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          // Cancel button
          Expanded(
            child: OutlinedButton(
              onPressed: isLoading ? null : onCancel,
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                side: BorderSide(
                  color: isLoading
                      ? Colors.grey.shade300
                      : Colors.grey.shade400,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                backgroundColor: Colors.white,
              ),
              child: GText(
                cancelText,
                style: TextStyle(
                  color: isLoading
                      ? Colors.grey.shade400
                      : Colors.grey.shade700,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),

          const SizedBox(width: 16),

          // Save button
          Expanded(
            child: ElevatedButton(
              onPressed: (isLoading || !canSave) ? null : onSave,
              style: ElevatedButton.styleFrom(
                backgroundColor: canSave && !isLoading
                    ? Colors.blue
                    : Colors.grey.shade300,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: canSave && !isLoading ? 2 : 0,
              ),
              child: isLoading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  : GText(
                      saveText,
                      style: TextStyle(
                        color: canSave && !isLoading
                            ? Colors.white
                            : Colors.grey.shade600,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
