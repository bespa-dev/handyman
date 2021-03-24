// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: return_of_invalid_type, constant_identifier_names, prefer_const_constructors_in_immutables, unnecessary_this, sort_unnamed_constructors_first, join_return_with_assignment, missing_return, lines_longer_than_80_chars

part of 'service_event.dart';

// **************************************************************************
// SuperEnumGenerator
// **************************************************************************

@immutable
abstract class ArtisanServiceEvent<T> extends Equatable {
  const ArtisanServiceEvent(this._type);

  factory ArtisanServiceEvent.getArtisanServices({@required String id}) =
      GetArtisanServices<T>.create;

  factory ArtisanServiceEvent.getServiceById({@required String id}) =
      GetServiceById<T>.create;

  factory ArtisanServiceEvent.updateArtisanService(
      {@required String id,
      @required T service}) = UpdateArtisanService<T>.create;

  factory ArtisanServiceEvent.getAllArtisanServices() =
      GetAllArtisanServices<T>.create;

  factory ArtisanServiceEvent.getArtisanServicesByCategory(
      {@required String categoryId}) = GetArtisanServicesByCategory<T>.create;

  factory ArtisanServiceEvent.resetAllPrices() = ResetAllPrices<T>.create;

  final _ArtisanServiceEvent _type;

  /// The [when] method is the equivalent to pattern matching.
  /// Its prototype depends on the _ArtisanServiceEvent [_type]s defined.
  R when<R extends Object>(
      {@required
          R Function(GetArtisanServices<T>) getArtisanServices,
      @required
          R Function(GetServiceById<T>) getServiceById,
      @required
          R Function(UpdateArtisanService<T>) updateArtisanService,
      @required
          R Function() getAllArtisanServices,
      @required
          R Function(GetArtisanServicesByCategory<T>)
              getArtisanServicesByCategory,
      @required
          R Function() resetAllPrices}) {
    assert(() {
      if (getArtisanServices == null ||
          getServiceById == null ||
          updateArtisanService == null ||
          getAllArtisanServices == null ||
          getArtisanServicesByCategory == null ||
          resetAllPrices == null) {
        throw 'check for all possible cases';
      }
      return true;
    }());
    switch (this._type) {
      case _ArtisanServiceEvent.GetArtisanServices:
        return getArtisanServices(this as GetArtisanServices);
      case _ArtisanServiceEvent.GetServiceById:
        return getServiceById(this as GetServiceById);
      case _ArtisanServiceEvent.UpdateArtisanService:
        return updateArtisanService(this as UpdateArtisanService);
      case _ArtisanServiceEvent.GetAllArtisanServices:
        return getAllArtisanServices();
      case _ArtisanServiceEvent.GetArtisanServicesByCategory:
        return getArtisanServicesByCategory(
            this as GetArtisanServicesByCategory);
      case _ArtisanServiceEvent.ResetAllPrices:
        return resetAllPrices();
    }
  }

  /// The [whenOrElse] method is equivalent to [when], but doesn't require
  /// all callbacks to be specified.
  ///
  /// On the other hand, it adds an extra orElse required parameter,
  /// for fallback behavior.
  R whenOrElse<R extends Object>(
      {R Function(GetArtisanServices<T>) getArtisanServices,
      R Function(GetServiceById<T>) getServiceById,
      R Function(UpdateArtisanService<T>) updateArtisanService,
      R Function() getAllArtisanServices,
      R Function(GetArtisanServicesByCategory<T>) getArtisanServicesByCategory,
      R Function() resetAllPrices,
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
        return getArtisanServices(this as GetArtisanServices);
      case _ArtisanServiceEvent.GetServiceById:
        if (getServiceById == null) break;
        return getServiceById(this as GetServiceById);
      case _ArtisanServiceEvent.UpdateArtisanService:
        if (updateArtisanService == null) break;
        return updateArtisanService(this as UpdateArtisanService);
      case _ArtisanServiceEvent.GetAllArtisanServices:
        if (getAllArtisanServices == null) break;
        return getAllArtisanServices();
      case _ArtisanServiceEvent.GetArtisanServicesByCategory:
        if (getArtisanServicesByCategory == null) break;
        return getArtisanServicesByCategory(
            this as GetArtisanServicesByCategory);
      case _ArtisanServiceEvent.ResetAllPrices:
        if (resetAllPrices == null) break;
        return resetAllPrices();
    }
    return orElse(this);
  }

