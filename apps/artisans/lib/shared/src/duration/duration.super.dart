// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: return_of_invalid_type, constant_identifier_names, prefer_const_constructors_in_immutables, unnecessary_this, sort_unnamed_constructors_first, join_return_with_assignment, missing_return, lines_longer_than_80_chars

part of 'duration.dart';

// **************************************************************************
// SuperEnumGenerator
// **************************************************************************

@immutable
abstract class SnackBarDuration extends Equatable {
  const SnackBarDuration(this._type);

  factory SnackBarDuration.shortLength() = shortLength.create;

  factory SnackBarDuration.longLength() = longLength.create;

  factory SnackBarDuration.infiniteLength() = infiniteLength.create;

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
      case _SnackBarDuration.shortLength:
        return shortLength();
      case _SnackBarDuration.longLength:
        return longLength();
      case _SnackBarDuration.infiniteLength:
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
      case _SnackBarDuration.shortLength:
        if (shortLength == null) break;
        return shortLength();
      case _SnackBarDuration.longLength:
        if (longLength == null) break;
        return longLength();
      case _SnackBarDuration.infiniteLength:
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
      case _SnackBarDuration.shortLength:
        if (shortLength == null) break;
        return shortLength();
      case _SnackBarDuration.longLength:
        if (longLength == null) break;
        return longLength();
      case _SnackBarDuration.infiniteLength:
        if (infiniteLength == null) break;
        return infiniteLength();
    }
  }

  @override
  List<Object> get props => const [];
}

@immutable
abstract class shortLength extends SnackBarDuration {
  const shortLength() : super(_SnackBarDuration.shortLength);

  factory shortLength.create() = _shortLengthImpl;
}

@immutable
class _shortLengthImpl extends shortLength {
  const _shortLengthImpl() : super();

  @override
  String toString() => 'shortLength()';
}

@immutable
abstract class longLength extends SnackBarDuration {
  const longLength() : super(_SnackBarDuration.longLength);

  factory longLength.create() = _longLengthImpl;
}

@immutable
class _longLengthImpl extends longLength {
  const _longLengthImpl() : super();

  @override
  String toString() => 'longLength()';
}

@immutable
abstract class infiniteLength extends SnackBarDuration {
  const infiniteLength() : super(_SnackBarDuration.infiniteLength);

  factory infiniteLength.create() = _infiniteLengthImpl;
}

@immutable
class _infiniteLengthImpl extends infiniteLength {
  const _infiniteLengthImpl() : super();

  @override
  String toString() => 'infiniteLength()';
}
