// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: return_of_invalid_type, constant_identifier_names, prefer_const_constructors_in_immutables, unnecessary_this, sort_unnamed_constructors_first, join_return_with_assignment, missing_return, lines_longer_than_80_chars

part of 'auth_event.dart';

// **************************************************************************
// SuperEnumGenerator
// **************************************************************************

@immutable
abstract class AuthEvent extends Equatable {
  const AuthEvent(this._type);

  factory AuthEvent.emailSignInEvent(
      {@required String email,
      @required String password}) = EmailSignInEvent.create;

  factory AuthEvent.emailSignUpEvent(
      {@required String username,
      @required String email,
      @required String password}) = EmailSignUpEvent.create;

  factory AuthEvent.resetPasswordEvent({@required String email}) =
      ResetPasswordEvent.create;

  factory AuthEvent.federatedOAuthEvent() = FederatedOAuthEvent.create;

  factory AuthEvent.authSignOutEvent() = AuthSignOutEvent.create;

  factory AuthEvent.observeMessageEvent() = ObserveMessageEvent.create;

  factory AuthEvent.observeAuthStateEvent() = ObserveAuthStatetEvent.create;

  final _AuthEvent _type;

  /// The [when] method is the equivalent to pattern matching.
  /// Its prototype depends on the _AuthEvent [_type]s defined.
  R when<R extends Object>(
      {@required R Function(EmailSignInEvent) emailSignInEvent,
      @required R Function(EmailSignUpEvent) emailSignUpEvent,
      @required R Function(ResetPasswordEvent) resetPasswordEvent,
      @required R Function() federatedOAuthEvent,
      @required R Function() authSignOutEvent,
      @required R Function() observeMessageEvent,
      @required R Function() observeAuthStatetEvent}) {
    assert(() {
      if (emailSignInEvent == null ||
          emailSignUpEvent == null ||
          resetPasswordEvent == null ||
          federatedOAuthEvent == null ||
          authSignOutEvent == null ||
          observeMessageEvent == null ||
          observeAuthStatetEvent == null) {
        throw 'check for all possible cases';
      }
      return true;
    }());
    switch (this._type) {
      case _AuthEvent.EmailSignInEvent:
        return emailSignInEvent(this as EmailSignInEvent);
      case _AuthEvent.EmailSignUpEvent:
        return emailSignUpEvent(this as EmailSignUpEvent);
      case _AuthEvent.ResetPasswordEvent:
        return resetPasswordEvent(this as ResetPasswordEvent);
      case _AuthEvent.FederatedOAuthEvent:
        return federatedOAuthEvent();
      case _AuthEvent.AuthSignOutEvent:
        return authSignOutEvent();
      case _AuthEvent.ObserveMessageEvent:
        return observeMessageEvent();
      case _AuthEvent.ObserveAuthStatetEvent:
        return observeAuthStatetEvent();
    }
  }

  /// The [whenOrElse] method is equivalent to [when], but doesn't require
  /// all callbacks to be specified.
  ///
  /// On the other hand, it adds an extra orElse required parameter,
  /// for fallback behavior.
  R whenOrElse<R extends Object>(
      {R Function(EmailSignInEvent) emailSignInEvent,
      R Function(EmailSignUpEvent) emailSignUpEvent,
      R Function(ResetPasswordEvent) resetPasswordEvent,
      R Function() federatedOAuthEvent,
      R Function() authSignOutEvent,
      R Function() observeMessageEvent,
      R Function() observeAuthStatetEvent,
      @required R Function(AuthEvent) orElse}) {
    assert(() {
      if (orElse == null) {
        throw 'Missing orElse case';
      }
      return true;
    }());
    switch (this._type) {
      case _AuthEvent.EmailSignInEvent:
        if (emailSignInEvent == null) break;
        return emailSignInEvent(this as EmailSignInEvent);
      case _AuthEvent.EmailSignUpEvent:
        if (emailSignUpEvent == null) break;
        return emailSignUpEvent(this as EmailSignUpEvent);
      case _AuthEvent.ResetPasswordEvent:
        if (resetPasswordEvent == null) break;
        return resetPasswordEvent(this as ResetPasswordEvent);
      case _AuthEvent.FederatedOAuthEvent:
        if (federatedOAuthEvent == null) break;
        return federatedOAuthEvent();
      case _AuthEvent.AuthSignOutEvent:
        if (authSignOutEvent == null) break;
        return authSignOutEvent();
      case _AuthEvent.ObserveMessageEvent:
        if (observeMessageEvent == null) break;
        return observeMessageEvent();
      case _AuthEvent.ObserveAuthStatetEvent:
        if (observeAuthStatetEvent == null) break;
        return observeAuthStatetEvent();
    }
    return orElse(this);
  }

