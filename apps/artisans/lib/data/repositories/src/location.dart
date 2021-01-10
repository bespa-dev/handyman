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
import 'package:handyman/data/entities/entities.dart';
import 'package:handyman/domain/models/src/location/location.dart';
import 'package:handyman/domain/repositories/repositories.dart';
import 'package:handyman/shared/shared.dart';
import 'package:meta/meta.dart';

class LocationRepositoryImpl implements BaseLocationRepository {
  final Geocoding _geocoding;

  LocationRepositoryImpl({
    @required Geocoding geocoding,
  }) : _geocoding = geocoding;

  @override
  Future<BaseLocationMetadata> getCurrentLocation() async {
    var position = await Geolocator.getCurrentPosition();
    return LocationMetadata(lat: position.latitude, lng: position.longitude);
  }

  @override
  Future<String> getLocationName(
      {@required BaseLocationMetadata metadata}) async {
    final addresses = await _geocoding
        .findAddressesFromCoordinates(Coordinates(metadata.lat, metadata.lng));
    return addresses.first?.addressLine ?? "Unknown location";
  }

  @override
  Stream<BaseLocationMetadata> observeCurrentLocation() async* {
    yield* Geolocator.getPositionStream().map(
        (event) => LocationMetadata(lat: event.latitude, lng: event.longitude));
  }

  @override
  Future<BaseLocationMetadata> getLocationPosition(
      {@required String name}) async {
    var addresses = await _geocoding.findAddressesFromQuery(name);
    if (addresses.isNotEmpty) {
      for (var value in addresses) {
        logger.i("Address: ${value.addressLine} => ${value.coordinates}");
      }
      /// return first address
      return LocationMetadata(
          lat: addresses[0].coordinates.latitude,
          lng: addresses[0].coordinates.longitude);
    }
    return null;
  }
}
