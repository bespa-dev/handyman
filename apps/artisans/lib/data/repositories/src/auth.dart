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
import 'package:handyman/data/entities/entities.dart';
import 'package:handyman/domain/models/models.dart';
import 'package:handyman/domain/repositories/repositories.dart';
import 'package:handyman/shared/shared.dart';
import 'package:meta/meta.dart';

class AuthRepositoryImpl implements BaseAuthRepository {
  final GoogleSignIn _googleSignIn;
  final FirebaseAuth _auth;
  final BasePreferenceRepository _prefsRepo;
  final BaseUserRepository _userRepo;
  final FirebaseMessaging _messaging;

  final _onAuthStateChangedController = StreamController<AuthState>.broadcast();
  final _onMessageChangedController = StreamController<String>.broadcast();

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

  Future<BaseUser> _getOrCreateUserFromCredential(
      UserCredential credential) async {
    var firebaseUser = credential.user;

    var user = await _userRepo.getCustomerById(id: firebaseUser.uid);
    if (user == null) {
      var timestamp = DateTime.now().toIso8601String();
      final newUser = Artisan(
        id: firebaseUser.uid,
        email: firebaseUser.email,
        createdAt: timestamp,
        name: firebaseUser.displayName,
        phone: firebaseUser.phoneNumber,
        token: await _messaging.getToken(),
        avatar: firebaseUser.photoURL,
        categoryGroup: ServiceCategoryGroup.featured().name(),
        // mechanic default
        category: "8ecf642d-429f-4b51-805b-0678a9af8e28",
        startWorkingHours: timestamp,
        endWorkingHours: timestamp,
        // no business id set at registration
        businessId: "",
      );
      await _userRepo.updateUser(user: newUser);
      _prefsRepo.userId = newUser.id;
      _onAuthStateChangedController
          .add(AuthState.authenticatedState(user: newUser));
      _onMessageChangedController.add("New account created successfully");
      return newUser;
    } else {
      _prefsRepo.userId = user.id;
      await _userRepo.updateUser(
        user: user.copyWith(
          token: await _messaging.getToken(),
        ),
      );
      _onAuthStateChangedController
          .add(AuthState.authenticatedState(user: user));
      _onMessageChangedController.add("Signed in successfully");
      return user;
    }
  }

  @override
  Future<BaseUser> createUserWithEmailAndPassword(
      {String username, String email, String password}) async {
    if (username.isEmpty ||
        !Validators.validateEmail(email) ||
        !Validators.validatePassword(password)) {
      _onAuthStateChangedController
          .add(AuthState.authInvalidCredentialsState());
      _onMessageChangedController.add("Invalid credentials");
      return null;
    }
    try {
      _onAuthStateChangedController.add(AuthState.authLoadingState());
      var credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await _auth.currentUser.updateProfile(displayName: username);
      return _getOrCreateUserFromCredential(credential);
    } on Exception catch (ex) {
      _onAuthStateChangedController.add(
          AuthState.authFailedState(message: "Unable to create new user\n$ex"));
      _onMessageChangedController.add("Unable to create new user");
      return null;
    }
  }

  @override
  void dispose() {
    _onAuthStateChangedController.close();
    _onMessageChangedController.close();
  }

  @override
  Stream<AuthState> get onAuthStateChanged =>
      _onAuthStateChangedController.stream;

  @override
  Stream<String> get onMessageChanged => _onMessageChangedController.stream;

  @override
  Future<void> sendPasswordReset({String email}) async {
    if (!Validators.validateEmail(email)) {
      _onAuthStateChangedController
          .add(AuthState.authInvalidCredentialsState());
      _onMessageChangedController.add("Invalid email address");
      return;
    }

    try {
      _onAuthStateChangedController.add(AuthState.authLoadingState());
      await _auth.sendPasswordResetEmail(email: email);
      _onAuthStateChangedController.add(AuthState.authSuccessState());
      _onMessageChangedController.add("Link to password reset sent to $email");
    } on Exception catch (ex) {
      _onAuthStateChangedController
          .add(AuthState.authFailedState(message: "$ex"));
      _onMessageChangedController.add("Failed to reset password");
      return;
    }
  }

  @override
  Future<BaseUser> signInWithEmailAndPassword(
      {String email, String password}) async {
    if (!Validators.validateEmail(email) ||
        !Validators.validatePassword(password)) {
      _onAuthStateChangedController
          .add(AuthState.authInvalidCredentialsState());
      _onMessageChangedController.add("Invalid credentials");
      return null;
    }
    try {
      _onAuthStateChangedController.add(AuthState.authLoadingState());
      var credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return _getOrCreateUserFromCredential(credential);
    } on Exception catch (ex) {
      _onAuthStateChangedController
          .add(AuthState.authFailedState(message: "Unable to sign in\n$ex"));
      _onMessageChangedController.add("Unable to sign in");
      return null;
    }
  }

  @override
  Future<BaseUser> signInWithFederatedOAuth() async {
    try {
      _onAuthStateChangedController.add(AuthState.authLoadingState());
      var account = await _googleSignIn.signIn();
      var authentication = await account.authentication;
      var credential =
          await _auth.signInWithCredential(GoogleAuthProvider.credential(
        idToken: authentication.idToken,
        accessToken: authentication.accessToken,
      ));
      return _getOrCreateUserFromCredential(credential);
    } on Exception catch (ex) {
      _onAuthStateChangedController
          .add(AuthState.authFailedState(message: "Unable to sign in\n$ex"));
      _onMessageChangedController.add("Unable to sign in");
      return null;
    }
  }

  @override
  Future<void> signOut() async {
    _onAuthStateChangedController.add(AuthState.authLoadingState());
    if (_googleSignIn.currentUser != null) await _googleSignIn.signOut();
    await _prefsRepo.signOut();
    await _auth.signOut();
    _onAuthStateChangedController.add(AuthState.authSuccessState());
  }
}
