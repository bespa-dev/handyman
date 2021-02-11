/*
 * Copyright (c) 2021.
 * This application is owned by HandyMan LLC,
 * developed & designed by Quabynah Codelabs LLC.
 *
 *
 * author: codelbas.quabynah@gmail.com
 */

import 'package:handyman/domain/models/models.dart'
    show BaseModel, BaseLocationMetadata;
import 'package:super_enum/super_enum.dart';

part 'booking.super.dart';

@superEnum
enum _BookingState {
  @object
  None,
  @object
  Complete,
  @object
  Pending,
  @object
  Cancelled,
}

/// base bookings class
abstract class BaseBooking extends BaseModel {
  String customerId;
  String artisanId;
  String category;
  String imageUrl;
  String description;
  BaseLocationMetadata position;
  double cost;
  double progress;
  String dueDate;
  String currentState;
  String serviceType;

  bool get hasImage;

  bool get isDue;

  bool get isPending;

  bool get isComplete;

  bool get isCancelled;

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
  });
}

extension BookingStateX on BookingState {
  String name() => toString().replaceAll('()', '');
}