  /// The [whenPartial] method is equivalent to [whenOrElse],
  /// but non-exhaustive.
  void whenPartial(
      {void Function(EmailSignInEvent) emailSignInEvent,
      void Function(EmailSignUpEvent) emailSignUpEvent,
      void Function(ResetPasswordEvent) resetPasswordEvent,
      void Function() federatedOAuthEvent,
      void Function() authSignOutEvent,
      void Function() observeMessageEvent,
      void Function() observeAuthStatetEvent}) {
    assert(() {
      if (emailSignInEvent == null &&
          emailSignUpEvent == null &&
          resetPasswordEvent == null &&
          federatedOAuthEvent == null &&
          authSignOutEvent == null &&
          observeMessageEvent == null &&
          observeAuthStatetEvent == null) {
        throw 'provide at least one branch';
      }
      return true;
    }());
    switch (this._type) {
      case _AuthEvent.EmailSignInEvent:
        if (emailSignInEvent == null) break;
        return emailSignInEvent(this as EmailSignInEvent);
      case _AuthEvent.EmailSignUpEvent:
        if (emailSignUpEvent == null) break;
        return emailSignUpEvent(this as EmailSignUpEvent);
      case _AuthEvent.ResetPasswordEvent:
        if (resetPasswordEvent == null) break;
        return resetPasswordEvent(this as ResetPasswordEvent);
      case _AuthEvent.FederatedOAuthEvent:
        if (federatedOAuthEvent == null) break;
        return federatedOAuthEvent();
      case _AuthEvent.AuthSignOutEvent:
        if (authSignOutEvent == null) break;
        return authSignOutEvent();
      case _AuthEvent.ObserveMessageEvent:
        if (observeMessageEvent == null) break;
        return observeMessageEvent();
      case _AuthEvent.ObserveAuthStatetEvent:
        if (observeAuthStatetEvent == null) break;
        return observeAuthStatetEvent();
    }
  }

  @override
  List<Object> get props => const [];
}

@immutable
abstract class EmailSignInEvent extends AuthEvent {
  const EmailSignInEvent({@required this.email, @required this.password})
      : super(_AuthEvent.EmailSignInEvent);

  factory EmailSignInEvent.create(
      {@required String email,
      @required String password}) = _EmailSignInEventImpl;

  final String email;

  final String password;

  /// Creates a copy of this EmailSignInEvent but with the given fields
  /// replaced with the new values.
  EmailSignInEvent copyWith({String email, String password});
}

@immutable
class _EmailSignInEventImpl extends EmailSignInEvent {
  const _EmailSignInEventImpl({@required this.email, @required this.password})
      : super(email: email, password: password);

  @override
  final String email;

  @override
  final String password;

  @override
  _EmailSignInEventImpl copyWith(
          {Object email = superEnum, Object password = superEnum}) =>
      _EmailSignInEventImpl(
        email: email == superEnum ? this.email : email as String,
        password: password == superEnum ? this.password : password as String,
      );
  @override
  String toString() =>
      'EmailSignInEvent(email: ${this.email}, password: ${this.password})';
  @override
  List<Object> get props => [email, password];
}

@immutable
abstract class EmailSignUpEvent extends AuthEvent {
  const EmailSignUpEvent(
      {@required this.username, @required this.email, @required this.password})
      : super(_AuthEvent.EmailSignUpEvent);

