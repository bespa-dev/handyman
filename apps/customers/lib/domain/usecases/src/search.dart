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

class SearchUseCase extends UseCase<List<BaseUser>, String> {
  const SearchUseCase(this._repo);

  final BaseSearchRepository _repo;

  @override
  Future<UseCaseResult<List<BaseUser>>> execute(String query) async {
    try {
      var results = await _repo.searchFor(query: query);
      return UseCaseResult.success(results);
    } on Exception {
      return UseCaseResult.error('Unable to complete search');
    }
  }
}
