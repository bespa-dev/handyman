/*
 * Copyright (c) 2021.
 * This application is owned by HandyMan LLC,
 * developed & designed by Quabynah Codelabs LLC.
 *
 *
 * author: codelbas.quabynah@gmail.com
 */

import 'package:geocoder/geocoder.dart' show Coordinates;
import 'package:geocoder/services/base.dart' show Geocoding;
import 'package:geolocator/geolocator.dart';
import 'package:handyman/domain/models/src/location/location.dart';
import 'package:handyman/domain/repositories/repositories.dart';
import 'package:meta/meta.dart';

class LocationRepositoryImpl implements BaseLocationRepository {
  final Geolocator _geolocator;
  final Geocoding _geocoding;

  LocationRepositoryImpl({
    @required Geolocator locatorService,
    @required Geocoding geocoding,
  })  : _geolocator = locatorService,
        _geocoding = geocoding;

  @override
  Future<LocationMetadata> getCurrentLocation() async {
    var position = await _geolocator.getCurrentPosition();
    return LocationMetadata(lat: position.latitude, lng: position.longitude);
  }

  @override
  Future<String> getLocationName({LocationMetadata metadata}) async {
    final addresses = await _geocoding
        .findAddressesFromCoordinates(Coordinates(metadata.lat, metadata.lng));
    return addresses.first?.addressLine ?? "Unknown location";
  }

  @override
  Stream<LocationMetadata> observeCurrentLocation() async* {
    yield* _geolocator.getPositionStream().map(
        (event) => LocationMetadata(lat: event.latitude, lng: event.longitude));
  }
}
