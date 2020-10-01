import 'package:moor/moor.dart';

@DataClassName("Customer")
class User extends Table {
  TextColumn get id => text()();

  TextColumn get name => text()();

  TextColumn get email => text()();

  TextColumn get avatar => text().nullable()();

  TextColumn get createdAt => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
