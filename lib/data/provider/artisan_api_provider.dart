import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:handyman/core/service_locator.dart';
import 'package:handyman/data/entities/category.dart';
import 'package:handyman/data/local_database.dart';
import 'package:meta/meta.dart';

class ArtisanProvider {
  final _database = sl.get<LocalDatabase>();

  ArtisanProvider._();

  static ArtisanProvider get instance => ArtisanProvider._();

  /// Get all [Artisan]s from data source
  Future<List<Artisan>> getArtisans({@required String category}) async {
    await Future.delayed(const Duration(milliseconds: 350));
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

  Future<List<ServiceCategory>> getCategories(
      {CategoryGroup categoryGroup = CategoryGroup.FEATURED}) async {
    debugPrint("Selected category -> $categoryGroup");
    await Future.delayed(const Duration(milliseconds: 350));
    final data = await rootBundle.loadString("assets/sample_categories.json");
    var decodedData = json.decode(data);
    final List<dynamic> categories =
        decodedData != null ? List.from(decodedData) : [];
    final results = <ServiceCategory>[];
    for (var json in categories) {
      final item = ServiceCategory.fromJson(json);
      if (item.group == categoryGroup.index) {
        results.add(item);
      }
    }
    return results;
  }
}
