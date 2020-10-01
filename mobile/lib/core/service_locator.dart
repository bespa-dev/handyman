import 'package:algolia/algolia.dart';
import 'package:get_it/get_it.dart';
import 'package:handyman/data/local_database.dart';
import 'package:handyman/data/provider/artisan_api_provider.dart';
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

  sl.registerSingleton<LocalDatabase>(LocalDatabase.instance);
}
