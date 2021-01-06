import 'package:handyman/domain/models/models.dart';

abstract class BaseBusiness extends BaseModel {
  String docUrl;
  String artisanId;
  String name;
  LocationMetadata location;

  BaseBusiness copyWith({
    String docUrl,
    String artisanId,
    String name,
    LocationMetadata location,
  });
}
