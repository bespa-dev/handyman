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
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:meta/meta.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

/// Read more -> https://docs.hivedb.dev/
Future registerLocalDatabase([bool useHive = true]) async {
  if (useHive) {
    /// initialize hive
    await Hive.initFlutter();

    /// register adapters
    Hive
      ..registerAdapter(BookingAdapter())
      ..registerAdapter(ServiceCategoryAdapter())
      ..registerAdapter(ConversationAdapter())
      ..registerAdapter(GalleryAdapter())
      ..registerAdapter(ReviewAdapter())
      ..registerAdapter(ArtisanAdapter())
      ..registerAdapter(CustomerAdapter())
      ..registerAdapter(BusinessAdapter())
      ..registerAdapter(LocationMetadataAdapter())
      ..registerAdapter(ArtisanServiceAdapter());

    /// open boxes
    await Hive.openBox<Booking>(RefUtils.kBookingRef);
    await Hive.openBox<ServiceCategory>(RefUtils.kCategoryRef);
    await Hive.openBox<Conversation>(RefUtils.kConversationRef);
    await Hive.openBox<Gallery>(RefUtils.kGalleryRef);
    await Hive.openBox<Review>(RefUtils.kReviewRef);
    await Hive.openBox<Artisan>(RefUtils.kArtisanRef);
    await Hive.openBox<Customer>(RefUtils.kCustomerRef);
    await Hive.openBox<Business>(RefUtils.kBusinessRef);
    await Hive.openBox<ArtisanService>(RefUtils.kServiceRef);
  } else {
    await AppDatabase.instance.database;
  }
}

class HiveLocalDatasource extends BaseLocalDatasource {
  HiveLocalDatasource({
    @required this.prefsRepo,
    @required this.bookingBox,
    @required this.customerBox,
    @required this.artisanBox,
    @required this.reviewBox,
    @required this.galleryBox,
    @required this.conversationBox,
    @required this.categoryBox,
    @required this.businessBox,
    @required this.serviceBox,
  }) {
    /// load initial data from assets
    _performInitLoad();
  }

  final BasePreferenceRepository prefsRepo;
  final Box<Booking> bookingBox;
  final Box<Customer> customerBox;
  final Box<Artisan> artisanBox;
  final Box<Review> reviewBox;
  final Box<Gallery> galleryBox;
  final Box<Conversation> conversationBox;
  final Box<ServiceCategory> categoryBox;
  final Box<Business> businessBox;
  final Box<ArtisanService> serviceBox;

  void _performInitLoad() async {
    if (prefsRepo.isLoggedIn) return;

    /// decode categories from json
    var categorySource = await rootBundle.loadString('assets/categories.json');
    var decodedCategories = jsonDecode(categorySource) as List;
    for (var json in decodedCategories) {
      final item = ServiceCategory.fromJson(json);

      /// put each one into box
      await categoryBox.put(item.id, item);
    }

    /// decode services from json
    var serviceSource = await rootBundle.loadString('assets/services.json');
    var decodedServices = jsonDecode(serviceSource) as List;
    for (var json in decodedServices) {
      final item = ArtisanService.fromJson(json);

      /// put each one into box
      await serviceBox.put(item.id, item);
    }
  }

  @override
  Stream<List<BaseBooking>> bookingsForCustomerAndArtisan(
      String customerId, String artisanId) async* {
    yield bookingBox.values
        .where((item) => item.artisanId == artisanId)
        .where((item) => item.customerId == customerId)
        .toList();
    notifyListeners();
  }

  @override
  Future<void> deleteBooking({BaseBooking booking}) async {
    await bookingBox.delete(booking.id);
    notifyListeners();
  }

  @override
  Future<void> deleteReviewById({String id}) async {
    await reviewBox.delete(id);
    notifyListeners();
  }

  @override
  Future<BaseArtisan> getArtisanById({String id}) async => artisanBox.get(id);

  @override
  Stream<BaseBooking> getBookingById({String id}) async* {
    yield bookingBox.get(id);
  }

