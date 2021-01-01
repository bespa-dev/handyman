/*
 * Copyright (c) 2021.
 * This application is owned by HandyMan LLC,
 * developed & designed by Quabynah Codelabs LLC.
 *
 *
 * author: codelbas.quabynah@gmail.com
 */

import 'package:lite/domain/models/models.dart' show BaseUser;

/// base artisan class
abstract class BaseArtisan extends BaseUser {
  String businessId;

  String category;

  int startWorkingHours;

  int endWorkingHours;

  int bookingsCount;

  List<String> requests;

  List<String> reports;

  int get requestsCount;

  int get reportsCount;

  int get ongoingBookingsCount;

  int get completedBookingsCount;

  int get cancelledBookingsCount;

  bool get isCertified;

  bool get isAvailable;

  bool get isApproved;
}
