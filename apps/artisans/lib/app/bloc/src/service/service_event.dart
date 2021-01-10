import 'package:super_enum/super_enum.dart';

part 'service_event.super.dart';

@superEnum
enum _ArtisanServiceEvent {
  @object
  GetArtisanServices,
  @generic
  @Data(fields: [DataField<Generic>("service")])
  UpdateArtisanService,
}
