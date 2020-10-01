import 'package:flutter/material.dart';

/// Theme provider for application
class ThemeProvider extends ChangeNotifier {
  bool _isLightTheme = true;

  bool get isLightTheme => _isLightTheme;

  void toggleTheme({bool value}) {
    _isLightTheme = value ?? !_isLightTheme;
    notifyListeners();
  }
}
