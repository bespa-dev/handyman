/*
 * Copyright (c) 2021.
 * This application is owned by HandyMan LLC,
 * developed & designed by Quabynah Codelabs LLC.
 *
 *
 * author: codelbas.quabynah@gmail.com
 */

import 'package:handyman/domain/models/models.dart';
import 'package:handyman/domain/repositories/repositories.dart';
import 'package:meta/meta.dart';

import 'usecase/result.dart';
import 'usecase/usecase.dart';

class ObserveBookingForArtisanUseCase
    extends ObservableUseCase<List<BaseBooking>, String> {
  final BaseBookingRepository _repo;

  const ObserveBookingForArtisanUseCase(this._repo);

  @override
  Future<UseCaseResult<Stream<List<BaseBooking>>>> execute(String id) async {
    try {
      var stream = _repo.observeBookingsForArtisan(id);
      return UseCaseResult<Stream<List<BaseBooking>>>.success(
          stream.asBroadcastStream());
    } on Exception {
      return UseCaseResult.error("Cannot get booking by id -> $id");
    }
  }
}

class ObserveBookingForCustomerUseCase
    extends ObservableUseCase<List<BaseBooking>, String> {
  final BaseBookingRepository _repo;

  const ObserveBookingForCustomerUseCase(this._repo);

  @override
  Future<UseCaseResult<Stream<List<BaseBooking>>>> execute(String id) async {
    try {
      var stream = _repo.observeBookingsForCustomer(id);
      return UseCaseResult<Stream<List<BaseBooking>>>.success(
          stream.asBroadcastStream());
    } on Exception {
      return UseCaseResult.error("Cannot get booking by id -> $id");
    }
  }
}

class ObserveBookingByIdUseCase extends ObservableUseCase<BaseBooking, String> {
  final BaseBookingRepository _repo;

  const ObserveBookingByIdUseCase(this._repo);

  @override
  Future<UseCaseResult<Stream<BaseBooking>>> execute(String id) async {
    try {
      var stream = _repo.getBookingById(id: id);
      return UseCaseResult<Stream<BaseBooking>>.success(
          stream.asBroadcastStream());
    } on Exception {
      return UseCaseResult.error("Cannot get booking by id -> $id");
    }
  }
}

class GetBookingsByDueDateUseCase
    extends ObservableUseCase<List<BaseBooking>, GetBookingsByDueDateParams> {
  final BaseBookingRepository _repo;

  const GetBookingsByDueDateUseCase(this._repo);

  @override
  Future<UseCaseResult<Stream<List<BaseBooking>>>> execute(
      GetBookingsByDueDateParams params) async {
    try {
      var stream = _repo.getBookingsByDueDate(
          dueDate: params.dueDate, artisanId: params.artisanId);
      return UseCaseResult<Stream<List<BaseBooking>>>.success(
          stream.asBroadcastStream());
    } on Exception {
      return UseCaseResult.error(
          "Cannot get booking by due date with params -> $params");
    }
  }
}

class RequestBookingUseCase extends CompletableUseCase<RequestBookingParams> {
  final BaseBookingRepository _repo;

  const RequestBookingUseCase(this._repo);

  @override
  Future<UseCaseResult<void>> execute(RequestBookingParams params) async {
    try {
      await _repo.requestBooking(
        artisan: params.artisan,
        customer: params.customer,
        category: params.category,
        description: params.description,
        image: params.image,
        metadata: params.metadata,
      );
      return UseCaseResult.success();
    } on Exception {
      return UseCaseResult.error(
          "Cannot request a booking with params -> $params");
    }
  }
}

class UpdateBookingUseCase extends CompletableUseCase<BaseBooking> {
  final BaseBookingRepository _repo;

  UpdateBookingUseCase(this._repo);

  @override
  Future<UseCaseResult<void>> execute(BaseBooking booking) async {
    try {
      await _repo.updateBooking(booking: booking);
      return UseCaseResult.success();
    } on Exception {
      return UseCaseResult.error("Failed to update booking");
    }
  }
}

class DeleteBookingUseCase extends CompletableUseCase<BaseBooking> {
  final BaseBookingRepository _repo;

  DeleteBookingUseCase(this._repo);

  @override
  Future<UseCaseResult<void>> execute(BaseBooking booking) async {
    try {
      await _repo.deleteBooking(booking: booking);
      return UseCaseResult.success();
    } on Exception {
      return UseCaseResult.error("Failed to update booking");
    }
  }
}

class BookingsForCustomerAndArtisanUseCase extends ObservableUseCase<
    List<BaseBooking>, BookingsForCustomerAndArtisanParams> {
  final BaseBookingRepository _repo;

  const BookingsForCustomerAndArtisanUseCase(this._repo);

  @override
  Future<UseCaseResult<Stream<List<BaseBooking>>>> execute(
      BookingsForCustomerAndArtisanParams params) async {
    try {
      var stream = _repo.bookingsForCustomerAndArtisan(
          customerId: params.customer, artisanId: params.artisan);
      return UseCaseResult<Stream<List<BaseBooking>>>.success(
          stream.asBroadcastStream());
    } on Exception {
      return UseCaseResult.error(
          "Failed to get bookings for customer -> ${params.customer} & artisan -> ${params.artisan}");
    }
  }
}

/// params
class GetBookingsByDueDateParams {
  final String dueDate;
  final String artisanId;

  const GetBookingsByDueDateParams(
      {@required this.dueDate, @required this.artisanId});
}

/// params
class RequestBookingParams {
  final String artisan;
  final String customer;
  final String category;
  final String description;
  final String image;
  final BaseLocationMetadata metadata;

  const RequestBookingParams({
    this.artisan,
    this.customer,
    this.category,
    this.description,
    this.image,
    this.metadata,
  });
}

/// params
class BookingsForCustomerAndArtisanParams {
  final String customer;
  final String artisan;

  const BookingsForCustomerAndArtisanParams({
    this.customer,
    this.artisan,
  });
}
