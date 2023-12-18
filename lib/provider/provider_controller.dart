import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProviderController extends ChangeNotifier {

  ProviderController(this._prefs) {
    // load theme from preferences on initialization
    _currentThemeId = _prefs.getInt("themeId") ?? 0;
    _baseCurrency = _prefs.getString("baseCurrency") ?? "USD";
    _starredCurrencies = _prefs.getStringList("starredCurrencies") ?? [];
    _isFirstEnter = _prefs.getBool("isFirstEnter") ?? true;
  }

  final SharedPreferences _prefs;

  // themes: 0 == system, 1 == light, 2 == dark
  int _currentThemeId = 0;
  String _baseCurrency = "";

  List<String> _starredCurrencies = [];

  bool _isFirstEnter = true;

  String _timeAmount = "hour";

  // getters
  int get currentThemeId => _currentThemeId;

  String get baseCurrency => _baseCurrency;
  List<String> get starredCurrencies => _starredCurrencies;

  bool get isFirstEnter => _isFirstEnter;

  String get timeAmount => _timeAmount;

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

  void addStarredCurrency(String newStarred) {
    _starredCurrencies.add(newStarred);
    notifyListeners();
    _prefs.setStringList("starredCurrencies", _starredCurrencies);
  }

  void removeStarredCurrency(String removedStarred) {
    _starredCurrencies.remove(removedStarred);
    notifyListeners();
    _prefs.setStringList("starredCurrencies", _starredCurrencies);
  }

  void endFirstEnter() {
    _isFirstEnter = false;
    notifyListeners();
    _prefs.setBool("isFirstEnter", _isFirstEnter);
  }

  void setTimeAmount(String newAmount) {
    _timeAmount = newAmount;
    notifyListeners();
  }
}

