import 'package:super_enum/super_enum.dart';

part 'business_event.super.dart';

@superEnum
enum _BusinessEvent {
  @Data(fields: [DataField<String>("artisanId")])
  GetBusinessesForArtisan,
  @generic
  @Data(fields: [DataField<Generic>("business")])
  UpdateBusiness,
  @Data(fields: [
    DataField<String>("docUrl"),
    DataField<String>("name"),
    DataField<String>("artisan"),
    DataField<String>("location"),
  ])
  UploadBusiness,
}
