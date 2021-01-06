import 'package:super_enum/super_enum.dart';

part 'storage_event.super.dart';

@superEnum
enum _StorageEvent {
  @generic
  @Data(fields: [DataField<Generic>("file")])
  UploadFile,
}
