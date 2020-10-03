import 'package:moor/moor.dart';

class Bookings extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get customerId => text()();

  TextColumn get providerId => text()();
  TextColumn get description => text()
      .nullable()
      .withDefault(Constant(
          "Ipsum suspendisse ultrices gravida dictum fusce ut placerat. Cursus sit amet dictum sit amet. Vel elit scelerisque mauris pellentesque pulvinar pellentesque habitant morbi tristique"))
      .withLength(max: 1000)();
  TextColumn get reason => text()();
  @JsonKey("lat")
  RealColumn get locationLat =>
      real().named("lat").withDefault(Constant(5.5329650))();
  @JsonKey("lng")
  RealColumn get locationLng =>
      real().named("lng").withDefault(Constant(-0.2592160))();
  RealColumn get value => real().withDefault(Constant(10.99))();
  RealColumn get progress => real().withDefault(Constant(0.45))();

  @JsonKey("created_at")
  IntColumn get createdAt =>
      integer().withDefault(Constant(DateTime.now().millisecondsSinceEpoch))();
  IntColumn get dueDate => integer().withDefault(
      Constant(DateTime.now().millisecondsSinceEpoch + 430000000))();
}

enum BookingType { NEW, ONGOING, COMPLETED }
