import 'package:moor/moor.dart';

@DataClassName("Artisan")
class ServiceProvider extends Table {
  TextColumn get id => text()();

  TextColumn get name => text()();

  TextColumn get business => text().nullable()();

  TextColumn get phone => text().nullable()();

  TextColumn get email => text()();

  @JsonKey("certified")
  BoolColumn get isCertified =>
      boolean().named("certified").withDefault(Constant(false))();

  @JsonKey("available")
  BoolColumn get isAvailable =>
      boolean().named("available").withDefault(Constant(false))();

  TextColumn get category =>
      text().withDefault(Constant("598d67f5-b84b-4572-9058-57f36463aeac"))();

  @JsonKey("start_working_hours")
  IntColumn get startWorkingHours =>
      integer().withDefault(Constant(DateTime.now().hour))();
  @JsonKey("completed_bookings_count")
  IntColumn get completedBookingsCount => integer().withDefault(Constant(0))();
  @JsonKey("ongoing_bookings_count")
  IntColumn get ongoingBookingsCount => integer().withDefault(Constant(0))();
  @JsonKey("cancelled_bookings_count")
  IntColumn get cancelledBookingsCount => integer().withDefault(Constant(0))();
  @JsonKey("requests_count")
  IntColumn get requestsCount => integer().withDefault(Constant(0))();

  @JsonKey("end_working_hours")
  IntColumn get endWorkingHours =>
      integer().withDefault(Constant(DateTime.now().hour + 12))();

  TextColumn get avatar => text().nullable()();

  @JsonKey("about_me")
  TextColumn get aboutMe => text().nullable().withLength(max: 5000)();

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
