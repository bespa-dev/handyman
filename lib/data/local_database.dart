import 'dart:io';

import 'package:flutter/material.dart';
import 'package:moor/ffi.dart';
import 'package:moor/moor.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import 'entities/booking.dart';
import 'entities/category.dart';
import 'entities/provider.dart';
import 'entities/review.dart';
import 'entities/user.dart';

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

@UseMoor(
  tables: [ServiceProvider, User, Bookings, Review, CategoryItem],
  queries: {
    "userById": "SELECT * FROM user WHERE id = ?",
  },
  daos: [ProviderDao],
)
class LocalDatabase extends _$LocalDatabase {
  LocalDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(onCreate: (m) {
        debugPrint("Created database");
        return Future.value();
      }, beforeOpen: (_) {
        debugPrint("Before open");
        return Future.value();
      });
}

@UseDao(
  tables: [ServiceProvider],
  queries: {
    "providerById": "SELECT * FROM service_provider WHERE id = ?",
  },
)
class ProviderDao extends DatabaseAccessor<LocalDatabase>
    with _$ProviderDaoMixin {
  ProviderDao(LocalDatabase db) : super(db);

  Future addProviders(List<Artisan> providers) {
    providers.forEach((person) async {
      await into(serviceProvider)
          .insert(person, mode: InsertMode.insertOrReplace);
    });
  }
}