  @override
  Stream<List<BaseBooking>> getBookingsByDueDate(
      {String dueDate, String artisanId}) async* {
    yield bookingBox.values
        .where((item) => compareTime(item.dueDate, dueDate) <= 0)
        .where((item) => item.artisanId == artisanId)
        .toList();
  }

  @override
  Future<BaseUser> getCustomerById({String id}) async => customerBox.get(id);

  @override
  Stream<List<BaseGallery>> getPhotosForArtisan({String userId}) async* {
    yield galleryBox.values.where((item) => item.userId == userId).toList();
  }

  @override
  Stream<BaseArtisan> observeArtisanById({String id}) async* {
    yield artisanBox.get(id);
  }

  @override
  Stream<List<BaseArtisan>> observeArtisans(
      {@required String category}) async* {
    yield artisanBox.values
        .where((item) => item.category == category)
        .where((item) => item.isAvailable)
        .where((item) => item.isApproved)
        .where((item) => item.id != prefsRepo.userId)
        .toList();
  }

  @override
  Stream<BaseArtisan> currentUser() async* {
    var artisan = artisanBox.get(prefsRepo.userId);
    yield artisan;
    notifyListeners();
  }

  @override
  Stream<List<BaseBooking>> observeBookingsForArtisan(String id) async* {
    yield bookingBox.values.where((item) => item.artisanId == id).toList();
  }

  @override
  Stream<List<BaseBooking>> observeBookingsForCustomer(String id) async* {
    yield bookingBox.values.where((item) => item.customerId == id).toList();
  }

  @override
  Stream<List<BaseServiceCategory>> observeCategories(
      {ServiceCategoryGroup categoryGroup}) async* {
    yield categoryBox.values
        .where((item) => item.groupName.contains(categoryGroup.name()))
        .toList();
  }

  @override
  Stream<BaseServiceCategory> observeCategoryById({String id}) async* {
    yield categoryBox.get(id);
  }

  @override
  Stream<List<BaseConversation>> observeConversation(
      {String sender, String recipient}) async* {
    logger.d(conversationBox.values.toList());

    yield conversationBox.values
        .where((item) =>
            (item.author == sender || item.author == recipient) &&
            (item.recipient == sender || item.recipient == recipient))
        .sortByDescending<String>((r) => r.createdAt)
        .toList();
  }

  @override
  Stream<BaseUser> observeCustomerById({String id}) async* {
    yield customerBox.get(id);
  }

  @override
  Stream<List<BaseReview>> observeReviewsByCustomer(String id) async* {
    yield reviewBox.values.where((item) => item.customerId == id).toList();
  }

  @override
  Stream<List<BaseReview>> observeReviewsForArtisan(String id) async* {
    yield reviewBox.values.where((item) => item.artisanId == id).toList();
  }

  @override
  Future<void> requestBooking({@required BaseBooking booking}) async {
    await bookingBox.put(booking.id, booking);
    notifyListeners();
  }

  @override
  Future<List<BaseUser>> searchFor({String query, String categoryId}) async {
    return artisanBox.values
        .where((item) =>
            item != null &&
                item.isAvailable &&
                item.isApproved &&
                item.email.contains(query) ||
            item.category.contains(query) ||
            (item.services != null && item.services.contains(query)) ||
            (item.reports != null && item.reports.contains(query)) ||
            item.name.contains(query))
        .sortByDescending<String>((r) => r.rating.toString())
        .toList();
  }

  @override
  Future<void> sendMessage({@required BaseConversation conversation}) async =>
      await conversationBox.put(conversation.id, conversation);

  @override
  Future<void> sendReview({@required BaseReview review}) async =>
      await reviewBox.put(review.id, review);

  @override
  Future<void> updateBooking({@required BaseBooking booking}) async =>
      await bookingBox.put(booking.id, booking);

  @override
  Future<void> updateCategory({BaseServiceCategory category}) async =>
      await categoryBox.put(category.id, category);

  @override
  Future<void> updateGallery({BaseGallery gallery}) async =>
      await galleryBox.put(gallery.id, gallery);

