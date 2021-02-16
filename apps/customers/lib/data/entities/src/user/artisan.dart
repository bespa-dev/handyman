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
import 'package:lite/data/entities/entities.dart';
import 'package:lite/domain/models/models.dart';
import 'package:meta/meta.dart';

part 'artisan.g.dart';

@HiveType(typeId: 5)
@JsonSerializable(fieldRename: FieldRename.snake)
class Artisan extends BaseArtisan {
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
    this.birthCert,
    this.nationalId,
    this.category,
    this.categoryGroup,
    this.rating = 2.5,
    this.bookingsCount = 0,
    this.requests = const [],
    this.reports = const [],
    this.services = const [],
    this.isAvailable = false,
    this.isApproved = false,
  });

  factory Artisan.fromJson(Map<String, dynamic> json) =>
      _$ArtisanFromJson(json);

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
  @JsonKey(name: 'available')
  @override
  final bool isAvailable;

  @HiveField(9)
  @JsonKey(name: 'approved')
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

  @HiveField(19)
  @override
  final String birthCert;

  @HiveField(20)
  @override
  final String nationalId;

  @HiveField(21)
  @override
  final List<BaseArtisanService> services;

  @override
  int get cancelledBookingsCount => 0;

  @override
  int get completedBookingsCount => 0;

  @override
  int get ongoingBookingsCount => 0;

  @override
  int get servicesCount => services?.length ?? 0;

  @override
  int get reportsCount => reports?.length ?? 0;

  @override
  int get requestsCount => requests?.length ?? 0;

  @override
  bool get hasHighRatings => rating != null && rating >= 3.5;

  @override
  Artisan get model => this;

  @override
  Map<String, dynamic> toJson() => _$ArtisanToJson(this);

  @override
  BaseArtisan copyWith({
    String name,
    String email,
    String avatar,
    String token,
    String phone,
    String category,
    String businessId,
    String birthCert,
    String nationalId,
    String categoryGroup,
    String startWorkingHours,
    String endWorkingHours,
    double rating,
    bool isAvailable,
    bool isApproved,
    int bookingsCount,
    List<String> requests,
    List<String> reports,
    List<BaseArtisanService> services,
  }) =>
      Artisan(
        name: name ??= this.name,
        email: email ??= this.email,
        avatar: avatar ??= this.avatar,
        token: token ??= this.token,
        phone: phone ??= this.phone,
        birthCert: birthCert ?? this.birthCert,
        nationalId: nationalId ?? this.nationalId,
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
        services: services ??= this.services,
        id: id,
        createdAt: createdAt,
      );
}
