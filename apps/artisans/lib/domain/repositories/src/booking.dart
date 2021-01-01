/*
 * Copyright (c) 2021.
 * This application is owned by HandyMan LLC,
 * developed & designed by Quabynah Codelabs LLC.
 *
 *
 * author: codelbas.quabynah@gmail.com
 */

import 'package:handyman/domain/models/models.dart';
import 'package:meta/meta.dart';

abstract class BaseBookingRepository implements Exposable {
  /// Get [BaseBooking] by [id]
  Stream<BaseBooking> getBookingById({String id});

  /// Get [BaseBooking] by [dueDate]
  Stream<List<BaseBooking>> getBookingsByDueDate(
      {@required String dueDate, @required String artisanId});

  /// Request [Booking] for an [Artisan]
  Future<void> requestBooking({
    @required String artisan,
    @required String customer,
    @required String category,
    @required String description,
    @required String image,
    @required LocationMetadata metadata,
  });

  Future<void> updateBooking({@required BaseBooking booking});

  Future<void> deleteBooking({@required BaseBooking booking});

  /// Get [Booking] for [Artisan] & [Customer]
  Stream<List<BaseBooking>> bookingsForCustomerAndArtisan(
      {String customerId, String artisanId});
}
