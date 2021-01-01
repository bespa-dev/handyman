// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: return_of_invalid_type, constant_identifier_names, prefer_const_constructors_in_immutables, unnecessary_this, sort_unnamed_constructors_first, join_return_with_assignment, missing_return, lines_longer_than_80_chars

part of 'payload.dart';

// **************************************************************************
// SuperEnumGenerator
// **************************************************************************

/// payload type for notification grouping
@immutable
abstract class PayloadType extends Equatable {
  const PayloadType(this._type);

  factory PayloadType.conversationPayload() = ConversationPayload.create;

  factory PayloadType.bookingPayload() = BookingPayload.create;

  final _PayloadType _type;

  /// The [when] method is the equivalent to pattern matching.
  /// Its prototype depends on the _PayloadType [_type]s defined.
  R when<R extends Object>(
      {@required R Function() conversationPayload,
      @required R Function() bookingPayload}) {
    assert(() {
      if (conversationPayload == null || bookingPayload == null) {
        throw 'check for all possible cases';
      }
      return true;
    }());
    switch (this._type) {
      case _PayloadType.ConversationPayload:
        return conversationPayload();
      case _PayloadType.BookingPayload:
        return bookingPayload();
    }
  }

  /// The [whenOrElse] method is equivalent to [when], but doesn't require
  /// all callbacks to be specified.
  ///
  /// On the other hand, it adds an extra orElse required parameter,
  /// for fallback behavior.
  R whenOrElse<R extends Object>(
      {R Function() conversationPayload,
      R Function() bookingPayload,
      @required R Function(PayloadType) orElse}) {
    assert(() {
      if (orElse == null) {
        throw 'Missing orElse case';
      }
      return true;
    }());
    switch (this._type) {
      case _PayloadType.ConversationPayload:
        if (conversationPayload == null) break;
        return conversationPayload();
      case _PayloadType.BookingPayload:
        if (bookingPayload == null) break;
        return bookingPayload();
    }
    return orElse(this);
  }

  /// The [whenPartial] method is equivalent to [whenOrElse],
  /// but non-exhaustive.
  void whenPartial(
      {void Function() conversationPayload, void Function() bookingPayload}) {
    assert(() {
      if (conversationPayload == null && bookingPayload == null) {
        throw 'provide at least one branch';
      }
      return true;
    }());
    switch (this._type) {
      case _PayloadType.ConversationPayload:
        if (conversationPayload == null) break;
        return conversationPayload();
      case _PayloadType.BookingPayload:
        if (bookingPayload == null) break;
        return bookingPayload();
    }
  }

  @override
  List<Object> get props => const [];
}

@immutable
abstract class ConversationPayload extends PayloadType {
  const ConversationPayload() : super(_PayloadType.ConversationPayload);

  factory ConversationPayload.create() = _ConversationPayloadImpl;
}

@immutable
class _ConversationPayloadImpl extends ConversationPayload {
  const _ConversationPayloadImpl() : super();

  @override
  String toString() => 'ConversationPayload()';
}

@immutable
abstract class BookingPayload extends PayloadType {
  const BookingPayload() : super(_PayloadType.BookingPayload);

  factory BookingPayload.create() = _BookingPayloadImpl;
}

@immutable
class _BookingPayloadImpl extends BookingPayload {
  const _BookingPayloadImpl() : super();

  @override
  String toString() => 'BookingPayload()';
}
