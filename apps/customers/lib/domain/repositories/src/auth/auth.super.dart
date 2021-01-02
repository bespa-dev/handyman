// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: return_of_invalid_type, constant_identifier_names, prefer_const_constructors_in_immutables, unnecessary_this, sort_unnamed_constructors_first, join_return_with_assignment, missing_return, lines_longer_than_80_chars

part of 'auth.dart';

// **************************************************************************
// SuperEnumGenerator
// **************************************************************************

@immutable
abstract class AuthState extends Equatable {
  const AuthState(this._type);

  factory AuthState.initialState() = InitialState.create;

  factory AuthState.loadingState() = LoadingState.create;

  factory AuthState.successState() = SuccessState.create;

  factory AuthState.authenticatedState({@required BaseUser user}) =
      AuthenticatedState.create;

  factory AuthState.failedState({String message}) = FailedState.create;

  factory AuthState.invalidCredentialsState() = InvalidCredentialsState.create;

  final _AuthState _type;

  /// The [when] method is the equivalent to pattern matching.
  /// Its prototype depends on the _AuthState [_type]s defined.
  R when<R extends Object>(
      {@required R Function() initialState,
      @required R Function() loadingState,
      @required R Function() successState,
      @required R Function(AuthenticatedState) authenticatedState,
      @required R Function(FailedState) failedState,
      @required R Function() invalidCredentialsState}) {
    assert(() {
      if (initialState == null ||
          loadingState == null ||
          successState == null ||
          authenticatedState == null ||
          failedState == null ||
          invalidCredentialsState == null) {
        throw 'check for all possible cases';
      }
      return true;
    }());
    switch (this._type) {
      case _AuthState.InitialState:
        return initialState();
      case _AuthState.LoadingState:
        return loadingState();
      case _AuthState.SuccessState:
        return successState();
      case _AuthState.AuthenticatedState:
        return authenticatedState(this as AuthenticatedState);
      case _AuthState.FailedState:
        return failedState(this as FailedState);
      case _AuthState.InvalidCredentialsState:
        return invalidCredentialsState();
    }
  }

  /// The [whenOrElse] method is equivalent to [when], but doesn't require
  /// all callbacks to be specified.
  ///
  /// On the other hand, it adds an extra orElse required parameter,
  /// for fallback behavior.
  R whenOrElse<R extends Object>(
      {R Function() initialState,
      R Function() loadingState,
      R Function() successState,
      R Function(AuthenticatedState) authenticatedState,
      R Function(FailedState) failedState,
      R Function() invalidCredentialsState,
      @required R Function(AuthState) orElse}) {
    assert(() {
      if (orElse == null) {
        throw 'Missing orElse case';
      }
      return true;
    }());
    switch (this._type) {
      case _AuthState.InitialState:
        if (initialState == null) break;
        return initialState();
      case _AuthState.LoadingState:
        if (loadingState == null) break;
        return loadingState();
      case _AuthState.SuccessState:
        if (successState == null) break;
        return successState();
      case _AuthState.AuthenticatedState:
        if (authenticatedState == null) break;
        return authenticatedState(this as AuthenticatedState);
      case _AuthState.FailedState:
        if (failedState == null) break;
        return failedState(this as FailedState);
      case _AuthState.InvalidCredentialsState:
        if (invalidCredentialsState == null) break;
        return invalidCredentialsState();
    }
    return orElse(this);
  }

  /// The [whenPartial] method is equivalent to [whenOrElse],
  /// but non-exhaustive.
  void whenPartial(
      {void Function() initialState,
      void Function() loadingState,
      void Function() successState,
      void Function(AuthenticatedState) authenticatedState,
      void Function(FailedState) failedState,
      void Function() invalidCredentialsState}) {
    assert(() {
      if (initialState == null &&
          loadingState == null &&
          successState == null &&
          authenticatedState == null &&
          failedState == null &&
          invalidCredentialsState == null) {
        throw 'provide at least one branch';
      }
      return true;
    }());
    switch (this._type) {
      case _AuthState.InitialState:
        if (initialState == null) break;
        return initialState();
      case _AuthState.LoadingState:
        if (loadingState == null) break;
        return loadingState();
      case _AuthState.SuccessState:
        if (successState == null) break;
        return successState();
      case _AuthState.AuthenticatedState:
        if (authenticatedState == null) break;
        return authenticatedState(this as AuthenticatedState);
      case _AuthState.FailedState:
        if (failedState == null) break;
        return failedState(this as FailedState);
      case _AuthState.InvalidCredentialsState:
        if (invalidCredentialsState == null) break;
        return invalidCredentialsState();
    }
  }

  @override
  List<Object> get props => const [];
}

@immutable
abstract class InitialState extends AuthState {
  const InitialState() : super(_AuthState.InitialState);

  factory InitialState.create() = _InitialStateImpl;
}

@immutable
class _InitialStateImpl extends InitialState {
  const _InitialStateImpl() : super();

  @override
  String toString() => 'InitialState()';
}

@immutable
abstract class LoadingState extends AuthState {
  const LoadingState() : super(_AuthState.LoadingState);

  factory LoadingState.create() = _LoadingStateImpl;
}

@immutable
class _LoadingStateImpl extends LoadingState {
  const _LoadingStateImpl() : super();

  @override
  String toString() => 'LoadingState()';
}

@immutable
abstract class SuccessState extends AuthState {
  const SuccessState() : super(_AuthState.SuccessState);

  factory SuccessState.create() = _SuccessStateImpl;
}

@immutable
class _SuccessStateImpl extends SuccessState {
  const _SuccessStateImpl() : super();

  @override
  String toString() => 'SuccessState()';
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
abstract class FailedState extends AuthState {
  const FailedState({this.message}) : super(_AuthState.FailedState);

  factory FailedState.create({String message}) = _FailedStateImpl;

  final String message;

  /// Creates a copy of this FailedState but with the given fields
  /// replaced with the new values.
  FailedState copyWith({String message});
}

@immutable
class _FailedStateImpl extends FailedState {
  const _FailedStateImpl({this.message}) : super(message: message);

  @override
  final String message;

  @override
  _FailedStateImpl copyWith({Object message = superEnum}) => _FailedStateImpl(
        message: message == superEnum ? this.message : message as String,
      );
  @override
  String toString() => 'FailedState(message: ${this.message})';
  @override
  List<Object> get props => [message];
}

@immutable
abstract class InvalidCredentialsState extends AuthState {
  const InvalidCredentialsState() : super(_AuthState.InvalidCredentialsState);

  factory InvalidCredentialsState.create() = _InvalidCredentialsStateImpl;
}

@immutable
class _InvalidCredentialsStateImpl extends InvalidCredentialsState {
  const _InvalidCredentialsStateImpl() : super();

  @override
  String toString() => 'InvalidCredentialsState()';
}
