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
import 'package:meta/meta.dart';

import 'usecase/result.dart';
import 'usecase/usecase.dart';

/// google sign in
class FederatedAuthUseCase extends NoParamsUseCase<BaseUser> {
  final BaseAuthRepository repo;

  const FederatedAuthUseCase({@required this.repo});

  @override
  Future<UseCaseResult<BaseUser>> execute(_) async {
    try {
      final person = await repo.signInWithFederatedOAuth();
      return UseCaseResult<BaseUser>.success(person);
    } on Exception {
      return UseCaseResult.error(null);
    }
  }
}

/// sign in with email & password
class EmailPasswordSignInUseCase
    extends CompletableUseCase<EmailPasswordSignInUseCaseParams> {
  final BaseAuthRepository _repo;

  const EmailPasswordSignInUseCase(this._repo);

  @override
  Future<UseCaseResult<void>> execute(params) async {
    try {
      await _repo.signInWithEmailAndPassword(
          email: params.email, password: params.password);
      return UseCaseResult.success();
    } on Exception catch (ex) {
      return UseCaseResult.error(ex.toString());
    }
  }
}

/// sign up with email & password
class EmailPasswordSignUpUseCase
    extends CompletableUseCase<EmailPasswordSignUpUseCaseParams> {
  final BaseAuthRepository _repo;

  EmailPasswordSignUpUseCase(this._repo);

  @override
  Future<UseCaseResult<void>> execute(params) async {
    try {
      await _repo.createUserWithEmailAndPassword(
          username: params.username,
          email: params.email,
          password: params.password);
      return UseCaseResult.success();
    } on Exception catch (ex) {
      return UseCaseResult.error(ex.toString());
    }
  }
}

/// reset password
class ResetPasswordUseCase extends CompletableUseCase<String> {
  final BaseAuthRepository _repo;

  const ResetPasswordUseCase(this._repo);

  @override
  Future<UseCaseResult<void>> execute(email) async {
    try {
      await _repo.sendPasswordReset(email: email);
      return UseCaseResult.success();
    } on Exception catch (ex) {
      return UseCaseResult.error(ex.toString());
    }
  }
}

class SignOutUseCase extends CompletableUseCase<void> {
  final BaseAuthRepository _repo;

  const SignOutUseCase(this._repo);

  @override
  Future<UseCaseResult<void>> execute(_) async {
    try {
      await _repo.signOut();
      return UseCaseResult.success();
    } on Exception catch (ex) {
      return UseCaseResult.error(ex.toString());
    }
  }
}

/// params for account creation with username, email & password
class EmailPasswordSignUpUseCaseParams {
  final String username;
  final String email;
  final String password;

  const EmailPasswordSignUpUseCaseParams({
    @required this.username,
    @required this.email,
    @required this.password,
  });
}

/// params for account login with email & password
class EmailPasswordSignInUseCaseParams {
  final String email;
  final String password;

  const EmailPasswordSignInUseCaseParams({
    @required this.email,
    @required this.password,
  });
}
