// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: return_of_invalid_type, constant_identifier_names, prefer_const_constructors_in_immutables, unnecessary_this, sort_unnamed_constructors_first, join_return_with_assignment, missing_return, lines_longer_than_80_chars

part of 'booking_event.dart';

// **************************************************************************
// SuperEnumGenerator
// **************************************************************************

@immutable
abstract class BookingEvent<T> extends Equatable {
  const BookingEvent(this._type);

  factory BookingEvent.observeBookingById({@required String id}) =
      ObserveBookingById<T>.create;

  factory BookingEvent.observeBookingForArtisan({@required String id}) =
      ObserveBookingForArtisan<T>.create;

  factory BookingEvent.observeBookingForCustomer({@required String id}) =
      ObserveBookingForCustomer<T>.create;

  factory BookingEvent.requestBooking(
      {@required String artisan,
      @required String customer,
      @required String category,
      @required String description,
      @required String image,
      @required double cost,
      @required T location}) = RequestBooking<T>.create;

  factory BookingEvent.getBookingByDueDate(
      {@required String dueDate,
      @required String artisan}) = GetBookingByDueDate<T>.create;

  factory BookingEvent.getBookingsForCustomerAndArtisan(
      {@required String customer,
      @required String artisan}) = GetBookingsForCustomerAndArtisan<T>.create;

  factory BookingEvent.deleteBooking({@required T booking}) =
      DeleteBooking<T>.create;

  factory BookingEvent.updateBooking({@required T booking}) =
      UpdateBooking<T>.create;

  final _BookingEvent _type;

  /// The [when] method is the equivalent to pattern matching.
  /// Its prototype depends on the _BookingEvent [_type]s defined.
  R when<R extends Object>(
      {@required
          R Function(ObserveBookingById<T>) observeBookingById,
      @required
          R Function(ObserveBookingForArtisan<T>) observeBookingForArtisan,
      @required
          R Function(ObserveBookingForCustomer<T>) observeBookingForCustomer,
      @required
          R Function(RequestBooking<T>) requestBooking,
      @required
          R Function(GetBookingByDueDate<T>) getBookingByDueDate,
      @required
          R Function(GetBookingsForCustomerAndArtisan<T>)
              getBookingsForCustomerAndArtisan,
      @required
          R Function(DeleteBooking<T>) deleteBooking,
      @required
          R Function(UpdateBooking<T>) updateBooking}) {
    assert(() {
      if (observeBookingById == null ||
          observeBookingForArtisan == null ||
          observeBookingForCustomer == null ||
          requestBooking == null ||
          getBookingByDueDate == null ||
          getBookingsForCustomerAndArtisan == null ||
          deleteBooking == null ||
          updateBooking == null) {
        throw 'check for all possible cases';
      }
      return true;
    }());
    switch (this._type) {
      case _BookingEvent.ObserveBookingById:
        return observeBookingById(this as ObserveBookingById);
      case _BookingEvent.ObserveBookingForArtisan:
        return observeBookingForArtisan(this as ObserveBookingForArtisan);
      case _BookingEvent.ObserveBookingForCustomer:
        return observeBookingForCustomer(this as ObserveBookingForCustomer);
      case _BookingEvent.RequestBooking:
        return requestBooking(this as RequestBooking);
      case _BookingEvent.GetBookingByDueDate:
        return getBookingByDueDate(this as GetBookingByDueDate);
      case _BookingEvent.GetBookingsForCustomerAndArtisan:
        return getBookingsForCustomerAndArtisan(
            this as GetBookingsForCustomerAndArtisan);
      case _BookingEvent.DeleteBooking:
        return deleteBooking(this as DeleteBooking);
      case _BookingEvent.UpdateBooking:
        return updateBooking(this as UpdateBooking);
    }
  }

