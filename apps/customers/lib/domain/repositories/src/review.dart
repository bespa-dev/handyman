/*
 * Copyright (c) 2021.
 * This application is owned by lite LLC,
 * developed & designed by Quabynah Codelabs LLC.
 *
 *
 * author: codelbas.quabynah@gmail.com
 */

import 'package:lite/domain/models/models.dart';
import 'package:lite/domain/repositories/repositories.dart';
import 'package:lite/domain/sources/src/local.dart';
import 'package:lite/domain/sources/src/remote.dart';
import 'package:meta/meta.dart';

abstract class BaseReviewRepository extends BaseRepository {
  const BaseReviewRepository(BaseLocalDatasource local, BaseRemoteDatasource remote) : super(local, remote);

  /// Delete a [CustomerReview] by [id]
  Future<void> deleteReviewById({@required String id});

  /// Send a [CustomerReview]
  Future<void> sendReview({
    @required String message,
    @required String reviewer,
    @required String artisan,
    @required double rating,
  });

  /// Get [BaseReview] for [Artisan]
  Stream<List<BaseReview>> observeReviewsForArtisan(String id);

  /// Get [BaseReview] for [Customer] by [id]
  Stream<List<BaseReview>> observeReviewsByCustomer(String id);
}
