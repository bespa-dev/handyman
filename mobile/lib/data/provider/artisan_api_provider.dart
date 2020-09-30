import 'dart:async';
import 'dart:convert';

import 'package:algolia/algolia.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:handyman/core/service_locator.dart';
import 'package:handyman/core/utils.dart';
import 'package:handyman/data/entities/category.dart';
import 'package:handyman/data/local_database.dart';
import 'package:meta/meta.dart';

/// API service for application
/// FIXME: fix bugs with moor database
class ApiProviderService {
  final _providerDao = sl.get<LocalDatabase>().providerDao;
  final _customerDao = sl.get<LocalDatabase>().customerDao;
  final _categoryDao = sl.get<LocalDatabase>().categoryDao;
  final _messageDao = sl.get<LocalDatabase>().messageDao;
  final _reviewDao = sl.get<LocalDatabase>().reviewDao;
  final _bookingDao = sl.get<LocalDatabase>().bookingDao;

  ApiProviderService._();

  static ApiProviderService get instance => ApiProviderService._();

  /// Get all [Artisan]s from data source
  Future<List<Artisan>> getArtisans({@required String category}) async {
    // Decode artisans from json array
    final data = await rootBundle.loadString("assets/sample_artisan.json");
    var decodedData = json.decode(data);

    // Convert each object to `Artisan` object
    final List<dynamic> artisans = decodedData ??= [];

    // Add to database
    // _providerDao.addProviders(artisans.map((e) => Artisan.fromJson(e)).toList());

    // Traverse json array
    final results = artisans
        .map((e) => Artisan.fromJson(e))
        .where((item) => item.category == category)
        .toList();
    return results;
  }

  Stream<Artisan> getArtisanById({@required String id}) =>
      _providerDao.artisanById(id).watchSingle();

  Future<void> sendMessage({@required Conversation conversation}) =>
      _messageDao.sendMessage(conversation);

  // TODO: Uncomment this
  // Stream<List<Conversation>> getConversation(
  //         {@required String sender, @required String recipient}) =>
  //     _messageDao.conversationWithRecipient(sender, recipient).watch();

  Stream<List<Conversation>> getConversation(
      {@required String sender, @required String recipient}) async* {
    // Decode artisans from json array
    final data = await rootBundle.loadString("assets/sample_conversation.json");
    var decodedData = json.decode(data);

    // Convert each object to `Artisan` object
    final List<dynamic> messages = decodedData ??= [];

    // Add to database
    // _messageDao.addMessages(messages.map((e) => Conversation.fromJson(e)).toList());

    // Traverse json array
    final results = messages
        .map((e) => Conversation.fromJson(e))
        // .where((item) => item.author == sender && item.recipient == recipient)
        .toList();

    yield results;
  }

  Stream<Customer> getCustomerById({@required String id}) =>
      _customerDao.customerById(id).watchSingle();

  /// Get all [ServiceCategory] from data source
  Future<List<ServiceCategory>> getCategories(
      {CategoryGroup categoryGroup = CategoryGroup.FEATURED}) async {
    // Decode categories from json array
    final data = await rootBundle.loadString("assets/sample_categories.json");
    var decodedData = json.decode(data);

    // Convert each object to `ServiceCategory` object
    final List<dynamic> categories = decodedData ??= [];

    // Add to database
    // _categoryDao.addItems(categories.map((e) => ServiceCategory.fromJson(e)).toList());

    // Traverse json array
    final results = categories
        .map((e) => ServiceCategory.fromJson(e))
        .where((item) => item.groupName == categoryGroup.index)
        .toList();
    return results;
  }

  Stream<List<CustomerReview>> getReviews(String id) =>
      _reviewDao.reviewsForProvider(id).watch();

  Stream<List<Booking>> getMyBookings(String id) =>
      _bookingDao.bookingsForCustomer(id).watch();

  Stream<List<Booking>> getMyBookingsForProvider(
          String customerId, String providerId) =>
      _bookingDao
          .bookingsForCustomerAndProvider(customerId, providerId)
          .watch();

  /// Performs a search for [Artisan]s in [Algolia]
  Future<List<Artisan>> searchFor(
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
          : snapshot.hits.map((e) => Artisan.fromJson(e.data)).toList();
    } on Exception {
      return Future.value(<Artisan>[]);
    }
  }
}
