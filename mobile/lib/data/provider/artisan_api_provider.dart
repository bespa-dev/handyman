import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:handyman/core/service_locator.dart';
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
    final data = await rootBundle.loadString("assets/sample_artisan.json");
    var decodedData = json.decode(data);
    final List<dynamic> artisans =
        decodedData != null ? List.from(decodedData) : [];
    final results = <Artisan>[];
    for (var json in artisans) {
      final item = Artisan.fromJson(json);
      if (item.category == category) results.add(item);
    }
    _database.providerDao.addProviders(results);
    return results;
  }

  /// Get all [ServiceCategory] from data source
  Future<List<ServiceCategory>> getCategories(
      {CategoryGroup categoryGroup = CategoryGroup.FEATURED}) async {
    // var categoryList =
    //     await _database.categoryDao.categoryByGroup(categoryGroup.index).get();
    // if (categoryList.isNotEmpty)
    //   return categoryList;
    // else {
      final results = <ServiceCategory>[];
      final data = await rootBundle.loadString("assets/sample_categories.json");
      var decodedData = json.decode(data);
      final List<dynamic> categories =
          decodedData != null ? List.from(decodedData) : [];
      for (var json in categories) {
        final item = ServiceCategory.fromJson(json);
        /*if (item.groupName == categoryGroup.index)*/ results.add(item);
      }
      _database.categoryDao.addItems(results);
      return results;
    // }
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
}
