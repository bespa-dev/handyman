import 'dart:io';
import 'dart:convert';

import 'package:handyman/data/entities/artisan_model.dart';
import 'package:handyman/data/entities/conversation.dart';
import 'package:handyman/data/entities/gallery.dart';
import 'package:handyman/domain/models/user.dart';
import 'package:moor/ffi.dart';
import 'package:moor/moor.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:meta/meta.dart';

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
    CategoryDao,
    BookingDao,
    ReviewDao,
    MessageDao,
    UserDao,
    GalleryDao,
  ],
)
class LocalDatabase extends _$LocalDatabase {
  LocalDatabase._() : super(_openConnection());

  static LocalDatabase get instance => LocalDatabase._();

  @override
  int get schemaVersion => 6;

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
            userDao.addProviders(artisans
                .map((e) => ArtisanModel(artisan: Artisan.fromJson(e)))
                .toList());

            // Decode categories from json array
            final categoryData =
                await rootBundle.loadString("assets/sample_categories.json");
            var decodedCategoryData = json.decode(categoryData);

            List<dynamic> categories = decodedCategoryData ??= [];

            // Convert each object to `ServiceCategory` object
            categoryDao.addItems(
                categories.map((e) => ServiceCategory.fromJson(e)).toList());

            // Decode bookings from json array
            final bookingsData =
                await rootBundle.loadString("assets/sample_bookings.json");
            var decodedBookingsData = json.decode(bookingsData);

            List<dynamic> _bookings = decodedBookingsData ??= [];

            // Save to database
            await bookingDao
                .addItems(_bookings.map((e) => Booking.fromJson(e)).toList());

            await customStatement('PRAGMA foreign_keys = ON');
          }
        },
        onUpgrade: (m, from, to) async {
          switch (from) {
            case 1:
              await m.addColumn(user, user.token);
              await m.addColumn(serviceProvider, serviceProvider.token);
              break;
            case 2:
              await m.addColumn(serviceProvider, serviceProvider.reportsCount);
              break;
            case 3:
              await m.addColumn(bookings, bookings.createdAt);
              await m.addColumn(bookings, bookings.dueDate);
              break;
            case 5:
              await m.addColumn(bookings, bookings.locationLat);
              await m.addColumn(bookings, bookings.locationLng);
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

//
@UseDao(
  tables: [Bookings],
  queries: {
    "bookingsForCustomer":
        "SELECT * FROM bookings WHERE customer_id = ? ORDER BY due_date DESC",
    "bookingsForProvider": "SELECT * FROM bookings ORDER BY due_date DESC",
    "bookingsForCustomerAndProvider":
        "SELECT * FROM bookings WHERE customer_id = ? AND provider_id = ? ORDER BY due_date DESC"
  },
)
class BookingDao extends DatabaseAccessor<LocalDatabase>
    with _$BookingDaoMixin {
  BookingDao(LocalDatabase db) : super(db);

  Future addItems(List<Booking> items) async {
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
        "SELECT * FROM review WHERE provider_id = ? ORDER BY created_at DESC",
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
            ..where((item) => item.author.isSmallerOrEqualValue(sender))
            ..where((item) => item.recipient.isSmallerOrEqualValue(recipient))
            ..orderBy(
              [
                (u) => OrderingTerm(
                    expression: u.createdAt, mode: OrderingMode.desc),
              ],
            ))
          .watch();
}

@UseDao(
  tables: [User, ServiceProvider],
  queries: {
    "customerById": "SELECT * FROM user WHERE id = ?",
    "artisanById": "SELECT * FROM service_provider WHERE id = ?",
    "artisans":
        "SELECT * FROM service_provider WHERE category = ? ORDER BY id desc",
    "searchFor": """SELECT * FROM service_provider
        INNER JOIN user
        ON service_provider.name LIKE ? OR service_provider.category LIKE ? ORDER BY user.id, service_provider.id DESC""",
  },
)
class UserDao extends DatabaseAccessor<LocalDatabase> with _$UserDaoMixin {
  UserDao(LocalDatabase db) : super(db);

  Future<int> addCustomer(BaseUser item) =>
      into(user).insert(item.user, mode: InsertMode.insertOrReplace);

  Future addProviders(List<BaseUser> providers) async =>
      providers.forEach((person) async => await saveProvider(person.user));

  Future<int> saveProvider(BaseUser artisan) => into(serviceProvider)
      .insert(artisan.user, mode: InsertMode.insertOrReplace);
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
