/*
 * Copyright (c) 2021.
 * This application is owned by HandyMan LLC,
 * developed & designed by Quabynah Codelabs LLC.
 *
 *
 * author: codelbas.quabynah@gmail.com
 */

import 'package:handyman/domain/models/models.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

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
    @required this.id,
    @required this.createdAt,
    @required this.startWorkingHours,
    @required this.endWorkingHours,
    @required this.name,
    @required this.token,
    @required this.phone,
    @required this.avatar,
    @required this.email,
    this.businessId,
    this.category,
    this.categoryGroup,
    this.rating = 2.5,
    this.bookingsCount = 0,
    this.requests = const [],
    this.reports = const [],
    this.isAvailable = false,
    this.isApproved = false,
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
  BaseArtisan copyWith({
    String name,
    String email,
    String avatar,
    String token,
    String phone,
    String category,
    String businessId,
    String categoryGroup,
    String startWorkingHours,
    String endWorkingHours,
    double rating,
    bool isAvailable,
    bool isApproved,
    int bookingsCount,
    List<String> requests,
    List<String> reports,
  }) =>
      Artisan(
        name: name ??= this.name,
        email: email ??= this.email,
        avatar: avatar ??= this.avatar,
        token: token ??= this.token,
        phone: phone ??= this.phone,
        category: category ??= this.category,
        businessId: businessId ??= this.businessId,
        categoryGroup: categoryGroup ??= this.categoryGroup,
        startWorkingHours: startWorkingHours ??= this.startWorkingHours,
        endWorkingHours: endWorkingHours ??= this.endWorkingHours,
        rating: rating ??= this.rating,
        isAvailable: isAvailable ??= this.isAvailable,
        isApproved: isApproved ??= this.isApproved,
        bookingsCount: bookingsCount ??= this.bookingsCount,
        requests: requests ??= this.requests,
        reports: reports ??= this.reports,
        id: this.id,
        createdAt: this.createdAt,
      );
}
