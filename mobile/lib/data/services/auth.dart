import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:handyman/app/model/prefs_provider.dart';
import 'package:handyman/core/constants.dart';
import 'package:handyman/core/service_locator.dart';
import 'package:handyman/core/utils.dart';
import 'package:handyman/data/entities/artisan_model.dart';
import 'package:handyman/data/entities/customer_model.dart';
import 'package:handyman/data/local_database.dart';
import 'package:handyman/domain/models/user.dart';
import 'package:handyman/domain/services/auth.dart';

/// [AuthService] implementation for production use
class FirebaseAuthService implements AuthService {
  // Firebase SDKs
  final _auth = sl.get<FirebaseAuth>();
  final _firestore = sl.get<FirebaseFirestore>();
  final _firebaseMessaging = sl.get<FirebaseMessaging>();

  // Local database
  final _database = sl.get<LocalDatabase>();

  // Get prefs instance
  final _prefsProvider = sl.get<PrefsProvider>();

  // Authentication states
  final successState = AuthState.SUCCESS;
  final errorState = AuthState.ERROR;
  final loadingState = AuthState.AUTHENTICATING;
  final initialState = AuthState.NONE;

  // Private constructor
  FirebaseAuthService._() {
    // Get current user id, if any
    final uid = _auth.currentUser?.uid;
    debugPrint("FirebaseAuthService._(): User id => $uid");

    // Save to prefs
    if (uid != null && uid.isNotEmpty) _prefsProvider?.saveUserId(uid);
  }

  // Singleton
  static AuthService create() => FirebaseAuthService._();

  // StreamControllers
  final StreamController<String> _onMessageChanged =
      StreamController.broadcast();
  final StreamController<BaseUser> _onAuthStateChanged =
      StreamController.broadcast();
  final StreamController<AuthState> _onProcessingStateChanged =
      StreamController.broadcast();

  /// Creates new user data in Firestore & saves it locally, returning that user instance
  Future<BaseUser> _createUserInstance(
      User user, String username, bool isCustomer) async {
    _onProcessingStateChanged.sink.add(loadingState);
    _onMessageChanged.sink.add("Please wait...");

    // get device token
    final token = await _firebaseMessaging.getToken();

    if (isCustomer) {
      final customer = Customer(
        id: user.uid,
        name: username,
        email: user.email,
        avatar: user.photoURL,
        phone: user.phoneNumber,
        token: token,
        createdAt: DateTime.now().millisecondsSinceEpoch,
      );
      await _firestore
          .collection(FirestoreUtils.kCustomerRef)
          .doc(user.uid)
          .set(customer.toJson());

      final model = CustomerModel(customer: customer);
      await _database.userDao.addCustomer(model);
      _prefsProvider.saveUserId(user.uid);
      _prefsProvider.saveUserType(kCustomerString);
      _onProcessingStateChanged.sink.add(successState);
      _onAuthStateChanged.sink.add(model);
      _onMessageChanged.sink.add("Account created successfully");
      return model;
    } else {
      final artisan = Artisan(
        id: user.uid,
        name: username,
        business: "None available",
        email: user.email,
        avatar: user.photoURL,
        phone: user.phoneNumber,
        token: token,
        isCertified: false,
        isAvailable: true,
        isApproved: false,
        aboutMe: "Hello there, I am using $kAppName!",
        category: kGeneralCategory,
        startWorkingHours: DateTime.now().millisecondsSinceEpoch,
        reportsCount: 0,
        completedBookingsCount: 0,
        ongoingBookingsCount: 0,
        cancelledBookingsCount: 0,
        endWorkingHours: DateTime.now().millisecondsSinceEpoch + 43200000,
        rating: 2.5,
        startPrice: 19.99,
        endPrice: 119.99,
        requestsCount: 0,
        createdAt: DateTime.now().millisecondsSinceEpoch,
      );
      await _firestore
          .collection(FirestoreUtils.kArtisanRef)
          .doc(user.uid)
          .set(artisan.toJson());

      final model = ArtisanModel(artisan: artisan);
      await _database.userDao.saveProvider(model);
      _prefsProvider.saveUserId(user.uid);
      _prefsProvider.saveUserType(kArtisanString);
      _onProcessingStateChanged.sink.add(successState);
      _onAuthStateChanged.sink.add(model);
      _onMessageChanged.sink.add("Account created successfully");
      return model;
    }
  }

