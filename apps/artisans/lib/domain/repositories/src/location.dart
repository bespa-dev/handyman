/*
 * Copyright (c) 2021.
 * This application is owned by HandyMan LLC,
 * developed & designed by Quabynah Codelabs LLC.
 *
 *
 * author: codelbas.quabynah@gmail.com
 */

import 'package:handyman/domain/models/models.dart' show Exposable, BaseLocationMetadata;
import 'package:meta/meta.dart';

/// base location repository class
abstract class BaseLocationRepository implements Exposable {
  /// Get current location
  Future<BaseLocationMetadata> getCurrentLocation();

  /// Observe location updates
  Stream<BaseLocationMetadata> observeCurrentLocation();

  /// Get location name based on [metaData]
  Future<String> getLocationName({@required BaseLocationMetadata metadata});
}