  /// The [whenOrElse] method is equivalent to [when], but doesn't require
  /// all callbacks to be specified.
  ///
  /// On the other hand, it adds an extra orElse required parameter,
  /// for fallback behavior.
  R whenOrElse<R extends Object>(
      {R Function(ObserveBookingById<T>) observeBookingById,
      R Function(ObserveBookingForArtisan<T>) observeBookingForArtisan,
      R Function(ObserveBookingForCustomer<T>) observeBookingForCustomer,
      R Function(RequestBooking<T>) requestBooking,
      R Function(GetBookingByDueDate<T>) getBookingByDueDate,
      R Function(GetBookingsForCustomerAndArtisan<T>)
          getBookingsForCustomerAndArtisan,
      R Function(DeleteBooking<T>) deleteBooking,
      R Function(UpdateBooking<T>) updateBooking,
      @required R Function(BookingEvent<T>) orElse}) {
    assert(() {
      if (orElse == null) {
        throw 'Missing orElse case';
      }
      return true;
    }());
    switch (this._type) {
      case _BookingEvent.ObserveBookingById:
        if (observeBookingById == null) break;
        return observeBookingById(this as ObserveBookingById);
      case _BookingEvent.ObserveBookingForArtisan:
        if (observeBookingForArtisan == null) break;
        return observeBookingForArtisan(this as ObserveBookingForArtisan);
      case _BookingEvent.ObserveBookingForCustomer:
        if (observeBookingForCustomer == null) break;
        return observeBookingForCustomer(this as ObserveBookingForCustomer);
      case _BookingEvent.RequestBooking:
        if (requestBooking == null) break;
        return requestBooking(this as RequestBooking);
      case _BookingEvent.GetBookingByDueDate:
        if (getBookingByDueDate == null) break;
        return getBookingByDueDate(this as GetBookingByDueDate);
      case _BookingEvent.GetBookingsForCustomerAndArtisan:
        if (getBookingsForCustomerAndArtisan == null) break;
        return getBookingsForCustomerAndArtisan(
            this as GetBookingsForCustomerAndArtisan);
      case _BookingEvent.DeleteBooking:
        if (deleteBooking == null) break;
        return deleteBooking(this as DeleteBooking);
      case _BookingEvent.UpdateBooking:
        if (updateBooking == null) break;
        return updateBooking(this as UpdateBooking);
    }
    return orElse(this);
  }

  /// The [whenPartial] method is equivalent to [whenOrElse],
  /// but non-exhaustive.
  void whenPartial(
      {void Function(ObserveBookingById<T>) observeBookingById,
      void Function(ObserveBookingForArtisan<T>) observeBookingForArtisan,
      void Function(ObserveBookingForCustomer<T>) observeBookingForCustomer,
      void Function(RequestBooking<T>) requestBooking,
      void Function(GetBookingByDueDate<T>) getBookingByDueDate,
      void Function(GetBookingsForCustomerAndArtisan<T>)
          getBookingsForCustomerAndArtisan,
      void Function(DeleteBooking<T>) deleteBooking,
      void Function(UpdateBooking<T>) updateBooking}) {
    assert(() {
      if (observeBookingById == null &&
          observeBookingForArtisan == null &&
          observeBookingForCustomer == null &&
          requestBooking == null &&
          getBookingByDueDate == null &&
          getBookingsForCustomerAndArtisan == null &&
          deleteBooking == null &&
          updateBooking == null) {
        throw 'provide at least one branch';
      }
      return true;
    }());
    switch (this._type) {
      case _BookingEvent.ObserveBookingById:
        if (observeBookingById == null) break;
        return observeBookingById(this as ObserveBookingById);
      case _BookingEvent.ObserveBookingForArtisan:
        if (observeBookingForArtisan == null) break;
        return observeBookingForArtisan(this as ObserveBookingForArtisan);
      case _BookingEvent.ObserveBookingForCustomer:
        if (observeBookingForCustomer == null) break;
        return observeBookingForCustomer(this as ObserveBookingForCustomer);
      case _BookingEvent.RequestBooking:
        if (requestBooking == null) break;
        return requestBooking(this as RequestBooking);
      case _BookingEvent.GetBookingByDueDate:
        if (getBookingByDueDate == null) break;
        return getBookingByDueDate(this as GetBookingByDueDate);
      case _BookingEvent.GetBookingsForCustomerAndArtisan:
        if (getBookingsForCustomerAndArtisan == null) break;
        return getBookingsForCustomerAndArtisan(
            this as GetBookingsForCustomerAndArtisan);
      case _BookingEvent.DeleteBooking:
        if (deleteBooking == null) break;
        return deleteBooking(this as DeleteBooking);
      case _BookingEvent.UpdateBooking:
        if (updateBooking == null) break;
        return updateBooking(this as UpdateBooking);
    }
  }

