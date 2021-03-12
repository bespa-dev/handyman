/*
 * Copyright (c) 2021.
 * This application is owned by HandyMan LLC,
 * developed & designed by Quabynah Codelabs LLC.
 *
 *
 * author: codelbas.quabynah@gmail.com
 */

import 'package:lite/app/bloc/bloc.dart';
import 'package:lite/domain/models/models.dart';
import 'package:lite/domain/repositories/repositories.dart';
import 'package:lite/domain/usecases/usecases.dart';
import 'package:meta/meta.dart';

import 'category_event.dart';

class CategoryBloc extends BaseBloc<CategoryEvent> {
  final BaseCategoryRepository _repo;

  CategoryBloc({@required BaseCategoryRepository repo})
      : assert(repo != null),
        _repo = repo;

  @override
  Stream<BlocState> mapEventToState(CategoryEvent event) async* {
    yield* event.when(
      observeAllCategories: (e) => _mapEventToState(e),
      observeCategoryById: (e) => _mapEventToState(e),
    );
  }

  Stream<BlocState> _mapEventToState(CategoryEvent event) async* {
    yield BlocState.loadingState();

    if (event is ObserveAllCategories) {
      var result = await ObserveCategoriesUseCase(_repo).execute(event.group);
      if (result is UseCaseResultSuccess<Stream<List<BaseServiceCategory>>>) {
        yield BlocState<Stream<List<BaseServiceCategory>>>.successState(
            data: result.value);
      } else {
        yield BlocState.errorState(failure: []);
      }
    } else if (event is ObserveCategoryById) {
      var result = await ObserveCategoryByIdUseCase(_repo).execute(event.id);
      if (result is UseCaseResultSuccess<Stream<BaseServiceCategory>>) {
        yield BlocState<Stream<BaseServiceCategory>>.successState(
            data: result.value);
      } else {
        yield BlocState.errorState(failure: null);
      }
    }
  }
}
