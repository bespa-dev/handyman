// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: return_of_invalid_type, constant_identifier_names, prefer_const_constructors_in_immutables, unnecessary_this, sort_unnamed_constructors_first, join_return_with_assignment, missing_return, lines_longer_than_80_chars

part of 'booking.dart';

// **************************************************************************
// SuperEnumGenerator
// **************************************************************************

@immutable
abstract class BookingState extends Equatable {
  const BookingState(this._type);

  factory BookingState.complete() = Complete.create;

  factory BookingState.pending() = Pending.create;

  factory BookingState.cancelled() = Cancelled.create;

  final _BookingState _type;

  /// The [when] method is the equivalent to pattern matching.
  /// Its prototype depends on the _BookingState [_type]s defined.
  R when<R extends Object>(
      {@required R Function() complete,
      @required R Function() pending,
      @required R Function() cancelled}) {
    assert(() {
      if (complete == null || pending == null || cancelled == null) {
        throw 'check for all possible cases';
      }
      return true;
    }());
    switch (this._type) {
      case _BookingState.Complete:
        return complete();
      case _BookingState.Pending:
        return pending();
      case _BookingState.Cancelled:
        return cancelled();
    }
  }

  /// The [whenOrElse] method is equivalent to [when], but doesn't require
  /// all callbacks to be specified.
  ///
  /// On the other hand, it adds an extra orElse required parameter,
  /// for fallback behavior.
  R whenOrElse<R extends Object>(
      {R Function() complete,
      R Function() pending,
      R Function() cancelled,
      @required R Function(BookingState) orElse}) {
    assert(() {
      if (orElse == null) {
        throw 'Missing orElse case';
      }
      return true;
    }());
    switch (this._type) {
      case _BookingState.Complete:
        if (complete == null) break;
        return complete();
      case _BookingState.Pending:
        if (pending == null) break;
        return pending();
      case _BookingState.Cancelled:
        if (cancelled == null) break;
        return cancelled();
    }
    return orElse(this);
  }

  /// The [whenPartial] method is equivalent to [whenOrElse],
  /// but non-exhaustive.
  void whenPartial(
      {void Function() complete,
      void Function() pending,
      void Function() cancelled}) {
    assert(() {
      if (complete == null && pending == null && cancelled == null) {
        throw 'provide at least one branch';
      }
      return true;
    }());
    switch (this._type) {
      case _BookingState.Complete:
        if (complete == null) break;
        return complete();
      case _BookingState.Pending:
        if (pending == null) break;
        return pending();
      case _BookingState.Cancelled:
        if (cancelled == null) break;
        return cancelled();
    }
  }

  @override
  List<Object> get props => const [];
}

@immutable
abstract class Complete extends BookingState {
  const Complete() : super(_BookingState.Complete);

  factory Complete.create() = _CompleteImpl;
}

@immutable
class _CompleteImpl extends Complete {
  const _CompleteImpl() : super();

  @override
  String toString() => 'Complete()';
}

@immutable
abstract class Pending extends BookingState {
  const Pending() : super(_BookingState.Pending);

  factory Pending.create() = _PendingImpl;
}

@immutable
class _PendingImpl extends Pending {
  const _PendingImpl() : super();

  @override
  String toString() => 'Pending()';
}

@immutable
abstract class Cancelled extends BookingState {
  const Cancelled() : super(_BookingState.Cancelled);

  factory Cancelled.create() = _CancelledImpl;
}

@immutable
class _CancelledImpl extends Cancelled {
  const _CancelledImpl() : super();

  @override
  String toString() => 'Cancelled()';
}
