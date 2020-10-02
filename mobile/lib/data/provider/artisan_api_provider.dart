import 'dart:async';

import 'package:algolia/algolia.dart';
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

/// API service for application
class ApiProviderService {
  final _providerDao = sl.get<LocalDatabase>().providerDao;
  final _customerDao = sl.get<LocalDatabase>().customerDao;
  final _categoryDao = sl.get<LocalDatabase>().categoryDao;
  final _messageDao = sl.get<LocalDatabase>().messageDao;
  final _reviewDao = sl.get<LocalDatabase>().reviewDao;
  final _bookingDao = sl.get<LocalDatabase>().bookingDao;
  final _galleryDao = sl.get<LocalDatabase>().galleryDao;

  ApiProviderService._();

  static ApiProviderService get instance => ApiProviderService._();

  /// Get all [Artisan]s from data source
  Stream<List<BaseUser>> getArtisans({@required String category}) =>
      _providerDao
          .artisans(category)
          .watch()
          .map((event) => event.map((e) => ArtisanModel(artisan: e)).toList());

  Stream<BaseUser> getArtisanById({@required String id}) => _providerDao
      .artisanById(id)
      .watchSingle()
      .map((artisan) => ArtisanModel(artisan: artisan));

  Future<void> sendMessage({@required Conversation conversation}) =>
      _messageDao.sendMessage(conversation);

  Stream<List<Conversation>> getConversation(
          {@required String sender, @required String recipient}) =>
      _messageDao.conversationWithRecipient(
          sender: sender, recipient: recipient);

  /// Get [Customer] by [id]
  Stream<BaseUser> getCustomerById({@required String id}) => _customerDao
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

  Stream<List<Booking>> getMyBookingsForProvider(
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
          ? _providerDao.searchFor(value, categoryId ?? "").get()
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
}
