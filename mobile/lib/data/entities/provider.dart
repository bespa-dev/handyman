import 'package:moor/moor.dart';

@DataClassName("Artisan")
class ServiceProvider extends Table {
  TextColumn get id => text()();

  TextColumn get name => text()();

  TextColumn get business => text().nullable()();

  TextColumn get phone => text().nullable()();

  TextColumn get email => text()();

  BoolColumn get isCertified =>
      boolean().named("certified").withDefault(Constant(false))();

  BoolColumn get isAvailable =>
      boolean().named("available").withDefault(Constant(false))();

  TextColumn get category =>
      text().withDefault(Constant("598d67f5-b84b-4572-9058-57f36463aeac"))();

  IntColumn get startWorkingHours =>
      integer().withDefault(Constant(DateTime.now().hour))();
  IntColumn get completedBookingsCount => integer().withDefault(Constant(0))();
  IntColumn get ongoingBookingsCount => integer().withDefault(Constant(0))();
  IntColumn get cancelledBookingsCount => integer().withDefault(Constant(0))();

  IntColumn get endWorkingHours =>
      integer().withDefault(Constant(DateTime.now().hour + 12))();

  TextColumn get avatar => text().nullable()();

  RealColumn get price => real().withDefault(Constant(20.99))();

  RealColumn get rating => real().withDefault(Constant(3.5))();

  @override
  Set<Column> get primaryKey => {id};
}

enum ProviderOrder {
  AVAILABILITY,
  PRICE,
  RATING,
}