  @override
  Future<void> updateReview({BaseReview review}) async =>
      await reviewBox.put(review.id, review);

  @override
  Future<void> updateUser(BaseUser user) async {
    if (user is BaseArtisan) {
      await artisanBox.put(user.id, user);
    } else if (user is BaseUser) await customerBox.put(user.id, user);
    notifyListeners();
  }

  @override
  Future<void> uploadBusinessPhotos(
      {@required List<BaseGallery> galleryItems}) async {
    for (var value in galleryItems) {
      await galleryBox.put(value.id, value);
    }
  }

  @override
  Future<List<BaseBusiness>> getBusinessesForArtisan(
          {@required String artisan}) async =>
      businessBox.values.where((item) => item.artisanId == artisan).toList();

  @override
  Future<void> updateBusiness({@required BaseBusiness business}) async =>
      await businessBox.put(business.id, business);

  @override
  Future<BaseBusiness> getBusinessById({@required String id}) async =>
      businessBox.get(id);

  @override
  Stream<BaseBusiness> observeBusinessById({@required String id}) async* {
    yield businessBox.get(id);
  }

  @override
  Future<List<BaseArtisanService>> getArtisanServices(
      {@required String id}) async {
    var services = <BaseArtisanService>[];
    if (id == null) {
      services = serviceBox.values.toList();
    } else {
      var artisan = await getArtisanById(id: id);

      if (artisan?.services != null && artisan.services.isNotEmpty) {
        artisan.services.forEach((serviceId) async {
          var service = await serviceBox.get(serviceId);
          if (service != null) services.add(service);
        });
      }
    }
    return services;
  }