  /// The [whenPartial] method is equivalent to [whenOrElse],
  /// but non-exhaustive.
  void whenPartial(
      {void Function(GetArtisanServices<T>) getArtisanServices,
      void Function(GetServiceById<T>) getServiceById,
      void Function(UpdateArtisanService<T>) updateArtisanService,
      void Function() getAllArtisanServices,
      void Function(GetArtisanServicesByCategory<T>)
          getArtisanServicesByCategory,
      void Function() resetAllPrices}) {
    assert(() {
      if (getArtisanServices == null &&
          getServiceById == null &&
          updateArtisanService == null &&
          getAllArtisanServices == null &&
          getArtisanServicesByCategory == null &&
          resetAllPrices == null) {
        throw 'provide at least one branch';
      }
      return true;
    }());
    switch (this._type) {
      case _ArtisanServiceEvent.GetArtisanServices:
        if (getArtisanServices == null) break;
        return getArtisanServices(this as GetArtisanServices);
      case _ArtisanServiceEvent.GetServiceById:
        if (getServiceById == null) break;
        return getServiceById(this as GetServiceById);
      case _ArtisanServiceEvent.UpdateArtisanService:
        if (updateArtisanService == null) break;
        return updateArtisanService(this as UpdateArtisanService);
      case _ArtisanServiceEvent.GetAllArtisanServices:
        if (getAllArtisanServices == null) break;
        return getAllArtisanServices();
      case _ArtisanServiceEvent.GetArtisanServicesByCategory:
        if (getArtisanServicesByCategory == null) break;
        return getArtisanServicesByCategory(
            this as GetArtisanServicesByCategory);
      case _ArtisanServiceEvent.ResetAllPrices:
        if (resetAllPrices == null) break;
        return resetAllPrices();
    }
  }

  @override
  List<Object> get props => const [];
}

@immutable
abstract class GetArtisanServices<T> extends ArtisanServiceEvent<T> {
  const GetArtisanServices({@required this.id})
      : super(_ArtisanServiceEvent.GetArtisanServices);

  factory GetArtisanServices.create({@required String id}) =
      _GetArtisanServicesImpl<T>;

  final String id;

  /// Creates a copy of this GetArtisanServices but with the given fields
  /// replaced with the new values.
  GetArtisanServices<T> copyWith({String id});
}

@immutable
class _GetArtisanServicesImpl<T> extends GetArtisanServices<T> {
  const _GetArtisanServicesImpl({@required this.id}) : super(id: id);

  @override
  final String id;

  @override
  _GetArtisanServicesImpl<T> copyWith({Object id = superEnum}) =>
      _GetArtisanServicesImpl(
        id: id == superEnum ? this.id : id as String,
      );
  @override
  String toString() => 'GetArtisanServices(id: ${this.id})';
  @override
  List<Object> get props => [id];
}

@immutable
abstract class GetServiceById<T> extends ArtisanServiceEvent<T> {
  const GetServiceById({@required this.id})
      : super(_ArtisanServiceEvent.GetServiceById);

  factory GetServiceById.create({@required String id}) = _GetServiceByIdImpl<T>;

  final String id;

  /// Creates a copy of this GetServiceById but with the given fields
  /// replaced with the new values.
  GetServiceById<T> copyWith({String id});
}

@immutable
class _GetServiceByIdImpl<T> extends GetServiceById<T> {
  const _GetServiceByIdImpl({@required this.id}) : super(id: id);

