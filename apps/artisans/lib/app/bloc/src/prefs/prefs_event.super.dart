// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: return_of_invalid_type, constant_identifier_names, prefer_const_constructors_in_immutables, unnecessary_this, sort_unnamed_constructors_first, join_return_with_assignment, missing_return, lines_longer_than_80_chars

part of 'prefs_event.dart';

// **************************************************************************
// SuperEnumGenerator
// **************************************************************************

@immutable
abstract class PrefsEvent extends Equatable {
  const PrefsEvent(this._type);

  factory PrefsEvent.getUserIdEvent() = GetUserIdEvent.create;

  factory PrefsEvent.getHomeAddressEvent() = GetHomeAddressEvent.create;

  factory PrefsEvent.getWorkAddressEvent() = GetWorkAddressEvent.create;

  factory PrefsEvent.getThemeEvent() = GetThemeEvent.create;

  factory PrefsEvent.getContactEvent() = GetContactEvent.create;

  factory PrefsEvent.observeThemeEvent() = ObserveThemeEvent.create;

  factory PrefsEvent.getStandardViewEvent() = GetStandardViewEvent.create;

  factory PrefsEvent.prefsSignOutEvent() = PrefsSignOutEvent.create;

  factory PrefsEvent.saveLightThemeEvent({@required bool lightTheme}) =
      SaveLightThemeEvent.create;

  factory PrefsEvent.saveStandardViewEvent({@required bool standardView}) =
      SaveStandardViewEvent.create;

  factory PrefsEvent.saveContactEvent({@required String contact}) =
      SaveContactEvent.create;

  factory PrefsEvent.saveUserIdEvent({@required String id}) =
      SaveUserIdEvent.create;

  factory PrefsEvent.saveHomeAddressEvent({@required String address}) =
      SaveHomeAddressEvent.create;

  factory PrefsEvent.saveWorkAddressEvent({@required String address}) =
      SaveWorkAddressEvent.create;

  final _PrefsEvent _type;

  /// The [when] method is the equivalent to pattern matching.
  /// Its prototype depends on the _PrefsEvent [_type]s defined.
  R when<R extends Object>(
      {@required R Function() getUserIdEvent,
      @required R Function() getHomeAddressEvent,
      @required R Function() getWorkAddressEvent,
      @required R Function() getThemeEvent,
      @required R Function() getContactEvent,
      @required R Function() observeThemeEvent,
      @required R Function() getStandardViewEvent,
      @required R Function() prefsSignOutEvent,
      @required R Function(SaveLightThemeEvent) saveLightThemeEvent,
      @required R Function(SaveStandardViewEvent) saveStandardViewEvent,
      @required R Function(SaveContactEvent) saveContactEvent,
      @required R Function(SaveUserIdEvent) saveUserIdEvent,
      @required R Function(SaveHomeAddressEvent) saveHomeAddressEvent,
      @required R Function(SaveWorkAddressEvent) saveWorkAddressEvent}) {
    assert(() {
      if (getUserIdEvent == null ||
          getHomeAddressEvent == null ||
          getWorkAddressEvent == null ||
          getThemeEvent == null ||
          getContactEvent == null ||
          observeThemeEvent == null ||
          getStandardViewEvent == null ||
          prefsSignOutEvent == null ||
          saveLightThemeEvent == null ||
          saveStandardViewEvent == null ||
          saveContactEvent == null ||
          saveUserIdEvent == null ||
          saveHomeAddressEvent == null ||
          saveWorkAddressEvent == null) {
        throw 'check for all possible cases';
      }
      return true;
    }());
    switch (this._type) {
      case _PrefsEvent.GetUserIdEvent:
        return getUserIdEvent();
      case _PrefsEvent.GetHomeAddressEvent:
        return getHomeAddressEvent();
      case _PrefsEvent.GetWorkAddressEvent:
        return getWorkAddressEvent();
      case _PrefsEvent.GetThemeEvent:
        return getThemeEvent();
      case _PrefsEvent.GetContactEvent:
        return getContactEvent();
      case _PrefsEvent.ObserveThemeEvent:
        return observeThemeEvent();
      case _PrefsEvent.GetStandardViewEvent:
        return getStandardViewEvent();
      case _PrefsEvent.PrefsSignOutEvent:
        return prefsSignOutEvent();
      case _PrefsEvent.SaveLightThemeEvent:
        return saveLightThemeEvent(this as SaveLightThemeEvent);
      case _PrefsEvent.SaveStandardViewEvent:
        return saveStandardViewEvent(this as SaveStandardViewEvent);
      case _PrefsEvent.SaveContactEvent:
        return saveContactEvent(this as SaveContactEvent);
      case _PrefsEvent.SaveUserIdEvent:
        return saveUserIdEvent(this as SaveUserIdEvent);
      case _PrefsEvent.SaveHomeAddressEvent:
        return saveHomeAddressEvent(this as SaveHomeAddressEvent);
      case _PrefsEvent.SaveWorkAddressEvent:
        return saveWorkAddressEvent(this as SaveWorkAddressEvent);
    }
  }

