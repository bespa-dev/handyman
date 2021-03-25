/*
 * Copyright (c) 2021.
 * This application is owned by lite LLC,
 * developed & designed by Quabynah Codelabs LLC.
 *
 *
 * author: codelbas.quabynah@gmail.com
 */

import 'package:lite/data/entities/entities.dart';
import 'package:lite/domain/models/models.dart';
import 'package:lite/domain/repositories/repositories.dart';
import 'package:lite/domain/sources/sources.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

class BookingRepositoryImpl extends BaseBookingRepository {
  const BookingRepositoryImpl({
    @required BaseLocalDatasource local,
    @required BaseRemoteDatasource remote,
  }) : super(local, remote);

  @override
  Stream<List<BaseBooking>> bookingsForCustomerAndArtisan(
      {@required String customerId, @required String artisanId}) async* {
    remote
        .bookingsForCustomerAndArtisan(customerId, artisanId)
        .listen((event) async {
      for (var value in event) {
        if (value != null) await local.updateBooking(booking: value);
      }
    });
    yield* local.bookingsForCustomerAndArtisan(customerId, artisanId);
  }

  @override
  Future<void> deleteBooking({BaseBooking booking}) async {
    await local.deleteBooking(booking: booking);
    await remote.deleteBooking(booking: booking);
  }

  @override
  Stream<BaseBooking> getBookingById({String id}) async* {
    remote.getBookingById(id: id).listen((event) async {
      if (event != null) await local.updateBooking(booking: event);
    });
    yield* local.getBookingById(id: id);
  }

  @override
  Stream<List<BaseBooking>> getBookingsByDueDate(
      {String dueDate, String artisanId}) async* {
    remote
        .getBookingsByDueDate(dueDate: dueDate, artisanId: artisanId)
        .listen((event) async {
      for (var value in event) {
        if (value != null) await local.updateBooking(booking: value);
      }
    });
    yield* local.getBookingsByDueDate(dueDate: dueDate, artisanId: artisanId);
  }

  @override
  Future<void> requestBooking(
      {@required String artisan,
      @required String customer,
      @required String category,
      @required String description,
      @required String image,
      @required double cost,
      @required String serviceType,
      @required BaseLocationMetadata metadata}) async {
    final now = DateTime.now();
    var booking = Booking(
      id: Uuid().v4(),
      createdAt: now.toIso8601String(),
      category: category,
      customerId: customer,
      serviceType: serviceType,
      artisanId: artisan,
      cost: cost,
      currentState: BookingState.none().name(),
      description: description,
      imageUrl: image,
      position: metadata,
      progress: 0.0,
      dueDate: DateTime.utc(
        2021,
        now.month,
        now.day,
        now.hour + 48,
        now.minute,
      ).toIso8601String(),
    );
    await local.requestBooking(booking: booking);
    await remote.requestBooking(booking: booking);
  }

  @override
  Future<void> updateBooking({BaseBooking booking}) async {
    await local.updateBooking(booking: booking);
    await remote.updateBooking(booking: booking);
  }

  @override
  Stream<List<BaseBooking>> observeBookingsForArtisan(String id) async* {
    remote.observeBookingsForArtisan(id).listen((event) async {
      for (var value in event) {
        if (value != null) await local.updateBooking(booking: value);
      }
    });
    yield* local.observeBookingsForArtisan(id);
  }

  @override
  Stream<List<BaseBooking>> observeBookingsForCustomer(String id) async* {
    remote.observeBookingsForCustomer(id).listen((event) async {
      for (var value in event) {
        if (value != null) await local.updateBooking(booking: value);
      }
    });
    yield* local.observeBookingsForCustomer(id);
  }
}
