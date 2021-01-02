/*
 * Copyright (c) 2021.
 * This application is owned by HandyMan LLC,
 * developed & designed by Quabynah Codelabs LLC.
 *
 *
 * author: codelbas.quabynah@gmail.com
 */

import 'package:json_annotation/json_annotation.dart';
import 'package:lite/domain/models/models.dart';

part 'artisan.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Artisan extends BaseArtisan {
  final String businessId;
  final String category;
  final int startWorkingHours;
  final int endWorkingHours;
  final int bookingsCount;
  final List<String> requests;
  final List<String> reports;
  final bool isCertified;
  final bool isAvailable;
  final bool isApproved;
  final String id;
  final int createdAt;

  Artisan({
    this.id,
    this.createdAt,
    this.businessId,
    this.category,
    this.startWorkingHours,
    this.endWorkingHours,
    this.bookingsCount,
    this.requests,
    this.reports,
    this.isCertified,
    this.isAvailable,
    this.isApproved,
  });

  @override
  int get cancelledBookingsCount => 0;

  @override
  int get completedBookingsCount => 0;

  @override
  int get ongoingBookingsCount => 0;

  @override
  int get reportsCount => reports.length;

  @override
  int get requestsCount => requests.length;

  @override
  get model => this;

  @override
  Map<String, dynamic> toJson() => _$ArtisanToJson(this);

  factory Artisan.fromJson(Map<String, dynamic> json) =>
      _$ArtisanFromJson(json);
}
