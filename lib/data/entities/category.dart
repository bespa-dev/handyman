import 'package:moor/moor.dart';

@DataClassName("ServiceCategory")
class CategoryItem extends Table {
  TextColumn get id => text()();

  TextColumn get name => text()();

  TextColumn get avatar => text()();

  IntColumn get group => integer().withDefault(Constant(0))();

  @override
  Set<Column> get primaryKey => {id};
}

enum CategoryGroup {
  FEATURED,
  MOST_RATED,
  RECENT,
  POPULAR,
  RECOMMENDED,
}
