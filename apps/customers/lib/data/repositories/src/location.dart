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
import 'package:lite/data/entities/entities.dart';
import 'package:lite/domain/models/src/location/location.dart';
import 'package:lite/domain/repositories/repositories.dart';
import 'package:meta/meta.dart';

class LocationRepositoryImpl implements BaseLocationRepository {
  final Geocoding _geocoding;

  LocationRepositoryImpl({
    @required Geocoding geocoding,
  }) : _geocoding = geocoding;

  @override
  Future<BaseLocationMetadata> getCurrentLocation() async {
    var position = await Geolocator.getCurrentPosition();
    var address = await getLocationName(
        metadata:
            LocationMetadata(lat: position.latitude, lng: position.longitude));
    return LocationMetadata(
      lat: position.latitude,
      lng: position.longitude,
      name: address,
    );
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
    Geolocator.getPositionStream().listen((event) async* {
      var metadata =
          LocationMetadata(lat: event.latitude, lng: event.longitude);
      final name = await getLocationName(metadata: metadata);
      yield metadata.copyWith(name: name);
    });
  }

  @override
  Future<BaseLocationMetadata> getLocationPosition(
      {@required String name}) async {
    var addresses = await _geocoding.findAddressesFromQuery(name);
    if (addresses.isNotEmpty) {
      /// return first address
      return LocationMetadata(
        lat: addresses[0].coordinates.latitude,
        lng: addresses[0].coordinates.longitude,
        name: addresses[0].addressLine,
      );
    }
    return null;
  }
}
