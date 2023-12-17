import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProviderController extends ChangeNotifier {

  ProviderController(this._prefs) {
    // load theme from preferences on initialization
    _currentThemeId = _prefs.getInt("themeId") ?? 0;
    _baseCurrency = _prefs.getString("baseCurrency") ?? "USD";
  }

  final SharedPreferences _prefs;

  // themes: 0 == system, 1 == light, 2 == dark
  int _currentThemeId = 0;
  String _baseCurrency = "";

  // getters
  int get currentThemeId => _currentThemeId;

  String get baseCurrency => _baseCurrency;

  void setTheme(int theme) {
    _currentThemeId = theme;

    // notify the app that the theme was changed
    notifyListeners();

    // store updated theme on disk
    _prefs.setInt("themeId", theme);
  }

  void setBaseCurrency(String newBase) {
    _baseCurrency = newBase;
    notifyListeners();
    _prefs.setString("baseCurrency", _baseCurrency);
  }
}

