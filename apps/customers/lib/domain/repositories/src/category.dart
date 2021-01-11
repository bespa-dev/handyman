/*
 * Copyright (c) 2021.
 * This application is owned by lite LLC,
 * developed & designed by Quabynah Codelabs LLC.
 *
 *
 * author: codelbas.quabynah@gmail.com
 */

import 'package:lite/domain/models/models.dart';
import 'package:lite/domain/repositories/repositories.dart';
import 'package:lite/domain/sources/src/local.dart';
import 'package:lite/domain/sources/src/remote.dart';
import 'package:meta/meta.dart';

abstract class BaseCategoryRepository extends BaseRepository {
  const BaseCategoryRepository(BaseLocalDatasource local, BaseRemoteDatasource remote) : super(local, remote);

  /// Get all [BaseServiceCategory]
  Stream<List<BaseServiceCategory>> observeCategories({
    @required ServiceCategoryGroup categoryGroup,
  });

  /// Get [BaseServiceCategory] by [id]
  Stream<BaseServiceCategory> observeCategoryById({String id});
}
