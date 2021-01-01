/*
 * Copyright (c) 2021.
 * This application is owned by HandyMan LLC,
 * developed & designed by Quabynah Codelabs LLC.
 *
 *
 * author: codelbas.quabynah@gmail.com
 */

import 'package:handyman/domain/models/models.dart';

/// Base preference repository
abstract class BasePreferenceRepository implements Exposable {
  String emergencyContactNumber;

  String userId;

  Stream<bool> get onThemeChanged;

  bool isLightTheme;
}
