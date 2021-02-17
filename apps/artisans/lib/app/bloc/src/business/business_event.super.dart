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

  factory BusinessEvent.updateBusiness({@required T business}) =
      UpdateBusiness<T>.create;

  factory BusinessEvent.getBusinessById({@required String id}) =
      GetBusinessById<T>.create;

  factory BusinessEvent.observeBusinessById({@required String id}) =
      ObserveBusinessById<T>.create;

  factory BusinessEvent.uploadBusiness(
      {@required String docUrl,
      @required String name,
      @required String artisan,
      @required String location,
      String nationalId,
      String birthCert}) = UploadBusiness<T>.create;

  final _BusinessEvent _type;

  /// The [when] method is the equivalent to pattern matching.
  /// Its prototype depends on the _BusinessEvent [_type]s defined.
  R when<R extends Object>(
      {@required R Function(GetBusinessesForArtisan<T>) getBusinessesForArtisan,
      @required R Function(UpdateBusiness<T>) updateBusiness,
      @required R Function(GetBusinessById<T>) getBusinessById,
      @required R Function(ObserveBusinessById<T>) observeBusinessById,
      @required R Function(UploadBusiness<T>) uploadBusiness}) {
    assert(() {
      if (getBusinessesForArtisan == null ||
          updateBusiness == null ||
          getBusinessById == null ||
          observeBusinessById == null ||
          uploadBusiness == null) {
        throw 'check for all possible cases';
      }
      return true;
    }());
    switch (this._type) {
      case _BusinessEvent.GetBusinessesForArtisan:
        return getBusinessesForArtisan(this as GetBusinessesForArtisan);
      case _BusinessEvent.UpdateBusiness:
        return updateBusiness(this as UpdateBusiness);
      case _BusinessEvent.GetBusinessById:
        return getBusinessById(this as GetBusinessById);
      case _BusinessEvent.ObserveBusinessById:
        return observeBusinessById(this as ObserveBusinessById);
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
      R Function(UpdateBusiness<T>) updateBusiness,
      R Function(GetBusinessById<T>) getBusinessById,
      R Function(ObserveBusinessById<T>) observeBusinessById,
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
      case _BusinessEvent.UpdateBusiness:
        if (updateBusiness == null) break;
        return updateBusiness(this as UpdateBusiness);
      case _BusinessEvent.GetBusinessById:
        if (getBusinessById == null) break;
        return getBusinessById(this as GetBusinessById);
      case _BusinessEvent.ObserveBusinessById:
        if (observeBusinessById == null) break;
        return observeBusinessById(this as ObserveBusinessById);
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
      void Function(UpdateBusiness<T>) updateBusiness,
      void Function(GetBusinessById<T>) getBusinessById,
      void Function(ObserveBusinessById<T>) observeBusinessById,
      void Function(UploadBusiness<T>) uploadBusiness}) {
    assert(() {
      if (getBusinessesForArtisan == null &&
          updateBusiness == null &&
          getBusinessById == null &&
          observeBusinessById == null &&
          uploadBusiness == null) {
        throw 'provide at least one branch';
      }
      return true;
    }());
    switch (this._type) {
      case _BusinessEvent.GetBusinessesForArtisan:
        if (getBusinessesForArtisan == null) break;
        return getBusinessesForArtisan(this as GetBusinessesForArtisan);
      case _BusinessEvent.UpdateBusiness:
        if (updateBusiness == null) break;
        return updateBusiness(this as UpdateBusiness);
      case _BusinessEvent.GetBusinessById:
        if (getBusinessById == null) break;
        return getBusinessById(this as GetBusinessById);
      case _BusinessEvent.ObserveBusinessById:
        if (observeBusinessById == null) break;
        return observeBusinessById(this as ObserveBusinessById);
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
abstract class UpdateBusiness<T> extends BusinessEvent<T> {
  const UpdateBusiness({@required this.business})
      : super(_BusinessEvent.UpdateBusiness);

  factory UpdateBusiness.create({@required T business}) =
      _UpdateBusinessImpl<T>;

  final T business;

  /// Creates a copy of this UpdateBusiness but with the given fields
  /// replaced with the new values.
  UpdateBusiness<T> copyWith({T business});
}

@immutable
class _UpdateBusinessImpl<T> extends UpdateBusiness<T> {
  const _UpdateBusinessImpl({@required this.business})
      : super(business: business);

  @override
  final T business;

  @override
  _UpdateBusinessImpl<T> copyWith({Object business = superEnum}) =>
      _UpdateBusinessImpl(
        business: business == superEnum ? this.business : business as T,
      );
  @override
  String toString() => 'UpdateBusiness(business: ${this.business})';
  @override
  List<Object> get props => [business];
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
abstract class ObserveBusinessById<T> extends BusinessEvent<T> {
  const ObserveBusinessById({@required this.id})
      : super(_BusinessEvent.ObserveBusinessById);

  factory ObserveBusinessById.create({@required String id}) =
      _ObserveBusinessByIdImpl<T>;

  final String id;

  /// Creates a copy of this ObserveBusinessById but with the given fields
  /// replaced with the new values.
  ObserveBusinessById<T> copyWith({String id});
}

@immutable
class _ObserveBusinessByIdImpl<T> extends ObserveBusinessById<T> {
  const _ObserveBusinessByIdImpl({@required this.id}) : super(id: id);

  @override
  final String id;

  @override
  _ObserveBusinessByIdImpl<T> copyWith({Object id = superEnum}) =>
      _ObserveBusinessByIdImpl(
        id: id == superEnum ? this.id : id as String,
      );
  @override
  String toString() => 'ObserveBusinessById(id: ${this.id})';
  @override
  List<Object> get props => [id];
}

@immutable
abstract class UploadBusiness<T> extends BusinessEvent<T> {
  const UploadBusiness(
      {@required this.docUrl,
      @required this.name,
      @required this.artisan,
      @required this.location,
      this.nationalId,
      this.birthCert})
      : super(_BusinessEvent.UploadBusiness);

  factory UploadBusiness.create(
      {@required String docUrl,
      @required String name,
      @required String artisan,
      @required String location,
      String nationalId,
      String birthCert}) = _UploadBusinessImpl<T>;

  final String docUrl;

  final String name;

  final String artisan;

  final String location;

  final String nationalId;

  final String birthCert;

  /// Creates a copy of this UploadBusiness but with the given fields
  /// replaced with the new values.
  UploadBusiness<T> copyWith(
      {String docUrl,
      String name,
      String artisan,
      String location,
      String nationalId,
      String birthCert});
}

@immutable
class _UploadBusinessImpl<T> extends UploadBusiness<T> {
  const _UploadBusinessImpl(
      {@required this.docUrl,
      @required this.name,
      @required this.artisan,
      @required this.location,
      this.nationalId,
      this.birthCert})
      : super(
            docUrl: docUrl,
            name: name,
            artisan: artisan,
            location: location,
            nationalId: nationalId,
            birthCert: birthCert);

  @override
  final String docUrl;

  @override
  final String name;

  @override
  final String artisan;

  @override
  final String location;

  @override
  final String nationalId;

  @override
  final String birthCert;

  @override
  _UploadBusinessImpl<T> copyWith(
          {Object docUrl = superEnum,
          Object name = superEnum,
          Object artisan = superEnum,
          Object location = superEnum,
          Object nationalId = superEnum,
          Object birthCert = superEnum}) =>
      _UploadBusinessImpl(
        docUrl: docUrl == superEnum ? this.docUrl : docUrl as String,
        name: name == superEnum ? this.name : name as String,
        artisan: artisan == superEnum ? this.artisan : artisan as String,
        location: location == superEnum ? this.location : location as String,
        nationalId:
            nationalId == superEnum ? this.nationalId : nationalId as String,
        birthCert:
            birthCert == superEnum ? this.birthCert : birthCert as String,
      );
  @override
  String toString() =>
      'UploadBusiness(docUrl: ${this.docUrl}, name: ${this.name}, artisan: ${this.artisan}, location: ${this.location}, nationalId: ${this.nationalId}, birthCert: ${this.birthCert})';
  @override
  List<Object> get props =>
      [docUrl, name, artisan, location, nationalId, birthCert];
}