  factory EmailSignUpEvent.create(
      {@required String username,
      @required String email,
      @required String password}) = _EmailSignUpEventImpl;

  final String username;

  final String email;

  final String password;

  /// Creates a copy of this EmailSignUpEvent but with the given fields
  /// replaced with the new values.
  EmailSignUpEvent copyWith({String username, String email, String password});
}

@immutable
class _EmailSignUpEventImpl extends EmailSignUpEvent {
  const _EmailSignUpEventImpl(
      {@required this.username, @required this.email, @required this.password})
      : super(username: username, email: email, password: password);

  @override
  final String username;

  @override
  final String email;

  @override
  final String password;

  @override
  _EmailSignUpEventImpl copyWith(
          {Object username = superEnum,
          Object email = superEnum,
          Object password = superEnum}) =>
      _EmailSignUpEventImpl(
        username: username == superEnum ? this.username : username as String,
        email: email == superEnum ? this.email : email as String,
        password: password == superEnum ? this.password : password as String,
      );
  @override
  String toString() =>
      'EmailSignUpEvent(username: ${this.username}, email: ${this.email}, password: ${this.password})';
  @override
  List<Object> get props => [username, email, password];
}

@immutable
abstract class ResetPasswordEvent extends AuthEvent {
  const ResetPasswordEvent({@required this.email})
      : super(_AuthEvent.ResetPasswordEvent);

  factory ResetPasswordEvent.create({@required String email}) =
      _ResetPasswordEventImpl;

  final String email;

  /// Creates a copy of this ResetPasswordEvent but with the given fields
  /// replaced with the new values.
  ResetPasswordEvent copyWith({String email});
}

@immutable
class _ResetPasswordEventImpl extends ResetPasswordEvent {
  const _ResetPasswordEventImpl({@required this.email}) : super(email: email);

  @override
  final String email;

  @override
  _ResetPasswordEventImpl copyWith({Object email = superEnum}) =>
      _ResetPasswordEventImpl(
        email: email == superEnum ? this.email : email as String,
      );
  @override
  String toString() => 'ResetPasswordEvent(email: ${this.email})';
  @override
  List<Object> get props => [email];
}

@immutable
abstract class FederatedOAuthEvent extends AuthEvent {
  const FederatedOAuthEvent() : super(_AuthEvent.FederatedOAuthEvent);

  factory FederatedOAuthEvent.create() = _FederatedOAuthEventImpl;
}

@immutable
class _FederatedOAuthEventImpl extends FederatedOAuthEvent {
  const _FederatedOAuthEventImpl() : super();

  @override
  String toString() => 'FederatedOAuthEvent()';
}

@immutable
abstract class AuthSignOutEvent extends AuthEvent {
  const AuthSignOutEvent() : super(_AuthEvent.AuthSignOutEvent);

  factory AuthSignOutEvent.create() = _AuthSignOutEventImpl;
}

@immutable
class _AuthSignOutEventImpl extends AuthSignOutEvent {
  const _AuthSignOutEventImpl() : super();

  @override
  String toString() => 'AuthSignOutEvent()';
}

@immutable
abstract class ObserveMessageEvent extends AuthEvent {
  const ObserveMessageEvent() : super(_AuthEvent.ObserveMessageEvent);

  factory ObserveMessageEvent.create() = _ObserveMessageEventImpl;
}

@immutable
class _ObserveMessageEventImpl extends ObserveMessageEvent {
  const _ObserveMessageEventImpl() : super();

  @override
  String toString() => 'ObserveMessageEvent()';
}

@immutable
abstract class ObserveAuthStatetEvent extends AuthEvent {
  const ObserveAuthStatetEvent() : super(_AuthEvent.ObserveAuthStatetEvent);

  factory ObserveAuthStatetEvent.create() = _ObserveAuthStatetEventImpl;
}

@immutable
class _ObserveAuthStatetEventImpl extends ObserveAuthStatetEvent {
  const _ObserveAuthStatetEventImpl() : super();

  @override
  String toString() => 'ObserveAuthStatetEvent()';
}
