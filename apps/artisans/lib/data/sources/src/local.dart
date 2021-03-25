/*
 * Copyright (c) 2021.
 * This application is owned by HandyMan LLC,
 * developed & designed by Quabynah Codelabs LLC.
 *
 *
 * author: codelbas.quabynah@gmail.com
 */

import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:handyman/data/entities/entities.dart';
import 'package:handyman/domain/models/models.dart';
import 'package:handyman/domain/repositories/repositories.dart';
import 'package:handyman/domain/sources/sources.dart';
import 'package:handyman/shared/shared.dart';
import 'package:meta/meta.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

/// register local database instance
Future registerLocalDatabase() async => await AppDatabase.instance.database;

/// sembast database setup
///
/// https://medium.com/flutterdevs/sembast-nosql-database-336a523a1567
class AppDatabase {
  // Singleton instance
  static final AppDatabase _singleton = AppDatabase._();

  // Singleton accessor
  static AppDatabase get instance => _singleton;

  // Completer is used for transforming synchronous code into asynchronous code.
  Completer<Database> _dbOpenCompleter;

  // A private constructor. Allows us to create instances of AppDatabase
  // only from within the AppDatabase class itself.
  AppDatabase._();

  // Database object accessor
  Future<Database> get database async {
    // If completer is null, AppDatabaseClass is newly instantiated, so database is not yet opened
    if (_dbOpenCompleter == null) {
      _dbOpenCompleter = Completer();
      // Calling _openDatabase will also complete the completer with database instance
      await _openDatabase();
    }
    // If the database is already opened, awaiting the future will happen instantly.
    // Otherwise, awaiting the returned future will take some time - until complete() is called
    // on the Completer in _openDatabase() below.
    return _dbOpenCompleter.future;
  }

  Future _openDatabase() async {
    // Get a platform-specific directory where persistent app data can be stored
    final appDocumentDir = await getApplicationDocumentsDirectory();
    // Path with the form: /platform-specific-directory/demo.db
    final dbPath = join(appDocumentDir.path, 'private-school-project.db');

    final database = await databaseFactoryIo.openDatabase(dbPath);

    // Any code awaiting the Completer's future will now start executing
    _dbOpenCompleter?.complete(database);
  }
}

/// local datasource implementation
///
/// https://pub.dev/packages/sembast
class SemBastLocalDatasource extends BaseLocalDatasource {
  SemBastLocalDatasource({
    @required this.prefsRepo,
    @required this.db,
    @required this.categoryStore,
    @required this.bookingStore,
    @required this.reviewStore,
    @required this.galleryStore,
    @required this.customerStore,
    @required this.conversationStore,
    @required this.businessStore,
    @required this.artisanStore,
    @required this.serviceStore,
  }) {
    _performInitLoad();
  }

  final BasePreferenceRepository prefsRepo;
  final Database db;
  final StoreRef<String, Map<String, Object>> categoryStore;
  final StoreRef<String, Map<String, Object>> bookingStore;
  final StoreRef<String, Map<String, Object>> conversationStore;
  final StoreRef<String, Map<String, Object>> galleryStore;
  final StoreRef<String, Map<String, Object>> reviewStore;
  final StoreRef<String, Map<String, Object>> artisanStore;
  final StoreRef<String, Map<String, Object>> customerStore;
  final StoreRef<String, Map<String, Object>> businessStore;
  final StoreRef<String, Map<String, Object>> serviceStore;

  void _performInitLoad() async {
    if (prefsRepo.isLoggedIn) return;

    /// decode categories from json
    var categorySource = await rootBundle.loadString('assets/categories.json');
    var decodedCategories = jsonDecode(categorySource) as List;
    for (var json in decodedCategories) {
      final item = ServiceCategory.fromJson(json);

      /// put each one into box
      await categoryStore.record(item.id).put(
            db,
            item.toJson(),
            merge: true,
          );
    }

    /// decode services from json
    var serviceSource = await rootBundle.loadString('assets/services.json');
    var decodedServices = jsonDecode(serviceSource) as List;
    for (var json in decodedServices) {
      final item = ArtisanService.fromJson(json);

      /// put each one into box
      await serviceStore.record(item.id).put(db, item.toJson());
    }

    // var keys = await serviceStore.findKeys(
    //   db,
    //   finder: Finder(
    //     filter:
    //         Filter.matches('category', '8ecf642d-429f-4b51-805b-0678a9af8e28') |
    //             Filter.matches('artisan_id', 'k4wot1FK22aaaHL9qXlBgdIT2h13'),
    //   ),
    // );
    // var services = await serviceStore
    //     .records(keys)
    //     .get(db);
    // logger.i('service => $services');
  }

