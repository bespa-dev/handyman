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

class ObserveAllArtisansUseCase
    extends ObservableUseCase<List<BaseArtisan>, String> {
  const ObserveAllArtisansUseCase(this._repo);

  final BaseUserRepository _repo;

  @override
  Future<UseCaseResult<Stream<List<BaseArtisan>>>> execute(
      String category) async {
    try {
      final artisans = _repo.observeArtisans(category: category);
      return UseCaseResult<Stream<List<BaseArtisan>>>.success(
          artisans.asBroadcastStream());
    } on Exception {
      return UseCaseResult.error(null);
    }
  }
}

class ObserveArtisanUseCase extends ObservableUseCase<BaseArtisan, String> {
  const ObserveArtisanUseCase(this._repo);

  final BaseUserRepository _repo;

  @override
  Future<UseCaseResult<Stream<BaseArtisan>>> execute(String userId) async {
    try {
      final person = _repo.observeArtisanById(id: userId);
      return UseCaseResult<Stream<BaseArtisan>>.success(
          person.asBroadcastStream());
    } on Exception {
      return UseCaseResult.error(null);
    }
  }
}

class ObserveCustomerUseCase extends ObservableUseCase<BaseUser, String> {
  const ObserveCustomerUseCase(this._repo);

  final BaseUserRepository _repo;

  @override
  Future<UseCaseResult<Stream<BaseUser>>> execute(String userId) async {
    try {
      final person = _repo.observeCustomerById(id: userId);
      return UseCaseResult<Stream<BaseUser>>.success(
          person.asBroadcastStream());
    } on Exception {
      return UseCaseResult.error(null);
    }
  }
}

class GetCustomerUseCase extends UseCase<BaseUser, String> {
  const GetCustomerUseCase(this._repo);

  final BaseUserRepository _repo;

  @override
  Future<UseCaseResult<BaseUser>> execute(String userId) async {
    try {
      final person = await _repo.getCustomerById(id: userId);
      return UseCaseResult<BaseUser>.success(person);
    } on Exception {
      return UseCaseResult.error(null);
    }
  }
}

class GetArtisanUseCase extends UseCase<BaseArtisan, String> {
  const GetArtisanUseCase(this._repo);

  final BaseUserRepository _repo;

  @override
  Future<UseCaseResult<BaseArtisan>> execute(String userId) async {
    try {
      final person = await _repo.getArtisanById(id: userId);
      return UseCaseResult<BaseArtisan>.success(person);
    } on Exception {
      return UseCaseResult.error(null);
    }
  }
}

/// streams live updates from the currently logged in [BaseUser] entity
class ObserveCurrentUserUseCase extends ObservableUseCase<BaseUser, void> {
  const ObserveCurrentUserUseCase(this._repo);

  final BaseUserRepository _repo;

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
  const UpdateUserUseCase(this._repo);

  final BaseUserRepository _repo;

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
