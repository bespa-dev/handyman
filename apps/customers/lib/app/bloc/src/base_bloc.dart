/*
 * Copyright (c) 2021.
 * This application is owned by HandyMan LLC,
 * developed & designed by Quabynah Codelabs LLC.
 *
 *
 * author: codelbas.quabynah@gmail.com
 */

import 'package:bloc/bloc.dart';
import 'package:lite/shared/shared.dart' show logger;

import 'bloc_state.dart';

/// base class for all blocs -> provides logging events
abstract class BaseBloc<E> extends Bloc<E, BlocState> {
  BaseBloc() : super(BlocState.initialState());

  @override
  Future<Function> close() {
    logger.d("Closing ${this.runtimeType}");
    super.close();
    return null;
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    logger.e("error encountered in ${this.runtimeType} -> $error");
    super.onError(error, stackTrace);
  }

  @override
  void onTransition(Transition<E, BlocState> transition) {
    logger.d(
        "onTransition ${this.runtimeType}: ${transition.currentState} -> ${transition.nextState}");
    super.onTransition(transition);
  }

  @override
  void onEvent(E event) {
    logger.d("onEvent ${this.runtimeType} -> ${event.runtimeType}");
    super.onEvent(event);
  }
}
