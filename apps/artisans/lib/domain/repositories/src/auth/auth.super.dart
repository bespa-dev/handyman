// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: return_of_invalid_type, constant_identifier_names, prefer_const_constructors_in_immutables, unnecessary_this, sort_unnamed_constructors_first, join_return_with_assignment, missing_return, lines_longer_than_80_chars

part of 'auth.dart';

// **************************************************************************
// SuperEnumGenerator
// **************************************************************************

@immutable
abstract class AuthState extends Equatable {
  const AuthState(this._type);

  factory AuthState.initial() = Initial.create;

  factory AuthState.loading() = Loading.create;

  factory AuthState.authenticated() = Authenticated.create;

  factory AuthState.failed() = Failed.create;

  final _AuthState _type;

  /// The [when] method is the equivalent to pattern matching.
  /// Its prototype depends on the _AuthState [_type]s defined.
  R when<R extends Object>(
      {@required R Function() initial,
      @required R Function() loading,
      @required R Function() authenticated,
      @required R Function() failed}) {
    assert(() {
      if (initial == null ||
          loading == null ||
          authenticated == null ||
          failed == null) {
        throw 'check for all possible cases';
      }
      return true;
    }());
    switch (this._type) {
      case _AuthState.Initial:
        return initial();
      case _AuthState.Loading:
        return loading();
      case _AuthState.Authenticated:
        return authenticated();
      case _AuthState.Failed:
        return failed();
    }
  }

  /// The [whenOrElse] method is equivalent to [when], but doesn't require
  /// all callbacks to be specified.
  ///
  /// On the other hand, it adds an extra orElse required parameter,
  /// for fallback behavior.
  R whenOrElse<R extends Object>(
      {R Function() initial,
      R Function() loading,
      R Function() authenticated,
      R Function() failed,
      @required R Function(AuthState) orElse}) {
    assert(() {
      if (orElse == null) {
        throw 'Missing orElse case';
      }
      return true;
    }());
    switch (this._type) {
      case _AuthState.Initial:
        if (initial == null) break;
        return initial();
      case _AuthState.Loading:
        if (loading == null) break;
        return loading();
      case _AuthState.Authenticated:
        if (authenticated == null) break;
        return authenticated();
      case _AuthState.Failed:
        if (failed == null) break;
        return failed();
    }
    return orElse(this);
  }

  /// The [whenPartial] method is equivalent to [whenOrElse],
  /// but non-exhaustive.
  void whenPartial(
      {void Function() initial,
      void Function() loading,
      void Function() authenticated,
      void Function() failed}) {
    assert(() {
      if (initial == null &&
          loading == null &&
          authenticated == null &&
          failed == null) {
        throw 'provide at least one branch';
      }
      return true;
    }());
    switch (this._type) {
      case _AuthState.Initial:
        if (initial == null) break;
        return initial();
      case _AuthState.Loading:
        if (loading == null) break;
        return loading();
      case _AuthState.Authenticated:
        if (authenticated == null) break;
        return authenticated();
      case _AuthState.Failed:
        if (failed == null) break;
        return failed();
    }
  }

  @override
  List<Object> get props => const [];
}

@immutable
abstract class Initial extends AuthState {
  const Initial() : super(_AuthState.Initial);

  factory Initial.create() = _InitialImpl;
}

@immutable
class _InitialImpl extends Initial {
  const _InitialImpl() : super();

  @override
  String toString() => 'Initial()';
}

@immutable
abstract class Loading extends AuthState {
  const Loading() : super(_AuthState.Loading);

  factory Loading.create() = _LoadingImpl;
}

@immutable
class _LoadingImpl extends Loading {
  const _LoadingImpl() : super();

  @override
  String toString() => 'Loading()';
}

@immutable
abstract class Authenticated extends AuthState {
  const Authenticated() : super(_AuthState.Authenticated);

  factory Authenticated.create() = _AuthenticatedImpl;
}

@immutable
class _AuthenticatedImpl extends Authenticated {
  const _AuthenticatedImpl() : super();

  @override
  String toString() => 'Authenticated()';
}

@immutable
abstract class Failed extends AuthState {
  const Failed() : super(_AuthState.Failed);

  factory Failed.create() = _FailedImpl;
}

@immutable
class _FailedImpl extends Failed {
  const _FailedImpl() : super();

  @override
  String toString() => 'Failed()';
}
