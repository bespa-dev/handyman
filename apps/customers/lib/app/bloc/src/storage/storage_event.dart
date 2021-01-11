import 'package:super_enum/super_enum.dart';

part 'storage_event.super.dart';

@superEnum
enum _StorageEvent {
  @Data(fields: [
    DataField<String>("path"),
    DataField<String>("filePath"),
    DataField<bool>("isImage"),
  ])
  UploadFile,
}
