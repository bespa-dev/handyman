/*
 * Copyright (c) 2021.
 * This application is owned by HandyMan LLC,
 * developed & designed by Quabynah Codelabs LLC.
 *
 *
 * author: codelbas.quabynah@gmail.com
 */

import 'package:lite/domain/models/models.dart';
import 'package:super_enum/super_enum.dart';
import 'package:meta/meta.dart';

part 'auth.super.dart';

@superEnum
enum _AuthState {
  @object
  Initial,
  @object
  Loading,
  @object
  Authenticated,
  @object
  Failed,
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

  /// sign in with google
  Future<BaseUser> signInWithGoogle();

  /// sign out
  Future<void> signOut();

  /// close all streams, if any
  void dispose();
}
