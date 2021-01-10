// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: return_of_invalid_type, constant_identifier_names, prefer_const_constructors_in_immutables, unnecessary_this, sort_unnamed_constructors_first, join_return_with_assignment, missing_return, lines_longer_than_80_chars

part of 'service_event.dart';

// **************************************************************************
// SuperEnumGenerator
// **************************************************************************

@immutable
abstract class ArtisanServiceEvent<T> extends Equatable {
  const ArtisanServiceEvent(this._type);

  factory ArtisanServiceEvent.getArtisanServices() =
      GetArtisanServices<T>.create;

  factory ArtisanServiceEvent.updateArtisanService({@required T service}) =
      UpdateArtisanService<T>.create;

  final _ArtisanServiceEvent _type;

  /// The [when] method is the equivalent to pattern matching.
  /// Its prototype depends on the _ArtisanServiceEvent [_type]s defined.
  R when<R extends Object>(
      {@required R Function() getArtisanServices,
      @required R Function(UpdateArtisanService<T>) updateArtisanService}) {
    assert(() {
      if (getArtisanServices == null || updateArtisanService == null) {
        throw 'check for all possible cases';
      }
      return true;
    }());
    switch (this._type) {
      case _ArtisanServiceEvent.GetArtisanServices:
        return getArtisanServices();
      case _ArtisanServiceEvent.UpdateArtisanService:
        return updateArtisanService(this as UpdateArtisanService);
    }
  }

  /// The [whenOrElse] method is equivalent to [when], but doesn't require
  /// all callbacks to be specified.
  ///
  /// On the other hand, it adds an extra orElse required parameter,
  /// for fallback behavior.
  R whenOrElse<R extends Object>(
      {R Function() getArtisanServices,
      R Function(UpdateArtisanService<T>) updateArtisanService,
      @required R Function(ArtisanServiceEvent<T>) orElse}) {
    assert(() {
      if (orElse == null) {
        throw 'Missing orElse case';
      }
      return true;
    }());
    switch (this._type) {
      case _ArtisanServiceEvent.GetArtisanServices:
        if (getArtisanServices == null) break;
        return getArtisanServices();
      case _ArtisanServiceEvent.UpdateArtisanService:
        if (updateArtisanService == null) break;
        return updateArtisanService(this as UpdateArtisanService);
    }
    return orElse(this);
  }

  /// The [whenPartial] method is equivalent to [whenOrElse],
  /// but non-exhaustive.
  void whenPartial(
      {void Function() getArtisanServices,
      void Function(UpdateArtisanService<T>) updateArtisanService}) {
    assert(() {
      if (getArtisanServices == null && updateArtisanService == null) {
        throw 'provide at least one branch';
      }
      return true;
    }());
    switch (this._type) {
      case _ArtisanServiceEvent.GetArtisanServices:
        if (getArtisanServices == null) break;
        return getArtisanServices();
      case _ArtisanServiceEvent.UpdateArtisanService:
        if (updateArtisanService == null) break;
        return updateArtisanService(this as UpdateArtisanService);
    }
  }

  @override
  List<Object> get props => const [];
}

@immutable
abstract class GetArtisanServices<T> extends ArtisanServiceEvent<T> {
  const GetArtisanServices() : super(_ArtisanServiceEvent.GetArtisanServices);

  factory GetArtisanServices.create() = _GetArtisanServicesImpl<T>;
}

@immutable
class _GetArtisanServicesImpl<T> extends GetArtisanServices<T> {
  const _GetArtisanServicesImpl() : super();

  @override
  String toString() => 'GetArtisanServices()';
}

@immutable
abstract class UpdateArtisanService<T> extends ArtisanServiceEvent<T> {
  const UpdateArtisanService({@required this.service})
      : super(_ArtisanServiceEvent.UpdateArtisanService);

  factory UpdateArtisanService.create({@required T service}) =
      _UpdateArtisanServiceImpl<T>;

  final T service;

  /// Creates a copy of this UpdateArtisanService but with the given fields
  /// replaced with the new values.
  UpdateArtisanService<T> copyWith({T service});
}

@immutable
class _UpdateArtisanServiceImpl<T> extends UpdateArtisanService<T> {
  const _UpdateArtisanServiceImpl({@required this.service})
      : super(service: service);

  @override
  final T service;

  @override
  _UpdateArtisanServiceImpl<T> copyWith({Object service = superEnum}) =>
      _UpdateArtisanServiceImpl(
        service: service == superEnum ? this.service : service as T,
      );
  @override
  String toString() => 'UpdateArtisanService(service: ${this.service})';
  @override
  List<Object> get props => [service];
}
