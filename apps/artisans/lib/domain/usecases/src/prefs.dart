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

/// get contact
class GetContactUseCase extends NoParamsUseCase<String> {
  final BasePreferenceRepository _repo;

  const GetContactUseCase(this._repo);

  @override
  Future<UseCaseResult<String>> execute(_) async {
    try {
      return UseCaseResult<String>.success(_repo.emergencyContactNumber);
    } on Exception catch (ex) {
      return UseCaseResult.error(ex.toString());
    }
  }
}

/// get theme
class GetThemeUseCase extends NoParamsUseCase<bool> {
  final BasePreferenceRepository _repo;

  const GetThemeUseCase(this._repo);

  @override
  Future<UseCaseResult<bool>> execute(_) async {
    try {
      return UseCaseResult<bool>.success(_repo.isLightTheme);
    } on Exception catch (ex) {
      return UseCaseResult.error(ex.toString());
    }
  }
}

/// observe theme
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

/// save contact
class SaveContactUseCase extends CompletableUseCase<String> {
  final BasePreferenceRepository _repo;

  const SaveContactUseCase(this._repo);

  @override
  Future<UseCaseResult<void>> execute(contact) async {
    try {
      _repo.emergencyContactNumber = contact;
      return UseCaseResult.success();
    } on Exception catch (ex) {
      return UseCaseResult.error(ex.toString());
    }
  }
}

/// get standard view type
class GetStandardViewUseCase extends UseCase<bool, void> {
  final BasePreferenceRepository _repo;

  const GetStandardViewUseCase(this._repo);

  @override
  Future<UseCaseResult<bool>> execute(_) async {
    try {
      return UseCaseResult<bool>.success(_repo.useStandardViewType);
    } on Exception catch (ex) {
      return UseCaseResult.error(ex.toString());
    }
  }
}

/// save standard view type
class SaveStandardViewUseCase extends CompletableUseCase<bool> {
  final BasePreferenceRepository _repo;

  const SaveStandardViewUseCase(this._repo);

  @override
  Future<UseCaseResult<void>> execute(value) async {
    try {
      _repo.useStandardViewType = value;
      return UseCaseResult<bool>.success();
    } on Exception catch (ex) {
      return UseCaseResult.error(ex.toString());
    }
  }
}

/// get standard view type
class GetShowSplashUseCase extends UseCase<bool, void> {
  final BasePreferenceRepository _repo;

  const GetShowSplashUseCase(this._repo);

  @override
  Future<UseCaseResult<bool>> execute(_) async {
    try {
      return UseCaseResult<bool>.success(_repo.shouldShowSplash);
    } on Exception catch (ex) {
      return UseCaseResult.error(ex.toString());
    }
  }
}

/// save standard view type
class SaveShowSplashUseCase extends CompletableUseCase<bool> {
  final BasePreferenceRepository _repo;

  const SaveShowSplashUseCase(this._repo);

  @override
  Future<UseCaseResult<void>> execute(value) async {
    try {
      _repo.shouldShowSplash = value;
      return UseCaseResult<bool>.success();
    } on Exception catch (ex) {
      return UseCaseResult.error(ex.toString());
    }
  }
}

class PrefsSignOutUseCase extends VoidableUseCase {
  final BasePreferenceRepository _repo;

  const PrefsSignOutUseCase(this._repo);

  @override
  Future<UseCaseResult<void>> execute(_) async {
    await _repo.signOut();
    return UseCaseResult.success();
  }
}
