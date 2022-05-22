import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
export 'package:provider/provider.dart';

class DrawerProvider extends ChangeNotifier {
  DrawerProvider(){
    getThemeMode();
  }

  int selectedIndex = 0;

  changeIndex(int index) {
    selectedIndex = index;
    notifyListeners();
  }

  bool _isDrawerOpened = true;

  bool get isDrawer => _isDrawerOpened;

  toggleDrawer() async {
    _isDrawerOpened = !_isDrawerOpened;
    notifyListeners();
  }

  bool _showLabel = false;

  bool get showLabel => _showLabel;

  showLabelText() async {
    _showLabel = !_showLabel;
    notifyListeners();
  }

  ThemeMode _themeMode = ThemeMode.light;
  ThemeMode get themeMode => _themeMode;

  getThemeMode() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    if (_prefs.getString('theme') == 'dark') {
      _themeMode = ThemeMode.dark;
    } else {
      _themeMode = ThemeMode.light;
    }
    notifyListeners();
  }

  changeThemeMode() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    if (_themeMode == ThemeMode.dark) {
      _themeMode = ThemeMode.light;
      _prefs.setString('theme', 'light');
    }else if (_themeMode == ThemeMode.light) {
      _themeMode = ThemeMode.dark;
      _prefs.setString('theme', 'dark');
    }
    notifyListeners();
  }
}
