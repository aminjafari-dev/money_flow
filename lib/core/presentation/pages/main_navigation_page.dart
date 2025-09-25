import 'package:flutter/material.dart';
import 'package:money_flow/core/theme/app_colors.dart';
import 'package:money_flow/core/widgets/widgets.dart';
import 'package:money_flow/l10n/generated/app_localizations.dart';
import 'package:money_flow/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:money_flow/features/transactions/presentation/pages/transactions_page.dart';

/// Main navigation page with bottom navigation bar.
/// This page serves as the root container for all main app features.
///
/// Features:
/// - Bottom navigation bar with 4 tabs
/// - Persistent navigation state
/// - Tab switching with proper state management
///
/// Usage Example:
/// ```dart
/// Navigator.pushReplacement(
///   context,
///   MaterialPageRoute(builder: (context) => const MainNavigationPage()),
/// );
/// ```
class MainNavigationPage extends StatefulWidget {
  /// Initial tab index to display (0-3)
  final int initialIndex;

  const MainNavigationPage({super.key, this.initialIndex = 0});

  @override
  State<MainNavigationPage> createState() => _MainNavigationPageState();
}

class _MainNavigationPageState extends State<MainNavigationPage> {
  late int _currentIndex;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    // Initialize current index with provided initial index or default to 0
    _currentIndex = widget.initialIndex;
    // Create page controller with initial page
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  void dispose() {
    // Dispose page controller to prevent memory leaks
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return GScaffold(
      backgroundColor: AppColors.background,
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        children: [
          // Dashboard Tab - Main financial overview
          DashboardPage(userId: 'user123'),

          // Transactions Tab - Transaction list and management
          const TransactionsPage(),

          // Analytics Tab - Charts and insights
          const SizedBox(),

          // Settings Tab - App configuration and preferences
          const SizedBox(),
        ],
      ),
      bottomNavigationBar: _buildBottomNavigationBar(l10n),
    );
  }

  /// Builds the bottom navigation bar with 4 tabs.
  /// This method creates a Material Design bottom navigation bar with icons and labels.
  ///
  /// Parameters:
  /// - [l10n]: Localization instance for tab labels
  ///
  /// Returns:
  /// - [Widget]: Configured bottom navigation bar
  BottomNavigationBar _buildBottomNavigationBar(AppLocalizations l10n) {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      onTap: _onTabTapped,
      type: BottomNavigationBarType.fixed,
      backgroundColor: AppColors.surface,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: AppColors.textSecondary,
      selectedLabelStyle: const TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 12,
      ),
      unselectedLabelStyle: const TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 12,
      ),
      items: [
        // Dashboard Tab
        BottomNavigationBarItem(
          icon: Icon(
            _currentIndex == 0 ? Icons.dashboard : Icons.dashboard_outlined,
            size: 24,
          ),
          label: l10n.dashboard,
        ),

        // Transactions Tab
        BottomNavigationBarItem(
          icon: Icon(
            _currentIndex == 1
                ? Icons.receipt_long
                : Icons.receipt_long_outlined,
            size: 24,
          ),
          label: l10n.transactions,
        ),

        // Analytics Tab
        BottomNavigationBarItem(
          icon: Icon(
            _currentIndex == 2 ? Icons.analytics : Icons.analytics_outlined,
            size: 24,
          ),
          label: l10n.analytics,
        ),

        // Settings Tab
        BottomNavigationBarItem(
          icon: Icon(
            _currentIndex == 3 ? Icons.settings : Icons.settings_outlined,
            size: 24,
          ),
          label: l10n.settings,
        ),
      ],
    );
  }

  /// Handles tab tap events.
  /// This method updates the current tab and animates to the selected page.
  ///
  /// Parameters:
  /// - [index]: Index of the tapped tab (0-3)
  void _onTabTapped(int index) {
    // Check if the same tab is tapped to avoid unnecessary operations
    if (_currentIndex == index) return;

    setState(() {
      _currentIndex = index;
    });

    // Animate to the selected page with smooth transition
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  /// Handles page change events from PageView.
  /// This method updates the current tab index when user swipes between pages.
  ///
  /// Parameters:
  /// - [index]: Index of the current page (0-3)
  void _onPageChanged(int index) {
    // Update current index without triggering animation
    setState(() {
      _currentIndex = index;
    });
  }
}
