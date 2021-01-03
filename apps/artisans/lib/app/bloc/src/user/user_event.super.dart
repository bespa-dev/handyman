// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: return_of_invalid_type, constant_identifier_names, prefer_const_constructors_in_immutables, unnecessary_this, sort_unnamed_constructors_first, join_return_with_assignment, missing_return, lines_longer_than_80_chars

part of 'user_event.dart';

// **************************************************************************
// SuperEnumGenerator
// **************************************************************************

@immutable
abstract class UserEvent<T> extends Equatable {
  const UserEvent(this._type);

  factory UserEvent.currentUserEvent() = CurrentUserEvent<T>.create;

  factory UserEvent.updateUserEvent({@required T user}) =
      UpdateUserEvent<T>.create;

  factory UserEvent.getArtisanByIdEvent({@required String id}) =
      GetArtisanByIdEvent<T>.create;

  factory UserEvent.observeArtisanByIdEvent({@required String id}) =
      ObserveArtisanByIdEvent<T>.create;

  factory UserEvent.getCustomerByIdEvent({@required String id}) =
      GetCustomerByIdEvent<T>.create;

  factory UserEvent.observeCustomerByIdEvent({@required String id}) =
      ObserveCustomerByIdEvent<T>.create;

  factory UserEvent.observeArtisansEvent({@required String category}) =
      ObserveArtisansEvent<T>.create;

  final _UserEvent _type;

  /// The [when] method is the equivalent to pattern matching.
  /// Its prototype depends on the _UserEvent [_type]s defined.
  R when<R extends Object>(
      {@required
          R Function() currentUserEvent,
      @required
          R Function(UpdateUserEvent<T>) updateUserEvent,
      @required
          R Function(GetArtisanByIdEvent<T>) getArtisanByIdEvent,
      @required
          R Function(ObserveArtisanByIdEvent<T>) observeArtisanByIdEvent,
      @required
          R Function(GetCustomerByIdEvent<T>) getCustomerByIdEvent,
      @required
          R Function(ObserveCustomerByIdEvent<T>) observeCustomerByIdEvent,
      @required
          R Function(ObserveArtisansEvent<T>) observeArtisansEvent}) {
    assert(() {
      if (currentUserEvent == null ||
          updateUserEvent == null ||
          getArtisanByIdEvent == null ||
          observeArtisanByIdEvent == null ||
          getCustomerByIdEvent == null ||
          observeCustomerByIdEvent == null ||
          observeArtisansEvent == null) {
        throw 'check for all possible cases';
      }
      return true;
    }());
    switch (this._type) {
      case _UserEvent.CurrentUserEvent:
        return currentUserEvent();
      case _UserEvent.UpdateUserEvent:
        return updateUserEvent(this as UpdateUserEvent);
      case _UserEvent.GetArtisanByIdEvent:
        return getArtisanByIdEvent(this as GetArtisanByIdEvent);
      case _UserEvent.ObserveArtisanByIdEvent:
        return observeArtisanByIdEvent(this as ObserveArtisanByIdEvent);
      case _UserEvent.GetCustomerByIdEvent:
        return getCustomerByIdEvent(this as GetCustomerByIdEvent);
      case _UserEvent.ObserveCustomerByIdEvent:
        return observeCustomerByIdEvent(this as ObserveCustomerByIdEvent);
      case _UserEvent.ObserveArtisansEvent:
        return observeArtisansEvent(this as ObserveArtisansEvent);
    }
  }

  /// The [whenOrElse] method is equivalent to [when], but doesn't require
  /// all callbacks to be specified.
  ///
  /// On the other hand, it adds an extra orElse required parameter,
  /// for fallback behavior.
  R whenOrElse<R extends Object>(
      {R Function() currentUserEvent,
      R Function(UpdateUserEvent<T>) updateUserEvent,
      R Function(GetArtisanByIdEvent<T>) getArtisanByIdEvent,
      R Function(ObserveArtisanByIdEvent<T>) observeArtisanByIdEvent,
      R Function(GetCustomerByIdEvent<T>) getCustomerByIdEvent,
      R Function(ObserveCustomerByIdEvent<T>) observeCustomerByIdEvent,
      R Function(ObserveArtisansEvent<T>) observeArtisansEvent,
      @required R Function(UserEvent<T>) orElse}) {
    assert(() {
      if (orElse == null) {
        throw 'Missing orElse case';
      }
      return true;
    }());
    switch (this._type) {
      case _UserEvent.CurrentUserEvent:
        if (currentUserEvent == null) break;
        return currentUserEvent();
      case _UserEvent.UpdateUserEvent:
        if (updateUserEvent == null) break;
        return updateUserEvent(this as UpdateUserEvent);
      case _UserEvent.GetArtisanByIdEvent:
        if (getArtisanByIdEvent == null) break;
        return getArtisanByIdEvent(this as GetArtisanByIdEvent);
      case _UserEvent.ObserveArtisanByIdEvent:
        if (observeArtisanByIdEvent == null) break;
        return observeArtisanByIdEvent(this as ObserveArtisanByIdEvent);
      case _UserEvent.GetCustomerByIdEvent:
        if (getCustomerByIdEvent == null) break;
        return getCustomerByIdEvent(this as GetCustomerByIdEvent);
      case _UserEvent.ObserveCustomerByIdEvent:
        if (observeCustomerByIdEvent == null) break;
        return observeCustomerByIdEvent(this as ObserveCustomerByIdEvent);
      case _UserEvent.ObserveArtisansEvent:
        if (observeArtisansEvent == null) break;
        return observeArtisansEvent(this as ObserveArtisansEvent);
    }
    return orElse(this);
  }

