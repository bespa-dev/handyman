/*
 * Copyright (c) 2021.
 * This application is owned by HandyMan LLC,
 * developed & designed by Quabynah Codelabs LLC.
 *
 *
 * author: codelbas.quabynah@gmail.com
 */

import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lite/app/routes/routes.gr.dart' as gr;
import 'package:lite/shared/shared.dart';

/// application instance -> entry point
class LiteApp extends StatefulWidget {
  @override
  _LiteAppState createState() => _LiteAppState();
}

class _LiteAppState extends State<LiteApp> {
  @override
  void initState() {
    super.initState();
    if (mounted) _configureUI();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: kAppName,
      debugShowCheckedModeBanner: false,
      theme: themeData(context),
      darkTheme: darkThemeData(context),
      builder: ExtendedNavigator<gr.Router>(
        router: gr.Router(),
        guards: [],
      ),
    );
  }

  void _configureUI() {
    final isLightTheme = Theme.of(context).brightness == Brightness.light;

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
  }
}
