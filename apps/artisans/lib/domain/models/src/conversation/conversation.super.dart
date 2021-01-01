// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: return_of_invalid_type, constant_identifier_names, prefer_const_constructors_in_immutables, unnecessary_this, sort_unnamed_constructors_first, join_return_with_assignment, missing_return, lines_longer_than_80_chars

part of 'conversation.dart';

// **************************************************************************
// SuperEnumGenerator
// **************************************************************************

@immutable
abstract class ConversationFormat extends Equatable {
  const ConversationFormat(this._type);

  factory ConversationFormat.textFormat() = TextFormat.create;

  factory ConversationFormat.imageFormat() = ImageFormat.create;

  final _ConversationFormat _type;

  /// The [when] method is the equivalent to pattern matching.
  /// Its prototype depends on the _ConversationFormat [_type]s defined.
  R when<R extends Object>(
      {@required R Function() textFormat, @required R Function() imageFormat}) {
    assert(() {
      if (textFormat == null || imageFormat == null) {
        throw 'check for all possible cases';
      }
      return true;
    }());
    switch (this._type) {
      case _ConversationFormat.TextFormat:
        return textFormat();
      case _ConversationFormat.ImageFormat:
        return imageFormat();
    }
  }

  /// The [whenOrElse] method is equivalent to [when], but doesn't require
  /// all callbacks to be specified.
  ///
  /// On the other hand, it adds an extra orElse required parameter,
  /// for fallback behavior.
  R whenOrElse<R extends Object>(
      {R Function() textFormat,
      R Function() imageFormat,
      @required R Function(ConversationFormat) orElse}) {
    assert(() {
      if (orElse == null) {
        throw 'Missing orElse case';
      }
      return true;
    }());
    switch (this._type) {
      case _ConversationFormat.TextFormat:
        if (textFormat == null) break;
        return textFormat();
      case _ConversationFormat.ImageFormat:
        if (imageFormat == null) break;
        return imageFormat();
    }
    return orElse(this);
  }

  /// The [whenPartial] method is equivalent to [whenOrElse],
  /// but non-exhaustive.
  void whenPartial({void Function() textFormat, void Function() imageFormat}) {
    assert(() {
      if (textFormat == null && imageFormat == null) {
        throw 'provide at least one branch';
      }
      return true;
    }());
    switch (this._type) {
      case _ConversationFormat.TextFormat:
        if (textFormat == null) break;
        return textFormat();
      case _ConversationFormat.ImageFormat:
        if (imageFormat == null) break;
        return imageFormat();
    }
  }

  @override
  List<Object> get props => const [];
}

@immutable
abstract class TextFormat extends ConversationFormat {
  const TextFormat() : super(_ConversationFormat.TextFormat);

  factory TextFormat.create() = _TextFormatImpl;
}

@immutable
class _TextFormatImpl extends TextFormat {
  const _TextFormatImpl() : super();

  @override
  String toString() => 'TextFormat()';
}

@immutable
abstract class ImageFormat extends ConversationFormat {
  const ImageFormat() : super(_ConversationFormat.ImageFormat);

  factory ImageFormat.create() = _ImageFormatImpl;
}

@immutable
class _ImageFormatImpl extends ImageFormat {
  const _ImageFormatImpl() : super();

  @override
  String toString() => 'ImageFormat()';
}