  /// The [whenPartial] method is equivalent to [whenOrElse],
  /// but non-exhaustive.
  void whenPartial(
      {void Function() currentUserEvent,
      void Function(UpdateUserEvent<T>) updateUserEvent,
      void Function(GetArtisanByIdEvent<T>) getArtisanByIdEvent,
      void Function(ObserveArtisanByIdEvent<T>) observeArtisanByIdEvent,
      void Function(GetCustomerByIdEvent<T>) getCustomerByIdEvent,
      void Function(ObserveCustomerByIdEvent<T>) observeCustomerByIdEvent,
      void Function(ObserveArtisansEvent<T>) observeArtisansEvent}) {
    assert(() {
      if (currentUserEvent == null &&
          updateUserEvent == null &&
          getArtisanByIdEvent == null &&
          observeArtisanByIdEvent == null &&
          getCustomerByIdEvent == null &&
          observeCustomerByIdEvent == null &&
          observeArtisansEvent == null) {
        throw 'provide at least one branch';
      }
      return true;
    }());
    switch (this._type) {
      case _UserEvent.CurrentUserEvent:
        if (currentUserEvent == null) break;
        return currentUserEvent();
      case _UserEvent.UpdateUserEvent:
        if (updateUserEvent == null) break;
        return updateUserEvent(this as UpdateUserEvent);
      case _UserEvent.GetArtisanByIdEvent:
        if (getArtisanByIdEvent == null) break;
        return getArtisanByIdEvent(this as GetArtisanByIdEvent);
      case _UserEvent.ObserveArtisanByIdEvent:
        if (observeArtisanByIdEvent == null) break;
        return observeArtisanByIdEvent(this as ObserveArtisanByIdEvent);
      case _UserEvent.GetCustomerByIdEvent:
        if (getCustomerByIdEvent == null) break;
        return getCustomerByIdEvent(this as GetCustomerByIdEvent);
      case _UserEvent.ObserveCustomerByIdEvent:
        if (observeCustomerByIdEvent == null) break;
        return observeCustomerByIdEvent(this as ObserveCustomerByIdEvent);
      case _UserEvent.ObserveArtisansEvent:
        if (observeArtisansEvent == null) break;
        return observeArtisansEvent(this as ObserveArtisansEvent);
    }
  }

  @override
  List<Object> get props => const [];
}

@immutable
abstract class CurrentUserEvent<T> extends UserEvent<T> {
  const CurrentUserEvent() : super(_UserEvent.CurrentUserEvent);

  factory CurrentUserEvent.create() = _CurrentUserEventImpl<T>;
}

@immutable
class _CurrentUserEventImpl<T> extends CurrentUserEvent<T> {
  const _CurrentUserEventImpl() : super();

  @override
  String toString() => 'CurrentUserEvent()';
}

@immutable
abstract class UpdateUserEvent<T> extends UserEvent<T> {
  const UpdateUserEvent({@required this.user})
      : super(_UserEvent.UpdateUserEvent);

  factory UpdateUserEvent.create({@required T user}) = _UpdateUserEventImpl<T>;

  final T user;

  /// Creates a copy of this UpdateUserEvent but with the given fields
  /// replaced with the new values.
  UpdateUserEvent<T> copyWith({T user});
}

@immutable
class _UpdateUserEventImpl<T> extends UpdateUserEvent<T> {
  const _UpdateUserEventImpl({@required this.user}) : super(user: user);

  @override
  final T user;

  @override
  _UpdateUserEventImpl<T> copyWith({Object user = superEnum}) =>
      _UpdateUserEventImpl(
        user: user == superEnum ? this.user : user as T,
      );
  @override
  String toString() => 'UpdateUserEvent(user: ${this.user})';
  @override
  List<Object> get props => [user];
}

@immutable
abstract class GetArtisanByIdEvent<T> extends UserEvent<T> {
  const GetArtisanByIdEvent({@required this.id})
      : super(_UserEvent.GetArtisanByIdEvent);

  factory GetArtisanByIdEvent.create({@required String id}) =
      _GetArtisanByIdEventImpl<T>;

  final String id;

  /// Creates a copy of this GetArtisanByIdEvent but with the given fields
  /// replaced with the new values.
  GetArtisanByIdEvent<T> copyWith({String id});
}