  @override
  Future<void> updateArtisanService(
          {@required String id,
          @required BaseArtisanService artisanService}) async =>
      await serviceBox.put(artisanService.id, artisanService);
}

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
      await serviceStore.record(item.id).put(
            db,
            item.toJson(),
            merge: true,
          );
    }
  }

  @override
  Stream<List<BaseBooking>> bookingsForCustomerAndArtisan(
      String customerId, String artisanId) async* {
    var bookings = await bookingStore.find(db,
        finder: Finder(
            filter: Filter.matches('customer_id', customerId) &
                Filter.matches('artisan_id', artisanId),
            sortOrders: [SortOrder('id')]));
    var keys = <String>[];
    for (var value in bookings) {
      keys.add(value.key);
    }
    yield (await bookingStore.records(keys).getSnapshots(db))
        .map((e) => Booking.fromJson(e.value))
        .toList();
  }

  @override
  Stream<BaseArtisan> currentUser() async* {
    if (!prefsRepo.isLoggedIn) return;

    yield* artisanStore
        .record(prefsRepo.userId)
        .onSnapshot(db)
        .map((event) => Artisan.fromJson(event.value));
  }

  @override
  Future<void> deleteBooking({@required BaseBooking booking}) async {
    await bookingStore.delete(db,
        finder: Finder(filter: Filter.byKey(booking.id)));
  }

  @override
  Future<void> deleteReviewById({@required String id}) async {
    await reviewStore.delete(db, finder: Finder(filter: Filter.byKey(id)));
  }

  @override
  Future<BaseArtisan> getArtisanById({@required String id}) async {
    var snapshot = await artisanStore.record(id).getSnapshot(db);
    return snapshot == null ? null : Artisan.fromJson(snapshot.value);
  }

  @override
  Future<List<BaseArtisanService>> getArtisanServices(
      {@required String id}) async {
    // todo -> get artisan services
    return (await serviceStore.find(
      db,
      finder: Finder(
        // filter: Filter.matches('id', id),
        sortOrders: [SortOrder('id')],
      ),
    ))
        .map((e) => ArtisanService.fromJson(e.value))
        .toList();
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
    yield (await bookingStore.find(
      db,
      finder: Finder(
        filter: Filter.matches('due_date', dueDate) &
            Filter.matches('artisan_id', artisanId),
        sortOrders: [SortOrder('id')],
      ),
    ))
        .map((e) => Booking.fromJson(e.value))
        .toList();
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
  Future<BaseUser> getCustomerById({@required String id}) async {
    var map = await customerStore.record(id).get(db);
    return Customer.fromJson(map);
  }

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
  Stream<BaseArtisan> observeArtisanById({@required String id}) async* {
    yield* artisanStore
        .record(id)
        .onSnapshot(db)
        .map((event) => Artisan.fromJson(event.value));
  }

  @override
  Stream<List<BaseArtisan>> observeArtisans({String category}) async* {
    var keys = await artisanStore.findKeys(
      db,
      finder: Finder(
        filter: Filter.matches('category', category),
      ),
    );
    var list = await artisanStore.records(keys).get(db);
    yield list.map((json) => Artisan.fromJson(json)).toList();
  }

  @override
  Stream<List<BaseBooking>> observeBookingsForArtisan(String id) async* {
    var keys = await bookingStore.findKeys(
      db,
      finder: Finder(
        filter: Filter.matches('artisan_id', id),
      ),
    );

    var list = await bookingStore.records(keys).get(db);
    yield list.map((json) => Booking.fromJson(json)).toList();
  }

  @override
  Stream<List<BaseBooking>> observeBookingsForCustomer(String id) async* {
    var keys = await bookingStore.findKeys(
      db,
      finder: Finder(
        filter: Filter.matches('customer_id', id),
      ),
    );
    var list = await bookingStore.records(keys).get(db);
    yield list.map((json) => Booking.fromJson(json)).toList();
  }

  @override
  Stream<BaseBusiness> observeBusinessById({@required String id}) async* {
    yield* businessStore
        .record(id)
        .onSnapshot(db)
        .map((event) => Business.fromJson(event.value));
  }

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
  Stream<List<BaseConversation>> observeConversation(
      {@required String sender, @required String recipient}) async* {
    var keys = await conversationStore.findKeys(
      db,
      finder: Finder(
        filter: Filter.and([
              Filter.matches('author', sender),
              Filter.matches('recipient', recipient),
            ]) |
            Filter.and([
              Filter.matches('author', recipient),
              Filter.matches('recipient', sender),
            ]),
      ),
    );
    var list = await conversationStore.records(keys).get(db);
    yield list.map((json) => Conversation.fromJson(json)).toList();
  }

  @override
  Stream<BaseUser> observeCustomerById({@required String id}) async* {
    yield* customerStore
        .record(id)
        .onSnapshot(db)
        .map((event) => Customer.fromJson(event.value));
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

  @override
  Future<void> sendMessage({@required BaseConversation conversation}) async =>
      conversationStore.record(conversation.id).put(
            db,
            conversation.toJson(),
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
  Future<void> updateArtisanService(
          {@required String id,
          @required BaseArtisanService artisanService}) async =>
      serviceStore.record(id).put(
            db,
            artisanService.toJson(),
            merge: true,
          );

  @override
  Future<void> updateBooking({@required BaseBooking booking}) async =>
      bookingStore.record(booking.id).put(
            db,
            booking.toJson(),
            merge: true,
          );

  @override
  Future<void> updateBusiness({@required BaseBusiness business}) async =>
      await businessStore.record(business.id).put(
            db,
            business.toJson(),
            merge: true,
          );

  @override
  Future<void> updateCategory({@required BaseServiceCategory category}) async =>
      await categoryStore.update(db, category.toJson(),
          finder: Finder(filter: Filter.byKey(category.id)));

  @override
  Future<void> updateGallery({@required BaseGallery gallery}) async =>
      galleryStore.record(gallery.id).put(
            db,
            gallery.toJson(),
            merge: true,
          );

  @override
  Future<void> updateReview({@required BaseReview review}) async =>
      reviewStore.record(review.id).put(
            db,
            review.toJson(),
            merge: true,
          );

  @override
  Future<void> updateUser(BaseArtisan user) async =>
      artisanStore.record(user.id).put(
            db,
            user.toJson(),
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
}

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
