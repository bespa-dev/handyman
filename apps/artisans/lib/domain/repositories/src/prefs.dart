/*
 * Copyright (c) 2021.
 * This application is owned by HandyMan LLC,
 * developed & designed by Quabynah Codelabs LLC.
 *
 *
 * author: codelbas.quabynah@gmail.com
 */

import 'package:flutter/foundation.dart';
import 'package:handyman/domain/models/models.dart';

/// Base preference repository
abstract class BasePreferenceRepository extends ChangeNotifier with Exposable {
  String emergencyContactNumber;
  String userId;
  bool isLightTheme;
  bool useStandardViewType;
  bool shouldShowSplash;

  Stream<bool> get onThemeChanged;

  bool get isLoggedIn;

  Future<void> signOut();

  void dispose();
}
