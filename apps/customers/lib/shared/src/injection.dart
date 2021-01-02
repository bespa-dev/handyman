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
import 'package:geolocator/geolocator.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive/hive.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:jiffy/jiffy.dart';
import 'package:lite/data/entities/entities.dart';
import 'package:lite/data/repositories/repositories.dart';
import 'package:lite/data/sources/sources.dart';
import 'package:lite/domain/models/models.dart';
import 'package:lite/domain/repositories/repositories.dart';
import 'package:lite/domain/sources/sources.dart';
import 'package:lite/shared/shared.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// region Preferences
final _sharedPreferencesProvider = FutureProvider<SharedPreferences>(
    (_) async => await SharedPreferences.getInstance());

@Exposed()
final _prefsRepositoryProvider =
    ChangeNotifierProvider.family<BasePreferenceRepository, SharedPreferences>(
        (_, prefs) {
  return PreferenceRepositoryImpl(prefs: prefs);
});

/// endregion Preferences

/// region Repositories
@Exposed()
final _authRepositoryProvider =
    FutureProvider.autoDispose<BaseAuthRepository>((_) async {
  final sharedPrefs = await _.watch(_sharedPreferencesProvider.future);
  var prefs = _.read(_prefsRepositoryProvider(sharedPrefs));
  return _.watch(_firebaseAuthRepositoryProvider(prefs).future);
});

@Exposed()
final _bookingRepositoryProvider =
    Provider.family<BaseBookingRepository, BasePreferenceRepository>(
        (_, prefs) {
  var local = _.read(_localDatasourceProvider(prefs));
  var remote = _.read(_remoteDatasourceProvider(prefs));
  return BookingRepositoryImpl(local: local, remote: remote);
});

@Exposed()
final _businessRepositoryProvider =
    Provider.family<BaseBusinessRepository, BasePreferenceRepository>(
        (_, prefs) {
  var local = _.read(_localDatasourceProvider(prefs));
  var remote = _.read(_remoteDatasourceProvider(prefs));
  return BusinessRepositoryImpl(local: local, remote: remote);
});

@Exposed()
final _categoryRepositoryProvider =
    Provider.family<BaseCategoryRepository, BasePreferenceRepository>(
        (_, prefs) {
  var local = _.read(_localDatasourceProvider(prefs));
  var remote = _.read(_remoteDatasourceProvider(prefs));
  return CategoryRepositoryImpl(local: local, remote: remote);
});

@Exposed()
final _conversationRepositoryProvider =
    Provider.family<BaseConversationRepository, BasePreferenceRepository>(
        (_, prefs) {
  var local = _.read(_localDatasourceProvider(prefs));
  var remote = _.read(_remoteDatasourceProvider(prefs));
  return ConversationRepositoryImpl(local: local, remote: remote);
});

@Exposed()
final _galleryRepositoryProvider =
    Provider.family<BaseGalleryRepository, BasePreferenceRepository>(
        (_, prefs) {
  var local = _.read(_localDatasourceProvider(prefs));
  var remote = _.read(_remoteDatasourceProvider(prefs));
  return GalleryRepositoryImpl(local: local, remote: remote);
});

@Exposed()
final _locationRepositoryProvider = Provider<BaseLocationRepository>((_) {
  final geocoding = Geocoder.local;
  final locatorService = Geolocator();
  return LocationRepositoryImpl(
      locatorService: locatorService, geocoding: geocoding);
});

final _reviewRepositoryProvider =
    Provider.family<BaseReviewRepository, BasePreferenceRepository>((_, prefs) {
  var local = _.read(_localDatasourceProvider(prefs));
  var remote = _.read(_remoteDatasourceProvider(prefs));
  return ReviewRepositoryImpl(local: local, remote: remote);
});

@Exposed()
final _searchRepositoryProvider =
    Provider.family<BaseSearchRepository, BasePreferenceRepository>((_, prefs) {
  var local = _.read(_localDatasourceProvider(prefs));
  final algolia = Algolia.init(
    applicationId: DotEnv().env['applicationId'],
    apiKey: DotEnv().env['apiKey'],
  );
  return SearchRepositoryImpl(local: local, algolia: algolia);
});

