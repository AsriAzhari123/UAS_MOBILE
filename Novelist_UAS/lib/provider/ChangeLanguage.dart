import 'package:flutter/material.dart';

class LanguageProvider with ChangeNotifier {
  Locale _currentLocale = Locale('en', 'US');
  bool _isDarkMode = false;

  Locale get currentLocale => _currentLocale;
  bool get isDarkMode => _isDarkMode;

  set currentLocale(Locale locale) {
    _currentLocale = locale;
    notifyListeners();
  }

  set isDarkMode(bool value) {
    _isDarkMode = value;
    notifyListeners();
  }

  List<Locale> supportedLocales = [
    Locale('en', 'US'),
    Locale('id', 'ID'),
    Locale('es', 'ES'), // Added Spanish locale
    // Add other languages as needed
  ];
}
