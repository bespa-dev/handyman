/*
 * Copyright (c) 2021.
 * This application is owned by HandyMan LLC,
 * developed & designed by Quabynah Codelabs LLC.
 *
 *
 * author: codelbas.quabynah@gmail.com
 */

import 'package:algolia/algolia.dart';
import 'package:handyman/data/entities/entities.dart';
import 'package:handyman/domain/models/src/user/user.dart';
import 'package:handyman/domain/repositories/repositories.dart';
import 'package:handyman/domain/sources/sources.dart';
import 'package:handyman/shared/shared.dart';
import 'package:meta/meta.dart';

class SearchRepositoryImpl extends BaseSearchRepository {

  const SearchRepositoryImpl({
    @required BaseLocalDatasource local,
    @required BaseRemoteDatasource remote,
    @required Algolia algolia,
  })  : _algolia = algolia,
        super(local, remote);

  final Algolia _algolia;

  @override
  Future<List<BaseUser>> searchFor({String query, String categoryId}) async {
    try {
      // Perform search with index
      var algQuery =
          _algolia.instance.index(RefUtils.kArtisanRef).search(query);

      // Get snapshot
      var snapshot = await algQuery.getObjects();

      // Checking if has [AlgoliaQuerySnapshot]
      logger.d('Hits count: ${snapshot.nbHits}');

      // Return transformed data from API
      if (snapshot.empty) {
        return await local.searchFor(query: query, categoryId: categoryId);
      }
      var results = snapshot.hits.map((e) => Artisan.fromJson(e.data)).toList();
      for (var value in results) {
        if (value != null) await local.updateUser(value);
      }
      return results;
    } on Exception {
      return Future.value(<BaseUser>[]);
    }
  }
}
