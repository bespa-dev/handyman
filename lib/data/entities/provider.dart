import 'package:moor/moor.dart';

@DataClassName("Artisan")
class ServiceProvider extends Table {
  TextColumn get id => text()();

  TextColumn get name => text()();

  TextColumn get business => text().nullable()();

  TextColumn get email => text()();

  TextColumn get category => text().withDefault(Constant("general"))();

  IntColumn get startWorkingHours =>
      integer().withDefault(Constant(DateTime.now().hour))();

  IntColumn get endWorkingHours =>
      integer().withDefault(Constant(DateTime.now().hour + 12))();

  TextColumn get avatar => text().nullable()();

  RealColumn get price => real().withDefault(Constant(20.99))();

  RealColumn get rating => real().withDefault(Constant(3.5))();

  @override
  Set<Column> get primaryKey => {id};
}
