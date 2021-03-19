/*
 * Copyright (c) 2021.
 * This application is owned by HandyMan LLC,
 * developed & designed by Quabynah Codelabs LLC.
 *
 *
 * author: codelbas.quabynah@gmail.com
 */

import 'dart:async';

import 'package:handyman/app/bloc/bloc.dart';
import 'package:handyman/domain/models/models.dart' show BaseUser;
import 'package:handyman/domain/repositories/repositories.dart';
import 'package:handyman/domain/usecases/usecases.dart';
import 'package:meta/meta.dart';

import 'auth_event.dart';

class AuthBloc extends BaseBloc<AuthEvent> {
  final BaseAuthRepository _repo;

  AuthBloc({@required BaseAuthRepository repo})
      : assert(repo != null),
        _repo = repo;

  @override
  Stream<BlocState> mapEventToState(
    AuthEvent event,
  ) async* {
    yield* event.when(
      emailSignInEvent: (e) => _mapStateToEvent(e),
      emailSignUpEvent: (e) => _mapStateToEvent(e),
      resetPasswordEvent: (e) => _mapStateToEvent(e),
      federatedOAuthEvent: () => _mapStateToEvent(event),
      authSignOutEvent: () => _mapStateToEvent(event),
      observeAuthStateEvent: () => _mapStateToEvent(event),
      observeMessageEvent: () => _mapStateToEvent(event),
    );
  }

  Stream<BlocState> _mapStateToEvent(AuthEvent event) async* {
    yield BlocState.loadingState();

    try {
      if (event is EmailSignInEvent) {
        var result = await EmailPasswordSignInUseCase(_repo).execute(
          EmailPasswordSignInUseCaseParams(
            email: event.email,
            password: event.password,
          ),
        );
        if (result is UseCaseResultSuccess<BaseUser>) {
          yield BlocState<BaseUser>.successState(data: result.value);
        } else {
          throw Exception('email sign in failed');
        }
      } else if (event is EmailSignUpEvent) {
        var result = await EmailPasswordSignUpUseCase(_repo).execute(
          EmailPasswordSignUpUseCaseParams(
            email: event.email,
            password: event.password,
            username: event.username,
          ),
        );
        if (result is UseCaseResultSuccess<BaseUser>) {
          yield BlocState<BaseUser>.successState(data: result.value);
        } else {
          throw Exception();
        }
      } else if (event is ResetPasswordEvent) {
        var result = await ResetPasswordUseCase(_repo).execute(event.email);
        if (result is UseCaseResultSuccess<void>) {
          yield BlocState.successState();
        } else {
          throw Exception();
        }
      } else if (event is FederatedOAuthEvent) {
        var result = await FederatedAuthUseCase(_repo).execute(null);
        if (result is UseCaseResultSuccess<BaseUser>) {
          yield BlocState<BaseUser>.successState(data: result.value);
        } else {
          throw Exception();
        }
      } else if (event is AuthSignOutEvent) {
        var result = await SignOutUseCase(_repo).execute(null);
        if (result is UseCaseResultSuccess<void>) {
          yield BlocState.successState();
        } else {
          throw Exception();
        }
      } else if (event is ObserveMessageEvent) {
        var result = await ObserveAuthMessageUseCase(_repo).execute(null);
        if (result is UseCaseResultSuccess<Stream<String>>) {
          yield BlocState<Stream<String>>.successState(data: result.value);
        } else {
          throw Exception();
        }
      } else if (event is ObserveAuthStateEvent) {
        var result = await ObserveAuthStateUseCase(_repo).execute(null);
        if (result is UseCaseResultSuccess<Stream<AuthState>>) {
          yield BlocState<Stream<AuthState>>.successState(data: result.value);
        } else {
          throw Exception();
        }
      }
    } on Exception catch (ex) {
      yield BlocState.errorState(failure: ex.toString());
    }
  }
}