  /// region reviews
  @override
  Future<void> deleteReviewById({@required String id}) async {
    await reviewStore.delete(db, finder: Finder(filter: Filter.byKey(id)));
  }

  @override
  Stream<List<BaseReview>> observeReviewsByCustomer(String id) async* {
    var keys = await reviewStore.findKeys(
      db,
      finder: Finder(
        filter: Filter.matches('customer_id', id),
      ),
    );
    var list = await reviewStore.records(keys).get(db);
    yield list.map((json) => Review.fromJson(json)).toList();
  }

  @override
  Stream<List<BaseReview>> observeReviewsForArtisan(String id) async* {
    var keys = await reviewStore.findKeys(
      db,
      finder: Finder(
        filter: Filter.matches('artisan_id', id),
      ),
    );
    var list = await reviewStore.records(keys).get(db);
    yield list.map((json) => Review.fromJson(json)).toList();
  }

  @override
  Future<void> requestBooking({@required BaseBooking booking}) async =>
      bookingStore.record(booking.id).put(
            db,
            booking.toJson(),
            merge: true,
          );

  @override
  Future<void> sendReview({@required BaseReview review}) async =>
      reviewStore.record(review.id).put(
            db,
            review.toJson(),
            merge: true,
          );

  @override
  Future<void> updateReview({@required BaseReview review}) async =>
      reviewStore.record(review.id).put(
            db,
            review.toJson(),
            merge: true,
          );

  /// endregion

  /// region users
  @override
  Future<void> updateUser(BaseUser user) async {
    logger.i('updating (${user.runtimeType}) -> $user');
    return user is BaseArtisan
        ? artisanStore.record(user.id).put(
              db,
              user.toJson(),
              merge: true,
            )
        : customerStore.record(user.id).put(
              db,
              user.toJson(),
              merge: true,
            );
  }

  @override
  Future<BaseUser> getCustomerById({@required String id}) async {
    var map = await customerStore.record(id).get(db);
    return map == null ? null : Customer.fromJson(map);
  }

  @override
  Stream<BaseArtisan> currentUser() async* {
    yield* artisanStore
        .query(finder: Finder(filter: Filter.byKey(prefsRepo.userId)))
        .onSnapshot(db)
        .transform(_artisanTransformer);
  }

  @override
  Future<BaseArtisan> getArtisanById({@required String id}) async {
    var snapshot = await artisanStore.record(id).getSnapshot(db);
    return snapshot == null ? null : Artisan.fromJson(snapshot.value);
  }

  @override
  Stream<BaseArtisan> observeArtisanById({@required String id}) async* {
    yield* artisanStore
        .query(finder: Finder(filter: Filter.byKey(id)))
        .onSnapshot(db)
        .transform(_artisanTransformer);
  }

  @override
  Stream<List<BaseArtisan>> observeArtisans(
      {@required String category}) async* {
    yield* artisanStore
        .query(
          finder: Finder(
              filter: Filter.equals('category', category) &
                  Filter.equals('approved', true),
              sortOrders: [SortOrder('id')]),
        )
        .onSnapshots(db)
        .transform(_artisanListTransformer);
  }

  @override
  Stream<BaseUser> observeCustomerById({@required String id}) async* {
    yield* customerStore
        .query(finder: Finder(filter: Filter.byKey(id)))
        .onSnapshot(db)
        .transform(_customerTransformer);
  }

  @override
  Future<List<BaseUser>> searchFor(
      {@required String query, @required String categoryId}) async {
    var keys = await customerStore.findKeys(
      db,
      finder: Finder(
        filter: Filter.or(
          [
            Filter.matches('name', query),
            Filter.matches('email', query),
            Filter.matches('phone', query),
          ],
        ),
      ),
    );
    var list = await customerStore.records(keys).get(db);
    return list.map((json) => Customer.fromJson(json)).toList();
  }

  /// endregion

  /// region businesses
  @override
  Stream<BaseBusiness> observeBusinessById({@required String id}) async* {
    yield* businessStore
        .record(id)
        .onSnapshot(db)
        .map((event) => Business.fromJson(event.value));
  }

  @override
  Future<BaseBusiness> getBusinessById({@required String id}) async {
    var json = await businessStore.record(id).get(db);
    return Business.fromJson(json);
  }