  /// Gets user's data from Firestore & saves it locally, returning that user instance
  Future<BaseUser> _userFromFirebase(User user,
      {bool isCustomer = true}) async {
    _onProcessingStateChanged.sink.add(loadingState);
    _onMessageChanged.sink.add("Please wait...");

    // get device token
    final token = await _firebaseMessaging.getToken();
    if (await _userExists(user.email, isCustomer: isCustomer)) {
      if (isCustomer) {
        final snapshot = await _firestore
            .collection(FirestoreUtils.kCustomerRef)
            .doc(user.uid)
            .get();
        if (snapshot.exists) {
          final customer = Customer.fromJson(snapshot.data());
          final model =
              CustomerModel(customer: customer.copyWith(token: token));
          await _database.userDao.addCustomer(model);
          _prefsProvider.saveUserId(user.uid);
          _prefsProvider.saveUserType(kCustomerString);
          _onProcessingStateChanged.sink.add(successState);
          _onAuthStateChanged.sink.add(model);
          _onMessageChanged.sink.add("Account updated successfully");
          return model;
        } else {
          _onProcessingStateChanged.sink.add(errorState);
          _onMessageChanged.sink.add("Unable to get your account details");
          return null;
        }
      } else {
        final snapshot = await _firestore
            .collection(FirestoreUtils.kArtisanRef)
            .doc(user.uid)
            .get();
        if (snapshot.exists) {
          final artisan = Artisan.fromJson(snapshot.data());

          final model = ArtisanModel(
              artisan: artisan.copyWith(
            business: artisan.business ?? "",
            token: token,
          ));
          await _database.userDao.saveProvider(model);
          _prefsProvider.saveUserId(user.uid);
          _prefsProvider.saveUserType(kArtisanString);
          _onProcessingStateChanged.sink.add(successState);
          _onAuthStateChanged.sink.add(model);
          _onMessageChanged.sink.add("Account updated successfully");
          return model;
        } else {
          _onAuthStateChanged.sink.add(null);
          _onProcessingStateChanged.sink.add(errorState);
          _onMessageChanged.sink.add("Unable to get your account details");
          return null;
        }
      }
    } else
      return _createUserInstance(user, user.displayName, isCustomer);
  }

  /// Checks for user's data existence in Firestore
  Future<bool> _userExists(String email, {bool isCustomer = true}) async {
    if (isCustomer) {
      final snapshot = await _firestore
          .collection(FirestoreUtils.kCustomerRef)
          .where("email", isEqualTo: email)
          .get();

      return snapshot.size > 0;
    } else {
      final snapshot = await _firestore
          .collection(FirestoreUtils.kArtisanRef)
          .where("email", isEqualTo: email)
          .get();
      return snapshot.size > 0;
    }
  }

  /// Creates new user accounts
  @override
  Future<BaseUser> createUserWithEmailAndPassword({
    String username,
    String email,
    String password,
    bool isCustomer,
  }) async {
    _onProcessingStateChanged.sink.add(loadingState);
    _onMessageChanged.sink.add("Please wait...");

    try {
      // Create user account
      final credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      // Update user information online
      await _auth.currentUser.updateProfile(displayName: username);

      return _createUserInstance(credential.user, username, isCustomer);
    } on Exception catch (e) {
      _onProcessingStateChanged.sink.add(errorState);
      _onMessageChanged.sink.add(
          "Failed to create your account at this time. Please try again later");
      debugPrint(e.toString());
      return null;
    }
  }

