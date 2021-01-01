/*
 * Copyright (c) 2021.
 * This application is owned by HandyMan LLC,
 * developed & designed by Quabynah Codelabs LLC.
 *
 *
 * author: codelbas.quabynah@gmail.com
 */

import 'base.dart';

/// base review class
abstract class BaseReview extends BaseModel {
  String body;
  String customerId;
  String artisanId;
  double rating;
}
