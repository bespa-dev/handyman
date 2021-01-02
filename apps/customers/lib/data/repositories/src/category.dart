/*
 * Copyright (c) 2021.
 * This application is owned by HandyMan LLC,
 * developed & designed by Quabynah Codelabs LLC.
 *
 *
 * author: codelbas.quabynah@gmail.com
 */

import 'package:lite/domain/models/src/category/category.dart';
import 'package:lite/domain/repositories/repositories.dart';
import 'package:lite/domain/sources/sources.dart';
import 'package:meta/meta.dart';

class CategoryRepositoryImpl implements BaseCategoryRepository {
  final BaseLocalDatasource _localDatasource;
  final BaseRemoteDatasource _remoteDatasource;

  CategoryRepositoryImpl({
    @required BaseLocalDatasource local,
    @required BaseRemoteDatasource remote,
  })  : _localDatasource = local,
        _remoteDatasource = remote;

  @override
  Stream<List<BaseServiceCategory>> observeCategories(
      {ServiceCategoryGroup categoryGroup}) async* {
    yield* _localDatasource.observeCategories(categoryGroup: categoryGroup);
    _remoteDatasource
        .observeCategories(categoryGroup: categoryGroup)
        .listen((event) async {
      for (var value in event) {
        if (value != null)
          await _localDatasource.updateCategory(category: value);
      }
    });
  }

  @override
  Stream<BaseServiceCategory> observeCategoryById({String id}) async* {
    yield* _localDatasource.observeCategoryById(id: id);
    _remoteDatasource.observeCategoryById(id: id).listen((event) async {
      if (event != null) await _localDatasource.updateCategory(category: event);
    });
  }
}
