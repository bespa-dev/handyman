// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: return_of_invalid_type, constant_identifier_names, prefer_const_constructors_in_immutables, unnecessary_this, sort_unnamed_constructors_first, join_return_with_assignment, missing_return, lines_longer_than_80_chars

part of 'business_event.dart';

// **************************************************************************
// SuperEnumGenerator
// **************************************************************************

@immutable
abstract class BusinessEvent extends Equatable {
  const BusinessEvent(this._type);

  factory BusinessEvent.getBusinessesForArtisan({@required String artisanId}) =
      GetBusinessesForArtisan.create;

  factory BusinessEvent.uploadBusiness(
      {@required String docUrl,
      @required String name,
      @required String artisan,
      @required double lat,
      @required double lng}) = UploadBusiness.create;

  final _BusinessEvent _type;

  /// The [when] method is the equivalent to pattern matching.
  /// Its prototype depends on the _BusinessEvent [_type]s defined.
  R when<R extends Object>(
      {@required R Function(GetBusinessesForArtisan) getBusinessesForArtisan,
      @required R Function(UploadBusiness) uploadBusiness}) {
    assert(() {
      if (getBusinessesForArtisan == null || uploadBusiness == null) {
        throw 'check for all possible cases';
      }
      return true;
    }());
    switch (this._type) {
      case _BusinessEvent.GetBusinessesForArtisan:
        return getBusinessesForArtisan(this as GetBusinessesForArtisan);
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
      {R Function(GetBusinessesForArtisan) getBusinessesForArtisan,
      R Function(UploadBusiness) uploadBusiness,
      @required R Function(BusinessEvent) orElse}) {
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
      case _BusinessEvent.UploadBusiness:
        if (uploadBusiness == null) break;
        return uploadBusiness(this as UploadBusiness);
    }
    return orElse(this);
  }

  /// The [whenPartial] method is equivalent to [whenOrElse],
  /// but non-exhaustive.
  void whenPartial(
      {void Function(GetBusinessesForArtisan) getBusinessesForArtisan,
      void Function(UploadBusiness) uploadBusiness}) {
    assert(() {
      if (getBusinessesForArtisan == null && uploadBusiness == null) {
        throw 'provide at least one branch';
      }
      return true;
    }());
    switch (this._type) {
      case _BusinessEvent.GetBusinessesForArtisan:
        if (getBusinessesForArtisan == null) break;
        return getBusinessesForArtisan(this as GetBusinessesForArtisan);
      case _BusinessEvent.UploadBusiness:
        if (uploadBusiness == null) break;
        return uploadBusiness(this as UploadBusiness);
    }
  }

  @override
  List<Object> get props => const [];
}

@immutable
abstract class GetBusinessesForArtisan extends BusinessEvent {
  const GetBusinessesForArtisan({@required this.artisanId})
      : super(_BusinessEvent.GetBusinessesForArtisan);

  factory GetBusinessesForArtisan.create({@required String artisanId}) =
      _GetBusinessesForArtisanImpl;

  final String artisanId;

  /// Creates a copy of this GetBusinessesForArtisan but with the given fields
  /// replaced with the new values.
  GetBusinessesForArtisan copyWith({String artisanId});
}

@immutable
class _GetBusinessesForArtisanImpl extends GetBusinessesForArtisan {
  const _GetBusinessesForArtisanImpl({@required this.artisanId})
      : super(artisanId: artisanId);

  @override
  final String artisanId;

  @override
  _GetBusinessesForArtisanImpl copyWith({Object artisanId = superEnum}) =>
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
abstract class UploadBusiness extends BusinessEvent {
  const UploadBusiness(
      {@required this.docUrl,
      @required this.name,
      @required this.artisan,
      @required this.lat,
      @required this.lng})
      : super(_BusinessEvent.UploadBusiness);

  factory UploadBusiness.create(
      {@required String docUrl,
      @required String name,
      @required String artisan,
      @required double lat,
      @required double lng}) = _UploadBusinessImpl;

  final String docUrl;

  final String name;

  final String artisan;

  final double lat;

  final double lng;

  /// Creates a copy of this UploadBusiness but with the given fields
  /// replaced with the new values.
  UploadBusiness copyWith(
      {String docUrl, String name, String artisan, double lat, double lng});
}

@immutable
class _UploadBusinessImpl extends UploadBusiness {
  const _UploadBusinessImpl(
      {@required this.docUrl,
      @required this.name,
      @required this.artisan,
      @required this.lat,
      @required this.lng})
      : super(docUrl: docUrl, name: name, artisan: artisan, lat: lat, lng: lng);

  @override
  final String docUrl;

  @override
  final String name;

  @override
  final String artisan;

  @override
  final double lat;

  @override
  final double lng;

  @override
  _UploadBusinessImpl copyWith(
          {Object docUrl = superEnum,
          Object name = superEnum,
          Object artisan = superEnum,
          Object lat = superEnum,
          Object lng = superEnum}) =>
      _UploadBusinessImpl(
        docUrl: docUrl == superEnum ? this.docUrl : docUrl as String,
        name: name == superEnum ? this.name : name as String,
        artisan: artisan == superEnum ? this.artisan : artisan as String,
        lat: lat == superEnum ? this.lat : lat as double,
        lng: lng == superEnum ? this.lng : lng as double,
      );
  @override
  String toString() =>
      'UploadBusiness(docUrl: ${this.docUrl}, name: ${this.name}, artisan: ${this.artisan}, lat: ${this.lat}, lng: ${this.lng})';
  @override
  List<Object> get props => [docUrl, name, artisan, lat, lng];
}
