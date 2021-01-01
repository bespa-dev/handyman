/*
 * Copyright (c) 2021.
 * This application is owned by HandyMan LLC,
 * developed & designed by Quabynah Codelabs LLC.
 *
 *
 * author: codelbas.quabynah@gmail.com
 */

import 'package:handyman/domain/models/models.dart';
import 'package:handyman/domain/repositories/repositories.dart';

import 'usecase/result.dart';
import 'usecase/usecase.dart';

class GetCategoriesUseCase
    extends ObservableUseCase<List<BaseServiceCategory>, ServiceCategoryGroup> {
  final BaseCategoryRepository _repo;

  const GetCategoriesUseCase(this._repo);

  @override
  Future<UseCaseResult<Stream<List<BaseServiceCategory>>>> execute(
      ServiceCategoryGroup group) async {
    try {
      var stream = _repo.getCategories(categoryGroup: group);
      return UseCaseResult<Stream<List<BaseServiceCategory>>>.success(stream);
    } on Exception {
      return UseCaseResult.error("Failed to get categories");
    }
  }
}

class GetCategoryByIdUseCase
    extends ObservableUseCase<BaseServiceCategory, String> {
  final BaseCategoryRepository _repo;

  const GetCategoryByIdUseCase(this._repo);

  @override
  Future<UseCaseResult<Stream<BaseServiceCategory>>> execute(String id) async {
    try {
      var stream = _repo.getCategoryById(id: id);
      return UseCaseResult<Stream<BaseServiceCategory>>.success(stream);
    } on Exception {
      return UseCaseResult.error("Failed to get categories");
    }
  }
}