  @override
  Future<List<BaseBusiness>> getBusinessesForArtisan(
      {@required String artisan}) async {
    var keys = await businessStore.findKeys(
      db,
      finder: Finder(
        filter: Filter.matches('artisan_id', artisan),
      ),
    );
    var list = await businessStore.records(keys).get(db);
    return list.map((json) => Business.fromJson(json)).toList();
  }

  @override
  Future<void> updateBusiness({@required BaseBusiness business}) async =>
      await businessStore.record(business.id).put(
            db,
            business.toJson(),
            merge: true,
          );

  /// endregion

  /// region categories
  @override
  Stream<List<BaseServiceCategory>> observeCategories(
      {@required ServiceCategoryGroup categoryGroup}) async* {
    var keys = await categoryStore.findKeys(
      db,
      finder: Finder(
        filter: Filter.matches(
          'group_name',
          categoryGroup.name(),
        ),
      ),
    );
    var list = await categoryStore.records(keys).get(db);
    yield list.map((json) => ServiceCategory.fromJson(json)).toList();
  }

  @override
  Stream<BaseServiceCategory> observeCategoryById(
      {@required String id}) async* {
    yield* serviceStore
        .record(id)
        .onSnapshot(db)
        .map((event) => ServiceCategory.fromJson(event.value));
  }

  @override
  Future<void> updateCategory({@required BaseServiceCategory category}) async =>
      await categoryStore.update(db, category.toJson(),
          finder: Finder(filter: Filter.byKey(category.id)));

  /// endregion

  /// region services
  @override
  Future<void> updateArtisanService(
      {@required String id,
      @required BaseArtisanService artisanService}) async {
    if (artisanService == null) return;
    logger.d('updating -> $artisanService');
    return serviceStore.record(artisanService.id).put(
          db,
          artisanService.toJson(),
          merge: true,
        );
  }

  @override
  Future<BaseArtisanService> getArtisanServiceById(
      {@required String id}) async {
    var json = await serviceStore.record(id).get(db);
    return ArtisanService.fromJson(json);
  }

  @override
  Future<List<BaseArtisanService>> getArtisanServicesByCategory(
      {@required String categoryId}) async {
    var keys = await serviceStore.findKeys(
      db,
      finder: Finder(
        filter: Filter.matches('category', categoryId),
        sortOrders: [
          SortOrder('id'),
          SortOrder('category'),
        ],
      ),
    );
    var list = await serviceStore.records(keys).get(db);
    logger.i('services by category($categoryId) -> $list');
    return list.map((json) => ArtisanService.fromJson(json)).toList();
  }

  @override
  Future<List<BaseArtisanService>> getArtisanServices(
      {@required String id}) async {
    var keys = await serviceStore.findKeys(
      db,
      finder: Finder(
          // filter: Filter.matches('artisan_id', id),
          sortOrders: [SortOrder('id')]),
    );

    var list = await serviceStore.records(keys).get(db);
    return list.map((json) => ArtisanService.fromJson(json)).toList();
  }

  @override
  Future<void> resetAllPrices() async {
    await db.transaction((transaction) async {
      /// get all services
      var keys = await serviceStore.findKeys(db, finder: Finder(limit: 100));
      var services = (await serviceStore.records(keys).get(db))
          .map((e) => ArtisanService.fromJson(e))
          .toList();

      /// perform transaction
      services.forEach((element) async {
        var issues = <BaseServiceIssue>[];
        element.issues?.forEach((element) {
          issues.add(element.copyWith(price: 0.00));
        });
        await serviceStore.record(element.id).put(
              db,
              element.copyWith().toJson(),
              merge: true,
            );
      });
    });
  }

  /// endregion

  /// region conversations
  @override
  Stream<List<BaseConversation>> observeConversation(
      {@required String sender, @required String recipient}) async* {
    yield* conversationStore
        .query(
            finder: Finder(
                filter: Filter.and([
                      Filter.matches('author', sender),
                      Filter.matches('recipient', recipient),
                    ]) |
                    Filter.and([
                      Filter.matches('author', recipient),
                      Filter.matches('recipient', sender),
                    ]),
                sortOrders: [SortOrder('created_at', false)]))
        .onSnapshots(db)
        .transform(_conversationsListTransformer);
  }

  @override
  Future<void> sendMessage({@required BaseConversation conversation}) async =>
      conversationStore.record(conversation.id).put(
            db,
            conversation.toJson(),
            merge: true,
          );

  /// endregion

  /// region galleries
  @override
  Stream<List<BaseGallery>> getPhotosForArtisan(
      {@required String userId}) async* {
    var keys = await galleryStore.findKeys(
      db,
      finder: Finder(
        filter: Filter.matches('user_id', userId),
      ),
    );
    var list = await galleryStore.records(keys).get(db);
    yield list.map((json) => Gallery.fromJson(json)).toList();
  }

