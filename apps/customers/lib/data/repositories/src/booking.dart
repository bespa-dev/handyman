/*
 * Copyright (c) 2021.
 * This application is owned by HandyMan LLC,
 * developed & designed by Quabynah Codelabs LLC.
 *
 *
 * author: codelbas.quabynah@gmail.com
 */

import 'package:lite/domain/models/models.dart';
import 'package:lite/domain/repositories/repositories.dart';
import 'package:lite/domain/sources/sources.dart';
import 'package:meta/meta.dart';

class BookingRepositoryImpl implements BaseBookingRepository {
  final BaseLocalDatasource _localDatasource;
  final BaseRemoteDatasource _remoteDatasource;

  BookingRepositoryImpl({
    @required BaseLocalDatasource local,
    @required BaseRemoteDatasource remote,
  })  : _localDatasource = local,
        _remoteDatasource = remote;

  @override
  Stream<List<BaseBooking>> bookingsForCustomerAndArtisan(
      {@required String customerId, @required String artisanId}) async* {
    yield* _localDatasource.bookingsForCustomerAndArtisan(
        customerId, artisanId);
    _remoteDatasource
        .bookingsForCustomerAndArtisan(customerId, artisanId)
        .listen((event) async {
      for (var value in event) {
        if (value != null) await _localDatasource.updateBooking(booking: value);
      }
    });
  }

  @override
  Future<void> deleteBooking({BaseBooking booking}) async {
    await _localDatasource.deleteBooking(booking: booking);
    await _remoteDatasource.deleteBooking(booking: booking);
  }

  @override
  Stream<BaseBooking> getBookingById({String id}) async* {
    yield* _localDatasource.getBookingById(id: id);
    _remoteDatasource.getBookingById(id: id).listen((event) async {
      if (event != null) await _localDatasource.updateBooking(booking: event);
    });
  }

  @override
  Stream<List<BaseBooking>> getBookingsByDueDate(
      {String dueDate, String artisanId}) async* {
    yield* _localDatasource.getBookingsByDueDate(
        dueDate: dueDate, artisanId: artisanId);
    _remoteDatasource
        .getBookingsByDueDate(dueDate: dueDate, artisanId: artisanId)
        .listen((event) async {
      for (var value in event) {
        if (value != null) await _localDatasource.updateBooking(booking: value);
      }
    });
  }

  @override
  Future<void> requestBooking(
      {String artisan,
      String customer,
      String category,
      String description,
      String image,
      LocationMetadata metadata}) async {
    await _localDatasource.requestBooking(
      artisan: artisan,
      customer: customer,
      category: category,
      description: description,
      image: image,
      lat: metadata.lat,
      lng: metadata.lng,
    );
    await _remoteDatasource.requestBooking(
      artisan: artisan,
      customer: customer,
      category: category,
      description: description,
      image: image,
      lat: metadata.lat,
      lng: metadata.lng,
    );
  }

  @override
  Future<void> updateBooking({BaseBooking booking}) async {
    await _localDatasource.updateBooking(booking: booking);
    await _remoteDatasource.updateBooking(booking: booking);
  }
}
