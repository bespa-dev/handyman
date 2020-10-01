import 'package:moor/moor.dart';

class Bookings extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get customerId => text()();

  TextColumn get providerId => text()();

  DateTimeColumn get createdAt =>
      dateTime().withDefault(Constant(DateTime.now()))();
}
