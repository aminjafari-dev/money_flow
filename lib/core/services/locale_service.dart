import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Service for managing app locale settings.
/// This service handles locale persistence and provides methods for changing the app language.
///
/// Usage Example:
/// ```dart
/// final localeService = LocaleService();
/// await localeService.setLocale(const Locale('fa', ''));
/// final currentLocale = localeService.currentLocale;
/// ```
class LocaleService extends ChangeNotifier {
  static const String _localeKey = 'app_locale';

  /// Current locale of the app
  Locale _currentLocale = const Locale('en', '');

  /// Get the current locale
  Locale get currentLocale => _currentLocale;

  /// Get the current locale code
  String get currentLocaleCode => _currentLocale.languageCode;

  /// Initialize the locale service
  /// This method loads the saved locale from SharedPreferences
  Future<void> initialize() async {
    final prefs = await SharedPreferences.getInstance();
    final savedLocaleCode = prefs.getString(_localeKey);

    if (savedLocaleCode != null) {
      _currentLocale = Locale(savedLocaleCode, '');
    }

    notifyListeners();
  }

  /// Set the app locale
  /// This method updates the locale and persists it to SharedPreferences
  ///
  /// Parameters:
  /// - [locale]: The new locale to set
  Future<void> setLocale(Locale locale) async {
    if (_currentLocale == locale) return;

    _currentLocale = locale;

    // Save to SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_localeKey, locale.languageCode);

    notifyListeners();
  }

  /// Toggle between English and Persian
  /// This method switches between the two supported languages
  Future<void> toggleLocale() async {
    final newLocale = _currentLocale.languageCode == 'en'
        ? const Locale('fa', '')
        : const Locale('en', '');

    await setLocale(newLocale);
  }

  /// Check if the current locale is Persian (RTL)
  bool get isRTL => _currentLocale.languageCode == 'fa';

  /// Check if the current locale is English
  bool get isEnglish => _currentLocale.languageCode == 'en';

  /// Get supported locales
  static const List<Locale> supportedLocales = [
    Locale('en', ''),
    Locale('fa', ''),
  ];
}