  @override
  Future<void> updateGallery({@required BaseGallery gallery}) async =>
      galleryStore.record(gallery.id).put(
            db,
            gallery.toJson(),
            merge: true,
          );

  @override
  Future<void> uploadBusinessPhotos(
      {@required List<BaseGallery> galleryItems}) async {
    await db.transaction((_) async {
      for (var value in galleryItems) {
        await galleryStore.record(value.id).put(
              db,
              value.toJson(),
              merge: true,
            );
      }
    });
  }

  /// endregion

  /// region bookings
  @override
  Stream<List<BaseBooking>> bookingsForCustomerAndArtisan(
      String customerId, String artisanId) async* {
    yield* bookingStore
        .query(
          finder: Finder(
            filter: Filter.matches('customer_id', customerId) &
                Filter.matches('artisan_id', artisanId),
            sortOrders: [SortOrder('id')],
          ),
        )
        .onSnapshots(db)
        .transform(_bookingsListTransformer);
  }

  @override
  Future<void> deleteBooking({@required BaseBooking booking}) async {
    await bookingStore.delete(db,
        finder: Finder(filter: Filter.byKey(booking.id)));
  }

  @override
  Stream<BaseBooking> getBookingById({@required String id}) async* {
    yield* bookingStore
        .record(id)
        .onSnapshot(db)
        .map((event) => Booking.fromJson(event.value));
  }

  @override
  Stream<List<BaseBooking>> getBookingsByDueDate(
      {@required String dueDate, @required String artisanId}) async* {
    yield* bookingStore
        .query(
          finder: Finder(
            filter: Filter.matches('due_date', dueDate) &
                Filter.matches('artisan_id', artisanId),
            sortOrders: [SortOrder('id')],
          ),
        )
        .onSnapshots(db)
        .transform(_bookingsListTransformer);
  }

  @override
  Stream<List<BaseBooking>> observeBookingsForArtisan(String id) async* {
    yield* bookingStore
        .query(
          finder: Finder(
            filter: Filter.matches('artisan_id', id),
          ),
        )
        .onSnapshots(db)
        .transform(_bookingsListTransformer);
  }

  @override
  Stream<List<BaseBooking>> observeBookingsForCustomer(String id) async* {
    yield* bookingStore
        .query(
          finder: Finder(
            filter: Filter.matches('customer_id', id),
          ),
        )
        .onSnapshots(db)
        .transform(_bookingsListTransformer);
  }

  @override
  Future<void> updateBooking({@required BaseBooking booking}) async =>
      bookingStore.record(booking.id).put(
            db,
            booking.toJson(),
            merge: true,
          );

  /// endregion

  /// region transformers
  final _artisanListTransformer = StreamTransformer<
      List<RecordSnapshot<String, Map<String, Object>>>,
      List<BaseArtisan>>.fromHandlers(handleData: (snapshotList, sink) {
    sink.add(snapshotList.map((e) => Artisan.fromJson(e.value)).toList());
  });

  final _artisanTransformer = StreamTransformer<
      RecordSnapshot<String, Map<String, Object>>,
      BaseArtisan>.fromHandlers(handleData: (snapshot, sink) {
    sink.add(snapshot == null ? null : Artisan.fromJson(snapshot.value));
  });

  final _customerListTransformer = StreamTransformer<
      List<RecordSnapshot<String, Map<String, Object>>>,
      List<BaseUser>>.fromHandlers(handleData: (snapshotList, sink) {
    sink.add(snapshotList.map((e) => Customer.fromJson(e.value)).toList());
  });

  final _customerTransformer = StreamTransformer<
      RecordSnapshot<String, Map<String, Object>>,
      BaseUser>.fromHandlers(handleData: (snapshot, sink) {
    sink.add(snapshot == null ? null : Customer.fromJson(snapshot.value));
  });

  final _conversationsListTransformer = StreamTransformer<
      List<RecordSnapshot<String, Map<String, Object>>>,
      List<BaseConversation>>.fromHandlers(handleData: (snapshotList, sink) {
    sink.add(snapshotList.map((e) => Conversation.fromJson(e.value)).toList());
  });

  final _bookingsListTransformer = StreamTransformer<
      List<RecordSnapshot<String, Map<String, Object>>>,
      List<BaseBooking>>.fromHandlers(handleData: (snapshotList, sink) {
    sink.add(snapshotList.map((e) => Booking.fromJson(e.value)).toList());
  });

  /// endregion

}
