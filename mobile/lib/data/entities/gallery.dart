import 'package:moor/moor.dart';

@DataClassName("Gallery")
class PhotoGallery extends Table {
  TextColumn get id => text()();
  @JsonKey("user_id")
  TextColumn get userId => text()();
  @JsonKey("image_url")
  TextColumn get imageUrl => text()();
  @JsonKey("created_at")
  DateTimeColumn get createdAt =>
      dateTime().withDefault(Constant(DateTime.now()))();

  @override
  Set<Column> get primaryKey => {id, userId};
}
