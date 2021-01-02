/*
 * Copyright (c) 2021.
 * This application is owned by HandyMan LLC,
 * developed & designed by Quabynah Codelabs LLC.
 *
 *
 * author: codelbas.quabynah@gmail.com
 */

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lite/data/entities/entities.dart';
import 'package:lite/domain/models/models.dart';
import 'package:lite/domain/repositories/repositories.dart';
import 'package:lite/shared/shared.dart';
import 'package:meta/meta.dart';

class AuthRepositoryImpl implements BaseAuthRepository {
  final GoogleSignIn _googleSignIn;
  final FirebaseAuth _auth;
  final BasePreferenceRepository _prefsRepo;
  final BaseUserRepository _userRepo;
  final FirebaseMessaging _messaging;

  final _onAuthStateChangedController = StreamController<AuthState>.broadcast();

  AuthRepositoryImpl({
    @required GoogleSignIn googleSignIn,
    @required FirebaseAuth auth,
    @required BasePreferenceRepository prefsRepo,
    @required BaseUserRepository userRepo,
    @required FirebaseMessaging messaging,
  })  : _googleSignIn = googleSignIn,
        _auth = auth,
        _prefsRepo = prefsRepo,
        _messaging = messaging,
        _userRepo = userRepo;

  /// fixme -> change to "Artisan" for artisan app
  Future<BaseUser> _getOrCreateUserFromCredential(
      UserCredential credential) async {
    var firebaseUser = credential.user;

    var user = await _userRepo.getCustomerById(id: firebaseUser.uid);
    if (user == null) {
      final newUser = Customer(
        id: firebaseUser.uid,
        email: firebaseUser.email,
        createdAt: DateTime.now().toIso8601String(),
        name: firebaseUser.displayName,
        phone: firebaseUser.phoneNumber,
        token: await _messaging.getToken(),
        avatar: firebaseUser.photoURL,
      );
      await _userRepo.updateUser(user: newUser);
      _onAuthStateChangedController
          .add(AuthState.authenticatedState(user: newUser));
      return newUser;
    } else {
      _onAuthStateChangedController
          .add(AuthState.authenticatedState(user: user));
      return user;
    }
  }

  @override
  Future<BaseUser> createUserWithEmailAndPassword(
      {String username, String email, String password}) async {
    if (username.isEmpty ||
        Validators.validateEmail(email) ||
        Validators.validatePassword(password)) {
      _onAuthStateChangedController.add(AuthState.invalidCredentialsState());
      return null;
    }
    try {
      _onAuthStateChangedController.add(AuthState.loadingState());
      var credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await _auth.currentUser.updateProfile(displayName: username);
      return _getOrCreateUserFromCredential(credential);
    } on Exception catch (ex) {
      _onAuthStateChangedController.add(
          AuthState.failedState(message: "Unable to create new user\n$ex"));
      return null;
    }
  }

  @override
  void dispose() {
    _onAuthStateChangedController.close();
  }

  @override
  Stream<AuthState> get onAuthStateChanged =>
      _onAuthStateChangedController.stream;

  @override
  // TODO: implement onMessageChanged
  Stream<String> get onMessageChanged => throw UnimplementedError();

  @override
  Future<void> sendPasswordReset({String email}) {
    // TODO: implement sendPasswordReset
    throw UnimplementedError();
  }

  @override
  Future<BaseUser> signInWithEmailAndPassword({String email, String password}) {
    // TODO: implement signInWithEmailAndPassword
    throw UnimplementedError();
  }

  @override
  Future<BaseUser> signInWithFederatedOAuth() {
    // TODO: implement signInWithFederatedOAuth
    throw UnimplementedError();
  }

  @override
  Future<void> signOut() {
    // TODO: implement signOut
    throw UnimplementedError();
  }
}
