/*
 * Copyright (c) 2021.
 * This application is owned by HandyMan LLC,
 * developed & designed by Quabynah Codelabs LLC.
 *
 *
 * author: codelbas.quabynah@gmail.com
 */

import 'package:handyman/data/entities/entities.dart';
import 'package:handyman/domain/models/models.dart';
import 'package:handyman/domain/repositories/repositories.dart';
import 'package:handyman/domain/sources/sources.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

class ReviewRepositoryImpl extends BaseReviewRepository {
  const ReviewRepositoryImpl({
    @required BaseLocalDatasource local,
    @required BaseRemoteDatasource remote,
  }) : super(local, remote);

  @override
  Future<void> deleteReviewById({@required String id}) async {
    await local.deleteReviewById(id: id);
    await remote.deleteReviewById(id: id);
  }

  @override
  Future<void> sendReview({
    @required String message,
    @required String reviewer,
    @required String artisan,
    @required double rating,
  }) async {
    final review = Review(
      id: Uuid().v4(),
      artisanId: artisan,
      customerId: reviewer,
      createdAt: DateTime.now().toIso8601String(),
      body: message,
      rating: rating,
    );

    await local.sendReview(review: review);
    await remote.sendReview(review: review);
  }

  @override
  Stream<List<BaseReview>> observeReviewsByCustomer(String id) async* {
    yield* local.observeReviewsByCustomer(id);
    remote.observeReviewsByCustomer(id).listen((event) async {
      for (var value in event) {
        if (value != null) await local.updateReview(review: value);
      }
    });
  }

  @override
  Stream<List<BaseReview>> observeReviewsForArtisan(String id) async* {
    yield* local.observeReviewsForArtisan(id);
    remote.observeReviewsForArtisan(id).listen((event) async {
      for (var value in event) {
        if (value != null) await local.updateReview(review: value);
      }
    });
  }
}
