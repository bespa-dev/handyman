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
import 'package:handyman/domain/repositories/repositories.dart';
import 'package:handyman/domain/usecases/usecases.dart';
import 'package:meta/meta.dart';

import 'prefs_event.dart';

class PrefsBloc extends BaseBloc<PrefsEvent> {
  final BasePreferenceRepository _repo;

  PrefsBloc({@required BasePreferenceRepository repo})
      : assert(repo != null),
        _repo = repo;

  @override
  Stream<BlocState> mapEventToState(
      PrefsEvent event,
      ) async* {
    yield* event.when(
      getHomeAddressEvent: () => _mapEventToState(event),
      getWorkAddressEvent: () => _mapEventToState(event),
      getUserIdEvent: () => _mapEventToState(event),
      getContactEvent: () => _mapEventToState(event),
      getStandardViewEvent: () => _mapEventToState(event),
      getThemeEvent: () => _mapEventToState(event),
      observeThemeEvent: () => _mapEventToState(event),
      saveContactEvent: (e) => _mapEventToState(e),
      saveLightThemeEvent: (e) => _mapEventToState(e),
      saveStandardViewEvent: (e) => _mapEventToState(e),
      saveHomeAddressEvent: (e) => _mapEventToState(e),
      saveUserIdEvent: (e) => _mapEventToState(e),
      saveWorkAddressEvent: (e) => _mapEventToState(e),
      prefsSignOutEvent: () => _mapEventToState(event),
    );
  }

  Stream<BlocState> _mapEventToState(PrefsEvent event) async* {
    yield BlocState.loadingState();

    try {
      if (event is GetUserIdEvent) {
        var result = await GetUserIdUseCase(_repo).execute(null);
        if (result is UseCaseResultSuccess<String>) {
          yield BlocState<String>.successState(data: result.value);
        } else
          throw Exception();
      } else if (event is GetThemeEvent) {
        var result = await GetThemeUseCase(_repo).execute(null);
        if (result is UseCaseResultSuccess<bool>) {
          yield BlocState<bool>.successState(data: result.value);
        } else
          throw Exception();
      } else if (event is GetContactEvent) {
        var result = await GetContactUseCase(_repo).execute(null);
        if (result is UseCaseResultSuccess<String>) {
          yield BlocState<String>.successState(data: result.value);
        } else
          throw Exception();
      } else if (event is ObserveThemeEvent) {
        var result = await ObserveThemeUseCase(_repo).execute(null);
        if (result is UseCaseResultSuccess<Stream<bool>>) {
          yield BlocState<Stream<bool>>.successState(data: result.value);
        } else
          throw Exception();
      } else if (event is GetStandardViewEvent) {
        var result = await GetStandardViewUseCase(_repo).execute(null);
        if (result is UseCaseResultSuccess<bool>) {
          yield BlocState<bool>.successState(data: result.value);
        } else
          throw Exception();
      } else if (event is SaveLightThemeEvent) {
        await SaveThemeUseCase(_repo).execute(event.lightTheme);
        yield BlocState.successState();
      } else if (event is SaveStandardViewEvent) {
        await SaveStandardViewUseCase(_repo).execute(event.standardView);
        yield BlocState.successState();
      } else if (event is SaveContactEvent) {
        await SaveContactUseCase(_repo).execute(event.contact);
        yield BlocState.successState();
      } else if (event is PrefsSignOutEvent) {
        await PrefsSignOutUseCase(_repo).execute(null);
        yield BlocState.successState();
      } else if (event is GetHomeAddressEvent) {
        var result = await GetHomeAddressUseCase(_repo).execute(null);
        if (result is UseCaseResultSuccess<String>) {
          yield BlocState<String>.successState(data: result.value);
        } else
          throw Exception();
      } else if (event is GetWorkAddressEvent) {
        var result = await GetWorkAddressUseCase(_repo).execute(null);
        if (result is UseCaseResultSuccess<String>) {
          yield BlocState<String>.successState(data: result.value);
        } else
          throw Exception();
      } else if (event is SaveUserIdEvent) {
        await SaveUserIdUseCase(_repo).execute(event.id);
        yield BlocState.successState();
      } else if (event is SaveHomeAddressEvent) {
        await SaveHomeAddressUseCase(_repo).execute(event.address);
        yield BlocState.successState();
      } else if (event is SaveWorkAddressEvent) {
        await SaveWorkAddressUseCase(_repo).execute(event.address);
        yield BlocState.successState();
      }
    } on Exception {
      yield BlocState.errorState(failure: "A process failed to complete");
    }
  }
}
