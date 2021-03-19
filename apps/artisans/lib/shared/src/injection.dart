/*
 * Copyright (c) 2021.
 * This application is owned by HandyMan LLC,
 * developed & designed by Quabynah Codelabs LLC.
 *
 *
 * author: codelbas.quabynah@gmail.com
 */

import 'package:algolia/algolia.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:handyman/data/entities/entities.dart';
import 'package:handyman/data/repositories/repositories.dart';
import 'package:handyman/data/sources/sources.dart';
import 'package:handyman/domain/models/models.dart';
import 'package:handyman/domain/repositories/repositories.dart';
import 'package:handyman/domain/sources/sources.dart';
import 'package:handyman/shared/shared.dart';
import 'package:hive/hive.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:sembast/sembast.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// region Services

final notificationServiceProvider = Provider((_) => LocalNotificationService());

final firebaseMessaging = Provider((_) => FirebaseMessaging.instance);

/// endregion

/// region Preferences
final sharedPreferencesProvider = FutureProvider<SharedPreferences>(
    (_) async => await SharedPreferences.getInstance());

@Exposed()
final prefsRepositoryProvider =
    ChangeNotifierProvider.family<BasePreferenceRepository, SharedPreferences>(
        (_, prefs) {
  return PreferenceRepositoryImpl(prefs: prefs);
});

/// endregion Preferences

/// region Repositories
@Exposed()
final _authRepositoryProvider =
    FutureProvider.autoDispose<BaseAuthRepository>((_) async {
  final sharedPrefs = await _.watch(sharedPreferencesProvider.future);
  var prefs = _.read(prefsRepositoryProvider(sharedPrefs));
  return _.watch(_firebaseAuthRepositoryProvider(prefs).future);
});

@Exposed()
final _bookingRepositoryProvider =
    FutureProvider.family<BaseBookingRepository, BasePreferenceRepository>(
        (_, prefs) async {
  var local = await _.read(localDatasourceProvider(prefs).future);
  var remote = _.read(remoteDatasourceProvider(prefs));
  return BookingRepositoryImpl(local: local, remote: remote);
});

final _businessRepositoryProvider =
    FutureProvider.family<BaseBusinessRepository, BasePreferenceRepository>(
        (_, prefs) async {
  var local = await _.read(localDatasourceProvider(prefs).future);
  var remote = _.read(remoteDatasourceProvider(prefs));
  return BusinessRepositoryImpl(local: local, remote: remote);
});

final _serviceRepositoryProvider = FutureProvider.family<
    BaseArtisanServiceRepository, BasePreferenceRepository>((_, prefs) async {
  var local = await _.read(localDatasourceProvider(prefs).future);
  var remote = _.read(remoteDatasourceProvider(prefs));
  return ArtisanServiceRepositoryImpl(local: local, remote: remote);
});

@Exposed()
final _categoryRepositoryProvider =
    FutureProvider.family<BaseCategoryRepository, BasePreferenceRepository>(
        (_, prefs) async {
  var local = await _.read(localDatasourceProvider(prefs).future);
  var remote = _.read(remoteDatasourceProvider(prefs));
  return CategoryRepositoryImpl(local: local, remote: remote);
});

@Exposed()
final _conversationRepositoryProvider =
    FutureProvider.family<BaseConversationRepository, BasePreferenceRepository>(
        (_, prefs) async {
  var local = await _.read(localDatasourceProvider(prefs).future);
  var remote = _.read(remoteDatasourceProvider(prefs));
  return ConversationRepositoryImpl(local: local, remote: remote);
});

@Exposed()
final _galleryRepositoryProvider =
    FutureProvider.family<BaseGalleryRepository, BasePreferenceRepository>(
        (_, prefs) async {
  var local = await _.read(localDatasourceProvider(prefs).future);
  var remote = _.read(remoteDatasourceProvider(prefs));
  return GalleryRepositoryImpl(local: local, remote: remote);
});

@Exposed()
final _locationRepositoryProvider = Provider<BaseLocationRepository>((_) {
  final geocoding = Geocoder.local;
  return LocationRepositoryImpl(geocoding: geocoding);
});

final _reviewRepositoryProvider =
    FutureProvider.family<BaseReviewRepository, BasePreferenceRepository>(
        (_, prefs) async {
  var local = await _.read(localDatasourceProvider(prefs).future);
  var remote = _.read(remoteDatasourceProvider(prefs));
  return ReviewRepositoryImpl(local: local, remote: remote);
});

@Exposed()
final _searchRepositoryProvider =
    FutureProvider.family<BaseSearchRepository, BasePreferenceRepository>(
        (_, prefs) async {
  var local = await _.read(localDatasourceProvider(prefs).future);
  var remote = _.read(remoteDatasourceProvider(prefs));
  final dotenv = DotEnv();
  final algolia = Algolia.init(
    applicationId: dotenv.env['applicationId'],
    apiKey: dotenv.env['apiKey'],
  );
  return SearchRepositoryImpl(local: local, remote: remote, algolia: algolia);
});

@Exposed()
final _storageRepositoryProvider =
    Provider.autoDispose<BaseStorageRepository>((_) {
  return _.watch(_firebaseStorageRepositoryProvider);
});

final _userRepositoryProvider =
    FutureProvider.family<BaseUserRepository, BasePreferenceRepository>(
        (_, prefs) async {
  var local = await _.read(localDatasourceProvider(prefs).future);
  var remote = _.read(remoteDatasourceProvider(prefs));
  return UserRepositoryImpl(local: local, remote: remote);
});

