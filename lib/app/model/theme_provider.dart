import 'package:flutter/material.dart';
import 'package:handyman/app/model/prefs_provider.dart';
import 'package:provider/provider.dart';

/// Theme provider for application
class ThemeProvider extends ChangeNotifier {
  bool _isLightTheme = true;
  PrefsProvider _prefsProvider;

  bool get isLightTheme => _isLightTheme;

  ThemeProvider(BuildContext context) {
    _prefsProvider = Provider.of<PrefsProvider>(context);
    _isLightTheme = !_prefsProvider.isDarkTheme;
    notifyListeners();
  }

  void toggleTheme(BuildContext context) {
    _isLightTheme = !_isLightTheme;
    _prefsProvider.updateTheme(!_isLightTheme);
    notifyListeners();
  }
}
