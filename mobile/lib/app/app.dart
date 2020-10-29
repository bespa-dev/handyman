import 'package:auto_route/auto_route.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:handyman/app/model/prefs_provider.dart';
import 'package:handyman/app/routes/guard.dart';
import 'package:handyman/app/routes/route.gr.dart' as gr;
import 'package:handyman/core/theme.dart';
import 'package:handyman/data/services/auth.dart';
import 'package:handyman/data/services/data.dart';
import 'package:handyman/data/services/storage.dart';
import 'package:handyman/domain/services/auth.dart';
import 'package:handyman/domain/services/data.dart';
import 'package:handyman/domain/services/storage.dart';
import 'package:provider/provider.dart';

class HandyManApp extends StatefulWidget {
  @override
  _HandyManAppState createState() => _HandyManAppState();
}

class _HandyManAppState extends State<HandyManApp> {
  final _analytics = FirebaseAnalytics();

  Future<void> setupRemoteConfig() async {
    // RemoteConfig
    final RemoteConfig remoteConfig = await RemoteConfig.instance;

    // Enable developer mode to relax fetch throttling
    remoteConfig.setConfigSettings(RemoteConfigSettings(debugMode: true));
    remoteConfig.setDefaults(<String, dynamic>{
      'welcome': 'default welcome',
      'hello': 'default hello',
    });
  }

  @override
  void initState() {
    super.initState();
    setupRemoteConfig();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<PrefsProvider>(
          create: (_) => PrefsProvider.create(),
        ),
        Provider<AuthService>.value(
          value: FirebaseAuthService.create(),
        ),
        Provider<DataService>.value(
          value: DataServiceImpl.create(),
        ),
        Provider<StorageService>.value(
          value: StorageServiceImpl.create(),
        ),
      ],
      child: Consumer<PrefsProvider>(
        builder: (_, prefs, __) => MaterialApp(
          debugShowCheckedModeBanner: !kReleaseMode,
          theme: themeData(context),
          darkTheme: darkThemeData(context),
          themeMode: prefs.isLightTheme ? ThemeMode.light : ThemeMode.dark,
          navigatorObservers: <NavigatorObserver>[
            FirebaseAnalyticsObserver(analytics: _analytics),
          ],
          onUnknownRoute: (_) => MaterialPageRoute(builder: (__) => Scaffold()),
          builder: ExtendedNavigator<gr.Router>(
            router: gr.Router(),
            guards: [AuthGuard(), ClientGuard(), ProviderGuard()],
          ),
        ),
      ),
    );
  }
}