@Exposed()
final _firebaseAuthRepositoryProvider =
    FutureProvider.family<BaseAuthRepository, BasePreferenceRepository>(
        (_, prefs) async {
  var userRepo = await _.read(_userRepositoryProvider(prefs).future);
  return AuthRepositoryImpl(
    auth: FirebaseAuth.instance,
    messaging: FirebaseMessaging.instance,
    googleSignIn: GoogleSignIn(),
    prefsRepo: prefs,
    userRepo: userRepo,
  );
});

final _firebaseStorageRepositoryProvider = Provider<BaseStorageRepository>((_) {
  final bucket = FirebaseStorage.instance.ref(RefUtils.kBucketRef).child('/uploads');
  return StorageRepositoryImpl(bucket: bucket);
});

/// endregion

/// region Data sources
final remoteDatasourceProvider =
    Provider.family<BaseRemoteDatasource, BasePreferenceRepository>((_, prefs) {
  return _.watch(_firebaseRemoteDatasourceProvider(prefs));
});

final localDatasourceProvider =
    FutureProvider.family<BaseLocalDatasource, BasePreferenceRepository>(
        (_, prefs) async =>
            await _.read(_sembastDatasourceProvider(prefs).future));

/// FIREBASE datasource provider -> remote source
final _firebaseRemoteDatasourceProvider =
    Provider.family<BaseRemoteDatasource, BasePreferenceRepository>((_, prefs) {
  return FirebaseRemoteDatasource(
      prefsRepo: prefs, firestore: FirebaseFirestore.instance);
});

/// HIVE datasource provider -> local source
final _hiveDatasourceProvider = ChangeNotifierProvider.family<
    BaseLocalDatasource, BasePreferenceRepository>((_, prefs) {
  return HiveLocalDatasource(
    prefsRepo: prefs,
    bookingBox: Hive.box<Booking>(RefUtils.kBookingRef),
    categoryBox: Hive.box<ServiceCategory>(RefUtils.kCategoryRef),
    conversationBox: Hive.box<Conversation>(RefUtils.kConversationRef),
    galleryBox: Hive.box<Gallery>(RefUtils.kGalleryRef),
    reviewBox: Hive.box<Review>(RefUtils.kReviewRef),
    artisanBox: Hive.box<Artisan>(RefUtils.kArtisanRef),
    customerBox: Hive.box<Customer>(RefUtils.kCustomerRef),
    businessBox: Hive.box<Business>(RefUtils.kBusinessRef),
    serviceBox: Hive.box<ArtisanService>(RefUtils.kServiceRef),
  );
});

final _localSembastDatabaseProvider =
    FutureProvider<Database>((_) async => AppDatabase.instance.database);
final _sembastDatasourceProvider =
    FutureProvider.family<BaseLocalDatasource, BasePreferenceRepository>(
        (_, prefs) async => SemBastLocalDatasource(
              prefsRepo: prefs,
              bookingStore: stringMapStoreFactory.store(RefUtils.kBookingRef),
              categoryStore: stringMapStoreFactory.store(RefUtils.kCategoryRef),
              conversationStore:
                  stringMapStoreFactory.store(RefUtils.kConversationRef),
              galleryStore: stringMapStoreFactory.store(RefUtils.kGalleryRef),
              reviewStore: stringMapStoreFactory.store(RefUtils.kReviewRef),
              artisanStore: stringMapStoreFactory.store(RefUtils.kArtisanRef),
              customerStore: stringMapStoreFactory.store(RefUtils.kCustomerRef),
              businessStore: stringMapStoreFactory.store(RefUtils.kBusinessRef),
              serviceStore: stringMapStoreFactory.store(RefUtils.kServiceRef),
              db: await _.read(_localSembastDatabaseProvider.future),
            ));

/// endregion Data sources

/// region Dependency Injection
class Injection {
  /// list of all repositories
  static final _repos = <dynamic>[];

  static Future<void> inject() async {
    var container = ProviderContainer();
    final prefs = await container.read(sharedPreferencesProvider.future);
    var prefsRepo = container.read(prefsRepositoryProvider(prefs));
    _repos.add(prefsRepo);
    _repos.add(await container.read(_authRepositoryProvider.future));
    _repos.add(
        await container.read(_bookingRepositoryProvider(prefsRepo).future));
    _repos.add(
        await container.read(_businessRepositoryProvider(prefsRepo).future));
    _repos.add(
        await container.read(_serviceRepositoryProvider(prefsRepo).future));
    _repos.add(
        await container.read(_categoryRepositoryProvider(prefsRepo).future));
    _repos.add(await container
        .read(_conversationRepositoryProvider(prefsRepo).future));
    _repos.add(
        await container.read(_galleryRepositoryProvider(prefsRepo).future));
    _repos.add(await container.read(_locationRepositoryProvider));
    _repos
        .add(await container.read(_reviewRepositoryProvider(prefsRepo).future));
    _repos
        .add(await container.read(_searchRepositoryProvider(prefsRepo).future));
    _repos.add(container.read(_storageRepositoryProvider));
    _repos.add(await container.read(_userRepositoryProvider(prefsRepo).future));
    _repos.add(await container.read(firebaseMessaging));
    logger.i('${_repos.length} repositories injected');
  }

  /// retrieves an instance of a repository registered above
  static R get<R>() {
    for (var value in _repos) {
      if (value is R) return value;
    }
    throw Exception('Unknown repository for -> ${R.runtimeType}');
  }
}

/// endregion

/// region Init Dependencies
Future<void> initAppDependencies() async {
  /// Locale support for calendar date formatting
  await initializeDateFormatting();

  /// Initialize Firebase App
  await Firebase.initializeApp();

  /// register & open local database
  await registerLocalDatabase(false);

  /// load environment variables
  await DotEnv().load('.env');

  /// inject dependencies
  await Injection.inject();
}

/// endregion
