/*
 * Copyright (c) 2021.
 * This application is owned by HandyMan LLC,
 * developed & designed by Quabynah Codelabs LLC.
 *
 *
 * author: codelbas.quabynah@gmail.com
 */

import 'package:lite/domain/models/models.dart' show Exposable, LocationMetadata;
import 'package:meta/meta.dart';

/// base location repository class
abstract class BaseLocationRepository implements Exposable {
  /// Get current location
  Future<LocationMetadata> getCurrentLocation();

  /// Observe location updates
  Stream<LocationMetadata> watchCurrentLocation();

  /// Get location name based on [metaData]
  Future<String> getLocationName({@required LocationMetadata metadata});
}
