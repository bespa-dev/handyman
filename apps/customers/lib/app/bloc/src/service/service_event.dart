import 'package:super_enum/super_enum.dart';

part 'service_event.super.dart';

@superEnum
enum _ArtisanServiceEvent {
  @Data(fields: [DataField<String>('id')])
  GetArtisanServices,
  @Data(fields: [DataField<String>('categoryId')])
  GetCategoryServices,
  @Data(fields: [DataField<String>('id')])
  GetServiceById,
  @generic
  @Data(fields: [DataField<Generic>('service')])
  UpdateArtisanService,
  @object
  GetAllArtisanServices,
}
