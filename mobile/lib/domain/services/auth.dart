import 'dart:async' show Future, Stream;

import 'package:handyman/domain/models/user.dart';
import 'package:meta/meta.dart';

/// Base authentication service
abstract class AuthService {
  Stream<BaseUser> currentUser();

  Future<BaseUser> signInWithEmailAndPassword({
    @required String email,
    @required String password,
    bool isCustomer,
  });

  Future<BaseUser> createUserWithEmailAndPassword({
    @required String username,
    @required String email,
    @required String password,
    bool isCustomer,
  });

  Future<void> updateCustomer({
    String username,
    String avatar,
    String createdAt,
    String phone,
  });

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
  });

  Future<void> sendPasswordReset({@required String email});

  Future<BaseUser> signInWithGoogle();

  Future<bool> signOut();

  Stream<BaseUser> get onAuthStateChanged;

  Stream<bool> get onProcessingStateChanged;

  void dispose();
}
