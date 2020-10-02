import 'package:moor/moor.dart';

@DataClassName("CustomerReview")
class Review extends Table {
  TextColumn get id => text()();

  TextColumn get review => text()();

  TextColumn get customerId => text()();

  TextColumn get providerId => text()();

  DateTimeColumn get createdAt =>
      dateTime().withDefault(Constant(DateTime.now()))();

  @override
  Set<Column> get primaryKey => {id, customerId, providerId};
}
