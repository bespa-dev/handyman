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
  String birthCert;
  String nationalId;
  String category;
  String categoryGroup;
  String startWorkingHours;
  String endWorkingHours;
  int bookingsCount;
  double rating;
  List<String> requests;
  List<String> reports;
  List<String> services;
  bool isAvailable;
  bool isApproved;

  int get requestsCount;

  bool get isCertified;

  int get reportsCount;

  int get servicesCount;

  int get ongoingBookingsCount;

  int get completedBookingsCount;

  int get cancelledBookingsCount;

  BaseArtisan copyWith({
    String name,
    String email,
    String avatar,
    String token,
    String phone,
    String category,
    String businessId,
    String nationalId,
    String birthCert,
    String categoryGroup,
    String startWorkingHours,
    String endWorkingHours,
    double rating,
    bool isAvailable,
    bool isApproved,
    int bookingsCount,
    List<String> requests,
    List<String> reports,
    List<String> services,
  });
}
