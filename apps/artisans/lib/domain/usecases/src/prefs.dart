/*
 * Copyright (c) 2021.
 * This application is owned by HandyMan LLC,
 * developed & designed by Quabynah Codelabs LLC.
 *
 *
 * author: codelbas.quabynah@gmail.com
 */

import 'package:handyman/domain/repositories/repositories.dart';

import 'usecase/result.dart';
import 'usecase/usecase.dart';

/// get user id
class GetUserIdUseCase extends NoParamsUseCase<String> {
  final BasePreferenceRepository _repo;

  const GetUserIdUseCase(this._repo);

  @override
  Future<UseCaseResult<String>> execute(_) async {
    try {
      return UseCaseResult<String>.success(_repo.userId);
    } on Exception catch (ex) {
      return UseCaseResult.error(ex.toString());
    }
  }
}

/// get theme
class ObserveThemeUseCase extends ObservableUseCase<bool, void> {
  final BasePreferenceRepository _repo;

  const ObserveThemeUseCase(this._repo);

  @override
  Future<UseCaseResult<Stream<bool>>> execute(_) async {
    try {
      return UseCaseResult<Stream<bool>>.success(_repo.onThemeChanged);
    } on Exception catch (ex) {
      return UseCaseResult.error(ex.toString());
    }
  }
}

/// save theme
class SaveThemeUseCase extends CompletableUseCase<bool> {
  final BasePreferenceRepository _repo;

  const SaveThemeUseCase(this._repo);

  @override
  Future<UseCaseResult<void>> execute(theme) async {
    try {
      _repo.isLightTheme = theme;
      return UseCaseResult<bool>.success();
    } on Exception catch (ex) {
      return UseCaseResult.error(ex.toString());
    }
  }
}

/// save user id
class SaveUserIdUseCase extends CompletableUseCase<String> {
  final BasePreferenceRepository _repo;

  const SaveUserIdUseCase(this._repo);

  @override
  Future<UseCaseResult<void>> execute(id) async {
    try {
      _repo.userId = id;
      return UseCaseResult.success();
    } on Exception catch (ex) {
      return UseCaseResult.error(ex.toString());
    }
  }
}
