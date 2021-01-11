/*
 * Copyright (c) 2021.
 * This application is owned by HandyMan LLC,
 * developed & designed by Quabynah Codelabs LLC.
 *
 *
 * author: codelbas.quabynah@gmail.com
 */

import 'package:lite/domain/models/models.dart'
    show Exposable, BaseLocationMetadata;
import 'package:meta/meta.dart';

/// base location repository class
abstract class BaseLocationRepository implements Exposable {
  /// Get current location
  Future<BaseLocationMetadata> getCurrentLocation();

  /// Observe location updates
  Stream<BaseLocationMetadata> observeCurrentLocation();

  /// Get location name based on [metadata]
  Future<String> getLocationName({@required BaseLocationMetadata metadata});

  /// Get location based on [name]
  Future<BaseLocationMetadata> getLocationPosition({@required String name});
}