  @override
  List<Object> get props => const [];
}

@immutable
abstract class ObserveBookingById<T> extends BookingEvent<T> {
  const ObserveBookingById({@required this.id})
      : super(_BookingEvent.ObserveBookingById);

  factory ObserveBookingById.create({@required String id}) =
      _ObserveBookingByIdImpl<T>;

  final String id;

  /// Creates a copy of this ObserveBookingById but with the given fields
  /// replaced with the new values.
  ObserveBookingById<T> copyWith({String id});
}

@immutable
class _ObserveBookingByIdImpl<T> extends ObserveBookingById<T> {
  const _ObserveBookingByIdImpl({@required this.id}) : super(id: id);

  @override
  final String id;

  @override
  _ObserveBookingByIdImpl<T> copyWith({Object id = superEnum}) =>
      _ObserveBookingByIdImpl(
        id: id == superEnum ? this.id : id as String,
      );
  @override
  String toString() => 'ObserveBookingById(id: ${this.id})';
  @override
  List<Object> get props => [id];
}

@immutable
abstract class ObserveBookingForArtisan<T> extends BookingEvent<T> {
  const ObserveBookingForArtisan({@required this.id})
      : super(_BookingEvent.ObserveBookingForArtisan);

  factory ObserveBookingForArtisan.create({@required String id}) =
      _ObserveBookingForArtisanImpl<T>;

  final String id;

  /// Creates a copy of this ObserveBookingForArtisan but with the given fields
  /// replaced with the new values.
  ObserveBookingForArtisan<T> copyWith({String id});
}

@immutable
class _ObserveBookingForArtisanImpl<T> extends ObserveBookingForArtisan<T> {
  const _ObserveBookingForArtisanImpl({@required this.id}) : super(id: id);

  @override
  final String id;

  @override
  _ObserveBookingForArtisanImpl<T> copyWith({Object id = superEnum}) =>
      _ObserveBookingForArtisanImpl(
        id: id == superEnum ? this.id : id as String,
      );
  @override
  String toString() => 'ObserveBookingForArtisan(id: ${this.id})';
  @override
  List<Object> get props => [id];
}

@immutable
abstract class ObserveBookingForCustomer<T> extends BookingEvent<T> {
  const ObserveBookingForCustomer({@required this.id})
      : super(_BookingEvent.ObserveBookingForCustomer);

  factory ObserveBookingForCustomer.create({@required String id}) =
      _ObserveBookingForCustomerImpl<T>;

  final String id;

  /// Creates a copy of this ObserveBookingForCustomer but with the given fields
  /// replaced with the new values.
  ObserveBookingForCustomer<T> copyWith({String id});
}

@immutable
class _ObserveBookingForCustomerImpl<T> extends ObserveBookingForCustomer<T> {
  const _ObserveBookingForCustomerImpl({@required this.id}) : super(id: id);

  @override
  final String id;

