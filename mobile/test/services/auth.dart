import 'dart:async';
import 'dart:math';

import 'package:handyman/data/entities/artisan_model.dart';
import 'package:handyman/data/entities/customer_model.dart';
import 'package:handyman/data/local_database.dart';
import 'package:handyman/domain/models/user.dart';
import 'package:handyman/domain/services/auth.dart';
import 'package:uuid/uuid.dart';

/// Mock implementation of [AuthService]
class MockAuthService implements AuthService {
  final Duration startupTime;
  final Duration responseTime;

  MockAuthService(
      {this.startupTime = const Duration(milliseconds: 850),
      this.responseTime = const Duration(seconds: 2)});

  final customerModel = CustomerModel(
    customer: Customer(
      id: Uuid().v4(),
      email: "quabynahdennis@gmail.com",
      avatar: "",
      name: "Dennis Bilson",
    ),
  );
  final artisanModel = ArtisanModel(
    artisan: Artisan(
      id: Uuid().v4(),
      name: "Quabynah Bilson",
      business: "Quabynah Codelabs LLC",
      email: "codelbas.quabynah@gmail.com",
      isCertified: false,
      isAvailable: true,
      avatar: "",
      category: "programming",
      startWorkingHours: 12,
      endWorkingHours: 20,
      price: 45.99,
      rating: 3.5,
      cancelledBookingsCount: 12,
      completedBookingsCount: 23,
      ongoingBookingsCount: 33,
      phone: "+233123456789",
      requestsCount: 12,
      aboutMe: "",
    ),
  );

  StreamController<BaseUser> _onAuthStateChanged = StreamController<BaseUser>();

  @override
  Future<BaseUser> createUserWithEmailAndPassword({
    String username,
    String email,
    String password,
    bool isCustomer,
  }) async {
    await Future.delayed(startupTime);
    final user = Random().nextBool() ? customerModel : artisanModel;
    _onAuthStateChanged.sink.add(user);
    await Future.delayed(responseTime);
    return user;
  }

  @override
  Stream<BaseUser> currentUser() async* {
    await Future.delayed(startupTime);
    yield Random().nextBool() ? customerModel : artisanModel;
  }

  @override
  void dispose() {
    _onAuthStateChanged.close();
  }

  @override
  Stream<BaseUser> get onAuthStateChanged => _onAuthStateChanged.stream;

  @override
  Future<void> sendPasswordReset({String email}) async {
    await Future.delayed(startupTime);
    return Future.delayed(responseTime);
  }

  @override
  Future<BaseUser> signInWithEmailAndPassword({
    String email,
    String password,
    bool isCustomer,
  }) async {
    await Future.delayed(startupTime);
    final user = Random().nextBool() ? customerModel : artisanModel;
    _onAuthStateChanged.sink.add(user);
    await Future.delayed(responseTime);
    return user;
  }

  @override
  Future<BaseUser> signInWithGoogle() async {
    await Future.delayed(startupTime);
    _onAuthStateChanged.sink.add(customerModel);
    await Future.delayed(responseTime);
    return customerModel;
  }

  @override
  Future<bool> signOut() async {
    await Future.delayed(startupTime);
    _onAuthStateChanged.sink.add(null);
    await Future.delayed(responseTime);
    return true;
  }

  @override
  Future<void> updateCustomer({
    String username,
    String avatar,
    String createdAt,
    String phone,
  }) async {}

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
    await Future.delayed(startupTime);
    var artisan = artisanModel.artisan.copyWith(
      name: username ??= artisanModel.artisan.name,
      avatar: avatar ??= artisanModel.artisan.avatar,
      business: username ??= artisanModel.artisan.business,
      phone: phone ??= artisanModel.artisan.phone,
      category: category ??= artisanModel.artisan.category,
      startWorkingHours: startWorkingHours ??=
          artisanModel.artisan.startWorkingHours,
      endWorkingHours: endWorkingHours ??= artisanModel.artisan.endWorkingHours,
      price: price ??= artisanModel.artisan.price,
      isAvailable: availability ??= artisanModel.artisan.isAvailable,
    );
    _onAuthStateChanged.sink.add(ArtisanModel(artisan: artisan));
    return Future.delayed(responseTime);
  }

  @override
  Stream<AuthState> get onProcessingStateChanged =>
      Stream.value(AuthState.NONE);
}