  @override
  final String id;

  @override
  _GetServiceByIdImpl<T> copyWith({Object id = superEnum}) =>
      _GetServiceByIdImpl(
        id: id == superEnum ? this.id : id as String,
      );
  @override
  String toString() => 'GetServiceById(id: ${this.id})';
  @override
  List<Object> get props => [id];
}

@immutable
abstract class UpdateArtisanService<T> extends ArtisanServiceEvent<T> {
  const UpdateArtisanService({@required this.id, @required this.service})
      : super(_ArtisanServiceEvent.UpdateArtisanService);

  factory UpdateArtisanService.create(
      {@required String id,
      @required T service}) = _UpdateArtisanServiceImpl<T>;

  final String id;

  final T service;

  /// Creates a copy of this UpdateArtisanService but with the given fields
  /// replaced with the new values.
  UpdateArtisanService<T> copyWith({String id, T service});
}

@immutable
class _UpdateArtisanServiceImpl<T> extends UpdateArtisanService<T> {
  const _UpdateArtisanServiceImpl({@required this.id, @required this.service})
      : super(id: id, service: service);

  @override
  final String id;

  @override
  final T service;

  @override
  _UpdateArtisanServiceImpl<T> copyWith(
          {Object id = superEnum, Object service = superEnum}) =>
      _UpdateArtisanServiceImpl(
        id: id == superEnum ? this.id : id as String,
        service: service == superEnum ? this.service : service as T,
      );
  @override
  String toString() =>
      'UpdateArtisanService(id: ${this.id}, service: ${this.service})';
  @override
  List<Object> get props => [id, service];
}

@immutable
abstract class GetAllArtisanServices<T> extends ArtisanServiceEvent<T> {
  const GetAllArtisanServices()
      : super(_ArtisanServiceEvent.GetAllArtisanServices);

  factory GetAllArtisanServices.create() = _GetAllArtisanServicesImpl<T>;
}

@immutable
class _GetAllArtisanServicesImpl<T> extends GetAllArtisanServices<T> {
  const _GetAllArtisanServicesImpl() : super();

  @override
  String toString() => 'GetAllArtisanServices()';
}

@immutable
abstract class GetArtisanServicesByCategory<T> extends ArtisanServiceEvent<T> {
  const GetArtisanServicesByCategory({@required this.categoryId})
      : super(_ArtisanServiceEvent.GetArtisanServicesByCategory);

  factory GetArtisanServicesByCategory.create({@required String categoryId}) =
      _GetArtisanServicesByCategoryImpl<T>;

  final String categoryId;

  /// Creates a copy of this GetArtisanServicesByCategory but with the given fields
  /// replaced with the new values.
  GetArtisanServicesByCategory<T> copyWith({String categoryId});
}

@immutable
class _GetArtisanServicesByCategoryImpl<T>
    extends GetArtisanServicesByCategory<T> {
  const _GetArtisanServicesByCategoryImpl({@required this.categoryId})
      : super(categoryId: categoryId);

  @override
  final String categoryId;

  @override
  _GetArtisanServicesByCategoryImpl<T> copyWith(
          {Object categoryId = superEnum}) =>
      _GetArtisanServicesByCategoryImpl(
        categoryId:
            categoryId == superEnum ? this.categoryId : categoryId as String,
      );
  @override
  String toString() =>
      'GetArtisanServicesByCategory(categoryId: ${this.categoryId})';
  @override
  List<Object> get props => [categoryId];
}

@immutable
abstract class ResetAllPrices<T> extends ArtisanServiceEvent<T> {
  const ResetAllPrices() : super(_ArtisanServiceEvent.ResetAllPrices);

  factory ResetAllPrices.create() = _ResetAllPricesImpl<T>;
}

@immutable
class _ResetAllPricesImpl<T> extends ResetAllPrices<T> {
  const _ResetAllPricesImpl() : super();

  @override
  String toString() => 'ResetAllPrices()';
}
