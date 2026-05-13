import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/app_constants.dart';

class DarkThemeProvider extends ChangeNotifier {
  bool _darkTheme = false;

  bool get darkTheme => _darkTheme;

  DarkThemeProvider() {
    _loadFromPrefs();
  }

  set darkTheme(bool value) {
    _darkTheme = value;
    _saveToPrefs();
    notifyListeners();
  }

  _loadFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _darkTheme = prefs.getBool(AppConstants.themeKey) ?? false;
    notifyListeners();
  }

  _saveToPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(AppConstants.themeKey, _darkTheme);
  }
}
