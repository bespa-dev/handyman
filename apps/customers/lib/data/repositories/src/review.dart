/*
 * Copyright (c) 2021.
 * This application is owned by HandyMan LLC,
 * developed & designed by Quabynah Codelabs LLC.
 *
 *
 * author: codelbas.quabynah@gmail.com
 */

import 'package:lite/data/entities/entities.dart';
import 'package:lite/domain/repositories/repositories.dart';
import 'package:lite/domain/sources/sources.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

class ReviewRepositoryImpl implements BaseReviewRepository {
  final BaseLocalDatasource _localDatasource;
  final BaseRemoteDatasource _remoteDatasource;

  ReviewRepositoryImpl({
    @required BaseLocalDatasource local,
    @required BaseRemoteDatasource remote,
  })  : _localDatasource = local,
        _remoteDatasource = remote;

  @override
  Future<void> deleteReviewById({String id}) async {
    await _localDatasource.deleteReviewById(id: id);
    await _remoteDatasource.deleteReviewById(id: id);
  }

  @override
  Future<void> sendReview(
      {String message, String reviewer, String artisan, double rating}) async {
    final review = Review(
      id: Uuid().v4(),
      artisanId: artisan,
      customerId: reviewer,
      createdAt: DateTime.now().toIso8601String(),
      body: message,
      rating: rating,
    );

    await _localDatasource.sendReview(review: review);
    await _remoteDatasource.sendReview(review: review);
  }
}
