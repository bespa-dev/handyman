import 'package:get_it/get_it.dart';
import 'package:handyman/data/provider/artisan_api_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Instance of service locator
GetIt sl = GetIt.instance;

Future<void> registerServiceLocator() async {
// Shared Preferences
  sl.registerLazySingletonAsync<SharedPreferences>(
      () => SharedPreferences.getInstance());

  // Artisan API Provider
  sl.registerLazySingleton<ArtisanProvider>(() => ArtisanProvider.instance);
}
