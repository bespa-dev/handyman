// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: return_of_invalid_type, constant_identifier_names, prefer_const_constructors_in_immutables, unnecessary_this, sort_unnamed_constructors_first, join_return_with_assignment, missing_return, lines_longer_than_80_chars

part of 'storage_event.dart';

// **************************************************************************
// SuperEnumGenerator
// **************************************************************************

@immutable
abstract class StorageEvent extends Equatable {
  const StorageEvent(this._type);

  factory StorageEvent.uploadFile(
      {@required String path,
      @required String filePath,
      @required bool isImage}) = UploadFile.create;

  final _StorageEvent _type;

  /// The [when] method is the equivalent to pattern matching.
  /// Its prototype depends on the _StorageEvent [_type]s defined.
  R when<R extends Object>({@required R Function(UploadFile) uploadFile}) {
    assert(() {
      if (uploadFile == null) {
        throw 'check for all possible cases';
      }
      return true;
    }());
    switch (this._type) {
      case _StorageEvent.UploadFile:
        return uploadFile(this as UploadFile);
    }
  }

  /// The [whenOrElse] method is equivalent to [when], but doesn't require
  /// all callbacks to be specified.
  ///
  /// On the other hand, it adds an extra orElse required parameter,
  /// for fallback behavior.
  R whenOrElse<R extends Object>(
      {R Function(UploadFile) uploadFile,
      @required R Function(StorageEvent) orElse}) {
    assert(() {
      if (orElse == null) {
        throw 'Missing orElse case';
      }
      return true;
    }());
    switch (this._type) {
      case _StorageEvent.UploadFile:
        if (uploadFile == null) break;
        return uploadFile(this as UploadFile);
    }
    return orElse(this);
  }

  /// The [whenPartial] method is equivalent to [whenOrElse],
  /// but non-exhaustive.
  void whenPartial({void Function(UploadFile) uploadFile}) {
    assert(() {
      if (uploadFile == null) {
        throw 'provide at least one branch';
      }
      return true;
    }());
    switch (this._type) {
      case _StorageEvent.UploadFile:
        if (uploadFile == null) break;
        return uploadFile(this as UploadFile);
    }
  }

  @override
  List<Object> get props => const [];
}

@immutable
abstract class UploadFile extends StorageEvent {
  const UploadFile(
      {@required this.path, @required this.filePath, @required this.isImage})
      : super(_StorageEvent.UploadFile);

  factory UploadFile.create(
      {@required String path,
      @required String filePath,
      @required bool isImage}) = _UploadFileImpl;

  final String path;

  final String filePath;

  final bool isImage;

  /// Creates a copy of this UploadFile but with the given fields
  /// replaced with the new values.
  UploadFile copyWith({String path, String filePath, bool isImage});
}

@immutable
class _UploadFileImpl extends UploadFile {
  const _UploadFileImpl(
      {@required this.path, @required this.filePath, @required this.isImage})
      : super(path: path, filePath: filePath, isImage: isImage);

  @override
  final String path;

  @override
  final String filePath;

  @override
  final bool isImage;

  @override
  _UploadFileImpl copyWith(
          {Object path = superEnum,
          Object filePath = superEnum,
          Object isImage = superEnum}) =>
      _UploadFileImpl(
        path: path == superEnum ? this.path : path as String,
        filePath: filePath == superEnum ? this.filePath : filePath as String,
        isImage: isImage == superEnum ? this.isImage : isImage as bool,
      );
  @override
  String toString() =>
      'UploadFile(path: ${this.path}, filePath: ${this.filePath}, isImage: ${this.isImage})';
  @override
  List<Object> get props => [path, filePath, isImage];
}
