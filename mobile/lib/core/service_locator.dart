import 'package:algolia/algolia.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:handyman/data/local_database.dart';
import 'package:handyman/data/provider/artisan_api_provider.dart';
import 'package:handyman/data/services/auth.dart';
import 'package:handyman/domain/services/auth.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import 'constants.dart';

// Instance of service locator
GetIt sl = GetIt.instance;

// Instance of Algolia
Algolia algolia = Algolia.init(
  applicationId: kAlgoliaAppId,
  apiKey: kAlgoliaKey,
);

// Instance of url launcher
void launchUrl({@required String url}) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

Future<void> registerServiceLocator() async {
// Shared Preferences
  sl.registerLazySingletonAsync<SharedPreferences>(
      () => SharedPreferences.getInstance());

  // Register Provider
  sl.registerLazySingleton<ApiProviderService>(
      () => ApiProviderService.instance);

  // Local database
  sl.registerSingleton<LocalDatabase>(LocalDatabase.instance);

  // Firebase APIs
  sl.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  sl.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);
  sl.registerLazySingleton<StorageReference>(() => FirebaseStorage.instance
      .ref()
      .child(kAppName.toLowerCase().replaceAll(" ", "_")));

  // Services
  sl.registerLazySingleton<AuthService>(() => FirebaseAuthService.instance);
}