  /// The [whenOrElse] method is equivalent to [when], but doesn't require
  /// all callbacks to be specified.
  ///
  /// On the other hand, it adds an extra orElse required parameter,
  /// for fallback behavior.
  R whenOrElse<R extends Object>(
      {R Function() getUserIdEvent,
      R Function() getHomeAddressEvent,
      R Function() getWorkAddressEvent,
      R Function() getThemeEvent,
      R Function() getContactEvent,
      R Function() observeThemeEvent,
      R Function() getStandardViewEvent,
      R Function() prefsSignOutEvent,
      R Function(SaveLightThemeEvent) saveLightThemeEvent,
      R Function(SaveStandardViewEvent) saveStandardViewEvent,
      R Function(SaveContactEvent) saveContactEvent,
      R Function(SaveUserIdEvent) saveUserIdEvent,
      R Function(SaveHomeAddressEvent) saveHomeAddressEvent,
      R Function(SaveWorkAddressEvent) saveWorkAddressEvent,
      @required R Function(PrefsEvent) orElse}) {
    assert(() {
      if (orElse == null) {
        throw 'Missing orElse case';
      }
      return true;
    }());
    switch (this._type) {
      case _PrefsEvent.GetUserIdEvent:
        if (getUserIdEvent == null) break;
        return getUserIdEvent();
      case _PrefsEvent.GetHomeAddressEvent:
        if (getHomeAddressEvent == null) break;
        return getHomeAddressEvent();
      case _PrefsEvent.GetWorkAddressEvent:
        if (getWorkAddressEvent == null) break;
        return getWorkAddressEvent();
      case _PrefsEvent.GetThemeEvent:
        if (getThemeEvent == null) break;
        return getThemeEvent();
      case _PrefsEvent.GetContactEvent:
        if (getContactEvent == null) break;
        return getContactEvent();
      case _PrefsEvent.ObserveThemeEvent:
        if (observeThemeEvent == null) break;
        return observeThemeEvent();
      case _PrefsEvent.GetStandardViewEvent:
        if (getStandardViewEvent == null) break;
        return getStandardViewEvent();
      case _PrefsEvent.PrefsSignOutEvent:
        if (prefsSignOutEvent == null) break;
        return prefsSignOutEvent();
      case _PrefsEvent.SaveLightThemeEvent:
        if (saveLightThemeEvent == null) break;
        return saveLightThemeEvent(this as SaveLightThemeEvent);
      case _PrefsEvent.SaveStandardViewEvent:
        if (saveStandardViewEvent == null) break;
        return saveStandardViewEvent(this as SaveStandardViewEvent);
      case _PrefsEvent.SaveContactEvent:
        if (saveContactEvent == null) break;
        return saveContactEvent(this as SaveContactEvent);
      case _PrefsEvent.SaveUserIdEvent:
        if (saveUserIdEvent == null) break;
        return saveUserIdEvent(this as SaveUserIdEvent);
      case _PrefsEvent.SaveHomeAddressEvent:
        if (saveHomeAddressEvent == null) break;
        return saveHomeAddressEvent(this as SaveHomeAddressEvent);
      case _PrefsEvent.SaveWorkAddressEvent:
        if (saveWorkAddressEvent == null) break;
        return saveWorkAddressEvent(this as SaveWorkAddressEvent);
    }
    return orElse(this);
  }

