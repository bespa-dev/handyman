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

  String categoryGroup;

  String startWorkingHours;

  String endWorkingHours;

  int bookingsCount;

  double rating;

  List<String> requests;

  List<String> reports;

  bool get isCertified;

  bool isAvailable;

  bool isApproved;

  int get requestsCount;

  int get reportsCount;

  int get ongoingBookingsCount;

  int get completedBookingsCount;

  int get cancelledBookingsCount;
}
