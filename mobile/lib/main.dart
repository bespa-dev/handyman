import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:handyman/app/app.dart';
import 'package:handyman/core/service_locator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inject service locator here
  await registerServiceLocator();

  final preferences = await sl.getAsync<SharedPreferences>();
  final isLightTheme = preferences.getBool(PrefsUtils.THEME_MODE) ?? false;

  // Set orientation
  if (defaultTargetPlatform == TargetPlatform.android ||
      defaultTargetPlatform == TargetPlatform.iOS) {
    SystemChrome.setSystemUIOverlayStyle(
      isLightTheme ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark,
    );
    SystemChrome.setEnabledSystemUIOverlays([
      SystemUiOverlay.bottom,
      SystemUiOverlay.top,
    ]);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  runApp(HandyManApp());
}
