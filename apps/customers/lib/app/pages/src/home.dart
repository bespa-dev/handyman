/*
 * Copyright (c) 2021.
 * This application is owned by HandyMan LLC,
 * developed & designed by Quabynah Codelabs LLC.
 *
 *
 * author: codelbas.quabynah@gmail.com
 */

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:lite/app/bloc/bloc.dart';
import 'package:lite/app/widgets/src/user_avatar.dart';
import 'package:lite/shared/shared.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  /// UI
  ThemeData _kTheme;
  bool _isLoggedIn = false;

  /// blocs
  final _authBloc = AuthBloc(repo: Injection.get());
  final _prefsBloc = PrefsBloc(repo: Injection.get());
  final _userBloc = UserBloc(repo: Injection.get());

  @override
  void dispose() {
    _authBloc.close();
    _userBloc.close();
    _prefsBloc.close();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    if (mounted) {
      /// observe current user id
      _prefsBloc
        ..add(PrefsEvent.getUserIdEvent())
        ..listen((state) {
          if (state is SuccessState<String>) {
            _isLoggedIn = state.data != null && state.data.isNotEmpty;
            if (mounted) setState(() {});
            logger.d("Login state -> $_isLoggedIn");
          }
        });

      _authBloc.add(AuthEvent.authSignOutEvent());
      _prefsBloc.add(PrefsEvent.getUserIdEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    _kTheme = Theme.of(context);

    return Scaffold(
      body: Center(
        child: Text(kAppName),
      ),
      bottomNavigationBar: Container(
        height: getProportionateScreenHeight(kSpacingX56),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(Feather.home),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Feather.bell),
              onPressed: () {},
            ),
            GestureDetector(
              child: SizedBox(
                height: kSpacingX48,
                width: kSpacingX48,
                child: UserAvatar(
                  url: "",
                  isCircular: true,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
