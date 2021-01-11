import 'package:lite/domain/models/models.dart';

abstract class BaseBusiness extends BaseModel {
  String docUrl;
  String artisanId;
  String name;
  String location;

  BaseBusiness copyWith({
    String docUrl,
    String artisanId,
    String name,
    String location,
  });
}
