// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: return_of_invalid_type, constant_identifier_names, prefer_const_constructors_in_immutables, unnecessary_this, sort_unnamed_constructors_first, join_return_with_assignment, missing_return, lines_longer_than_80_chars

part of 'location_event.dart';

// **************************************************************************
// SuperEnumGenerator
// **************************************************************************

@immutable
abstract class LocationEvent<T> extends Equatable {
  const LocationEvent(this._type);

  factory LocationEvent.getCurrentLocation() = GetCurrentLocation<T>.create;

  factory LocationEvent.observeCurrentLocation() =
      ObserveCurrentLocation<T>.create;

  factory LocationEvent.getLocationName({@required T location}) =
      GetLocationName<T>.create;

  final _LocationEvent _type;

  /// The [when] method is the equivalent to pattern matching.
  /// Its prototype depends on the _LocationEvent [_type]s defined.
  R when<R extends Object>(
      {@required R Function() getCurrentLocation,
      @required R Function() observeCurrentLocation,
      @required R Function(GetLocationName<T>) getLocationName}) {
    assert(() {
      if (getCurrentLocation == null ||
          observeCurrentLocation == null ||
          getLocationName == null) {
        throw 'check for all possible cases';
      }
      return true;
    }());
    switch (this._type) {
      case _LocationEvent.GetCurrentLocation:
        return getCurrentLocation();
      case _LocationEvent.ObserveCurrentLocation:
        return observeCurrentLocation();
      case _LocationEvent.GetLocationName:
        return getLocationName(this as GetLocationName);
    }
  }

  /// The [whenOrElse] method is equivalent to [when], but doesn't require
  /// all callbacks to be specified.
  ///
  /// On the other hand, it adds an extra orElse required parameter,
  /// for fallback behavior.
  R whenOrElse<R extends Object>(
      {R Function() getCurrentLocation,
      R Function() observeCurrentLocation,
      R Function(GetLocationName<T>) getLocationName,
      @required R Function(LocationEvent<T>) orElse}) {
    assert(() {
      if (orElse == null) {
        throw 'Missing orElse case';
      }
      return true;
    }());
    switch (this._type) {
      case _LocationEvent.GetCurrentLocation:
        if (getCurrentLocation == null) break;
        return getCurrentLocation();
      case _LocationEvent.ObserveCurrentLocation:
        if (observeCurrentLocation == null) break;
        return observeCurrentLocation();
      case _LocationEvent.GetLocationName:
        if (getLocationName == null) break;
        return getLocationName(this as GetLocationName);
    }
    return orElse(this);
  }

  /// The [whenPartial] method is equivalent to [whenOrElse],
  /// but non-exhaustive.
  void whenPartial(
      {void Function() getCurrentLocation,
      void Function() observeCurrentLocation,
      void Function(GetLocationName<T>) getLocationName}) {
    assert(() {
      if (getCurrentLocation == null &&
          observeCurrentLocation == null &&
          getLocationName == null) {
        throw 'provide at least one branch';
      }
      return true;
    }());
    switch (this._type) {
      case _LocationEvent.GetCurrentLocation:
        if (getCurrentLocation == null) break;
        return getCurrentLocation();
      case _LocationEvent.ObserveCurrentLocation:
        if (observeCurrentLocation == null) break;
        return observeCurrentLocation();
      case _LocationEvent.GetLocationName:
        if (getLocationName == null) break;
        return getLocationName(this as GetLocationName);
    }
  }

  @override
  List<Object> get props => const [];
}

@immutable
abstract class GetCurrentLocation<T> extends LocationEvent<T> {
  const GetCurrentLocation() : super(_LocationEvent.GetCurrentLocation);

  factory GetCurrentLocation.create() = _GetCurrentLocationImpl<T>;
}

@immutable
class _GetCurrentLocationImpl<T> extends GetCurrentLocation<T> {
  const _GetCurrentLocationImpl() : super();

  @override
  String toString() => 'GetCurrentLocation()';
}

@immutable
abstract class ObserveCurrentLocation<T> extends LocationEvent<T> {
  const ObserveCurrentLocation() : super(_LocationEvent.ObserveCurrentLocation);

  factory ObserveCurrentLocation.create() = _ObserveCurrentLocationImpl<T>;
}

@immutable
class _ObserveCurrentLocationImpl<T> extends ObserveCurrentLocation<T> {
  const _ObserveCurrentLocationImpl() : super();

  @override
  String toString() => 'ObserveCurrentLocation()';
}

@immutable
abstract class GetLocationName<T> extends LocationEvent<T> {
  const GetLocationName({@required this.location})
      : super(_LocationEvent.GetLocationName);

  factory GetLocationName.create({@required T location}) =
      _GetLocationNameImpl<T>;

  final T location;

  /// Creates a copy of this GetLocationName but with the given fields
  /// replaced with the new values.
  GetLocationName<T> copyWith({T location});
}

@immutable
class _GetLocationNameImpl<T> extends GetLocationName<T> {
  const _GetLocationNameImpl({@required this.location})
      : super(location: location);

  @override
  final T location;

  @override
  _GetLocationNameImpl<T> copyWith({Object location = superEnum}) =>
      _GetLocationNameImpl(
        location: location == superEnum ? this.location : location as T,
      );
  @override
  String toString() => 'GetLocationName(location: ${this.location})';
  @override
  List<Object> get props => [location];
}
