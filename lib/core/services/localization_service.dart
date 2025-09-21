import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Localization service for managing app strings and translations.
/// This service provides centralized access to localized strings.
///
/// Usage Example:
/// ```dart
/// final loc = LocalizationService.of(context);
/// final title = loc.getString('dashboard');
/// ```
class LocalizationService {
  /// Private constructor
  LocalizationService._();

  /// Singleton instance
  static final LocalizationService _instance = LocalizationService._();

  /// Get the singleton instance
  static LocalizationService get instance => _instance;

  /// Localized strings map
  Map<String, String> _strings = {};

  /// Current locale
  Locale _currentLocale = const Locale('en');

  /// Get current locale
  Locale get currentLocale => _currentLocale;

  /// Initialize the localization service
  /// This method loads the default English strings
  ///
  /// Usage Example:
  /// ```dart
  /// await LocalizationService.instance.initialize();
  /// ```
  Future<void> initialize() async {
    await _loadStrings('en');
  }

  /// Load strings for a specific locale
  /// This method loads strings from the ARB file for the given locale
  ///
  /// Parameters:
  /// - [locale]: The locale to load strings for
  ///
  /// Usage Example:
  /// ```dart
  /// await LocalizationService.instance.loadLocale(Locale('en'));
  /// ```
  Future<void> loadLocale(Locale locale) async {
    await _loadStrings(locale.languageCode);
    _currentLocale = locale;
  }

  /// Load strings from ARB file
  /// This method reads and parses the ARB file for the given language code
  ///
  /// Parameters:
  /// - [languageCode]: The language code (e.g., 'en', 'fa')
  Future<void> _loadStrings(String languageCode) async {
    try {
      // Load the ARB file
      final String jsonString = await rootBundle.loadString(
        'lib/l10n/app_$languageCode.arb',
      );

      // Parse the JSON
      final Map<String, dynamic> jsonMap = json.decode(jsonString);

      // Convert to string map
      _strings = jsonMap.map((key, value) => MapEntry(key, value.toString()));
    } catch (e) {
      // Fallback to English if the locale file is not found
      if (languageCode != 'en') {
        await _loadStrings('en');
      } else {
        // Use default strings if even English fails
        _strings = _getDefaultStrings();
      }
    }
  }

  /// Get a localized string by key
  /// This method returns the localized string for the given key
  ///
  /// Parameters:
  /// - [key]: The string key
  /// - [params]: Optional parameters for string interpolation
  ///
  /// Returns:
  /// - [String]: The localized string
  ///
  /// Usage Example:
  /// ```dart
  /// final title = LocalizationService.instance.getString('dashboard');
  /// final message = LocalizationService.instance.getString('welcome', {'name': 'John'});
  /// ```
  String getString(String key, [Map<String, String>? params]) {
    String string = _strings[key] ?? key;

    // Replace parameters if provided
    if (params != null) {
      params.forEach((paramKey, value) {
        string = string.replaceAll('{$paramKey}', value);
      });
    }

    return string;
  }

  /// Get localized string with context
  /// This method provides a convenient way to get strings with BuildContext
  ///
  /// Parameters:
  /// - [context]: The BuildContext
  /// - [key]: The string key
  /// - [params]: Optional parameters for string interpolation
  ///
  /// Returns:
  /// - [String]: The localized string
  ///
  /// Usage Example:
  /// ```dart
  /// final title = LocalizationService.of(context).getString('dashboard');
  /// ```
  static String of(
    BuildContext context,
    String key, [
    Map<String, String>? params,
  ]) {
    return instance.getString(key, params);
  }

  /// Get default English strings
  /// This method provides fallback strings if ARB files are not available
  Map<String, String> _getDefaultStrings() {
    return {
      'appTitle': 'Money Flow',
      'dashboard': 'Dashboard',
      'transactions': 'Transactions',
      'analytics': 'Analytics',
      'settings': 'Settings',
      'addTransaction': 'Add Transaction',
      'editTransaction': 'Edit Transaction',
      'login': 'Login',
      'splash': 'Splash',
      'welcomeToDashboard': 'Welcome to your dashboard!',
      'somethingWentWrong': 'Something went wrong',
      'retry': 'Retry',
      'settingsComingSoon': 'Settings coming soon!',
      'addTransactionComingSoon': 'Add transaction coming soon!',
      'refresh': 'Refresh',
      'loading': 'Loading...',
      'error': 'Error',
      'success': 'Success',
      'cancel': 'Cancel',
      'save': 'Save',
      'delete': 'Delete',
      'edit': 'Edit',
      'add': 'Add',
      'close': 'Close',
      'back': 'Back',
      'next': 'Next',
      'previous': 'Previous',
      'done': 'Done',
      'confirm': 'Confirm',
      'yes': 'Yes',
      'no': 'No',
      'ok': 'OK',
      'noData': 'No data available',
      'tryAgain': 'Try again',
      'networkError': 'Network error. Please check your connection.',
      'serverError': 'Server error. Please try again later.',
      'unknownError': 'An unknown error occurred.',
      'totalBalance': 'Total Balance',
      'monthlyIncome': 'Monthly Income',
      'monthlyExpenses': 'Monthly Expenses',
      'recentTransactions': 'Recent Transactions',
      'viewAll': 'View All',
      'income': 'Income',
      'expense': 'Expense',
      'investment': 'Investment',
      'charity': 'Charity',
      'amount': 'Amount',
      'category': 'Category',
      'description': 'Description',
      'date': 'Date',
      'time': 'Time',
      'notes': 'Notes',
    };
  }

  /// Check if a string key exists
  /// This method checks if the given key exists in the current locale
  ///
  /// Parameters:
  /// - [key]: The string key to check
  ///
  /// Returns:
  /// - [bool]: True if the key exists, false otherwise
  bool hasKey(String key) {
    return _strings.containsKey(key);
  }

  /// Get all available string keys
  /// This method returns all available string keys for the current locale
  ///
  /// Returns:
  /// - [Set<String>]: Set of all available keys
  Set<String> getAllKeys() {
    return _strings.keys.toSet();
  }

  /// Get current locale strings count
  /// This method returns the number of strings loaded for the current locale
  ///
  /// Returns:
  /// - [int]: Number of strings
  int get stringsCount => _strings.length;
}

/// Extension on BuildContext for easy localization access
/// This extension provides convenient methods for accessing localized strings
///
/// Usage Example:
/// ```dart
/// final title = context.l10n('dashboard');
/// final message = context.l10n('welcome', {'name': 'John'});
/// ```
extension LocalizationExtension on BuildContext {
  /// Get localized string with context
  /// This method provides a convenient way to get strings with BuildContext
  ///
  /// Parameters:
  /// - [key]: The string key
  /// - [params]: Optional parameters for string interpolation
  ///
  /// Returns:
  /// - [String]: The localized string
  ///
  /// Usage Example:
  /// ```dart
  /// final title = context.l10n('dashboard');
  /// final message = context.l10n('welcome', {'name': 'John'});
  /// ```
  String l10n(String key, [Map<String, String>? params]) {
    return LocalizationService.of(this, key, params);
  }
}
