/*
 * Copyright (c) 2021.
 * This application is owned by HandyMan LLC,
 * developed & designed by Quabynah Codelabs LLC.
 *
 *
 * author: codelbas.quabynah@gmail.com
 */

import 'package:handyman/domain/models/models.dart';
import 'package:meta/meta.dart';
import 'package:super_enum/super_enum.dart';

part 'auth.super.dart';

@superEnum
enum _AuthState {
  @object
  AuthInitialState,
  @object
  AuthLoadingState,
  @object
  AuthSuccessState,
  @Data(fields: [DataField<BaseUser>("user")])
  AuthenticatedState,
  @Data(fields: [DataField<String>("message", required: false)])
  AuthFailedState,
  @object
  AuthInvalidCredentialsState,
}

/// base authentication repository class
abstract class BaseAuthRepository implements Exposable {
  /// observe authentication state
  Stream<AuthState> get onAuthStateChanged;

  /// observe message from authentication state
  Stream<String> get onMessageChanged;

  /// create user with email & password
  Future<BaseUser> createUserWithEmailAndPassword({
    @required String username,
    @required String email,
    @required String password,
  });

  /// sign in existing user with email & password
  Future<BaseUser> signInWithEmailAndPassword({
    @required String email,
    @required String password,
  });

  /// sign in with third party OAuth service
  Future<BaseUser> signInWithFederatedOAuth();

  /// sign out
  Future<void> signOut();

  /// reset password
  Future<void> sendPasswordReset({@required String email});

  /// close all streams, if any
  void dispose();
}
