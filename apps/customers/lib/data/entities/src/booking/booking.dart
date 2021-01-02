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

part 'booking.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Booking extends BaseBooking {
  final String customerId;
  final String artisanId;
  final String category;
  final String imageUrl;
  final String description;
  final LocationMetadata position;
  final double cost;
  final double progress;
  final int dueDate;

  Booking({
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