@Exposed()
final _storageRepositoryProvider =
    Provider.autoDispose<BaseStorageRepository>((_) {
  return _.watch(_firebaseStorageRepositoryProvider);
});

@Exposed()
final _userRepositoryProvider =
    Provider.family<BaseUserRepository, BasePreferenceRepository>((_, prefs) {
  var local = _.read(_localDatasourceProvider(prefs));
  var remote = _.read(_remoteDatasourceProvider(prefs));
  return UserRepositoryImpl(local: local, remote: remote);
});

@Exposed()
final _firebaseAuthRepositoryProvider =
    FutureProvider.family<BaseAuthRepository, BasePreferenceRepository>(
        (_, prefs) async {
  var userRepo = _.read(_userRepositoryProvider(prefs));
  return AuthRepositoryImpl(
    auth: FirebaseAuth.instance,
    messaging: FirebaseMessaging(),
    googleSignIn: GoogleSignIn(),
    prefsRepo: prefs,
    userRepo: userRepo,
  );
});

final _firebaseStorageRepositoryProvider = Provider<BaseStorageRepository>((_) {
  final bucket = FirebaseStorage.instance.ref().child(RefUtils.kBucketRef);
  return StorageRepositoryImpl(bucket: bucket);
});

/// endregion

/// region Data sources
final _remoteDatasourceProvider =
    Provider.family<BaseRemoteDatasource, BasePreferenceRepository>((_, prefs) {
  return _.watch(_firebaseRemoteDatasourceProvider(prefs));
});

final _localDatasourceProvider =
    Provider.family<BaseLocalDatasource, BasePreferenceRepository>((_, prefs) {
  return _.watch(_hiveDatasourceProvider(prefs));
});

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
  );
});

/// endregion Data sources

/// region Parsers
String parseFromTimestamp(
  DateTime timestamp, {
  bool isChatFormat = false,
  bool isDetailedFormat = false,
  bool fromNow = false,
}) {
  return fromNow
      ? Jiffy.unix(timestamp.millisecondsSinceEpoch).fromNow()
      : isChatFormat
          ? Jiffy.unix(timestamp.millisecondsSinceEpoch).jm
          : isDetailedFormat
              ? Jiffy.unix(timestamp.millisecondsSinceEpoch).yMMMEd
              : Jiffy.unix(timestamp.millisecondsSinceEpoch).yMMMd;
}

/// endregion

/// region Dependency Injection
class Injection {
  /// list of all repositories
  static final _repos = <Exposable>[];

  static Future<void> inject() async {
    var container = ProviderContainer();
    final prefs = await container.read(_sharedPreferencesProvider.future);
    var prefsRepo = container.read(_prefsRepositoryProvider(prefs));
    _repos.add(await container.read(_authRepositoryProvider.future));
    _repos.add(await container.read(_bookingRepositoryProvider(prefsRepo)));
    _repos.add(await container.read(_businessRepositoryProvider(prefsRepo)));
    _repos.add(await container.read(_categoryRepositoryProvider(prefsRepo)));
    _repos
        .add(await container.read(_conversationRepositoryProvider(prefsRepo)));
    _repos.add(await container.read(_galleryRepositoryProvider(prefsRepo)));
    _repos.add(await container.read(_locationRepositoryProvider));
    _repos.add(prefsRepo);
    _repos.add(await container.read(_reviewRepositoryProvider(prefsRepo)));
    _repos.add(await container.read(_searchRepositoryProvider(prefsRepo)));
    _repos.add(container.read(_storageRepositoryProvider));
    _repos.add(await container.read(_userRepositoryProvider(prefsRepo)));
    logger.i("${_repos.length} repositories injected");
  }

  /// retrieves an instance of a repository registered above
  static R get<R>() {
    for (var value in _repos) {
      if (value is R) return value as R;
    }
    return null;
  }
}

/// endregion

/// region Init Dependencies
Future<void> initAppDependencies() async {
  /// Locale support for calendar date formatting
  await initializeDateFormatting();

  /// Initialize Firebase App
  await Firebase.initializeApp();

  /// register & open hive database boxes
  await registerHiveDatabase();

  /// load environment variables
  await DotEnv().load('.env');

  /// inject dependencies
  await Injection.inject();
}

/// endregion