  /// Listens for current user's details
  @override
  Stream<BaseUser> currentUser() async* {
    if (!_prefsProvider.isLoggedIn) return;

    // Listen for changes in user id
    // _prefsProvider.onUserIdChanged.listen((userId) async* {
    final userId = _prefsProvider.userId;
    debugPrint(
        "FirebaseAuthService.currentUser => ${_prefsProvider.userType} : $userId");
    if (userId == null || userId.isEmpty) return;

    if (_prefsProvider.userType == kCustomerString) {
      var localSource = _database.userDao
          .customerById(userId)
          .watchSingle()
          .map((customer) => CustomerModel(customer: customer));
      yield* localSource;

      // Get snapshots from Firestore
      var customerSnapshot = _firestore
          .collection(FirestoreUtils.kCustomerRef)
          .doc(userId)
          .snapshots(includeMetadataChanges: true);
      customerSnapshot.listen((event) async {
        if (event.exists) {
          // Update local database
          final customer = Customer.fromJson(event.data());
          final model = CustomerModel(customer: customer);
          await _database.userDao.addCustomer(model);
        }
      });
    } else {
      var localSource = _database.userDao
          .artisanById(userId)
          .watchSingle()
          .map((event) => ArtisanModel(artisan: event));
      yield* localSource;

      // Get snapshots from Firestore
      final snapshot = _firestore
          .collection(FirestoreUtils.kArtisanRef)
          .doc(userId)
          .snapshots(includeMetadataChanges: true);
      snapshot.listen((event) async {
        if (event.exists) {
          // Update local database
          final artisan = Artisan.fromJson(event.data());
          final model = ArtisanModel(artisan: artisan);
          await _database.userDao.saveProvider(model);
        }
      });
    }
    // });
  }

  /// Listens to [BaseUser] changes
  @override
  Stream<BaseUser> get onAuthStateChanged => _onAuthStateChanged.stream;

  /// Listens to [AuthState] changes
  @override
  Stream<AuthState> get onProcessingStateChanged =>
      _onProcessingStateChanged.stream;

  /// Listens to message changes. This will be displayed from the UI
  @override
  Stream<String> get onMessageChanged => _onMessageChanged.stream;

  /// Resets user password
  @override
  Future<void> sendPasswordReset({String email}) async {
    _onProcessingStateChanged.sink.add(loadingState);
    await _auth.sendPasswordResetEmail(email: email);
    _onProcessingStateChanged.sink.add(successState);
  }

  /// Signs in existing users
  @override
  Future<BaseUser> signInWithEmailAndPassword(
      {String email, String password, bool isCustomer}) async {
    _onProcessingStateChanged.sink.add(loadingState);
    try {
      final userExists = await _userExists(email, isCustomer: isCustomer);
      if (userExists) {
        // Sign in
        final credential = await _auth.signInWithEmailAndPassword(
            email: email, password: password);

        // Return user instance
        return _userFromFirebase(credential.user, isCustomer: isCustomer);
      } else {
        _onProcessingStateChanged.sink.add(errorState);
        return null;
      }
    } on Exception catch (e) {
      _onProcessingStateChanged.sink.add(errorState);
      debugPrint(e.toString());
      return null;
    }
  }

  /// Signs in with Google account
  @override
  Future<BaseUser> signInWithGoogle({bool isCustomer = true}) async {
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
          return _userFromFirebase(userCredential.user, isCustomer: isCustomer);
        } else {
          throw PlatformException(
              code: "ERROR_ABORTED_BY_USER",
              message: "Operation aborted by user");
        }
      }
    } on PlatformException catch (e) {
      debugPrint("Google Auth => ${e.message}");
      _onProcessingStateChanged.sink.add(errorState);
      _onMessageChanged.sink.add(e.message);
      return null;
    } catch (e) {
      debugPrint("Google Auth => $e");
      _onProcessingStateChanged.sink.add(errorState);
      _onMessageChanged.sink.add(e.toString());
      return null;
    }
  }

  /// Signs out any logged in user
  @override
  Future<bool> signOut() async {
    _onProcessingStateChanged?.sink?.add(loadingState);
    try {
      // Perform sign out
      await _auth.signOut();
      final googleSignIn = GoogleSignIn();
      if (googleSignIn.currentUser != null) await googleSignIn.signOut();

      // Clear prefs
      await _prefsProvider.clearUserData();

      _onProcessingStateChanged?.sink?.add(successState);
      _onAuthStateChanged?.sink?.add(null);
      return true;
    } on PlatformException catch (e) {
      debugPrint(e.message);
      _onProcessingStateChanged?.sink?.add(errorState);
      return false;
    }
  }

  /// Closes all active streams
  @override
  void dispose() {
    _onProcessingStateChanged.close();
    _onAuthStateChanged.close();
    _onMessageChanged.close();
  }
}
