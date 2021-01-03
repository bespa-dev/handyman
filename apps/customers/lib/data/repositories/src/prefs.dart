/*
 * Copyright (c) 2021.
 * This application is owned by HandyMan LLC,
 * developed & designed by Quabynah Codelabs LLC.
 *
 *
 * author: codelbas.quabynah@gmail.com
 */

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:lite/domain/repositories/repositories.dart';
import 'package:lite/shared/shared.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferenceRepositoryImpl extends BasePreferenceRepository {
  final SharedPreferences _prefs;

  PreferenceRepositoryImpl({@required SharedPreferences prefs})
      : _prefs = prefs {
    _initPrefs();
  }

  bool _isLightTheme = true,
      _useStandardViewType = true,
      _isLoggedIn = true,
      _shouldShowSplash = true;
  String _userId, _emergencyContactNumber;
  final StreamController<bool> _onThemeChangeController =
      StreamController.broadcast();

  @override
  String get emergencyContactNumber => _emergencyContactNumber;

  @override
  bool get isLightTheme => _isLightTheme;

  @override
  bool get isLoggedIn => _isLoggedIn;

  @override
  bool get shouldShowSplash => _shouldShowSplash;

  @override
  bool get useStandardViewType => _useStandardViewType;

  @override
  String get userId => _userId;

  @override
  Stream<bool> get onThemeChanged => _onThemeChangeController.stream;

  @override
  set userId(String _userId) {
    _prefs.setString(PrefUtils.kUserId, _userId);
    this._userId = _userId;
    notifyListeners();
  }

  @override
  set isLightTheme(bool _isLightTheme) {
    _prefs.setBool(PrefUtils.kTheme, _isLightTheme);
    this._isLightTheme = _isLightTheme;
    notifyListeners();
  }

  @override
  set shouldShowSplash(bool _shouldShowSplash) {
    _prefs.setBool(PrefUtils.kShowSplash, _shouldShowSplash);
    this._shouldShowSplash = _shouldShowSplash;
    notifyListeners();
  }

  @override
  set useStandardViewType(bool _useStandardViewType) {
    _prefs.setBool(PrefUtils.kStandardView, _useStandardViewType);
    this._useStandardViewType = _useStandardViewType;
    notifyListeners();
  }

  @override
  Future<void> signOut() async {
    userId = null;
    notifyListeners();
  }

  @override
  void dispose() {
    _onThemeChangeController.close();
    super.dispose();
  }

  void _initPrefs() async {
    _userId = _prefs.getString(PrefUtils.kUserId);
    _emergencyContactNumber = _prefs.getString(PrefUtils.kEmergencyContact);
    _isLightTheme = _prefs.getBool(PrefUtils.kTheme) ?? false;
    _useStandardViewType = _prefs.getBool(PrefUtils.kStandardView) ?? true;
    _shouldShowSplash = _prefs.getBool(PrefUtils.kShowSplash) ?? true;
    _onThemeChangeController.add(_isLightTheme);
    _isLoggedIn = _userId != null && _userId.isNotEmpty;

    notifyListeners();
  }
}
