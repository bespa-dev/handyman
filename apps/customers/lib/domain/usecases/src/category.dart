/*
 * Copyright (c) 2021.
 * This application is owned by HandyMan LLC,
 * developed & designed by Quabynah Codelabs LLC.
 *
 *
 * author: codelbas.quabynah@gmail.com
 */

import 'package:lite/domain/models/models.dart';
import 'package:lite/domain/repositories/repositories.dart';

import 'usecase/result.dart';
import 'usecase/usecase.dart';

class ObserveCategoriesUseCase
    extends ObservableUseCase<List<BaseServiceCategory>, ServiceCategoryGroup> {
  final BaseCategoryRepository _repo;

  const ObserveCategoriesUseCase(this._repo);

  @override
  Future<UseCaseResult<Stream<List<BaseServiceCategory>>>> execute(
      ServiceCategoryGroup group) async {
    try {
      var stream = _repo.observeCategories(categoryGroup: group);
      return UseCaseResult<Stream<List<BaseServiceCategory>>>.success(
          stream.asBroadcastStream());
    } on Exception {
      return UseCaseResult.error("Failed to get categories");
    }
  }
}

class ObserveCategoryByIdUseCase
    extends ObservableUseCase<BaseServiceCategory, String> {
  final BaseCategoryRepository _repo;

  const ObserveCategoryByIdUseCase(this._repo);

  @override
  Future<UseCaseResult<Stream<BaseServiceCategory>>> execute(String id) async {
    try {
      var stream = _repo.observeCategoryById(id: id);
      return UseCaseResult<Stream<BaseServiceCategory>>.success(
          stream.asBroadcastStream());
    } on Exception {
      return UseCaseResult.error("Failed to get categories");
    }
  }
}
