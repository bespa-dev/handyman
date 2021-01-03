/*
 * Copyright (c) 2021.
 * This application is owned by HandyMan LLC,
 * developed & designed by Quabynah Codelabs LLC.
 *
 *
 * author: codelbas.quabynah@gmail.com
 */

import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lite/app/bloc/bloc.dart';
import 'package:lite/app/routes/routes.gr.dart' as gr;
import 'package:lite/shared/shared.dart';

/// application instance -> entry point
class LiteApp extends StatefulWidget {
  @override
  _LiteAppState createState() => _LiteAppState();
}

class _LiteAppState extends State<LiteApp> {
  final _prefsBloc = PrefsBloc(repo: Injection.get());

  @override
  void initState() {
    super.initState();

    /// get current user's id
    if (mounted) _prefsBloc.add(PrefsEvent.getUserIdEvent());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (mounted) _configureUI();
  }

  @override
  void dispose() {
    _prefsBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PrefsBloc, BlocState>(
      cubit: _prefsBloc,
      builder: (_, state) => MaterialApp(
        title: kAppName,
        debugShowCheckedModeBanner: false,
        theme: themeData(context),
        darkTheme: darkThemeData(context),
        builder: ExtendedNavigator<gr.Router>(
          router: gr.Router(),
          guards: [],
        ),
      ),
    );
  }

  void _configureUI() {
    final isLightTheme = Theme.of(context).brightness == Brightness.light;

    // Set orientation
    if (Platform.isIOS || Platform.isAndroid) {
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
