import 'dart:async';

import 'package:algolia/algolia.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:handyman/core/service_locator.dart';
import 'package:handyman/core/utils.dart';
import 'package:handyman/data/entities/artisan_model.dart';
import 'package:handyman/data/entities/category.dart';
import 'package:handyman/data/entities/customer_model.dart';
import 'package:handyman/data/local_database.dart';
import 'package:handyman/domain/models/user.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

/// API service for application.
/// [LocalDatabase] is the source of data.
/// Data is fetched using streams so that upon update it will
/// automatically notify all listeners.
class ApiProviderService {
  final _userDao = sl.get<LocalDatabase>().userDao;
  final _categoryDao = sl.get<LocalDatabase>().categoryDao;
  final _messageDao = sl.get<LocalDatabase>().messageDao;
  final _reviewDao = sl.get<LocalDatabase>().reviewDao;
  final _bookingDao = sl.get<LocalDatabase>().bookingDao;
  final _galleryDao = sl.get<LocalDatabase>().galleryDao;
  final _firestore = sl.get<FirebaseFirestore>();

  // Private constructor
  ApiProviderService._();

  // Singleton
  static ApiProviderService get instance => ApiProviderService._();

  /// Get all [Artisan]s from data source
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
        final artisan = Artisan.fromJson(element.data());
        await _userDao.saveProvider(ArtisanModel(artisan: artisan));
      });
    });
    // await _providerDao.addProviders(results);
  }

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
      final artisanModel =
          ArtisanModel(artisan: Artisan.fromJson(event.data()));
      await _userDao.saveProvider(artisanModel);
    });
  }

  Future<void> sendMessage({@required Conversation conversation}) async {
    await _messageDao.sendMessage(conversation);
    await _firestore
        .collection(FirestoreUtils.kMessagesRef)
        .doc(conversation.id)
        .set(conversation.toJson());
  }

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
        await _messageDao.sendMessage(Conversation.fromJson(element.data()));
      });
    });
  }

  /// Get [Customer] by [id]
  Stream<BaseUser> getCustomerById({@required String id}) => _userDao
      .customerById(id)
      .watchSingle()
      .map((customer) => CustomerModel(customer: customer));

  /// Get all [ServiceCategory] from data source
  Stream<List<ServiceCategory>> getCategories({
    CategoryGroup categoryGroup = CategoryGroup.FEATURED,
  }) =>
      _categoryDao.categoryByGroup(categoryGroup.index).watch();

  Stream<List<CustomerReview>> getReviews(String id) =>
      _reviewDao.reviewsForProvider(id).watch();

  Stream<List<Booking>> getMyBookings(String id) =>
      _bookingDao.bookingsForCustomer(id).watch();

  Stream<List<Booking>> getBookingsForProvider(String id) =>
      _bookingDao.bookingsForProvider(id).watch();

  Stream<List<Booking>> getBookingsForCustomer(String id) =>
      _bookingDao.bookingsForCustomer(id).watch();

  Stream<List<Booking>> bookingsForCustomerAndProvider(
          String customerId, String providerId) =>
      _bookingDao
          .bookingsForCustomerAndProvider(customerId, providerId)
          .watch();

  Stream<List<Gallery>> getPhotosForUser(String userId) =>
      _galleryDao.photosForUser(userId).watch();

  /// Performs a search for [Artisan]s in [Algolia]
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

  /// Save [CustomerReview] in database
  Future<void> sendReview({String message, String reviewer, artisan}) =>
      _reviewDao.addItem(
        CustomerReview(
          id: Uuid().v4(),
          review: message,
          customerId: reviewer,
          providerId: artisan,
          createdAt: DateTime.now(),
        ),
      );

  /// Fetch [ServiceCategory] by [id]
  Stream<ServiceCategory> getCategoryById({String id}) =>
      _categoryDao.categoryById(id).watchSingle();
}
