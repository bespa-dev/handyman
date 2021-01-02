/*
 * Copyright (c) 2021.
 * This application is owned by HandyMan LLC,
 * developed & designed by Quabynah Codelabs LLC.
 *
 *
 * author: codelbas.quabynah@gmail.com
 */

import 'package:flutter/foundation.dart';
import 'package:lite/domain/models/models.dart';

/// Base preference repository
abstract class BasePreferenceRepository extends ChangeNotifier with Exposable {
  String emergencyContactNumber;

  String userId;

  Stream<bool> get onThemeChanged;

  bool isLightTheme;

  bool useStandardViewType;

  bool shouldShowSplash;

  Future<void> signOut();

  void dispose();
}
