import 'package:flutter/material.dart';
import 'package:money_flow/core/router/page_name.dart';
import 'package:money_flow/core/presentation/pages/main_navigation_page.dart';
import 'package:money_flow/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:money_flow/features/add_transaction/presentation/pages/add_transaction_page.dart';
import 'package:money_flow/features/transactions/presentation/pages/transactions_page.dart';
import 'package:money_flow/features/sms_import/presentation/pages/sms_import_page.dart';
import 'package:money_flow/features/sms_import/presentation/pages/sms_messages_page.dart';

/// Global page router for the application.
/// This class manages all route mappings and page navigation.
///
/// Usage Example:
/// ```dart
/// Navigator.pushNamed(context, PageName.dashboard);
/// ```
class PageRouter {
  /// Map of all routes in the application
  static Map<String, WidgetBuilder> routes = {
    // Main navigation route (root with bottom navigation)
    PageName.mainNavigation: (context) => const MainNavigationPage(),

    // Dashboard routes
    PageName.dashboard: (context) => const DashboardPage(userId: 'user123'),

    // Transaction routes
    PageName.addTransaction: (context) => const AddTransactionPage(),
    PageName.transactions: (context) => const TransactionsPage(),

    // SMS Import routes
    PageName.smsImport: (context) => const SmsImportPage(),
    PageName.smsMessages: (context) {
      final address =
          ModalRoute.of(context)?.settings.arguments as String? ?? '';
      return SmsMessagesPage(address: address);
    },

    // TODO: Add other routes as features are implemented
    // PageName.analytics: (context) => const AnalyticsPage(),
    // PageName.settings: (context) => const SettingsPage(),
    // PageName.editTransaction: (context) => const EditTransactionPage(),
    // PageName.login: (context) => const LoginPage(),
    // PageName.splash: (context) => const SplashPage(),
  };

  /// Gets the route generator for MaterialApp
  /// This method returns the route generator function for the app
  ///
  /// Returns:
  /// - [Route<dynamic>?]: Route generator function
  ///
  /// Usage Example:
  /// ```dart
  /// MaterialApp(
  ///   onGenerateRoute: PageRouter.onGenerateRoute,
  /// )
  /// ```
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    final routeName = settings.name;

    if (routeName == null || !routes.containsKey(routeName)) {
      // Return a 404 page or redirect to main navigation
      return MaterialPageRoute(
        builder: (context) => const MainNavigationPage(),
      );
    }

    return MaterialPageRoute(builder: routes[routeName]!, settings: settings);
  }
}
