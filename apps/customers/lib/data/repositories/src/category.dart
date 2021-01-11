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

class CategoryRepositoryImpl extends BaseCategoryRepository {
  const CategoryRepositoryImpl({
    @required BaseLocalDatasource local,
    @required BaseRemoteDatasource remote,
  }) : super(local, remote);

  @override
  Stream<List<BaseServiceCategory>> observeCategories(
      {ServiceCategoryGroup categoryGroup}) async* {
    yield* local
        .observeCategories(categoryGroup: categoryGroup)
        .asBroadcastStream();
    remote
        .observeCategories(categoryGroup: categoryGroup)
        .listen((event) async {
      for (var value in event) {
        if (value != null) await local.updateCategory(category: value);
      }
    });
  }

  @override
  Stream<BaseServiceCategory> observeCategoryById({String id}) async* {
    yield* local.observeCategoryById(id: id);
    remote.observeCategoryById(id: id).listen((event) async {
      if (event != null) await local.updateCategory(category: event);
    });
  }
}
