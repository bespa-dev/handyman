import 'package:meta/meta.dart';

class LocationMetaData {
  final double lat;
  final double lng;

  const LocationMetaData({@required this.lat,@required  this.lng});
}

abstract class LocationService {
  /// Get current location
  Future<LocationMetaData> getCurrentLocation();

  /// Observe location updates
  Stream<LocationMetaData> watchCurrentLocation();

  /// Get location name based on [metaData]
  Future<String> getLocationName({@required LocationMetaData metadata});
}
