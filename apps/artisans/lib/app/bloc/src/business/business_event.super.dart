// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: return_of_invalid_type, constant_identifier_names, prefer_const_constructors_in_immutables, unnecessary_this, sort_unnamed_constructors_first, join_return_with_assignment, missing_return, lines_longer_than_80_chars

part of 'business_event.dart';

// **************************************************************************
// SuperEnumGenerator
// **************************************************************************

@immutable
abstract class BusinessEvent<T> extends Equatable {
  const BusinessEvent(this._type);

  factory BusinessEvent.getBusinessesForArtisan({@required String artisanId}) =
      GetBusinessesForArtisan<T>.create;

  factory BusinessEvent.getBusinessById({@required String id}) =
      GetBusinessById<T>.create;

  factory BusinessEvent.uploadBusiness({@required T params}) =
      UploadBusiness<T>.create;

  final _BusinessEvent _type;

  /// The [when] method is the equivalent to pattern matching.
  /// Its prototype depends on the _BusinessEvent [_type]s defined.
  R when<R extends Object>(
      {@required R Function(GetBusinessesForArtisan<T>) getBusinessesForArtisan,
      @required R Function(GetBusinessById<T>) getBusinessById,
      @required R Function(UploadBusiness<T>) uploadBusiness}) {
    assert(() {
      if (getBusinessesForArtisan == null ||
          getBusinessById == null ||
          uploadBusiness == null) {
        throw 'check for all possible cases';
      }
      return true;
    }());
    switch (this._type) {
      case _BusinessEvent.GetBusinessesForArtisan:
        return getBusinessesForArtisan(this as GetBusinessesForArtisan);
      case _BusinessEvent.GetBusinessById:
        return getBusinessById(this as GetBusinessById);
      case _BusinessEvent.UploadBusiness:
        return uploadBusiness(this as UploadBusiness);
    }
  }

  /// The [whenOrElse] method is equivalent to [when], but doesn't require
  /// all callbacks to be specified.
  ///
  /// On the other hand, it adds an extra orElse required parameter,
  /// for fallback behavior.
  R whenOrElse<R extends Object>(
      {R Function(GetBusinessesForArtisan<T>) getBusinessesForArtisan,
      R Function(GetBusinessById<T>) getBusinessById,
      R Function(UploadBusiness<T>) uploadBusiness,
      @required R Function(BusinessEvent<T>) orElse}) {
    assert(() {
      if (orElse == null) {
        throw 'Missing orElse case';
      }
      return true;
    }());
    switch (this._type) {
      case _BusinessEvent.GetBusinessesForArtisan:
        if (getBusinessesForArtisan == null) break;
        return getBusinessesForArtisan(this as GetBusinessesForArtisan);
      case _BusinessEvent.GetBusinessById:
        if (getBusinessById == null) break;
        return getBusinessById(this as GetBusinessById);
      case _BusinessEvent.UploadBusiness:
        if (uploadBusiness == null) break;
        return uploadBusiness(this as UploadBusiness);
    }
    return orElse(this);
  }

  /// The [whenPartial] method is equivalent to [whenOrElse],
  /// but non-exhaustive.
  void whenPartial(
      {void Function(GetBusinessesForArtisan<T>) getBusinessesForArtisan,
      void Function(GetBusinessById<T>) getBusinessById,
      void Function(UploadBusiness<T>) uploadBusiness}) {
    assert(() {
      if (getBusinessesForArtisan == null &&
          getBusinessById == null &&
          uploadBusiness == null) {
        throw 'provide at least one branch';
      }
      return true;
    }());
    switch (this._type) {
      case _BusinessEvent.GetBusinessesForArtisan:
        if (getBusinessesForArtisan == null) break;
        return getBusinessesForArtisan(this as GetBusinessesForArtisan);
      case _BusinessEvent.GetBusinessById:
        if (getBusinessById == null) break;
        return getBusinessById(this as GetBusinessById);
      case _BusinessEvent.UploadBusiness:
        if (uploadBusiness == null) break;
        return uploadBusiness(this as UploadBusiness);
    }
  }

  @override
  List<Object> get props => const [];
}

@immutable
abstract class GetBusinessesForArtisan<T> extends BusinessEvent<T> {
  const GetBusinessesForArtisan({@required this.artisanId})
      : super(_BusinessEvent.GetBusinessesForArtisan);

  factory GetBusinessesForArtisan.create({@required String artisanId}) =
      _GetBusinessesForArtisanImpl<T>;

  final String artisanId;

  /// Creates a copy of this GetBusinessesForArtisan but with the given fields
  /// replaced with the new values.
  GetBusinessesForArtisan<T> copyWith({String artisanId});
}

@immutable
class _GetBusinessesForArtisanImpl<T> extends GetBusinessesForArtisan<T> {
  const _GetBusinessesForArtisanImpl({@required this.artisanId})
      : super(artisanId: artisanId);

  @override
  final String artisanId;

  @override
  _GetBusinessesForArtisanImpl<T> copyWith({Object artisanId = superEnum}) =>
      _GetBusinessesForArtisanImpl(
        artisanId:
            artisanId == superEnum ? this.artisanId : artisanId as String,
      );
  @override
  String toString() => 'GetBusinessesForArtisan(artisanId: ${this.artisanId})';
  @override
  List<Object> get props => [artisanId];
}

@immutable
abstract class GetBusinessById<T> extends BusinessEvent<T> {
  const GetBusinessById({@required this.id})
      : super(_BusinessEvent.GetBusinessById);

  factory GetBusinessById.create({@required String id}) =
      _GetBusinessByIdImpl<T>;

  final String id;

  /// Creates a copy of this GetBusinessById but with the given fields
  /// replaced with the new values.
  GetBusinessById<T> copyWith({String id});
}

@immutable
class _GetBusinessByIdImpl<T> extends GetBusinessById<T> {
  const _GetBusinessByIdImpl({@required this.id}) : super(id: id);

  @override
  final String id;

  @override
  _GetBusinessByIdImpl<T> copyWith({Object id = superEnum}) =>
      _GetBusinessByIdImpl(
        id: id == superEnum ? this.id : id as String,
      );
  @override
  String toString() => 'GetBusinessById(id: ${this.id})';
  @override
  List<Object> get props => [id];
}

@immutable
abstract class UploadBusiness<T> extends BusinessEvent<T> {
  const UploadBusiness({@required this.params})
      : super(_BusinessEvent.UploadBusiness);

  factory UploadBusiness.create({@required T params}) = _UploadBusinessImpl<T>;

  final T params;

  /// Creates a copy of this UploadBusiness but with the given fields
  /// replaced with the new values.
  UploadBusiness<T> copyWith({T params});
}

@immutable
class _UploadBusinessImpl<T> extends UploadBusiness<T> {
  const _UploadBusinessImpl({@required this.params}) : super(params: params);

  @override
  final T params;

  @override
  _UploadBusinessImpl<T> copyWith({Object params = superEnum}) =>
      _UploadBusinessImpl(
        params: params == superEnum ? this.params : params as T,
      );
  @override
  String toString() => 'UploadBusiness(params: ${this.params})';
  @override
  List<Object> get props => [params];
}