  @override
  _ObserveBookingForCustomerImpl<T> copyWith({Object id = superEnum}) =>
      _ObserveBookingForCustomerImpl(
        id: id == superEnum ? this.id : id as String,
      );
  @override
  String toString() => 'ObserveBookingForCustomer(id: ${this.id})';
  @override
  List<Object> get props => [id];
}

@immutable
abstract class RequestBooking<T> extends BookingEvent<T> {
  const RequestBooking(
      {@required this.artisan,
      @required this.customer,
      @required this.category,
      @required this.description,
      @required this.image,
      @required this.cost,
      @required this.location})
      : super(_BookingEvent.RequestBooking);

  factory RequestBooking.create(
      {@required String artisan,
      @required String customer,
      @required String category,
      @required String description,
      @required String image,
      @required double cost,
      @required T location}) = _RequestBookingImpl<T>;

  final String artisan;

  final String customer;

  final String category;

  final String description;

  final String image;

  final double cost;

  final T location;

  /// Creates a copy of this RequestBooking but with the given fields
  /// replaced with the new values.
  RequestBooking<T> copyWith(
      {String artisan,
      String customer,
      String category,
      String description,
      String image,
      double cost,
      T location});
}

@immutable
class _RequestBookingImpl<T> extends RequestBooking<T> {
  const _RequestBookingImpl(
      {@required this.artisan,
      @required this.customer,
      @required this.category,
      @required this.description,
      @required this.image,
      @required this.cost,
      @required this.location})
      : super(
            artisan: artisan,
            customer: customer,
            category: category,
            description: description,
            image: image,
            cost: cost,
            location: location);

  @override
  final String artisan;

  @override
  final String customer;

  @override
  final String category;

  @override
  final String description;

  @override
  final String image;

  @override
  final double cost;

  @override
  final T location;

  @override
  _RequestBookingImpl<T> copyWith(
          {Object artisan = superEnum,
          Object customer = superEnum,
          Object category = superEnum,
          Object description = superEnum,
          Object image = superEnum,
          Object cost = superEnum,
          Object location = superEnum}) =>
      _RequestBookingImpl(
        artisan: artisan == superEnum ? this.artisan : artisan as String,
        customer: customer == superEnum ? this.customer : customer as String,
        category: category == superEnum ? this.category : category as String,
        description:
            description == superEnum ? this.description : description as String,
        image: image == superEnum ? this.image : image as String,
        cost: cost == superEnum ? this.cost : cost as double,
        location: location == superEnum ? this.location : location as T,
      );
  @override
  String toString() =>
      'RequestBooking(artisan: ${this.artisan}, customer: ${this.customer}, category: ${this.category}, description: ${this.description}, image: ${this.image}, cost: ${this.cost}, location: ${this.location})';
  @override
  List<Object> get props =>
      [artisan, customer, category, description, image, cost, location];
}

@immutable
abstract class GetBookingByDueDate<T> extends BookingEvent<T> {
  const GetBookingByDueDate({@required this.dueDate, @required this.artisan})
      : super(_BookingEvent.GetBookingByDueDate);

  factory GetBookingByDueDate.create(
      {@required String dueDate,
      @required String artisan}) = _GetBookingByDueDateImpl<T>;

  final String dueDate;

  final String artisan;

  /// Creates a copy of this GetBookingByDueDate but with the given fields
  /// replaced with the new values.
  GetBookingByDueDate<T> copyWith({String dueDate, String artisan});
}

@immutable
class _GetBookingByDueDateImpl<T> extends GetBookingByDueDate<T> {
  const _GetBookingByDueDateImpl(
      {@required this.dueDate, @required this.artisan})
      : super(dueDate: dueDate, artisan: artisan);

  @override
  final String dueDate;

  @override
  final String artisan;

