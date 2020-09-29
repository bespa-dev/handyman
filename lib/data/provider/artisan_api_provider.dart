import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:handyman/data/local_database.dart';

class ArtisanProvider {
  ArtisanProvider._();

  static ArtisanProvider get instance => ArtisanProvider._();

  /// Get all [Artisan]s from data source
  Future<List<Artisan>> getArtisans() async {
    await Future.delayed(const Duration(milliseconds: 850));
    final data = await rootBundle.loadString("assets/sample_artisan.json");
    var decodedData = json.decode(data);
    final List<dynamic> artisans =
        decodedData != null ? List.from(decodedData) : [];
    final results = <Artisan>[];
    for (var json in artisans) {
      final item = Artisan.fromJson(json);
      debugPrint(item.toString());
      results.add(item);
    }
    return results;
  }
}
