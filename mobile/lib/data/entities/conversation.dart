import 'package:moor/moor.dart';

@DataClassName("Conversation")
class Message extends Table {
  TextColumn get id => text()();

  TextColumn get author => text()();

  TextColumn get recipient => text()();

  TextColumn get content => text()();

  TextColumn get createdAt => text()();

  TextColumn get image => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
