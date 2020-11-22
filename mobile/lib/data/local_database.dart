import 'dart:async' show Future, Stream;
import 'dart:io';

import 'package:async/async.dart' show StreamGroup;
import 'package:handyman/data/entities/artisan_model.dart';
import 'package:handyman/data/entities/conversation.dart';
import 'package:handyman/data/entities/gallery.dart';
import 'package:handyman/domain/models/user.dart';
import 'package:meta/meta.dart';
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

LazyDatabase _openConnection() => LazyDatabase(() async {
      // put the database file, called db.sqlite here, into the documents folder
      // for your app.
      final dbFolder = await getApplicationDocumentsDirectory();
      final file = File(p.join(dbFolder.path, 'db.sqlite'));
      return VmDatabase(file);
    });

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
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onUpgrade: (m, from, to) async {
          switch (from) {
            // case 1:
            //   await m.addColumn(photoGallery, photoGallery.createdAt);
            //   break;
            // case 4:
            //   await m.addColumn(user, user.phone);
            //   break;
            // case 6:
            //   await m.addColumn(bookings, bookings.imageUrl);
            //   break;
            // case 7:
            //   await m.addColumn(serviceProvider, serviceProvider.startPrice);
            //   await m.addColumn(serviceProvider, serviceProvider.endPrice);
            //   break;
            // case 9:
            //   await m.addColumn(bookings, bookings.isAccepted);
            //   break;
            // case 10:
            //   // Destructive migration
            //   // Signs out any logged in user and clears user preferences
            //   await sl.get<AuthService>().signOut();
            //   break;
            //   case 11:
            //   // Destructive migration
            //   // Signs out any logged in user and clears user preferences
            //   await m.addColumn(serviceProvider, serviceProvider.isApproved);
            //   break;
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
    "bookingById": "SELECT * FROM bookings WHERE id = ?",
    "bookingByDueDate":
        "SELECT * FROM bookings WHERE due_date LIKE ? AND provider_id = ? ORDER BY due_date DESC",
    "bookingsForCustomer":
        "SELECT * FROM bookings WHERE customer_id = ? ORDER BY due_date DESC",
    "bookingsForProvider":
        "SELECT * FROM bookings WHERE provider_id = ? ORDER BY due_date DESC",
    "bookingsForCustomerAndProvider":
        "SELECT * FROM bookings WHERE customer_id = ? AND provider_id = ? ORDER BY due_date DESC",
    "removeBooking": "DELETE from bookings WHERE id = ?",
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
    "reviewsByCustomer":
        "SELECT * FROM review WHERE customer_id = ? ORDER BY created_at DESC",
    "reviewsForCustomerAndProvider":
        "SELECT * FROM review WHERE customer_id = ? AND provider_id = ? ORDER BY created_at DESC",
    "deleteReviewById": "DELETE FROM review WHERE id = ? AND customer_id = ?"
  },
)
class ReviewDao extends DatabaseAccessor<LocalDatabase> with _$ReviewDaoMixin {
  ReviewDao(LocalDatabase db) : super(db);

  Future<int> addItem(CustomerReview item) =>
      into(review).insert(item, mode: InsertMode.insertOrReplace);
}

@UseDao(
  tables: [Message],
  queries: {
    "removeMessage": "DELETE FROM message WHERE id = ?",
  },
)
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

  Stream<List<Conversation>> myMessages({@required userId}) => (select(message)
        ..where((item) => item.recipient.equals(userId))
        ..orderBy(
          [
            (u) =>
                OrderingTerm(expression: u.createdAt, mode: OrderingMode.desc),
          ],
        ))
      .watch();

  Stream<List<Conversation>> conversationWithRecipient(
      {@required String sender, @required String recipient}) {
    var streamSender = /*(select(message)
          ..where((item) => item.author.equals(sender))
          ..where((item) => item.recipient.equals(recipient))
          ..orderBy(
            [
              (u) => OrderingTerm(
                  expression: u.createdAt, mode: OrderingMode.desc),
            ],
          ))*/
    select(message)
        .watch();
    var streamRecipient = /*(select(message)
          ..where((item) => item.author.equals(recipient))
          ..where((item) => item.recipient.equals(sender))
          ..orderBy(
            [
              (u) => OrderingTerm(
                  expression: u.createdAt, mode: OrderingMode.desc),
            ],
          ))*/
    select(message)
        .watch();
    return StreamGroup.merge([streamSender, streamRecipient]).asBroadcastStream();
  }
}

@UseDao(
  tables: [User, ServiceProvider],
  queries: {
    "customerById": "SELECT * FROM user WHERE id = ?",
    "artisanById": "SELECT * FROM service_provider WHERE id = ?",
    "artisans":
        "SELECT * FROM service_provider WHERE category = ? AND approved ORDER BY id desc",
    "searchFor":
        "SELECT * FROM service_provider INNER JOIN user ON service_provider.name LIKE ? OR service_provider.category LIKE ? ORDER BY user.id, service_provider.id DESC",
  },
)
class UserDao extends DatabaseAccessor<LocalDatabase> with _$UserDaoMixin {
  UserDao(LocalDatabase db) : super(db);

  Future<int> addCustomer(BaseUser item) =>
      into(user).insert(item.user, mode: InsertMode.insertOrReplace);

  Future addProviders(List<BaseUser> providers) async => providers.forEach(
      (person) async => await saveProvider(ArtisanModel(artisan: person.user)));

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
