import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:handyman/core/constants.dart';
import 'package:handyman/core/service_locator.dart';
import 'package:handyman/core/utils.dart';
import 'package:handyman/data/entities/artisan_model.dart';
import 'package:handyman/data/entities/customer_model.dart';
import 'package:handyman/data/local_database.dart';
import 'package:handyman/domain/models/user.dart';
import 'package:handyman/domain/services/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// [AuthService] implementation for production use
class FirebaseAuthService implements AuthService {
  final FirebaseAuth _auth = sl.get<FirebaseAuth>();
  final FirebaseFirestore _firestore = sl.get<FirebaseFirestore>();
  final LocalDatabase _database = sl.get<LocalDatabase>();
  final successState = AuthState.SUCCESS;
  final errorState = AuthState.ERROR;
  final loadingState = AuthState.AUTHENTICATING;
  final initialState = AuthState.NONE;

  // Private constructor
  FirebaseAuthService._();

  // Singleton
  static FirebaseAuthService get instance => FirebaseAuthService._();

  final StreamController<BaseUser> _onAuthStateChanged =
      StreamController.broadcast();
  final StreamController<AuthState> _onProcessingStateChanged =
      StreamController.broadcast();

  Future<BaseUser> _userFromFirebase(User user,
      {bool isCustomer = true}) async {
    _onProcessingStateChanged.sink.add(loadingState);
    if (isCustomer) {
      final snapshot = await _firestore
          .collection(FirestoreUtils.kCustomerRef)
          .doc(user.uid)
          .get();
      if (snapshot.exists) {
        final customer = Customer.fromJson(snapshot.data());
        await _database.customerDao.addCustomer(customer);
        _onProcessingStateChanged.sink.add(successState);
        return CustomerModel(customer: customer);
      } else {
        _onProcessingStateChanged.sink.add(errorState);
        return null;
      }
    } else {
      final snapshot = await _firestore
          .collection(FirestoreUtils.kArtisanRef)
          .doc(user.uid)
          .get();
      if (snapshot.exists) {
        final artisan = Artisan.fromJson(snapshot.data());
        await _database.providerDao.saveProvider(artisan);
        _onProcessingStateChanged.sink.add(successState);
        return ArtisanModel(artisan: artisan);
      } else {
        _onProcessingStateChanged.sink.add(errorState);
        return null;
      }
    }
  }

  @override
  Future<BaseUser> createUserWithEmailAndPassword({
    String username,
    String email,
    String password,
    bool isCustomer,
  }) async {
    _onProcessingStateChanged.sink.add(loadingState);
    try {
      // Create user account
      final credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      // Update user information online
      await _auth.currentUser.updateProfile(displayName: username);

      // return user instance
      return _userFromFirebase(credential.user, isCustomer: isCustomer);
    } on Exception catch (e) {
      _onProcessingStateChanged.sink.add(errorState);
      debugPrint(e.toString());
      return null;
    }
  }

  @override
  Stream<BaseUser> currentUser() async* {
    var preferences = await sl.getAsync<SharedPreferences>();
    final userId = preferences.getString(PrefsUtils.USER_ID) ?? null;
    final userType = preferences.getString(PrefsUtils.USER_TYPE) ?? null;
    if (userId != null && userType != null) {
      if (userType == kCustomerString) {
        var localCustomer =
            await _database.customerDao.customerById(userId).getSingle();
        yield CustomerModel(customer: localCustomer);

        var customerSnapshot = await _firestore
            .collection(FirestoreUtils.kCustomerRef)
            .doc(userId)
            .get();
        if (customerSnapshot.exists) {
          final customer = Customer.fromJson(customerSnapshot.data());
          await _database.customerDao.addCustomer(customer);
          yield CustomerModel(customer: customer);
        }
      } else if (userType == kArtisanString) {
        final snapshot = await _firestore
            .collection(FirestoreUtils.kArtisanRef)
            .doc(userId)
            .get();
        if (snapshot.exists) {
          final artisan = Artisan.fromJson(snapshot.data());
          await _database.providerDao.saveProvider(artisan);
          yield ArtisanModel(artisan: artisan);
        }
      }
    } else
      yield null;
  }

