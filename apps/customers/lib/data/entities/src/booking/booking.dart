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

part 'booking.g.dart';

@HiveType(typeId: 0)
@JsonSerializable(fieldRename: FieldRename.snake, genericArgumentFactories: true)
class Booking extends BaseBooking {
  @HiveField(0)
  @override
  final String customerId;

  @HiveField(1)
  @override
  final String artisanId;

  @HiveField(2)
  @override
  final String category;

  @HiveField(3)
  @override
  final String imageUrl;

  @HiveField(4)
  @override
  final String description;

  @HiveField(5)
  @override
  final LocationMetadata position;

  @HiveField(6)
  @override
  final double cost;

  @HiveField(7)
  @override
  final double progress;

  @HiveField(8)
  @override
  final String dueDate;

  @HiveField(9)
  @override
  final String id;

  @HiveField(10)
  @override
  final String createdAt;

  Booking({
    this.id,
    this.createdAt,
    this.customerId,
    this.artisanId,
    this.category,
    this.imageUrl,
    this.description,
    this.position,
    this.cost,
    this.progress,
    this.dueDate,
  });

  @override
  get model => this;

  factory Booking.fromJson(Map<String, dynamic> json) =>
      _$BookingFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$BookingToJson(this);
}