  /// The [whenPartial] method is equivalent to [whenOrElse],
  /// but non-exhaustive.
  void whenPartial(
      {void Function() getUserIdEvent,
      void Function() getHomeAddressEvent,
      void Function() getWorkAddressEvent,
      void Function() getThemeEvent,
      void Function() getContactEvent,
      void Function() observeThemeEvent,
      void Function() getStandardViewEvent,
      void Function() prefsSignOutEvent,
      void Function(SaveLightThemeEvent) saveLightThemeEvent,
      void Function(SaveStandardViewEvent) saveStandardViewEvent,
      void Function(SaveContactEvent) saveContactEvent,
      void Function(SaveUserIdEvent) saveUserIdEvent,
      void Function(SaveHomeAddressEvent) saveHomeAddressEvent,
      void Function(SaveWorkAddressEvent) saveWorkAddressEvent}) {
    assert(() {
      if (getUserIdEvent == null &&
          getHomeAddressEvent == null &&
          getWorkAddressEvent == null &&
          getThemeEvent == null &&
          getContactEvent == null &&
          observeThemeEvent == null &&
          getStandardViewEvent == null &&
          prefsSignOutEvent == null &&
          saveLightThemeEvent == null &&
          saveStandardViewEvent == null &&
          saveContactEvent == null &&
          saveUserIdEvent == null &&
          saveHomeAddressEvent == null &&
          saveWorkAddressEvent == null) {
        throw 'provide at least one branch';
      }
      return true;
    }());
    switch (this._type) {
      case _PrefsEvent.GetUserIdEvent:
        if (getUserIdEvent == null) break;
        return getUserIdEvent();
      case _PrefsEvent.GetHomeAddressEvent:
        if (getHomeAddressEvent == null) break;
        return getHomeAddressEvent();
      case _PrefsEvent.GetWorkAddressEvent:
        if (getWorkAddressEvent == null) break;
        return getWorkAddressEvent();
      case _PrefsEvent.GetThemeEvent:
        if (getThemeEvent == null) break;
        return getThemeEvent();
      case _PrefsEvent.GetContactEvent:
        if (getContactEvent == null) break;
        return getContactEvent();
      case _PrefsEvent.ObserveThemeEvent:
        if (observeThemeEvent == null) break;
        return observeThemeEvent();
      case _PrefsEvent.GetStandardViewEvent:
        if (getStandardViewEvent == null) break;
        return getStandardViewEvent();
      case _PrefsEvent.PrefsSignOutEvent:
        if (prefsSignOutEvent == null) break;
        return prefsSignOutEvent();
      case _PrefsEvent.SaveLightThemeEvent:
        if (saveLightThemeEvent == null) break;
        return saveLightThemeEvent(this as SaveLightThemeEvent);
      case _PrefsEvent.SaveStandardViewEvent:
        if (saveStandardViewEvent == null) break;
        return saveStandardViewEvent(this as SaveStandardViewEvent);
      case _PrefsEvent.SaveContactEvent:
        if (saveContactEvent == null) break;
        return saveContactEvent(this as SaveContactEvent);
      case _PrefsEvent.SaveUserIdEvent:
        if (saveUserIdEvent == null) break;
        return saveUserIdEvent(this as SaveUserIdEvent);
      case _PrefsEvent.SaveHomeAddressEvent:
        if (saveHomeAddressEvent == null) break;
        return saveHomeAddressEvent(this as SaveHomeAddressEvent);
      case _PrefsEvent.SaveWorkAddressEvent:
        if (saveWorkAddressEvent == null) break;
        return saveWorkAddressEvent(this as SaveWorkAddressEvent);
    }
  }

  @override
  List<Object> get props => const [];
}

@immutable
abstract class GetUserIdEvent extends PrefsEvent {
  const GetUserIdEvent() : super(_PrefsEvent.GetUserIdEvent);

  factory GetUserIdEvent.create() = _GetUserIdEventImpl;
}

@immutable
class _GetUserIdEventImpl extends GetUserIdEvent {
  const _GetUserIdEventImpl() : super();

  @override
  String toString() => 'GetUserIdEvent()';
}

@immutable
abstract class GetHomeAddressEvent extends PrefsEvent {
  const GetHomeAddressEvent() : super(_PrefsEvent.GetHomeAddressEvent);

  factory GetHomeAddressEvent.create() = _GetHomeAddressEventImpl;
}

@immutable
class _GetHomeAddressEventImpl extends GetHomeAddressEvent {
  const _GetHomeAddressEventImpl() : super();

  @override
  String toString() => 'GetHomeAddressEvent()';
}

@immutable
abstract class GetWorkAddressEvent extends PrefsEvent {
  const GetWorkAddressEvent() : super(_PrefsEvent.GetWorkAddressEvent);

