/*
 * Copyright (c) 2021.
 * This application is owned by HandyMan LLC,
 * developed & designed by Quabynah Codelabs LLC.
 *
 *
 * author: codelbas.quabynah@gmail.com
 */

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:handyman/app/bloc/bloc.dart';
import 'package:handyman/domain/models/models.dart';
import 'package:handyman/domain/repositories/repositories.dart';
import 'package:handyman/domain/usecases/usecases.dart';
import 'package:meta/meta.dart';

import 'user_event.dart';

class UserBloc extends Bloc<UserEvent, BlocState> {
  final BaseUserRepository _repo;

  UserBloc({@required BaseUserRepository repo})
      : assert(repo != null),
        _repo = repo,
        super(BlocState.initialState());

  @override
  Stream<BlocState> mapEventToState(
    UserEvent event,
  ) async* {
    yield* event.when(
      currentUserEvent: () => _mapEventToState(event),
      updateUserEvent: (e) => _mapEventToState(e),
      getArtisanByIdEvent: (e) => _mapEventToState(e),
      observeArtisanByIdEvent: (e) => _mapEventToState(e),
      getCustomerByIdEvent: (e) => _mapEventToState(e),
      observeCustomerByIdEvent: (e) => _mapEventToState(e),
      observeArtisansEvent: (e) => _mapEventToState(e),
    );
  }

  Stream<BlocState> _mapEventToState(UserEvent<dynamic> event) async* {
    yield BlocState.loadingState();

    try {
      if (event is CurrentUserEvent) {
        var result = await ObserveCurrentUserUseCase(_repo).execute(null);
        if (result is UseCaseResultSuccess<Stream<BaseUser>>) {
          yield BlocState<Stream<BaseUser>>.successState(data: result.value);
        } else
          throw Exception();
      } else if (event is UpdateUserEvent) {
        var result = await UpdateUserUseCase(_repo).execute(event.user);
        if (result is UseCaseResultSuccess) {
          yield BlocState.successState();
        } else
          throw Exception();
      } else if (event is GetArtisanByIdEvent) {
        var result = await GetArtisanUseCase(_repo).execute(event.id);
        if (result is UseCaseResultSuccess<BaseArtisan>) {
          yield BlocState<BaseArtisan>.successState(data: result.value);
        } else
          throw Exception();
      } else if (event is ObserveArtisanByIdEvent) {
        var result = await ObserveArtisanUseCase(_repo).execute(event.id);
        if (result is UseCaseResultSuccess<Stream<BaseArtisan>>) {
          yield BlocState<Stream<BaseArtisan>>.successState(data: result.value);
        } else
          throw Exception();
      } else if (event is GetCustomerByIdEvent) {
        var result = await GetCustomerUseCase(_repo).execute(event.id);
        if (result is UseCaseResultSuccess<BaseUser>) {
          yield BlocState<BaseUser>.successState(data: result.value);
        } else
          throw Exception();
      } else if (event is ObserveCustomerByIdEvent) {
        var result = await ObserveCustomerUseCase(_repo).execute(event.id);
        if (result is UseCaseResultSuccess<Stream<BaseUser>>) {
          yield BlocState<Stream<BaseUser>>.successState(data: result.value);
        } else
          throw Exception();
      } else if (event is ObserveArtisansEvent) {
        var result =
            await ObserveAllArtisansUseCase(_repo).execute(event.category);
        if (result is UseCaseResultSuccess<Stream<List<BaseArtisan>>>) {
          yield BlocState<Stream<List<BaseArtisan>>>.successState(
              data: result.value);
        } else
          throw Exception();
      }
    } on Exception catch (ex) {
      yield BlocState.errorState(failure: ex.toString());
    }
  }
}
