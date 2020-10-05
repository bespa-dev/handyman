import 'dart:async';
import 'dart:convert';

import 'package:algolia/algolia.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:handyman/core/service_locator.dart';
import 'package:handyman/core/utils.dart';
import 'package:handyman/data/entities/artisan_model.dart';
import 'package:handyman/data/entities/category.dart';
import 'package:handyman/data/entities/customer_model.dart';
import 'package:handyman/data/local_database.dart';
import 'package:handyman/domain/models/user.dart';
import 'package:handyman/domain/services/data.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

/// API service for application.
/// [LocalDatabase] is the source of data.
/// Data is fetched using streams so that upon update it will
/// automatically notify all listeners.
@immutable
class DataServiceImpl implements DataService {
  final _userDao = sl.get<LocalDatabase>().userDao;
  final _categoryDao = sl.get<LocalDatabase>().categoryDao;
  final _messageDao = sl.get<LocalDatabase>().messageDao;
  final _reviewDao = sl.get<LocalDatabase>().reviewDao;
  final _bookingDao = sl.get<LocalDatabase>().bookingDao;
  final _galleryDao = sl.get<LocalDatabase>().galleryDao;
  final _firestore = sl.get<FirebaseFirestore>();

  // Private constructor
  DataServiceImpl._();

  // Singleton
  static DataService get instance => DataServiceImpl._();

  /// Get all [Artisan]s from data source
  @override
  Stream<List<BaseUser>> getArtisans({@required String category}) async* {
    final localSource = _userDao
        .artisans(category)
        .watch()
        .map((event) => event.map((e) => ArtisanModel(artisan: e)).toList());
    yield* localSource;

    // Get snapshot
    final snapshots = _firestore
        .collection(FirestoreUtils.kArtisanRef)
        .snapshots(includeMetadataChanges: true);

    // Listen for changes in the snapshot
    snapshots.listen((event) {
      event.docs.forEach((element) async {
        if (element.exists) {
          final artisan = Artisan.fromJson(element.data());
          await _userDao.saveProvider(ArtisanModel(artisan: artisan));
        }
      });
    });
  }

  @override
  Stream<BaseUser> getArtisanById({@required String id}) async* {
    final localSource = _userDao
        .artisanById(id)
        .watchSingle()
        .map((artisan) => ArtisanModel(artisan: artisan));
    yield* localSource;

    var snapshots = _firestore
        .collection(FirestoreUtils.kArtisanRef)
        .doc(id)
        .snapshots(includeMetadataChanges: true);
    snapshots.listen((event) async {
      if (event.exists) {
        final artisanModel =
            ArtisanModel(artisan: Artisan.fromJson(event.data()));
        await _userDao.saveProvider(artisanModel);
      }
    });
  }

  @override
  Future<void> sendMessage({@required Conversation conversation}) async {
    await _messageDao.sendMessage(conversation);
    await _firestore
        .collection(FirestoreUtils.kMessagesRef)
        .doc(conversation.id)
        .set(conversation.toJson());
  }

  // FIXME: Messages only return sender's chat'
  @override
  Stream<List<Conversation>> getConversation(
      {@required String sender, @required String recipient}) async* {
    final localSource = _messageDao.conversationWithRecipient(
        sender: sender, recipient: recipient);
    yield* localSource;

    var snapshots = _firestore
        .collection(FirestoreUtils.kMessagesRef)
        .where("sender", isLessThanOrEqualTo: sender)
        .where("recipient", isLessThanOrEqualTo: recipient)
        .snapshots(includeMetadataChanges: true);

    snapshots.listen((event) {
      event.docs.forEach((element) async {
        if (element.exists)
          await _messageDao.sendMessage(Conversation.fromJson(element.data()));
      });
    });
  }

  /// Get [Customer] by [id]
  @override
  Stream<BaseUser> getCustomerById({@required String id}) async* {
    var localSource = _userDao
        .customerById(id)
        .watchSingle()
        .map((customer) => CustomerModel(customer: customer));

    yield* localSource;

    var snapshots = _firestore
        .collection(FirestoreUtils.kCustomerRef)
        .doc(id)
        .snapshots(includeMetadataChanges: true);
    snapshots.listen((event) async {
      if (event.exists)
        await _userDao.addCustomer(
          CustomerModel(
            customer: Customer.fromJson(event.data()),
          ),
        );
    });
  }

  /// Get all [ServiceCategory] from data source
  @override
  Stream<List<ServiceCategory>> getCategories({
    CategoryGroup categoryGroup = CategoryGroup.FEATURED,
  }) async* {
    final localSource =
        _categoryDao.categoryByGroup(categoryGroup.index).watch();
    yield* localSource;

    var snapshots = _firestore
        .collection(FirestoreUtils.kCategoriesRef)
        .where("group_name", isEqualTo: categoryGroup.index)
        .snapshots(includeMetadataChanges: true);

    snapshots.listen((event) {
      event.docs.forEach((element) async {
        if (element.exists)
          await _categoryDao
              .addSingleItem(ServiceCategory.fromJson(element.data()));
      });
    });
  }

  @override
  Stream<List<CustomerReview>> getReviewsForProvider(String id) async* {
    final localSource = _reviewDao.reviewsForProvider(id).watch();
    yield* localSource;

    var snapshots = _firestore
        .collection(FirestoreUtils.kReviewsRef)
        .where("provider_id", isEqualTo: id)
        .snapshots(includeMetadataChanges: true);

    snapshots.listen((event) {
      event.docs.forEach((element) async {
        if (element.exists)
          await _reviewDao.addItem(CustomerReview.fromJson(element.data()));
      });
    });
  }