  @override
  Stream<BaseUser> get onAuthStateChanged => _onAuthStateChanged.stream;

  @override
  Stream<AuthState> get onProcessingStateChanged =>
      _onProcessingStateChanged.stream;

  @override
  Future<void> sendPasswordReset({String email}) =>
      _auth.sendPasswordResetEmail(email: email);

  @override
  Future<BaseUser> signInWithEmailAndPassword(
      {String email, String password, bool isCustomer}) async {
    _onProcessingStateChanged.sink.add(loadingState);
    try {
      // Sign in
      final credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      // Return user instance
      return _userFromFirebase(credential.user, isCustomer: isCustomer);
    } on Exception catch (e) {
      _onProcessingStateChanged.sink.add(errorState);
      debugPrint(e.toString());
      return null;
    }
  }

  @override
  Future<BaseUser> signInWithGoogle() async {
    _onProcessingStateChanged.sink.add(loadingState);
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        throw PlatformException(
            code: "ERROR_MISSING_GOOGLE_AUTH_TOKEN",
            message: "Auth token is missing");
      } else {
        final googleAuth = await googleUser.authentication;
        if (googleAuth.accessToken != null && googleAuth.idToken != null) {
          final userCredential = await _auth.signInWithCredential(
              GoogleAuthProvider.credential(
                  idToken: googleAuth.idToken,
                  accessToken: googleAuth.accessToken));
          return _userFromFirebase(userCredential.user);
        } else {
          throw PlatformException(
              code: "ERROR_ABORTED_BY_USER",
              message: "Operation aborted by user");
        }
      }
    } on PlatformException catch (e) {
      debugPrint(e.message);
      _onProcessingStateChanged.sink.add(errorState);
      return null;
    }
  }

  @override
  Future<bool> signOut() async {
    _onProcessingStateChanged.sink.add(loadingState);
    try {
      await GoogleSignIn().signOut();
      await _auth.signOut();
      _onProcessingStateChanged.sink.add(successState);
      return true;
    } on PlatformException catch (e) {
      debugPrint(e.message);
      _onProcessingStateChanged.sink.add(errorState);
      return false;
    }
  }

  @override
  void dispose() {
    // FIXME: Causes memory leak when turn off
    // _onProcessingStateChanged.close();
    // _onAuthStateChanged.close();
  }

  @override
  Future<void> updateCustomer({
    String username,
    String avatar,
    String createdAt,
    String phone,
  }) async {
    _onProcessingStateChanged.sink.add(loadingState);
    // TODO
    _onProcessingStateChanged.sink.add(initialState);
  }

  @override
  Future<void> updateProvider({
    String username,
    String avatar,
    String createdAt,
    String business,
    bool availability,
    String phone,
    String category,
    int startWorkingHours,
    int endWorkingHours,
    double price,
  }) async {
    _onProcessingStateChanged.sink.add(loadingState);
    // TODO
    // var artisan = artisanModel.artisan.copyWith(
    //   name: username ??= artisanModel.artisan.name,
    //   avatar: avatar ??= artisanModel.artisan.avatar,
    //   business: username ??= artisanModel.artisan.business,
    //   phone: phone ??= artisanModel.artisan.phone,
    //   category: category ??= artisanModel.artisan.category,
    //   startWorkingHours: startWorkingHours ??=
    //       artisanModel.artisan.startWorkingHours,
    //   endWorkingHours: endWorkingHours ??= artisanModel.artisan.endWorkingHours,
    //   price: price ??= artisanModel.artisan.price,
    //   isAvailable: availability ??= artisanModel.artisan.isAvailable,
    // );
    // _onAuthStateChanged.sink.add(ArtisanModel(artisan: artisan));
    _onProcessingStateChanged.sink.add(initialState);
  }
}
