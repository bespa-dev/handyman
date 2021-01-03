/*
 * Copyright (c) 2021.
 * This application is owned by HandyMan LLC,
 * developed & designed by Quabynah Codelabs LLC.
 *
 *
 * author: codelbas.quabynah@gmail.com
 */

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:lite/app/bloc/bloc.dart';
import 'package:lite/app/routes/routes.gr.dart';
import 'package:lite/app/widgets/widgets.dart';
import 'package:lite/domain/models/models.dart';
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
  final _prefsBloc = PrefsBloc(repo: Injection.get());
  final _userBloc = UserBloc(repo: Injection.get());

  @override
  void dispose() {
    _userBloc.close();
    _prefsBloc.close();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    if (mounted) {
      /// observe current user's id
      _prefsBloc
        ..add(PrefsEvent.getUserIdEvent())
        ..listen((state) {
          if (state is SuccessState<String>) {
            _isLoggedIn = state.data != null && state.data.isNotEmpty;
            if (mounted) setState(() {});

            /// observe current user
            _userBloc
              ..add(UserEvent.currentUserEvent())
              ..listen((state) {
                if (state is SuccessState<Stream<BaseUser>>) {
                  if (mounted) setState(() {});
                }
              });
          }
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    _kTheme = Theme.of(context);

    return BlocBuilder<UserBloc, BlocState>(
      cubit: _userBloc,
      builder: (_, state) => Scaffold(
        body: SafeArea(
          top: false,
          bottom: true,
          child: ExtendedNavigator(),
        ),
        bottomNavigationBar: Container(
          height: getProportionateScreenHeight(kSpacingX64),
          decoration: BoxDecoration(
            color: _kTheme.colorScheme.background,
          ),
          child: Column(
            children: [
              Divider(height: kSpacingX2),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(Feather.home),
                      color: _kTheme.colorScheme.onBackground,
                      onPressed: () {
                        context.navigator.push(
                            Routes.homePage + HomePageRoutes.artisansPage);
                      },
                    ),
                    IconButton(
                      icon: Icon(Feather.search),
                      color: _kTheme.colorScheme.onBackground,
                      onPressed: () {
                        context.navigator
                            .push(Routes.homePage + HomePageRoutes.searchPage);
                      },
                    ),
                    if (_isLoggedIn &&
                        state is SuccessState<Stream<BaseUser>>) ...{
                      StreamBuilder<BaseUser>(
                          stream: state.data,
                          builder: (_, snapshot) {
                            final user = snapshot.data;
                            return GestureDetector(
                              onTap: () {
                                context.navigator.push(Routes.homePage +
                                    HomePageRoutes.profilePage);
                              },
                              child: SizedBox(
                                height: kSpacingX36,
                                width: kSpacingX36,
                                child: UserAvatar(
                                  url: user?.avatar,
                                  isCircular: true,
                                ),
                              ),
                            );
                          }),
                    },
                    IconButton(
                      icon: Icon(Feather.bell),
                      color: _kTheme.colorScheme.onBackground,
                      onPressed: () {
                        context.navigator.push(
                            Routes.homePage + HomePageRoutes.notificationsPage);
                      },
                    ),
                    IconButton(
                      icon: Icon(Feather.briefcase),
                      color: _kTheme.colorScheme.onBackground,
                      onPressed: () {
                        context.navigator.push(
                            Routes.homePage + HomePageRoutes.bookingsPage);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