  factory GetWorkAddressEvent.create() = _GetWorkAddressEventImpl;
}

@immutable
class _GetWorkAddressEventImpl extends GetWorkAddressEvent {
  const _GetWorkAddressEventImpl() : super();

  @override
  String toString() => 'GetWorkAddressEvent()';
}

@immutable
abstract class GetThemeEvent extends PrefsEvent {
  const GetThemeEvent() : super(_PrefsEvent.GetThemeEvent);

  factory GetThemeEvent.create() = _GetThemeEventImpl;
}

@immutable
class _GetThemeEventImpl extends GetThemeEvent {
  const _GetThemeEventImpl() : super();

  @override
  String toString() => 'GetThemeEvent()';
}

@immutable
abstract class GetContactEvent extends PrefsEvent {
  const GetContactEvent() : super(_PrefsEvent.GetContactEvent);

  factory GetContactEvent.create() = _GetContactEventImpl;
}

@immutable
class _GetContactEventImpl extends GetContactEvent {
  const _GetContactEventImpl() : super();

  @override
  String toString() => 'GetContactEvent()';
}

@immutable
abstract class ObserveThemeEvent extends PrefsEvent {
  const ObserveThemeEvent() : super(_PrefsEvent.ObserveThemeEvent);

  factory ObserveThemeEvent.create() = _ObserveThemeEventImpl;
}

@immutable
class _ObserveThemeEventImpl extends ObserveThemeEvent {
  const _ObserveThemeEventImpl() : super();

  @override
  String toString() => 'ObserveThemeEvent()';
}

@immutable
abstract class GetStandardViewEvent extends PrefsEvent {
  const GetStandardViewEvent() : super(_PrefsEvent.GetStandardViewEvent);

  factory GetStandardViewEvent.create() = _GetStandardViewEventImpl;
}

@immutable
class _GetStandardViewEventImpl extends GetStandardViewEvent {
  const _GetStandardViewEventImpl() : super();

  @override
  String toString() => 'GetStandardViewEvent()';
}

@immutable
abstract class PrefsSignOutEvent extends PrefsEvent {
  const PrefsSignOutEvent() : super(_PrefsEvent.PrefsSignOutEvent);

  factory PrefsSignOutEvent.create() = _PrefsSignOutEventImpl;
}

@immutable
class _PrefsSignOutEventImpl extends PrefsSignOutEvent {
  const _PrefsSignOutEventImpl() : super();

  @override
  String toString() => 'PrefsSignOutEvent()';
}

@immutable
abstract class SaveLightThemeEvent extends PrefsEvent {
  const SaveLightThemeEvent({@required this.lightTheme})
      : super(_PrefsEvent.SaveLightThemeEvent);

  factory SaveLightThemeEvent.create({@required bool lightTheme}) =
      _SaveLightThemeEventImpl;

  final bool lightTheme;

  /// Creates a copy of this SaveLightThemeEvent but with the given fields
  /// replaced with the new values.
  SaveLightThemeEvent copyWith({bool lightTheme});
}

@immutable
class _SaveLightThemeEventImpl extends SaveLightThemeEvent {
  const _SaveLightThemeEventImpl({@required this.lightTheme})
      : super(lightTheme: lightTheme);

  @override
  final bool lightTheme;

  @override
  _SaveLightThemeEventImpl copyWith({Object lightTheme = superEnum}) =>
      _SaveLightThemeEventImpl(
        lightTheme:
            lightTheme == superEnum ? this.lightTheme : lightTheme as bool,
      );
  @override
  String toString() => 'SaveLightThemeEvent(lightTheme: ${this.lightTheme})';
  @override
  List<Object> get props => [lightTheme];
}

@immutable
abstract class SaveStandardViewEvent extends PrefsEvent {
  const SaveStandardViewEvent({@required this.standardView})
      : super(_PrefsEvent.SaveStandardViewEvent);

  factory SaveStandardViewEvent.create({@required bool standardView}) =
      _SaveStandardViewEventImpl;

  final bool standardView;

  /// Creates a copy of this SaveStandardViewEvent but with the given fields
  /// replaced with the new values.
  SaveStandardViewEvent copyWith({bool standardView});
}

@immutable
class _SaveStandardViewEventImpl extends SaveStandardViewEvent {
  const _SaveStandardViewEventImpl({@required this.standardView})
      : super(standardView: standardView);

