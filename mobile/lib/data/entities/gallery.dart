import 'package:moor/moor.dart';

@DataClassName("Gallery")
class PhotoGallery extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text()();
  TextColumn get imageUrl => text()();
  DateTimeColumn get createdAt =>
      dateTime().withDefault(Constant(DateTime.now()))();

  @override
  Set<Column> get primaryKey => {id, userId};
}
