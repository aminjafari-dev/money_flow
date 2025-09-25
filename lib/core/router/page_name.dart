/// Page name constants for the application.
/// This class contains all route names used throughout the app.
///
/// Usage Example:
/// ```dart
/// Navigator.pushNamed(context, PageName.dashboard);
/// ```
class PageName {
  /// Main navigation page route (root with bottom navigation)
  static const String mainNavigation = '/main-navigation';

  /// Dashboard page route
  static const String dashboard = '/dashboard';

  /// Transactions page route
  static const String transactions = '/transactions';

  /// Analytics page route
  static const String analytics = '/analytics';

  /// Settings page route
  static const String settings = '/settings';

  /// Add transaction page route
  static const String addTransaction = '/add-transaction';

  /// Edit transaction page route
  static const String editTransaction = '/edit-transaction';

  /// Login page route
  static const String login = '/login';

  /// Splash page route
  static const String splash = '/splash';

  /// Bank Selection page route
  static const String bankSelection = '/bank-selection';

  /// SMS Import page route
  static const String smsImport = '/sms-import';

  /// SMS Messages page route
  static const String smsMessages = '/sms-messages';

  /// SMS Conversations for Bank Selection page route
  static const String smsConversationsForBank = '/sms-conversations-for-bank';
}
