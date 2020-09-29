import 'dart:io';

import 'package:handyman/data/entities/booking.dart';
import 'package:handyman/data/entities/provider.dart';
import 'package:handyman/data/entities/review.dart';
import 'package:handyman/data/entities/user.dart';
import 'package:moor/ffi.dart';
import 'package:moor/moor.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'local_database.g.dart';

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'handyman_db.sqlite'));
    return VmDatabase(file);
  });
}

@UseMoor(tables: [ServiceProvider, User, Bookings, Review])
class LocalDatabase extends _$LocalDatabase {
  LocalDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}
