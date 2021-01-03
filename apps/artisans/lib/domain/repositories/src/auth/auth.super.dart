// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: return_of_invalid_type, constant_identifier_names, prefer_const_constructors_in_immutables, unnecessary_this, sort_unnamed_constructors_first, join_return_with_assignment, missing_return, lines_longer_than_80_chars

part of 'auth.dart';

// **************************************************************************
// SuperEnumGenerator
// **************************************************************************

@immutable
abstract class AuthState extends Equatable {
  const AuthState(this._type);

  factory AuthState.authInitialState() = AuthInitialState.create;

  factory AuthState.authLoadingState() = AuthLoadingState.create;

  factory AuthState.authSuccessState() = AuthSuccessState.create;

  factory AuthState.authenticatedState({@required BaseUser user}) =
      AuthenticatedState.create;

  factory AuthState.authFailedState({String message}) = AuthFailedState.create;

  factory AuthState.authInvalidCredentialsState() =
      AuthInvalidCredentialsState.create;

  final _AuthState _type;

  /// The [when] method is the equivalent to pattern matching.
  /// Its prototype depends on the _AuthState [_type]s defined.
  R when<R extends Object>(
      {@required R Function() authInitialState,
      @required R Function() authLoadingState,
      @required R Function() authSuccessState,
      @required R Function(AuthenticatedState) authenticatedState,
      @required R Function(AuthFailedState) authFailedState,
      @required R Function() authInvalidCredentialsState}) {
    assert(() {
      if (authInitialState == null ||
          authLoadingState == null ||
          authSuccessState == null ||
          authenticatedState == null ||
          authFailedState == null ||
          authInvalidCredentialsState == null) {
        throw 'check for all possible cases';
      }
      return true;
    }());
    switch (this._type) {
      case _AuthState.AuthInitialState:
        return authInitialState();
      case _AuthState.AuthLoadingState:
        return authLoadingState();
      case _AuthState.AuthSuccessState:
        return authSuccessState();
      case _AuthState.AuthenticatedState:
        return authenticatedState(this as AuthenticatedState);
      case _AuthState.AuthFailedState:
        return authFailedState(this as AuthFailedState);
      case _AuthState.AuthInvalidCredentialsState:
        return authInvalidCredentialsState();
    }
  }

  /// The [whenOrElse] method is equivalent to [when], but doesn't require
  /// all callbacks to be specified.
  ///
  /// On the other hand, it adds an extra orElse required parameter,
  /// for fallback behavior.
  R whenOrElse<R extends Object>(
      {R Function() authInitialState,
      R Function() authLoadingState,
      R Function() authSuccessState,
      R Function(AuthenticatedState) authenticatedState,
      R Function(AuthFailedState) authFailedState,
      R Function() authInvalidCredentialsState,
      @required R Function(AuthState) orElse}) {
    assert(() {
      if (orElse == null) {
        throw 'Missing orElse case';
      }
      return true;
    }());
    switch (this._type) {
      case _AuthState.AuthInitialState:
        if (authInitialState == null) break;
        return authInitialState();
      case _AuthState.AuthLoadingState:
        if (authLoadingState == null) break;
        return authLoadingState();
      case _AuthState.AuthSuccessState:
        if (authSuccessState == null) break;
        return authSuccessState();
      case _AuthState.AuthenticatedState:
        if (authenticatedState == null) break;
        return authenticatedState(this as AuthenticatedState);
      case _AuthState.AuthFailedState:
        if (authFailedState == null) break;
        return authFailedState(this as AuthFailedState);
      case _AuthState.AuthInvalidCredentialsState:
        if (authInvalidCredentialsState == null) break;
        return authInvalidCredentialsState();
    }
    return orElse(this);
  }

