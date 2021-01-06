// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: return_of_invalid_type, constant_identifier_names, prefer_const_constructors_in_immutables, unnecessary_this, sort_unnamed_constructors_first, join_return_with_assignment, missing_return, lines_longer_than_80_chars

part of 'storage_event.dart';

// **************************************************************************
// SuperEnumGenerator
// **************************************************************************

@immutable
abstract class StorageEvent<T> extends Equatable {
  const StorageEvent(this._type);

  factory StorageEvent.uploadFile({@required T file}) = UploadFile<T>.create;

  final _StorageEvent _type;

  /// The [when] method is the equivalent to pattern matching.
  /// Its prototype depends on the _StorageEvent [_type]s defined.
  R when<R extends Object>({@required R Function(UploadFile<T>) uploadFile}) {
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
      {R Function(UploadFile<T>) uploadFile,
      @required R Function(StorageEvent<T>) orElse}) {
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
  void whenPartial({void Function(UploadFile<T>) uploadFile}) {
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
abstract class UploadFile<T> extends StorageEvent<T> {
  const UploadFile({@required this.file}) : super(_StorageEvent.UploadFile);

  factory UploadFile.create({@required T file}) = _UploadFileImpl<T>;

  final T file;

  /// Creates a copy of this UploadFile but with the given fields
  /// replaced with the new values.
  UploadFile<T> copyWith({T file});
}

@immutable
class _UploadFileImpl<T> extends UploadFile<T> {
  const _UploadFileImpl({@required this.file}) : super(file: file);

  @override
  final T file;

  @override
  _UploadFileImpl<T> copyWith({Object file = superEnum}) => _UploadFileImpl(
        file: file == superEnum ? this.file : file as T,
      );
  @override
  String toString() => 'UploadFile(file: ${this.file})';
  @override
  List<Object> get props => [file];
}
