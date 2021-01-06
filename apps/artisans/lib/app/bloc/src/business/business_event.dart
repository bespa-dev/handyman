import 'package:super_enum/super_enum.dart';

part 'business_event.super.dart';

@superEnum
enum _BusinessEvent {
  @Data(fields: [DataField<String>("artisanId")])
  GetBusinessesForArtisan,
  @Data(fields: [
    DataField<String>("docUrl"),
    DataField<String>("name"),
    DataField<String>("artisan"),
    DataField<double>("lat"),
    DataField<double>("lng"),
  ])
  UploadBusiness,
}