  /// The [whenPartial] method is equivalent to [whenOrElse],
  /// but non-exhaustive.
  void whenPartial(
      {void Function() authInitialState,
      void Function() authLoadingState,
      void Function() authSuccessState,
      void Function(AuthenticatedState) authenticatedState,
      void Function(AuthFailedState) authFailedState,
      void Function() authInvalidCredentialsState}) {
    assert(() {
      if (authInitialState == null &&
          authLoadingState == null &&
          authSuccessState == null &&
          authenticatedState == null &&
          authFailedState == null &&
          authInvalidCredentialsState == null) {
        throw 'provide at least one branch';
      }
      return true;
    }());
    switch (this._type) {
      case _AuthState.AuthInitialState:
        if (authInitialState == null) break;
        return authInitialState();
      case _AuthState.AuthLoadingState:
        if (authLoadingState == null) break;
        return authLoadingState();
      case _AuthState.AuthSuccessState:
        if (authSuccessState == null) break;
        return authSuccessState();
      case _AuthState.AuthenticatedState:
        if (authenticatedState == null) break;
        return authenticatedState(this as AuthenticatedState);
      case _AuthState.AuthFailedState:
        if (authFailedState == null) break;
        return authFailedState(this as AuthFailedState);
      case _AuthState.AuthInvalidCredentialsState:
        if (authInvalidCredentialsState == null) break;
        return authInvalidCredentialsState();
    }
  }

  @override
  List<Object> get props => const [];
}

@immutable
abstract class AuthInitialState extends AuthState {
  const AuthInitialState() : super(_AuthState.AuthInitialState);

  factory AuthInitialState.create() = _AuthInitialStateImpl;
}

@immutable
class _AuthInitialStateImpl extends AuthInitialState {
  const _AuthInitialStateImpl() : super();

  @override
  String toString() => 'AuthInitialState()';
}

@immutable
abstract class AuthLoadingState extends AuthState {
  const AuthLoadingState() : super(_AuthState.AuthLoadingState);

  factory AuthLoadingState.create() = _AuthLoadingStateImpl;
}

@immutable
class _AuthLoadingStateImpl extends AuthLoadingState {
  const _AuthLoadingStateImpl() : super();

  @override
  String toString() => 'AuthLoadingState()';
}

@immutable
abstract class AuthSuccessState extends AuthState {
  const AuthSuccessState() : super(_AuthState.AuthSuccessState);

  factory AuthSuccessState.create() = _AuthSuccessStateImpl;
}

@immutable
class _AuthSuccessStateImpl extends AuthSuccessState {
  const _AuthSuccessStateImpl() : super();

  @override
  String toString() => 'AuthSuccessState()';
}

@immutable
abstract class AuthenticatedState extends AuthState {
  const AuthenticatedState({@required this.user})
      : super(_AuthState.AuthenticatedState);

  factory AuthenticatedState.create({@required BaseUser user}) =
      _AuthenticatedStateImpl;

  final BaseUser user;

  /// Creates a copy of this AuthenticatedState but with the given fields
  /// replaced with the new values.
  AuthenticatedState copyWith({BaseUser user});
}

@immutable
class _AuthenticatedStateImpl extends AuthenticatedState {
  const _AuthenticatedStateImpl({@required this.user}) : super(user: user);

  @override
  final BaseUser user;

  @override
  _AuthenticatedStateImpl copyWith({Object user = superEnum}) =>
      _AuthenticatedStateImpl(
        user: user == superEnum ? this.user : user as BaseUser,
      );
  @override
  String toString() => 'AuthenticatedState(user: ${this.user})';
  @override
  List<Object> get props => [user];
}

@immutable
abstract class AuthFailedState extends AuthState {
  const AuthFailedState({this.message}) : super(_AuthState.AuthFailedState);

  factory AuthFailedState.create({String message}) = _AuthFailedStateImpl;

  final String message;

  /// Creates a copy of this AuthFailedState but with the given fields
  /// replaced with the new values.
  AuthFailedState copyWith({String message});
}

@immutable
class _AuthFailedStateImpl extends AuthFailedState {
  const _AuthFailedStateImpl({this.message}) : super(message: message);

  @override
  final String message;

  @override
  _AuthFailedStateImpl copyWith({Object message = superEnum}) =>
      _AuthFailedStateImpl(
        message: message == superEnum ? this.message : message as String,
      );
  @override
  String toString() => 'AuthFailedState(message: ${this.message})';
  @override
  List<Object> get props => [message];
}

@immutable
abstract class AuthInvalidCredentialsState extends AuthState {
  const AuthInvalidCredentialsState()
      : super(_AuthState.AuthInvalidCredentialsState);

  factory AuthInvalidCredentialsState.create() =
      _AuthInvalidCredentialsStateImpl;
}

@immutable
class _AuthInvalidCredentialsStateImpl extends AuthInvalidCredentialsState {
  const _AuthInvalidCredentialsStateImpl() : super();

  @override
  String toString() => 'AuthInvalidCredentialsState()';
}
