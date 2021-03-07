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
@JsonSerializable(fieldRename: FieldRename.snake, genericArgumentFactories: true)
class Artisan extends BaseArtisan {
  @HiveField(0)
  @override
  final String businessId;

  @HiveField(1)
  @override
  final String category;

  @HiveField(2)
  @override
  final String startWorkingHours;

  @HiveField(3)
  @override
  final String endWorkingHours;

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
  bool get isCertified => rating >= 3;

  @HiveField(8)
  @JsonKey(name: "available")
  @override
  final bool isAvailable;

  @HiveField(9)
  @JsonKey(name: "approved")
  @override
  final bool isApproved;

  @HiveField(10)
  @override
  final String id;

  @HiveField(11)
  @override
  final String createdAt;

  @HiveField(12)
  @override
  final String token;

  @HiveField(13)
  @override
  final String phone;

  @HiveField(14)
  @override
  final String avatar;

  @HiveField(15)
  @override
  final String email;

  @HiveField(16)
  @override
  final String name;

  @HiveField(17)
  @override
  final double rating;

  @HiveField(18)
  @override
  final String categoryGroup;

  Artisan({
    this.id,
    this.rating,
    this.createdAt,
    this.businessId,
    this.category,
    this.categoryGroup,
    this.startWorkingHours,
    this.endWorkingHours,
    this.bookingsCount,
    this.requests,
    this.reports,
    this.isAvailable,
    this.isApproved,
    this.token,
    this.phone,
    this.avatar,
    this.email,
    this.name,
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

  @override
  BaseUser copyWith({
    String name,
    String email,
    String avatar,
    String token,
    String phone,
  }) =>
      Artisan(
        id: this.id,
        createdAt: this.createdAt,
        category: this.category,
        rating: this.rating,
        categoryGroup: this.categoryGroup,
        bookingsCount: this.bookingsCount,
        businessId: this.businessId,
        endWorkingHours: this.endWorkingHours,
        isApproved: this.isApproved,
        isAvailable: this.isAvailable,
        reports: this.reports,
        requests: this.requests,
        startWorkingHours: this.startWorkingHours,
        token: token ?? this.token,
        phone: phone ?? this.phone,
        avatar: avatar ?? this.avatar,
        email: email ?? this.email,
        name: name ?? this.name,
      );
}