@immutable
class _GetArtisanByIdEventImpl<T> extends GetArtisanByIdEvent<T> {
  const _GetArtisanByIdEventImpl({@required this.id}) : super(id: id);

  @override
  final String id;

  @override
  _GetArtisanByIdEventImpl<T> copyWith({Object id = superEnum}) =>
      _GetArtisanByIdEventImpl(
        id: id == superEnum ? this.id : id as String,
      );
  @override
  String toString() => 'GetArtisanByIdEvent(id: ${this.id})';
  @override
  List<Object> get props => [id];
}

@immutable
abstract class ObserveArtisanByIdEvent<T> extends UserEvent<T> {
  const ObserveArtisanByIdEvent({@required this.id})
      : super(_UserEvent.ObserveArtisanByIdEvent);

  factory ObserveArtisanByIdEvent.create({@required String id}) =
      _ObserveArtisanByIdEventImpl<T>;

  final String id;

  /// Creates a copy of this ObserveArtisanByIdEvent but with the given fields
  /// replaced with the new values.
  ObserveArtisanByIdEvent<T> copyWith({String id});
}

@immutable
class _ObserveArtisanByIdEventImpl<T> extends ObserveArtisanByIdEvent<T> {
  const _ObserveArtisanByIdEventImpl({@required this.id}) : super(id: id);

  @override
  final String id;

  @override
  _ObserveArtisanByIdEventImpl<T> copyWith({Object id = superEnum}) =>
      _ObserveArtisanByIdEventImpl(
        id: id == superEnum ? this.id : id as String,
      );
  @override
  String toString() => 'ObserveArtisanByIdEvent(id: ${this.id})';
  @override
  List<Object> get props => [id];
}

@immutable
abstract class GetCustomerByIdEvent<T> extends UserEvent<T> {
  const GetCustomerByIdEvent({@required this.id})
      : super(_UserEvent.GetCustomerByIdEvent);

  factory GetCustomerByIdEvent.create({@required String id}) =
      _GetCustomerByIdEventImpl<T>;

  final String id;

  /// Creates a copy of this GetCustomerByIdEvent but with the given fields
  /// replaced with the new values.
  GetCustomerByIdEvent<T> copyWith({String id});
}

@immutable
class _GetCustomerByIdEventImpl<T> extends GetCustomerByIdEvent<T> {
  const _GetCustomerByIdEventImpl({@required this.id}) : super(id: id);

  @override
  final String id;

  @override
  _GetCustomerByIdEventImpl<T> copyWith({Object id = superEnum}) =>
      _GetCustomerByIdEventImpl(
        id: id == superEnum ? this.id : id as String,
      );
  @override
  String toString() => 'GetCustomerByIdEvent(id: ${this.id})';
  @override
  List<Object> get props => [id];
}

@immutable
abstract class ObserveCustomerByIdEvent<T> extends UserEvent<T> {
  const ObserveCustomerByIdEvent({@required this.id})
      : super(_UserEvent.ObserveCustomerByIdEvent);

  factory ObserveCustomerByIdEvent.create({@required String id}) =
      _ObserveCustomerByIdEventImpl<T>;

  final String id;

  /// Creates a copy of this ObserveCustomerByIdEvent but with the given fields
  /// replaced with the new values.
  ObserveCustomerByIdEvent<T> copyWith({String id});
}

@immutable
class _ObserveCustomerByIdEventImpl<T> extends ObserveCustomerByIdEvent<T> {
  const _ObserveCustomerByIdEventImpl({@required this.id}) : super(id: id);

  @override
  final String id;

  @override
  _ObserveCustomerByIdEventImpl<T> copyWith({Object id = superEnum}) =>
      _ObserveCustomerByIdEventImpl(
        id: id == superEnum ? this.id : id as String,
      );
  @override
  String toString() => 'ObserveCustomerByIdEvent(id: ${this.id})';
  @override
  List<Object> get props => [id];
}

@immutable
abstract class ObserveArtisansEvent<T> extends UserEvent<T> {
  const ObserveArtisansEvent({@required this.category})
      : super(_UserEvent.ObserveArtisansEvent);

  factory ObserveArtisansEvent.create({@required String category}) =
      _ObserveArtisansEventImpl<T>;

  final String category;

  /// Creates a copy of this ObserveArtisansEvent but with the given fields
  /// replaced with the new values.
  ObserveArtisansEvent<T> copyWith({String category});
}

@immutable
class _ObserveArtisansEventImpl<T> extends ObserveArtisansEvent<T> {
  const _ObserveArtisansEventImpl({@required this.category})
      : super(category: category);

  @override
  final String category;

  @override
  _ObserveArtisansEventImpl<T> copyWith({Object category = superEnum}) =>
      _ObserveArtisansEventImpl(
        category: category == superEnum ? this.category : category as String,
      );
  @override
  String toString() => 'ObserveArtisansEvent(category: ${this.category})';
  @override
  List<Object> get props => [category];
}
