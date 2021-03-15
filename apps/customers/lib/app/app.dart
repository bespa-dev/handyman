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
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lite/app/bloc/bloc.dart';
import 'package:lite/app/routes/routes.gr.dart' as gr;
import 'package:lite/domain/models/models.dart';
import 'package:lite/shared/shared.dart';

/// application instance -> entry point
class HandyManApp extends StatefulWidget {
  @override
  _HandyManAppState createState() => _HandyManAppState();
}

class _HandyManAppState extends State<HandyManApp> {
  /// blocs
  final _prefsBloc = PrefsBloc(repo: Injection.get());
  final _userBloc = UserBloc(repo: Injection.get());

  /// notification
  LocalNotificationService _notificationService;

  /// User
  BaseUser _currentUser;
  var _userId;

  @override
  void initState() {
    super.initState();

    /// setup local notifications
    _notificationService = ProviderContainer().read(notificationServiceProvider)
      ..setupNotifications();

    /// get current user's id
    if (mounted) {
      _userBloc.listen((state) async {
        if (state is SuccessState<BaseUser>) {
          _currentUser = state.data;
          if (mounted) setState(() {});
          var messaging = Injection.get<FirebaseMessaging>();
          var token = await messaging.getToken();
          _currentUser = _currentUser?.copyWith(token: token);
          UserBloc(repo: Injection.get())
              .add(UserEvent.updateUserEvent(user: _currentUser));
        }
      });

      _prefsBloc
        ..add(PrefsEvent.getUserIdEvent())
        ..listen((state) {
          if (state is SuccessState<String>) {
            _userId = state.data;
            if (_userId != null) {
              _userBloc.add(UserEvent.getCustomerByIdEvent(id: state.data));
            }
            if (mounted) setState(() {});
          }
        });
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (mounted) _configureUI();
  }

  @override
  void dispose() {
    _prefsBloc.close();
    _userBloc.close();
    _notificationService.dispose();
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
        themeMode: kReleaseMode ? ThemeMode.system : ThemeMode.light,
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