  @override
  _GetBookingByDueDateImpl<T> copyWith(
          {Object dueDate = superEnum, Object artisan = superEnum}) =>
      _GetBookingByDueDateImpl(
        dueDate: dueDate == superEnum ? this.dueDate : dueDate as String,
        artisan: artisan == superEnum ? this.artisan : artisan as String,
      );
  @override
  String toString() =>
      'GetBookingByDueDate(dueDate: ${this.dueDate}, artisan: ${this.artisan})';
  @override
  List<Object> get props => [dueDate, artisan];
}

@immutable
abstract class GetBookingsForCustomerAndArtisan<T> extends BookingEvent<T> {
  const GetBookingsForCustomerAndArtisan(
      {@required this.customer, @required this.artisan})
      : super(_BookingEvent.GetBookingsForCustomerAndArtisan);

  factory GetBookingsForCustomerAndArtisan.create(
      {@required String customer,
      @required String artisan}) = _GetBookingsForCustomerAndArtisanImpl<T>;

  final String customer;

  final String artisan;

  /// Creates a copy of this GetBookingsForCustomerAndArtisan but with the given fields
  /// replaced with the new values.
  GetBookingsForCustomerAndArtisan<T> copyWith(
      {String customer, String artisan});
}

@immutable
class _GetBookingsForCustomerAndArtisanImpl<T>
    extends GetBookingsForCustomerAndArtisan<T> {
  const _GetBookingsForCustomerAndArtisanImpl(
      {@required this.customer, @required this.artisan})
      : super(customer: customer, artisan: artisan);

  @override
  final String customer;

  @override
  final String artisan;

  @override
  _GetBookingsForCustomerAndArtisanImpl<T> copyWith(
          {Object customer = superEnum, Object artisan = superEnum}) =>
      _GetBookingsForCustomerAndArtisanImpl(
        customer: customer == superEnum ? this.customer : customer as String,
        artisan: artisan == superEnum ? this.artisan : artisan as String,
      );
  @override
  String toString() =>
      'GetBookingsForCustomerAndArtisan(customer: ${this.customer}, artisan: ${this.artisan})';
  @override
  List<Object> get props => [customer, artisan];
}

@immutable
abstract class DeleteBooking<T> extends BookingEvent<T> {
  const DeleteBooking({@required this.booking})
      : super(_BookingEvent.DeleteBooking);

  factory DeleteBooking.create({@required T booking}) = _DeleteBookingImpl<T>;

  final T booking;

  /// Creates a copy of this DeleteBooking but with the given fields
  /// replaced with the new values.
  DeleteBooking<T> copyWith({T booking});
}

@immutable
class _DeleteBookingImpl<T> extends DeleteBooking<T> {
  const _DeleteBookingImpl({@required this.booking}) : super(booking: booking);

  @override
  final T booking;

  @override
  _DeleteBookingImpl<T> copyWith({Object booking = superEnum}) =>
      _DeleteBookingImpl(
        booking: booking == superEnum ? this.booking : booking as T,
      );
  @override
  String toString() => 'DeleteBooking(booking: ${this.booking})';
  @override
  List<Object> get props => [booking];
}

@immutable
abstract class UpdateBooking<T> extends BookingEvent<T> {
  const UpdateBooking({@required this.booking})
      : super(_BookingEvent.UpdateBooking);

  factory UpdateBooking.create({@required T booking}) = _UpdateBookingImpl<T>;

  final T booking;

  /// Creates a copy of this UpdateBooking but with the given fields
  /// replaced with the new values.
  UpdateBooking<T> copyWith({T booking});
}

@immutable
class _UpdateBookingImpl<T> extends UpdateBooking<T> {
  const _UpdateBookingImpl({@required this.booking}) : super(booking: booking);

  @override
  final T booking;

  @override
  _UpdateBookingImpl<T> copyWith({Object booking = superEnum}) =>
      _UpdateBookingImpl(
        booking: booking == superEnum ? this.booking : booking as T,
      );
  @override
  String toString() => 'UpdateBooking(booking: ${this.booking})';
  @override
  List<Object> get props => [booking];
}