  @override
  final bool standardView;

  @override
  _SaveStandardViewEventImpl copyWith({Object standardView = superEnum}) =>
      _SaveStandardViewEventImpl(
        standardView: standardView == superEnum
            ? this.standardView
            : standardView as bool,
      );
  @override
  String toString() =>
      'SaveStandardViewEvent(standardView: ${this.standardView})';
  @override
  List<Object> get props => [standardView];
}

@immutable
abstract class SaveContactEvent extends PrefsEvent {
  const SaveContactEvent({@required this.contact})
      : super(_PrefsEvent.SaveContactEvent);

  factory SaveContactEvent.create({@required String contact}) =
      _SaveContactEventImpl;

  final String contact;

  /// Creates a copy of this SaveContactEvent but with the given fields
  /// replaced with the new values.
  SaveContactEvent copyWith({String contact});
}

@immutable
class _SaveContactEventImpl extends SaveContactEvent {
  const _SaveContactEventImpl({@required this.contact})
      : super(contact: contact);

  @override
  final String contact;

  @override
  _SaveContactEventImpl copyWith({Object contact = superEnum}) =>
      _SaveContactEventImpl(
        contact: contact == superEnum ? this.contact : contact as String,
      );
  @override
  String toString() => 'SaveContactEvent(contact: ${this.contact})';
  @override
  List<Object> get props => [contact];
}

@immutable
abstract class SaveUserIdEvent extends PrefsEvent {
  const SaveUserIdEvent({@required this.id})
      : super(_PrefsEvent.SaveUserIdEvent);

  factory SaveUserIdEvent.create({@required String id}) = _SaveUserIdEventImpl;

  final String id;

  /// Creates a copy of this SaveUserIdEvent but with the given fields
  /// replaced with the new values.
  SaveUserIdEvent copyWith({String id});
}

@immutable
class _SaveUserIdEventImpl extends SaveUserIdEvent {
  const _SaveUserIdEventImpl({@required this.id}) : super(id: id);

  @override
  final String id;

  @override
  _SaveUserIdEventImpl copyWith({Object id = superEnum}) =>
      _SaveUserIdEventImpl(
        id: id == superEnum ? this.id : id as String,
      );
  @override
  String toString() => 'SaveUserIdEvent(id: ${this.id})';
  @override
  List<Object> get props => [id];
}

@immutable
abstract class SaveHomeAddressEvent extends PrefsEvent {
  const SaveHomeAddressEvent({@required this.address})
      : super(_PrefsEvent.SaveHomeAddressEvent);

  factory SaveHomeAddressEvent.create({@required String address}) =
      _SaveHomeAddressEventImpl;

  final String address;

  /// Creates a copy of this SaveHomeAddressEvent but with the given fields
  /// replaced with the new values.
  SaveHomeAddressEvent copyWith({String address});
}

@immutable
class _SaveHomeAddressEventImpl extends SaveHomeAddressEvent {
  const _SaveHomeAddressEventImpl({@required this.address})
      : super(address: address);

  @override
  final String address;

  @override
  _SaveHomeAddressEventImpl copyWith({Object address = superEnum}) =>
      _SaveHomeAddressEventImpl(
        address: address == superEnum ? this.address : address as String,
      );
  @override
  String toString() => 'SaveHomeAddressEvent(address: ${this.address})';
  @override
  List<Object> get props => [address];
}

@immutable
abstract class SaveWorkAddressEvent extends PrefsEvent {
  const SaveWorkAddressEvent({@required this.address})
      : super(_PrefsEvent.SaveWorkAddressEvent);

  factory SaveWorkAddressEvent.create({@required String address}) =
      _SaveWorkAddressEventImpl;

  final String address;

  /// Creates a copy of this SaveWorkAddressEvent but with the given fields
  /// replaced with the new values.
  SaveWorkAddressEvent copyWith({String address});
}

@immutable
class _SaveWorkAddressEventImpl extends SaveWorkAddressEvent {
  const _SaveWorkAddressEventImpl({@required this.address})
      : super(address: address);

  @override
  final String address;

  @override
  _SaveWorkAddressEventImpl copyWith({Object address = superEnum}) =>
      _SaveWorkAddressEventImpl(
        address: address == superEnum ? this.address : address as String,
      );
  @override
  String toString() => 'SaveWorkAddressEvent(address: ${this.address})';
  @override
  List<Object> get props => [address];
}
