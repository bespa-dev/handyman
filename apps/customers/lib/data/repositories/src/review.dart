/*
 * Copyright (c) 2021.
 * This application is owned by HandyMan LLC,
 * developed & designed by Quabynah Codelabs LLC.
 *
 *
 * author: codelbas.quabynah@gmail.com
 */

import 'package:lite/domain/repositories/repositories.dart';
import 'package:lite/domain/sources/sources.dart';
import 'package:meta/meta.dart';

class ReviewRepositoryImpl implements BaseReviewRepository {
  final BaseLocalDatasource _localDatasource;
  final BaseRemoteDatasource _remoteDatasource;

  ReviewRepositoryImpl({
    @required BaseLocalDatasource local,
    @required BaseRemoteDatasource remote,
  })  : _localDatasource = local,
        _remoteDatasource = remote;

  @override
  Future<void> deleteReviewById({String id, String customerId}) async {
    await _localDatasource.deleteReviewById(id: id, customerId: customerId);
    await _remoteDatasource.deleteReviewById(id: id, customerId: customerId);
  }

  @override
  Future<void> sendReview(
      {String message, String reviewer, String artisan}) async {
    await _localDatasource.sendReview(
        message: message, reviewer: reviewer, artisan: artisan);
    await _remoteDatasource.sendReview(
        message: message, reviewer: reviewer, artisan: artisan);
  }
}
