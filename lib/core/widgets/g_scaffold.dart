import 'package:flutter/material.dart';
import 'package:money_flow/core/theme/app_colors.dart';

/// Global Scaffold widget for consistent app-wide styling and behavior.
/// This widget provides a standardized scaffold with common configurations.
///
/// Usage Example:
/// ```dart
/// GScaffold(
///   title: 'Dashboard',
///   body: DashboardContent(),
///   actions: [
///     IconButton(
///       icon: Icon(Icons.settings),
///       onPressed: () => navigateToSettings(),
///     ),
///   ],
/// )
/// ```
class GScaffold extends StatelessWidget {
  /// The title to display in the app bar
  final String? title;

  /// The main content of the scaffold
  final Widget body;

  /// Optional actions to display in the app bar
  final List<Widget>? actions;

  /// Optional leading widget in the app bar
  final Widget? leading;

  /// Optional floating action button
  final Widget? floatingActionButton;

  /// Optional bottom navigation bar
  final Widget? bottomNavigationBar;

  /// Optional drawer
  final Widget? drawer;

  /// Optional end drawer
  final Widget? endDrawer;

  /// Background color of the scaffold
  final Color? backgroundColor;

  /// Whether to show the app bar
  final bool showAppBar;

  /// Whether to automatically adjust body for keyboard
  final bool resizeToAvoidBottomInset;

  /// Optional bottom sheet
  final Widget? bottomSheet;

  /// Whether the app bar should be pinned
  final bool pinned;

  /// Whether the app bar should be floating
  final bool floating;

  /// Whether the app bar should snap
  final bool snap;

  /// Creates a new instance of GScaffold.
  ///
  /// Parameters:
  /// - [title]: The title to display in the app bar
  /// - [body]: The main content of the scaffold
  /// - [actions]: Optional actions to display in the app bar
  /// - [leading]: Optional leading widget in the app bar
  /// - [floatingActionButton]: Optional floating action button
  /// - [bottomNavigationBar]: Optional bottom navigation bar
  /// - [drawer]: Optional drawer
  /// - [endDrawer]: Optional end drawer
  /// - [backgroundColor]: Background color of the scaffold
  /// - [showAppBar]: Whether to show the app bar
  /// - [resizeToAvoidBottomInset]: Whether to automatically adjust body for keyboard
  /// - [bottomSheet]: Optional bottom sheet
  /// - [pinned]: Whether the app bar should be pinned
  /// - [floating]: Whether the app bar should be floating
  /// - [snap]: Whether the app bar should snap
  ///
  /// Usage Example:
  /// ```dart
  /// GScaffold(
  ///   title: 'Dashboard',
  ///   body: DashboardContent(),
  ///   actions: [
  ///     IconButton(
  ///       icon: Icon(Icons.refresh),
  ///       onPressed: () => refreshData(),
  ///     ),
  ///   ],
  /// )
  /// ```
  const GScaffold({
    super.key,
    this.title,
    required this.body,
    this.actions,
    this.leading,
    this.floatingActionButton,
    this.bottomNavigationBar,
    this.drawer,
    this.endDrawer,
    this.backgroundColor,
    this.showAppBar = true,
    this.resizeToAvoidBottomInset = true,
    this.bottomSheet,
    this.pinned = false,
    this.floating = false,
    this.snap = false,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Set background color to light background for dashboard design
      backgroundColor: backgroundColor ?? AppColors.background,

      // Configure app bar if needed
      appBar: showAppBar && title != null
          ? AppBar(
              // Set title with consistent styling
              title: Text(
                title!,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),

              // Add actions if provided
              actions: actions,

              // Add leading widget if provided
              leading: leading,

              // Set consistent elevation
              elevation: 0,

              // Set background color to light background to match design
              backgroundColor: AppColors.background,

              // Set foreground color for contrast
              foregroundColor: AppColors.textPrimary,

              // Center the title
              centerTitle: true,

              // Remove rounded corners for clean design
              shape: null,
            )
          : null,

      // Set the main body content
      body: body,

      // Add floating action button if provided
      floatingActionButton: floatingActionButton,

      // Add bottom navigation bar if provided
      bottomNavigationBar: bottomNavigationBar,

      // Add drawer if provided
      drawer: drawer,

      // Add end drawer if provided
      endDrawer: endDrawer,

      // Add bottom sheet if provided
      bottomSheet: bottomSheet,

      // Configure keyboard behavior
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
    );
  }
}

/// Extension on GScaffold for common configurations.
/// This provides convenient methods for common scaffold setups.
extension GScaffoldExtensions on GScaffold {
  /// Creates a GScaffold with a simple title and body.
  /// This is useful for basic pages that only need a title and content.
  ///
  /// Parameters:
  /// - [title]: The title to display
  /// - [body]: The main content
  ///
  /// Usage Example:
  /// ```dart
  /// GScaffold.simple(
  ///   title: 'Settings',
  ///   body: SettingsContent(),
  /// )
  /// ```
  static GScaffold simple({
    required String title,
    required Widget body,
    Color? backgroundColor,
  }) {
    return GScaffold(
      title: title,
      body: body,
      backgroundColor: backgroundColor,
    );
  }

  /// Creates a GScaffold with a refresh action.
  /// This is useful for pages that need a refresh functionality.
  ///
  /// Parameters:
  /// - [title]: The title to display
  /// - [body]: The main content
  /// - [onRefresh]: Callback for refresh action
  ///
  /// Usage Example:
  /// ```dart
  /// GScaffold.withRefresh(
  ///   title: 'Dashboard',
  ///   body: DashboardContent(),
  ///   onRefresh: () => refreshDashboard(),
  /// )
  /// ```
  static GScaffold withRefresh({
    required String title,
    required Widget body,
    required VoidCallback onRefresh,
    Color? backgroundColor,
  }) {
    return GScaffold(
      title: title,
      body: body,
      backgroundColor: backgroundColor,
      actions: [
        IconButton(
          icon: const Icon(Icons.refresh),
          onPressed: onRefresh,
          tooltip: 'Refresh',
        ),
      ],
    );
  }

  /// Creates a GScaffold with a settings action.
  /// This is useful for pages that need access to settings.
  ///
  /// Parameters:
  /// - [title]: The title to display
  /// - [body]: The main content
  /// - [onSettings]: Callback for settings action
  ///
  /// Usage Example:
  /// ```dart
  /// GScaffold.withSettings(
  ///   title: 'Dashboard',
  ///   body: DashboardContent(),
  ///   onSettings: () => navigateToSettings(),
  /// )
  /// ```
  static GScaffold withSettings({
    required String title,
    required Widget body,
    required VoidCallback onSettings,
    Color? backgroundColor,
  }) {
    return GScaffold(
      title: title,
      body: body,
      backgroundColor: backgroundColor,
      actions: [
        IconButton(
          icon: const Icon(Icons.settings),
          onPressed: onSettings,
          tooltip: 'Settings',
        ),
      ],
    );
  }

  /// Creates a GScaffold without an app bar.
  /// This is useful for full-screen content or custom layouts.
  ///
  /// Parameters:
  /// - [body]: The main content
  /// - [backgroundColor]: Background color
  ///
  /// Usage Example:
  /// ```dart
  /// GScaffold.noAppBar(
  ///   body: FullScreenContent(),
  /// )
  /// ```
  static GScaffold noAppBar({required Widget body, Color? backgroundColor}) {
    return GScaffold(
      body: body,
      backgroundColor: backgroundColor,
      showAppBar: false,
    );
  }
}
