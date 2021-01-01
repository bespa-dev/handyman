/*
 * Copyright (c) 2021.
 * This application is owned by HandyMan LLC,
 * developed & designed by Quabynah Codelabs LLC.
 *
 *
 * author: codelbas.quabynah@gmail.com
 */

import 'package:lite/domain/models/models.dart' show BaseModel;

/// base position class
abstract class BasePosition {
  double lat;
  double lng;
}

/// base bookings class
abstract class BaseBooking extends BaseModel {
  String customerId;
  String artisanId;
  String category;
  String imageUrl;
  String description;
  BasePosition position;
  double cost;
  double progress;
  int dueDate;
}