  @override
  Stream<List<Booking>> getBookingsForProvider(String id) async* {
    // Decode bookings from json array
    final bookingsData =
        await rootBundle.loadString("assets/sample_bookings.json");
    var decodedBookingsData = json.decode(bookingsData);

    List<dynamic> _bookings = decodedBookingsData ??= [];

    // Save to database
    await _bookingDao
        .addItems(_bookings.map((e) => Booking.fromJson(e)).toList());

    final localSource = _bookingDao.bookingsForProvider(id).watch();
    yield* localSource;

    var snapshots = _firestore
        .collection(FirestoreUtils.kBookingsRef)
        .where("provider_id", isEqualTo: id)
        .snapshots(includeMetadataChanges: true);

    snapshots.listen((event) {
      event.docs.forEach((element) async {
        if (element.exists)
          await _bookingDao.addItem(Booking.fromJson(element.data()));
      });
    });
  }

  @override
  Stream<List<Booking>> getBookingsForCustomer(String id) async* {
    final localSource = _bookingDao.bookingsForCustomer(id).watch();
    yield* localSource;

    var snapshots = _firestore
        .collection(FirestoreUtils.kBookingsRef)
        .where("customer_id", isEqualTo: id)
        .snapshots(includeMetadataChanges: true);

    snapshots.listen((event) {
      event.docs.forEach((element) async {
        if (element.exists)
          await _bookingDao.addItem(Booking.fromJson(element.data()));
      });
    });
  }

  @override
  Stream<List<Booking>> bookingsForCustomerAndProvider(
      String customerId, String providerId) async* {
    final localSource = _bookingDao
        .bookingsForCustomerAndProvider(customerId, providerId)
        .watch();
    yield* localSource;

    var snapshots = _firestore
        .collection(FirestoreUtils.kBookingsRef)
        .where("customer_id", isEqualTo: customerId)
        .where("provider_id", isEqualTo: providerId)
        .snapshots(includeMetadataChanges: true);

    snapshots.listen((event) {
      event.docs.forEach((element) async {
        if (element.exists)
          await _bookingDao.addItem(Booking.fromJson(element.data()));
      });
    });
  }

  @override
  Stream<List<Gallery>> getPhotosForUser(String userId) async* {
    final localSource = _galleryDao.photosForUser(userId).watch();
    yield* localSource;

    var snapshots = _firestore
        .collection(FirestoreUtils.kGalleryRef)
        .where("user_id", isEqualTo: userId)
        .snapshots(includeMetadataChanges: true);

    snapshots.listen((event) {
      event.docs.forEach((element) async {
        if (element.exists)
          await _galleryDao.addPhoto(Gallery.fromJson(element.data()));
      });
    });
  }

  /// Save [CustomerReview] in database
  @override
  Future<void> sendReview({String message, String reviewer, artisan}) async {
    final review = CustomerReview(
      id: Uuid().v4(),
      review: message,
      customerId: reviewer,
      providerId: artisan,
      createdAt: DateTime.now(),
    );
    await _reviewDao.addItem(review);
    await _firestore
        .collection(FirestoreUtils.kReviewsRef)
        .doc(review.id)
        .set(review.toJson());
  }

  /// Fetch [ServiceCategory] by [id]
  @override
  Stream<ServiceCategory> getCategoryById({String id}) async* {
    final localSource = _categoryDao.categoryById(id).watchSingle();
    yield* localSource;

    var snapshots = _firestore
        .collection(FirestoreUtils.kCategoriesRef)
        .doc(id)
        .snapshots(includeMetadataChanges: true);

    snapshots.listen((event) async {
      if (event.exists)
        await _galleryDao.addPhoto(Gallery.fromJson(event.data()));
    });
  }

  /// Performs a search for [Artisan]s in [Algolia]
  @override
  Future<List<BaseUser>> searchFor(
      {@required String value, String categoryId}) async {
    try {
      // Perform search with index
      var query =
          algolia.instance.index(AlgoliaUtils.kArtisanIndex).search(value);

      // Get snapshot
      var snapshot = await query.getObjects();

      // Checking if has [AlgoliaQuerySnapshot]
      debugPrint('Hits count: ${snapshot.nbHits}');

      // Return transformed data from API
      return snapshot.empty
          ? _userDao.searchFor(value, categoryId ?? "").get()
          : snapshot.hits
              .map((e) => ArtisanModel(
                    artisan: Artisan.fromJson(e.data),
                  ))
              .toList();
    } on Exception {
      return Future.value(<BaseUser>[]);
    }
  }

  @override
  Future<void> updateUser(BaseUser user, {bool sync = true}) async {
    final token = await sl.get<FirebaseMessaging>().getToken();
    debugPrint("Token => $token");
    if (user.isCustomer) {
      user = CustomerModel(customer: user.user.copyWith(token: token));
      await _userDao.addCustomer(user);
    } else {
      user = ArtisanModel(artisan: user.user.copyWith(token: token));
      await _userDao.saveProvider(user);
    }
    if (sync)
      await sl
          .get<FirebaseFirestore>()
          .collection(
            user.isCustomer
                ? FirestoreUtils.kCustomerRef
                : FirestoreUtils.kArtisanRef,
          )
          .doc(user.user.id)
          .set(user.user.toJson());
  }

  @override
  Stream<Booking> getBookingById({String id}) async* {
    final localSource = _bookingDao.bookingById(id).watchSingle();
    yield* localSource;

    _firestore
        .collection(FirestoreUtils.kBookingsRef)
        .doc(id)
        .snapshots(includeMetadataChanges: true)
        .listen((event) async {
      if (event.exists) {
        final bookingItem = Booking.fromJson(event.data());
        await _bookingDao.addItem(bookingItem);
      }
    });
  }
}
