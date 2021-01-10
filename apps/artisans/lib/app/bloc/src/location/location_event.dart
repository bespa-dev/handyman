import 'package:super_enum/super_enum.dart';

part 'location_event.super.dart';

@superEnum
enum _LocationEvent {
  @object
  GetCurrentLocation,
  @object
  ObserveCurrentLocation,
  @generic
  @Data(fields: [DataField<Generic>("location")])
  GetLocationName
}
