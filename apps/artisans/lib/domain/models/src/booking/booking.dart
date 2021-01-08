/*
 * Copyright (c) 2021.
 * This application is owned by HandyMan LLC,
 * developed & designed by Quabynah Codelabs LLC.
 *
 *
 * author: codelbas.quabynah@gmail.com
 */

import 'package:handyman/domain/models/models.dart'
    show BaseModel, LocationMetadata;
import 'package:super_enum/super_enum.dart';

part 'booking.super.dart';

@superEnum
enum _BookingState {
  @object
  Paid,
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
  LocationMetadata position;
  double cost;
  double progress;
  String dueDate;
  String currentState;

  BaseBooking copyWith({
    String customerId,
    String artisanId,
    String category,
    String imageUrl,
    String description,
    LocationMetadata position,
    double cost,
    double progress,
    String dueDate,
    String currentState,
  });
}

extension BookingStateX on BookingState {
  String name() => this.toString().replaceAll("()", "");
}