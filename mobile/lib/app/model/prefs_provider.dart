import 'dart:async';

import 'package:flutter/material.dart';
import 'package:handyman/core/service_locator.dart';
import 'package:handyman/core/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// [SharedPreferences] helper class
class PrefsProvider extends ChangeNotifier {
  bool _isLoggedIn = false,
      _isLightTheme = true,
      _useStandardViewType = true,
      _shouldShowSplash = true;
  String _userId, _userType, _emergencyContactNumber;
  final StreamController<bool> _themeController = StreamController.broadcast();

  // Constructor
  PrefsProvider._();

  static PrefsProvider get instance => PrefsProvider._().._init();

  String get userId => _userId;

  String get userType => _userType;

  String get emergencyContactNumber => _emergencyContactNumber;

  bool get isLoggedIn => _isLoggedIn;

  bool get useStandardViewType => _useStandardViewType;

  bool get shouldShowSplash => _shouldShowSplash;

  bool get isLightTheme => _isLightTheme;

  Stream<bool> get onThemeChanged => _themeController.stream;

  SharedPreferences _prefs;

  void _init() async {
    _prefs = await sl.getAsync<SharedPreferences>();
    _userId = _prefs.getString(PrefsUtils.USER_ID) ?? null;
    _userType = _prefs.getString(PrefsUtils.USER_TYPE) ?? null;
    _emergencyContactNumber =
        _prefs.getString(PrefsUtils.EMERGENCY_CONTACT) ?? null;
    _useStandardViewType =
        _prefs.getBool(PrefsUtils.USER_STANDARD_PROFILE_VIEW_TYPE) ?? true;
    _isLightTheme = _prefs.getBool(PrefsUtils.THEME_MODE) ?? false;
    _shouldShowSplash = _prefs.getBool(PrefsUtils.SHOW_SPLASH_SCREEN) ?? true;
    _isLoggedIn = _userId != null && _userId.isNotEmpty;
    notifyListeners();
    toggleTheme(_isLightTheme);
  }

  void saveUserId([String value]) async {
    await _prefs.setString(PrefsUtils.USER_ID, value);
    _userId = value;
    _isLoggedIn = value != null && value.isNotEmpty;
    notifyListeners();
  }

  void saveUserType([String value]) async {
    await _prefs.setString(PrefsUtils.USER_TYPE, value);
    _userType = value;
    notifyListeners();
  }

  void updateEmergencyContact([String value]) async {
    await _prefs.setString(PrefsUtils.EMERGENCY_CONTACT, value);
    _emergencyContactNumber = value;
    notifyListeners();
  }

  void toggleTheme([bool isLightMode]) async {
    _isLightTheme = isLightMode ??= !_isLightTheme;
    await _prefs.setBool(PrefsUtils.THEME_MODE, _isLightTheme);
    _themeController.sink.add(_isLightTheme);
    notifyListeners();
  }

  void toggleShowSplash({bool value}) async {
    await _prefs.setBool(PrefsUtils.SHOW_SPLASH_SCREEN, value);
    _shouldShowSplash = value ??= !_shouldShowSplash;
    notifyListeners();
  }

  void toggleStandardProfileView([bool value]) async {
    _useStandardViewType = value ??= !_useStandardViewType;
    await _prefs.setBool(
        PrefsUtils.USER_STANDARD_PROFILE_VIEW_TYPE, _useStandardViewType);
    notifyListeners();
  }

  void clearUserData() async {
    _userId = null;
    _userType = null;
    await _prefs.setString(PrefsUtils.USER_ID, null);
    await _prefs.setString(PrefsUtils.USER_TYPE, null);
  }

  @override
  void dispose() {
    _themeController.close();
    super.dispose();
  }
}
