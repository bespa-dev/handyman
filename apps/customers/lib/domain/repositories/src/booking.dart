/*
 * Copyright (c) 2021.
 * This application is owned by lite LLC,
 * developed & designed by Quabynah Codelabs LLC.
 *
 *
 * author: codelbas.quabynah@gmail.com
 */

import 'package:lite/domain/models/models.dart';
import 'package:lite/domain/repositories/repositories.dart';
import 'package:lite/domain/sources/src/local.dart';
import 'package:lite/domain/sources/src/remote.dart';
import 'package:meta/meta.dart';

abstract class BaseBookingRepository extends BaseRepository {
  const BaseBookingRepository(BaseLocalDatasource local, BaseRemoteDatasource remote) : super(local, remote);

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
    @required double cost,
    @required BaseLocationMetadata metadata,
  });

  Future<void> updateBooking({@required BaseBooking booking});

  Future<void> deleteBooking({@required BaseBooking booking});

  /// Get [Booking] for [Artisan] & [Customer]
  Stream<List<BaseBooking>> bookingsForCustomerAndArtisan(
      {String customerId, String artisanId});

  /// Get [Booking] for [Artisan] by [id]
  Stream<List<BaseBooking>> observeBookingsForArtisan(String id);

  /// Get [Booking] for [Customer] by [id]
  Stream<List<BaseBooking>> observeBookingsForCustomer(String id);
}
