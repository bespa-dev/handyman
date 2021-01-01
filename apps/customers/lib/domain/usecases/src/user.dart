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

class ObserveUserUseCase extends ObservableUseCase<BaseArtisan, String> {
  final BaseUserRepository _repo;

  const ObserveUserUseCase(this._repo);

  @override
  Future<UseCaseResult<Stream<BaseArtisan>>> execute(String userId) async {
    try {
      final person = _repo.getArtisanById(id: userId);
      return UseCaseResult<Stream<BaseArtisan>>.success(person);
    } on Exception {
      return UseCaseResult.error(null);
    }
  }
}

/// streams live updates from the currently logged in [BaseUser] entity
class ObserveCurrentUserUseCase extends ObservableUseCase<BaseUser, void> {
  final BaseUserRepository _repo;

  const ObserveCurrentUserUseCase(this._repo);

  @override
  Future<UseCaseResult<Stream<BaseUser>>> execute(_) async {
    try {
      final personStream = _repo.currentUser();
      return UseCaseResult<Stream<BaseUser>>.success(
          personStream.asBroadcastStream());
    } on Exception catch (ex) {
      return UseCaseResult.error(ex.toString());
    }
  }
}

/// updates a [BasePerson]
class UpdateUserUseCase extends CompletableUseCase<BaseUser> {
  final BaseUserRepository _repo;

  const UpdateUserUseCase(this._repo);

  @override
  Future<UseCaseResult<void>> execute(BaseUser person) async {
    try {
      await _repo.updateUser(user: person);
      return UseCaseResult.success();
    } on Exception catch (ex) {
      return UseCaseResult.error(ex.toString());
    }
  }
}
