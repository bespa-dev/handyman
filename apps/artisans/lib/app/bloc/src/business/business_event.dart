import 'package:super_enum/super_enum.dart';

part 'business_event.super.dart';

@superEnum
enum _BusinessEvent {
  @Data(fields: [DataField<String>("artisanId")])
  GetBusinessesForArtisan,
  @Data(fields: [DataField<String>("id")])
  GetBusinessById,
  @generic
  @Data(fields: [DataField<Generic>("params")])
  UploadBusiness,
}
