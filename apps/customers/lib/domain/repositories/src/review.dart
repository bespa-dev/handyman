/*
 * Copyright (c) 2021.
 * This application is owned by HandyMan LLC,
 * developed & designed by Quabynah Codelabs LLC.
 *
 *
 * author: codelbas.quabynah@gmail.com
 */

import 'package:lite/domain/models/models.dart';
import 'package:meta/meta.dart';

abstract class BaseReviewRepository implements Exposable {
  /// Delete a [CustomerReview] by [id]
  Future<void> deleteReviewById({@required String id});

  /// Send a [CustomerReview]
  Future<void> sendReview({
    @required String message,
    @required String reviewer,
    @required String artisan,
    @required double rating,
  });
}
