import 'package:moor/moor.dart';

@DataClassName("ServiceCategory")
class CategoryItem extends Table {
  TextColumn get id => text()();

  TextColumn get name => text()();

  TextColumn get avatar => text()();

  @override
  Set<Column> get primaryKey => {id};
}
