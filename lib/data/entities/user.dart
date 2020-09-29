import 'package:moor/moor.dart';

@DataClassName("Customer")
class User extends Table {
  TextColumn get id => text()();

  TextColumn get name => text().nullable()();

  TextColumn get email => text().nullable()();

  TextColumn get avatar => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
