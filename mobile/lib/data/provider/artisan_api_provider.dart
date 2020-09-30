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
class ApiProviderService {
  final _database = sl.get<LocalDatabase>();

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
    _database.providerDao
        .addProviders(artisans.map((e) => Artisan.fromJson(e)).toList());

    // Traverse json array
    final results = artisans
        .map((e) => Artisan.fromJson(e))
        .where((item) => item.category == category)
        .toList();
    return /*_database.categoryDao.categoryByGroup(categoryGroup.index).get();*/ results;
  }

  Stream<Artisan> getArtisanById({@required String id}) =>
      _database.providerDao.artisanById(id).watchSingle();

  Stream<Customer> getCustomerById({@required String id}) =>
      _database.customerById(id).watchSingle();

  /// Get all [ServiceCategory] from data source
  Future<List<ServiceCategory>> getCategories(
      {CategoryGroup categoryGroup = CategoryGroup.FEATURED}) async {
    // Decode categories from json array
    final data = await rootBundle.loadString("assets/sample_categories.json");
    var decodedData = json.decode(data);

    // Convert each object to `ServiceCategory` object
    final List<dynamic> categories = decodedData ??= [];

    // Add to database
    _database.categoryDao
        .addItems(categories.map((e) => ServiceCategory.fromJson(e)).toList());

    // Traverse json array
    final results = categories
        .map((e) => ServiceCategory.fromJson(e))
        .where((item) => item.groupName == categoryGroup.index)
        .toList();
    return /*_database.categoryDao.categoryByGroup(categoryGroup.index).get();*/ results;
  }

  Stream<List<CustomerReview>> getReviews(String id) =>
      _database.reviewDao.reviewsForProvider(id).watch();

  Stream<List<Booking>> getMyBookings(String id) =>
      _database.bookingDao.bookingsForCustomer(id).watch();

  Stream<List<Booking>> getMyBookingsForProvider(
          String customerId, String providerId) =>
      _database.bookingDao
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
          ? _database.providerDao.searchFor(value, categoryId ?? "").get()
          : snapshot.hits.map((e) => Artisan.fromJson(e.data)).toList();
    } on Exception {
      return Future.value(<Artisan>[]);
    }
  }
}
