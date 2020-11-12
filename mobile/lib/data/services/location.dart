import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:handyman/domain/services/location.dart';
import 'package:meta/meta.dart';

/// Implementation of [LocationService]
class LocationServiceImpl implements LocationService {
  LocationServiceImpl._();

  static LocationService create() => LocationServiceImpl._();

  @override
  Future<LocationMetaData> getCurrentLocation() async {
    var position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    return LocationMetaData(lat: position.latitude, lng: position.longitude);
  }

  @override
  Stream<LocationMetaData> watchCurrentLocation() =>
      Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
          .asStream()
          .map((event) =>
              LocationMetaData(lat: event.latitude, lng: event.longitude));

  @override
  Future<String> getLocationName({@required LocationMetaData metadata}) async {
    final addresses = await Geocoder.local
        .findAddressesFromCoordinates(Coordinates(metadata.lat, metadata.lng));
    return addresses.first?.addressLine ?? "Unknown location";
  }
}
