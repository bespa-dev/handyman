import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Instance of service locator
GetIt sl = GetIt.instance;

Future<void> registerServiceLocator() async {
// Shared Preferences
  sl.registerLazySingletonAsync(() => SharedPreferences.getInstance());
}
