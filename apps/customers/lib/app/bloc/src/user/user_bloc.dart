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
import 'package:lite/app/bloc/bloc.dart';
import 'package:lite/domain/repositories/repositories.dart';
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
      } else if (event is UpdateUserEvent) {
      } else if (event is GetArtisanByIdEvent) {
      } else if (event is ObserveArtisanByIdEvent) {
      } else if (event is GetCustomerByIdEvent) {
      } else if (event is ObserveCustomerByIdEvent) {
      } else if (event is ObserveArtisansEvent) {}
    } on Exception catch (ex) {
      yield BlocState.errorState(failure: ex.toString());
    }
  }
}
