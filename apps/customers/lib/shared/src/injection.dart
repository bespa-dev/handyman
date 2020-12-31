import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:lite/data/sources/sources.dart';
import 'package:lite/domain/models/models.dart';
import 'package:lite/shared/shared.dart';

/// repository provider class
class Injection {
  /// list of all repositories
  static final _repos = <Exposable>[];

  static Future<void> inject() async {
    var container = ProviderContainer();
    // final prefs = await container.read(_sharedPreferencesProvider.future);
    // _repos.add(await container.read(_authRepositoryProvider.future));
    // _repos.add(await container.read(_userRepositoryProvider.future));
    // _repos.add(await container.read(_commentRepositoryProvider.future));
    // _repos.add(await container.read(_devotionRepositoryProvider.future));
    // _repos.add(await container.read(_feedRepositoryProvider.future));
    // _repos.add(await container.read(_groupRepositoryProvider.future));
    // _repos.add(await container.read(_messageRepositoryProvider.future));
    // _repos.add(await container.read(_ministryRepositoryProvider.future));
    // _repos.add(container.read(_prefsRepositoryProvider(prefs)));
    // _repos.add(await container.read(_schoolRepositoryProvider.future));
    // _repos.add(await container.read(_programmeRepositoryProvider.future));
    // _repos.add(await container.read(_searchRepositoryProvider.future));
    // _repos.add(container.read(_storageRepositoryProvider));
    // _repos.add(await container.read(_storeRepositoryProvider.future));
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

/// region SDKs
Future<void> registerSDKs() async {
  // Locale support for calendar date formatting
  await initializeDateFormatting();

  // Initialize Firebase App
  await Firebase.initializeApp();

  // register & open hive database boxes
  await registerHiveDatabase();
}

/// endregion SDKs
