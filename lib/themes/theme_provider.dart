import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import 'light_mode.dart';
import 'dark_mode.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData _themeData = lightMode;

  ThemeData get themeData => _themeData;

  bool get isDarkMode => _themeData == darkMode;

  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  void toggleThemes() {
    if (_themeData == lightMode) {
      themeData = darkMode as ThemeData;
    } else {
      themeData = lightMode;
    }
  }
}
