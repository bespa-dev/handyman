import 'package:flutter/material.dart';
import 'package:handyman/core/service_locator.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// [SharedPreferences] helper class
class PrefsProvider extends ChangeNotifier {
  static const USER_ID = "user_id";
  static const USER_TYPE = "user_type";
  static const THEME_MODE = "theme_mode";

  bool _isLoggedIn = false, _isDarkTheme = false;
  String _userId, _userType;

  String get userId => _userId;

  String get userType => _userType;

  bool get isLoggedIn => _isLoggedIn;

  bool get isDarkTheme => _isDarkTheme;

  SharedPreferences _prefs;

  // Constructor
  PrefsProvider() {
    _init();
  }

  void _init() async {
    _prefs = await sl.getAsync<SharedPreferences>();
    _isDarkTheme = _prefs.getBool(THEME_MODE) ?? false;
    _userId = _prefs.getString(USER_ID) ?? null;
    _userType = _prefs.getString(USER_TYPE) ?? null;
    _isLoggedIn = _userId != null && _userId.isNotEmpty;
  }

  void saveUserId(String value) async {
    await _prefs.setString(USER_ID, value);
    _userId = value;
    _isLoggedIn = value != null && value.isNotEmpty;
    notifyListeners();
  }

  void saveUserType(String value) async {
    await _prefs.setString(USER_TYPE, value);
    _userType = value;
    notifyListeners();
  }

  void updateTheme(bool value) async {
    await _prefs.setBool(THEME_MODE, value);
    _isDarkTheme = value;
    notifyListeners();
  }
}
