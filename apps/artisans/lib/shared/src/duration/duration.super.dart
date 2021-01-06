// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: return_of_invalid_type, constant_identifier_names, prefer_const_constructors_in_immutables, unnecessary_this, sort_unnamed_constructors_first, join_return_with_assignment, missing_return, lines_longer_than_80_chars

part of 'duration.dart';

// **************************************************************************
// SuperEnumGenerator
// **************************************************************************

@immutable
abstract class SnackBarDuration extends Equatable {
  const SnackBarDuration(this._type);

  factory SnackBarDuration.shortLength() = ShortLength.create;

  factory SnackBarDuration.longLength() = LongLength.create;

  factory SnackBarDuration.infiniteLength() = InfiniteLength.create;

  final _SnackBarDuration _type;

  /// The [when] method is the equivalent to pattern matching.
  /// Its prototype depends on the _SnackBarDuration [_type]s defined.
  R when<R extends Object>(
      {@required R Function() shortLength,
      @required R Function() longLength,
      @required R Function() infiniteLength}) {
    assert(() {
      if (shortLength == null || longLength == null || infiniteLength == null) {
        throw 'check for all possible cases';
      }
      return true;
    }());
    switch (this._type) {
      case _SnackBarDuration.ShortLength:
        return shortLength();
      case _SnackBarDuration.LongLength:
        return longLength();
      case _SnackBarDuration.InfiniteLength:
        return infiniteLength();
    }
  }

  /// The [whenOrElse] method is equivalent to [when], but doesn't require
  /// all callbacks to be specified.
  ///
  /// On the other hand, it adds an extra orElse required parameter,
  /// for fallback behavior.
  R whenOrElse<R extends Object>(
      {R Function() shortLength,
      R Function() longLength,
      R Function() infiniteLength,
      @required R Function(SnackBarDuration) orElse}) {
    assert(() {
      if (orElse == null) {
        throw 'Missing orElse case';
      }
      return true;
    }());
    switch (this._type) {
      case _SnackBarDuration.ShortLength:
        if (shortLength == null) break;
        return shortLength();
      case _SnackBarDuration.LongLength:
        if (longLength == null) break;
        return longLength();
      case _SnackBarDuration.InfiniteLength:
        if (infiniteLength == null) break;
        return infiniteLength();
    }
    return orElse(this);
  }

  /// The [whenPartial] method is equivalent to [whenOrElse],
  /// but non-exhaustive.
  void whenPartial(
      {void Function() shortLength,
      void Function() longLength,
      void Function() infiniteLength}) {
    assert(() {
      if (shortLength == null && longLength == null && infiniteLength == null) {
        throw 'provide at least one branch';
      }
      return true;
    }());
    switch (this._type) {
      case _SnackBarDuration.ShortLength:
        if (shortLength == null) break;
        return shortLength();
      case _SnackBarDuration.LongLength:
        if (longLength == null) break;
        return longLength();
      case _SnackBarDuration.InfiniteLength:
        if (infiniteLength == null) break;
        return infiniteLength();
    }
  }

  @override
  List<Object> get props => const [];
}

@immutable
abstract class ShortLength extends SnackBarDuration {
  const ShortLength() : super(_SnackBarDuration.ShortLength);

  factory ShortLength.create() = _ShortLengthImpl;
}

@immutable
class _ShortLengthImpl extends ShortLength {
  const _ShortLengthImpl() : super();

  @override
  String toString() => 'ShortLength()';
}

@immutable
abstract class LongLength extends SnackBarDuration {
  const LongLength() : super(_SnackBarDuration.LongLength);

  factory LongLength.create() = _LongLengthImpl;
}

@immutable
class _LongLengthImpl extends LongLength {
  const _LongLengthImpl() : super();

  @override
  String toString() => 'LongLength()';
}

@immutable
abstract class InfiniteLength extends SnackBarDuration {
  const InfiniteLength() : super(_SnackBarDuration.InfiniteLength);

  factory InfiniteLength.create() = _InfiniteLengthImpl;
}

@immutable
class _InfiniteLengthImpl extends InfiniteLength {
  const _InfiniteLengthImpl() : super();

  @override
  String toString() => 'InfiniteLength()';
}
