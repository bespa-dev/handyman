import 'package:auto_route/auto_route.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:handyman/app/model/prefs_provider.dart';
import 'package:handyman/app/model/theme_provider.dart';
import 'package:handyman/app/routes/guard.dart';
import 'package:handyman/app/routes/route.gr.dart' as gr;
import 'package:handyman/core/theme.dart';
import 'package:provider/provider.dart';

class HandyManApp extends StatefulWidget {
  @override
  _HandyManAppState createState() => _HandyManAppState();
}

class _HandyManAppState extends State<HandyManApp> {
  final _analytics = FirebaseAnalytics();

  Future<void> setupRemoteConfig() async {
    await Firebase.initializeApp();
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
            create: (context) => PrefsProvider()),
        ChangeNotifierProvider<ThemeProvider>(
            create: (context) => ThemeProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (ctx, theme, child) => MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: themeData(context),
          darkTheme: darkThemeData(context),
          themeMode: theme.isLightTheme ? ThemeMode.light : ThemeMode.dark,
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
