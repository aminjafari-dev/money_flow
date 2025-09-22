import 'package:flutter/material.dart';
import 'package:money_flow/core/router/page_name.dart';
import 'package:money_flow/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:money_flow/features/add_transaction/presentation/pages/add_transaction_page.dart';

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
    // Dashboard routes
    PageName.dashboard: (context) => const DashboardPage(userId: 'user123'),

    // Transaction routes
    PageName.addTransaction: (context) => const AddTransactionPage(),

    // TODO: Add other routes as features are implemented
    // PageName.transactions: (context) => const TransactionsPage(),
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
      // Return a 404 page or redirect to dashboard
      return MaterialPageRoute(
        builder: (context) => const DashboardPage(userId: 'user123'),
      );
    }

    return MaterialPageRoute(builder: routes[routeName]!, settings: settings);
  }
}
