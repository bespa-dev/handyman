import 'dart:async';

import 'package:flutter/material.dart';
import 'package:handyman/core/service_locator.dart';
import 'package:handyman/core/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// [SharedPreferences] helper class
class PrefsProvider extends ChangeNotifier {
  bool _isLoggedIn = false, _isLightTheme = true, _shouldShowSplash = true;
  String _userId, _userType;
  final StreamController<bool> _themeController = StreamController.broadcast();

  String get userId => _userId;

  String get userType => _userType;

  bool get isLoggedIn => _isLoggedIn;

  bool get shouldShowSplash => _shouldShowSplash;

  bool get isLightTheme => _isLightTheme;

  Stream<bool> get onThemeChanged => _themeController.stream;

  SharedPreferences _prefs;

  // Constructor
  PrefsProvider._();

  factory PrefsProvider.create() => PrefsProvider._().._init();

  void _init() async {
    _prefs = await sl.getAsync<SharedPreferences>();
    _isLightTheme = _prefs.getBool(PrefsUtils.THEME_MODE) ?? false;
    _shouldShowSplash = _prefs.getBool(PrefsUtils.SHOW_SPLASH_SCREEN) ?? true;
    _userId = _prefs.getString(PrefsUtils.USER_ID) ?? null;
    _userType = _prefs.getString(PrefsUtils.USER_TYPE) ?? null;
    _isLoggedIn = _userId != null && _userId.isNotEmpty;
    debugPrint("Light mode state -> $isLightTheme");
    toggleTheme(value: _isLightTheme);
  }

  void saveUserId(String value) async {
    await _prefs.setString(PrefsUtils.USER_ID, value);
    _userId = value;
    _isLoggedIn = value != null && value.isNotEmpty;
    notifyListeners();
  }

  void saveUserType(String value) async {
    await _prefs.setString(PrefsUtils.USER_TYPE, value);
    _userType = value;
    notifyListeners();
  }

  void toggleTheme({bool value}) async {
    await _prefs.setBool(PrefsUtils.THEME_MODE, value);
    _isLightTheme = value ?? !_isLightTheme;
    _themeController.sink.add(value);
    notifyListeners();
  }

  void toggleShowSplash({bool value}) async {
    await _prefs.setBool(PrefsUtils.SHOW_SPLASH_SCREEN, value);
    _shouldShowSplash = value ??= !_shouldShowSplash;
    notifyListeners();
  }

  @override
  void dispose() {
    _themeController.close();
    super.dispose();
  }
}
