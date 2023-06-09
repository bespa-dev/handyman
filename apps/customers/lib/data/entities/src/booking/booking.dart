/*
 * Copyright (c) 2021.
 * This application is owned by lite LLC,
 * developed & designed by Quabynah Codelabs LLC.
 *
 *
 * author: codelbas.quabynah@gmail.com
 */

import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:lite/data/entities/entities.dart' show LocationMetadata, LocationMetadataSerializer;
import 'package:lite/domain/models/models.dart';
import 'package:lite/shared/shared.dart';
import 'package:meta/meta.dart';

part 'booking.g.dart';

@HiveType(typeId: 0)
@JsonSerializable(fieldRename: FieldRename.snake)
class Booking extends BaseBooking {
  Booking({
    @required this.id,
    @required this.createdAt,
    @required this.customerId,
    @required this.artisanId,
    @required this.category,
    @required this.imageUrl,
    @required this.description,
    @required this.dueDate,
    @required this.currentState,
    @required this.serviceType,
    this.position,
    this.cost = 0.0,
    this.progress = 0.0,
  });

  factory Booking.fromJson(Map<String, dynamic> json) =>
      _$BookingFromJson(json);

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
  @LocationMetadataSerializer()
  final BaseLocationMetadata position;

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

  @HiveField(11)
  @override
  final String currentState;

  @HiveField(12)
  @override
  final String serviceType;

  @override
  Booking get model => this;

  @override
  bool get hasImage => imageUrl != null && imageUrl.isNotEmpty;

  @override
  bool get isDue =>
      compareTime(dueDate, DateTime.now().toIso8601String()).isNegative;

  @override
  bool get isPending => currentState == BookingState.pending().name();

  @override
  bool get isComplete => currentState == BookingState.complete().name();

  @override
  bool get isCancelled => currentState == BookingState.cancelled().name();

  @override
  Map<String, dynamic> toJson() => _$BookingToJson(this);

  @override
  BaseBooking copyWith({
    String customerId,
    String artisanId,
    String category,
    String imageUrl,
    String description,
    BaseLocationMetadata position,
    double cost,
    double progress,
    String dueDate,
    String currentState,
    String serviceType,
  }) =>
      Booking(
        id: id,
        createdAt: createdAt,
        customerId: customerId ?? this.customerId,
        artisanId: artisanId ?? this.artisanId,
        category: category ?? this.category,
        imageUrl: imageUrl ?? this.imageUrl,
        description: description ?? this.description,
        position: position ?? this.position,
        cost: cost ?? this.cost,
        progress: progress ?? this.progress,
        dueDate: dueDate ?? this.dueDate,
        serviceType: serviceType ?? this.serviceType,
        currentState: currentState ?? this.currentState,
      );
}
