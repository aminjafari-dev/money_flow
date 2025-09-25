import 'package:flutter/material.dart';
import 'package:money_flow/core/theme/app_colors.dart';
import 'package:money_flow/core/theme/app_fonts.dart';
import 'package:money_flow/core/widgets/g_button.dart';
import 'package:money_flow/core/widgets/g_gap.dart';
import 'package:money_flow/core/widgets/g_text.dart';
import 'package:money_flow/features/sms_import/presentation/bloc/sms_import_state.dart';

/// Widget for displaying SMS permission status and handling permission requests.
/// This widget shows the current permission status and provides a button
/// to request SMS permission when needed.
///
/// The widget follows the design system by using consistent colors, fonts,
/// and spacing throughout the application.
///
/// Usage Example:
/// ```dart
/// SmsPermissionWidget(
///   permissionState: state.permission,
///   onRequestPermission: () => requestPermission(),
/// )
/// ```
class SmsPermissionWidget extends StatelessWidget {
  /// The current permission state to display.
  /// This state determines what UI elements to show and their styling.
  final PermissionState permissionState;

  /// Callback function to request SMS permission.
  /// This function is called when the user taps the request permission button.
  final VoidCallback onRequestPermission;

  /// Creates a new instance of SmsPermissionWidget.
  ///
  /// Parameters:
  /// - [permissionState]: The current permission state to display
  /// - [onRequestPermission]: Callback function to request SMS permission
  ///
  /// Usage Example:
  /// ```dart
  /// SmsPermissionWidget(
  ///   permissionState: PermissionState.completed(true),
  ///   onRequestPermission: () => requestPermission(),
  /// )
  /// ```
  const SmsPermissionWidget({
    super.key,
    required this.permissionState,
    required this.onRequestPermission,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Permission status header
            Row(
              children: [
                // Permission icon
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: _getPermissionColor().withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    _getPermissionIcon(),
                    color: _getPermissionColor(),
                    size: 24,
                  ),
                ),

                GGap.medium(),

                // Permission title
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GText(
                        'SMS Permission',
                        style: AppFonts.titleMedium,
                        color: AppColors.textPrimary,
                      ),
                      GGap.extraSmall(),
                      GText(
                        _getPermissionMessage(),
                        style: AppFonts.bodySmall,
                        color: AppColors.textSecondary,
                      ),
                    ],
                  ),
                ),
              ],
            ),

            GGap.medium(),

            // Permission action button
            _buildPermissionButton(),
          ],
        ),
      ),
    );
  }

  /// Builds the permission action button based on the current state.
  /// This method returns different button configurations depending on
  /// the permission state and whether action is needed.
  Widget _buildPermissionButton() {
    return permissionState.when(
      // Initial state - show request permission button
      initial: () => GButton(
        text: 'Request Permission',
        onPressed: onRequestPermission,
        variant: GButtonVariant.filled,
        icon: Icons.security,
        isFullWidth: true,
      ),

      // Loading state - show loading button
      loading: () => GButton(
        text: 'Checking Permission...',
        onPressed: null,
        variant: GButtonVariant.filled,
        isLoading: true,
        isFullWidth: true,
      ),

      // Completed state - show appropriate button based on permission status
      completed: (hasPermission) => hasPermission
          ? GButton(
              text: 'Permission Granted',
              onPressed: null,
              variant: GButtonVariant.outlined,
              icon: Icons.check_circle,
              isFullWidth: true,
            )
          : GButton(
              text: 'Grant Permission',
              onPressed: onRequestPermission,
              variant: GButtonVariant.filled,
              icon: Icons.security,
              isFullWidth: true,
            ),

      // Error state - show retry button
      error: (message) => GButton(
        text: 'Retry',
        onPressed: onRequestPermission,
        variant: GButtonVariant.outlined,
        icon: Icons.refresh,
        isFullWidth: true,
      ),
    );
  }

  /// Gets the appropriate icon for the current permission state.
  /// This method returns different icons based on the permission status
  /// to provide visual feedback to the user.
  IconData _getPermissionIcon() {
    return permissionState.when(
      initial: () => Icons.security,
      loading: () => Icons.hourglass_empty,
      completed: (hasPermission) =>
          hasPermission ? Icons.check_circle : Icons.block,
      error: (message) => Icons.error,
    );
  }

  /// Gets the appropriate color for the current permission state.
  /// This method returns different colors based on the permission status
  /// to provide visual feedback to the user.
  Color _getPermissionColor() {
    return permissionState.when(
      initial: () => AppColors.warning,
      loading: () => AppColors.primary,
      completed: (hasPermission) =>
          hasPermission ? AppColors.success : AppColors.danger,
      error: (message) => AppColors.danger,
    );
  }

  /// Gets the appropriate message for the current permission state.
  /// This method returns different messages based on the permission status
  /// to inform the user about the current state.
  String _getPermissionMessage() {
    return permissionState.when(
      initial: () => 'SMS permission is required to import transactions',
      loading: () => 'Checking SMS permission status...',
      completed: (hasPermission) => hasPermission
          ? 'SMS permission is granted. You can now import transactions'
          : 'SMS permission is required to import transactions',
      error: (message) => 'Error checking permission: $message',
    );
  }
}
