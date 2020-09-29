import 'package:moor/moor.dart';

@DataClassName("Artisan")
class ServiceProvider extends Table {
  TextColumn get id => text()();

  TextColumn get name => text()();

  TextColumn get business => text().nullable()();

  TextColumn get email => text()();

  TextColumn get avatar => text().nullable()();

  RealColumn get price => real().withDefault(Constant(20.99))();

  @override
  Set<Column> get primaryKey => {id};
}
