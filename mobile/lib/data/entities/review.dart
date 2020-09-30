import 'package:moor/moor.dart';

@DataClassName("CustomerReview")
class Review extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get review => text()();

  TextColumn get customerId => text()();

  TextColumn get providerId => text()();

  DateTimeColumn get createdAt =>
      dateTime().withDefault(Constant(DateTime.now()))();
}
