import 'dart:io';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:handyman/data/entities/conversation.dart';
import 'package:handyman/data/entities/gallery.dart';
import 'package:moor/ffi.dart';
import 'package:moor/moor.dart';
import 'package:flutter/services.dart' show rootBundle;
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
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return VmDatabase(file);
  });
}

@UseMoor(
  tables: [
    ServiceProvider,
    User,
    PhotoGallery,
    Bookings,
    Review,
    CategoryItem,
    Message,
  ],
  daos: [
    ProviderDao,
    CategoryDao,
    BookingDao,
    ReviewDao,
    MessageDao,
    CustomerDao,
    GalleryDao,
  ],
)
class LocalDatabase extends _$LocalDatabase {
  LocalDatabase._() : super(_openConnection());

  static LocalDatabase get instance => LocalDatabase._();

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        beforeOpen: (details) async {
          if (details.wasCreated) {
            // Prepopulate the database with some sample data
            // Decode artisans from json array
            final data =
                await rootBundle.loadString("assets/sample_artisan.json");
            var decodedData = json.decode(data);

            List<dynamic> artisans = decodedData ??= [];

            // Save to database
            providerDao.addProviders(
                artisans.map((e) => Artisan.fromJson(e)).toList());

            // Decode categories from json array
            final categoryData =
                await rootBundle.loadString("assets/sample_categories.json");
            var decodedCategoryData = json.decode(categoryData);

            List<dynamic> categories = decodedCategoryData ??= [];

            // Convert each object to `ServiceCategory` object
            categoryDao.addItems(
                categories.map((e) => ServiceCategory.fromJson(e)).toList());

            await customStatement('PRAGMA foreign_keys = ON');
          }
        },
        onUpgrade: (m, from, to) async {
          switch (from) {
            case 1:
              await m.addColumn(serviceProvider, serviceProvider.business);
              break;
          }
        },
        onCreate: (m) async {
          // Create all tables
          return m.createAll();
        },
      );
}

@UseDao(
  tables: [ServiceProvider],
  queries: {
    "artisanById": "SELECT * FROM service_provider WHERE id = ?",
    "artisans":
        "SELECT * FROM service_provider WHERE category = ? ORDER BY id desc",
    "searchFor":
        "SELECT * FROM service_provider WHERE name LIKE ? OR category LIKE ? ORDER BY id desc",
  },
)
class ProviderDao extends DatabaseAccessor<LocalDatabase>
    with _$ProviderDaoMixin {
  ProviderDao(LocalDatabase db) : super(db);

  void addProviders(List<Artisan> providers) =>
      providers.forEach((person) async => await saveProvider(person));

  Future<int> saveProvider(Artisan artisan) =>
      into(serviceProvider).insert(artisan, mode: InsertMode.insertOrReplace);
}

@UseDao(
  tables: [CategoryItem],
  queries: {
    "categoryById": "SELECT * FROM category_item WHERE id = ?",
    "categoryByGroup": "SELECT * FROM category_item WHERE groupName = ?",
  },
)
class CategoryDao extends DatabaseAccessor<LocalDatabase>
    with _$CategoryDaoMixin {
  CategoryDao(LocalDatabase db) : super(db);

  void addItems(List<ServiceCategory> items) {
    items.forEach((item) async {
      await into(categoryItem).insert(item, mode: InsertMode.insertOrReplace);
    });
  }

  Future<void> addSingleItem(ServiceCategory item) =>
      into(categoryItem).insert(item, mode: InsertMode.insertOrReplace);
}

@UseDao(
  tables: [Bookings],
  queries: {
    "bookingsForCustomer":
        "SELECT * FROM bookings WHERE customer_id = ? ORDER BY created_at DESC",
    "bookingsForCustomerAndProvider":
        "SELECT * FROM bookings WHERE customer_id = ? AND provider_id = ? ORDER BY created_at DESC"
  },
)
class BookingDao extends DatabaseAccessor<LocalDatabase>
    with _$BookingDaoMixin {
  BookingDao(LocalDatabase db) : super(db);

  void addItems(List<Booking> items) {
    items.forEach((item) async {
      await into(bookings).insert(item, mode: InsertMode.insertOrReplace);
    });
  }

  Future<int> addItem(Booking item) =>
      into(bookings).insert(item, mode: InsertMode.insertOrReplace);
}

@UseDao(
  tables: [Review],
  queries: {
    "reviewsForProvider":
        "SELECT * FROM review WHERE customer_id = ? ORDER BY created_at DESC",
    "reviewsForCustomerAndProvider":
        "SELECT * FROM review WHERE customer_id = ? AND provider_id = ? ORDER BY created_at DESC"
  },
)
class ReviewDao extends DatabaseAccessor<LocalDatabase> with _$ReviewDaoMixin {
  ReviewDao(LocalDatabase db) : super(db);

  Future<int> addItem(CustomerReview item) =>
      into(review).insert(item, mode: InsertMode.insertOrReplace);
}

@UseDao(tables: [Message])
class MessageDao extends DatabaseAccessor<LocalDatabase>
    with _$MessageDaoMixin {
  MessageDao(LocalDatabase db) : super(db);

  Future<int> sendMessage(Conversation item) =>
      into(message).insert(item, mode: InsertMode.insertOrReplace);

  void addMessages(List<Conversation> messages) {
    messages.forEach((item) async {
      await sendMessage(item);
    });
  }

  Stream<List<Conversation>> conversationWithRecipient(
          {@required String sender, String recipient}) =>
      (select(message)
            ..where((item) => item.author.equals(sender))
            ..where((item) => item.recipient.equals(recipient))
            ..orderBy(
              [
                (u) => OrderingTerm(
                    expression: u.createdAt, mode: OrderingMode.desc),
              ],
            ))
          .watch();
}

@UseDao(
  tables: [User],
  queries: {
    "customerById": "SELECT * FROM user WHERE id = ?",
  },
)
class CustomerDao extends DatabaseAccessor<LocalDatabase>
    with _$CustomerDaoMixin {
  CustomerDao(LocalDatabase db) : super(db);

  Future<int> addCustomer(Customer item) =>
      into(user).insert(item, mode: InsertMode.insertOrReplace);
}

@UseDao(
  tables: [PhotoGallery],
  queries: {
    "photosForUser":
        "SELECT * FROM photo_gallery WHERE user_id = ? ORDER BY created_at DESC",
  },
)
class GalleryDao extends DatabaseAccessor<LocalDatabase>
    with _$GalleryDaoMixin {
  GalleryDao(LocalDatabase db) : super(db);

  Future<int> addPhoto(Gallery item) =>
      into(photoGallery).insert(item, mode: InsertMode.insertOrReplace);
}
