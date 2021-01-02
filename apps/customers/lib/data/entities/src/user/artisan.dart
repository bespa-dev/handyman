/*
 * Copyright (c) 2021.
 * This application is owned by HandyMan LLC,
 * developed & designed by Quabynah Codelabs LLC.
 *
 *
 * author: codelbas.quabynah@gmail.com
 */

import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:lite/domain/models/models.dart';

part 'artisan.g.dart';

/// fixme -> resolve cancelled, completed & ongoing bookings counts
@HiveType(typeId: 5)
@JsonSerializable(fieldRename: FieldRename.snake)
class Artisan extends BaseArtisan {
  @HiveField(0)
  @override
  final String businessId;

  @HiveField(1)
  @override
  final String category;

  @HiveField(2)
  @override
  final int startWorkingHours;

  @HiveField(3)
  @override
  final int endWorkingHours;

  @HiveField(4)
  @override
  final int bookingsCount;

  @HiveField(5)
  @override
  final List<String> requests;

  @HiveField(6)
  @override
  final List<String> reports;

  @HiveField(7)
  @override
  final bool isCertified;

  @HiveField(8)
  @override
  final bool isAvailable;

  @HiveField(9)
  @override
  final bool isApproved;

  @HiveField(10)
  @override
  final String id;

  @HiveField(11)
  @override
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
