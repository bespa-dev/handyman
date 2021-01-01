// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: return_of_invalid_type, constant_identifier_names, prefer_const_constructors_in_immutables, unnecessary_this, sort_unnamed_constructors_first, join_return_with_assignment, missing_return, lines_longer_than_80_chars

part of 'storage.dart';

// **************************************************************************
// SuperEnumGenerator
// **************************************************************************

/// storage progress
@immutable
abstract class StorageProgress extends Equatable {
  const StorageProgress(this._type);

  factory StorageProgress.uploadSuccess({@required String url}) =
      UploadSuccess.create;

  factory StorageProgress.uploadFailed({@required String cause}) =
      UploadFailed.create;

  factory StorageProgress.uploadInProgress() = UploadInProgress.create;

  factory StorageProgress.uploadPaused() = UploadPaused.create;

  final _StorageProgress _type;

  /// The [when] method is the equivalent to pattern matching.
  /// Its prototype depends on the _StorageProgress [_type]s defined.
  R when<R extends Object>(
      {@required R Function(UploadSuccess) uploadSuccess,
      @required R Function(UploadFailed) uploadFailed,
      @required R Function() uploadInProgress,
      @required R Function() uploadPaused}) {
    assert(() {
      if (uploadSuccess == null ||
          uploadFailed == null ||
          uploadInProgress == null ||
          uploadPaused == null) {
        throw 'check for all possible cases';
      }
      return true;
    }());
    switch (this._type) {
      case _StorageProgress.UploadSuccess:
        return uploadSuccess(this as UploadSuccess);
      case _StorageProgress.UploadFailed:
        return uploadFailed(this as UploadFailed);
      case _StorageProgress.UploadInProgress:
        return uploadInProgress();
      case _StorageProgress.UploadPaused:
        return uploadPaused();
    }
  }

  /// The [whenOrElse] method is equivalent to [when], but doesn't require
  /// all callbacks to be specified.
  ///
  /// On the other hand, it adds an extra orElse required parameter,
  /// for fallback behavior.
  R whenOrElse<R extends Object>(
      {R Function(UploadSuccess) uploadSuccess,
      R Function(UploadFailed) uploadFailed,
      R Function() uploadInProgress,
      R Function() uploadPaused,
      @required R Function(StorageProgress) orElse}) {
    assert(() {
      if (orElse == null) {
        throw 'Missing orElse case';
      }
      return true;
    }());
    switch (this._type) {
      case _StorageProgress.UploadSuccess:
        if (uploadSuccess == null) break;
        return uploadSuccess(this as UploadSuccess);
      case _StorageProgress.UploadFailed:
        if (uploadFailed == null) break;
        return uploadFailed(this as UploadFailed);
      case _StorageProgress.UploadInProgress:
        if (uploadInProgress == null) break;
        return uploadInProgress();
      case _StorageProgress.UploadPaused:
        if (uploadPaused == null) break;
        return uploadPaused();
    }
    return orElse(this);
  }

  /// The [whenPartial] method is equivalent to [whenOrElse],
  /// but non-exhaustive.
  void whenPartial(
      {void Function(UploadSuccess) uploadSuccess,
      void Function(UploadFailed) uploadFailed,
      void Function() uploadInProgress,
      void Function() uploadPaused}) {
    assert(() {
      if (uploadSuccess == null &&
          uploadFailed == null &&
          uploadInProgress == null &&
          uploadPaused == null) {
        throw 'provide at least one branch';
      }
      return true;
    }());
    switch (this._type) {
      case _StorageProgress.UploadSuccess:
        if (uploadSuccess == null) break;
        return uploadSuccess(this as UploadSuccess);
      case _StorageProgress.UploadFailed:
        if (uploadFailed == null) break;
        return uploadFailed(this as UploadFailed);
      case _StorageProgress.UploadInProgress:
        if (uploadInProgress == null) break;
        return uploadInProgress();
      case _StorageProgress.UploadPaused:
        if (uploadPaused == null) break;
        return uploadPaused();
    }
  }

  @override
  List<Object> get props => const [];
}

@immutable
abstract class UploadSuccess extends StorageProgress {
  const UploadSuccess({@required this.url})
      : super(_StorageProgress.UploadSuccess);

  factory UploadSuccess.create({@required String url}) = _UploadSuccessImpl;

  final String url;

  /// Creates a copy of this UploadSuccess but with the given fields
  /// replaced with the new values.
  UploadSuccess copyWith({String url});
}

@immutable
class _UploadSuccessImpl extends UploadSuccess {
  const _UploadSuccessImpl({@required this.url}) : super(url: url);

  @override
  final String url;

  @override
  _UploadSuccessImpl copyWith({Object url = superEnum}) => _UploadSuccessImpl(
        url: url == superEnum ? this.url : url as String,
      );
  @override
  String toString() => 'UploadSuccess(url: ${this.url})';
  @override
  List<Object> get props => [url];
}

@immutable
abstract class UploadFailed extends StorageProgress {
  const UploadFailed({@required this.cause})
      : super(_StorageProgress.UploadFailed);

  factory UploadFailed.create({@required String cause}) = _UploadFailedImpl;

  final String cause;

  /// Creates a copy of this UploadFailed but with the given fields
  /// replaced with the new values.
  UploadFailed copyWith({String cause});
}

@immutable
class _UploadFailedImpl extends UploadFailed {
  const _UploadFailedImpl({@required this.cause}) : super(cause: cause);

  @override
  final String cause;

  @override
  _UploadFailedImpl copyWith({Object cause = superEnum}) => _UploadFailedImpl(
        cause: cause == superEnum ? this.cause : cause as String,
      );
  @override
  String toString() => 'UploadFailed(cause: ${this.cause})';
  @override
  List<Object> get props => [cause];
}

@immutable
abstract class UploadInProgress extends StorageProgress {
  const UploadInProgress() : super(_StorageProgress.UploadInProgress);

  factory UploadInProgress.create() = _UploadInProgressImpl;
}

@immutable
class _UploadInProgressImpl extends UploadInProgress {
  const _UploadInProgressImpl() : super();

  @override
  String toString() => 'UploadInProgress()';
}

@immutable
abstract class UploadPaused extends StorageProgress {
  const UploadPaused() : super(_StorageProgress.UploadPaused);

  factory UploadPaused.create() = _UploadPausedImpl;
}

@immutable
class _UploadPausedImpl extends UploadPaused {
  const _UploadPausedImpl() : super();

  @override
  String toString() => 'UploadPaused()';
}
