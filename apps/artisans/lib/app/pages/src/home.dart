/*
 * Copyright (c) 2021.
 * This application is owned by HandyMan LLC,
 * developed & designed by Quabynah Codelabs LLC.
 *
 *
 * author: codelbas.quabynah@gmail.com
 */

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:handyman/app/bloc/bloc.dart';
import 'package:handyman/app/pages/pages.dart';
import 'package:handyman/app/widgets/widgets.dart';
import 'package:handyman/domain/models/models.dart';
import 'package:handyman/shared/shared.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  /// UI
  ThemeData _kTheme;
  bool _isLoggedIn = false;
  final _pageController = PageController();
  int _currentPage = 0;
  final _navKey = GlobalKey<NavigatorState>();

  /// blocs
  final _prefsBloc = PrefsBloc(repo: Injection.get());
  final _userBloc = UserBloc(repo: Injection.get());

  Future<bool> _backPressed(GlobalKey<NavigatorState> _yourKey) async {
    //Checks if current Navigator still has screens on the stack.
    if (_yourKey.currentState.canPop()) {
      // 'maybePop' method handles the decision of 'pop' to another WillPopScope if they exist.
      //If no other WillPopScope exists, it returns true
      _yourKey.currentState.maybePop();
      return Future<bool>.value(false);
    }

    //if nothing remains in the stack, it simply pops
    return Future<bool>.value(true);
  }

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
            _userBloc.add(UserEvent.currentUserEvent());
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
          top: _currentPage == 0,
          bottom: true,
          child: Navigator(
            key: _navKey,
            onGenerateRoute: (_) => MaterialPageRoute(
              builder: (__) => DashboardPage(),
            ),
          ),
        ),
        bottomNavigationBar: Container(
          height: getProportionateScreenHeight(kSpacingX64),
          decoration: BoxDecoration(
            color: _kTheme.colorScheme.background,
          ),
          child: Column(
            children: [
              Expanded(
                child: Material(
                  type: MaterialType.card,
                  elevation: kSpacingX2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(Feather.home),
                        color: _kTheme.colorScheme.onBackground,
                        onPressed: () {
                          // context.navigator.push(
                          //     Routes.homePage + HomePageRoutes.dashboardPage);
                        },
                      ),
                      IconButton(
                        icon: Icon(Feather.search),
                        color: _kTheme.colorScheme.onBackground,
                        onPressed: () {
                          // context.navigator
                          //     .push(Routes.homePage + HomePageRoutes.searchPage);
                        },
                      ),
                      IconButton(
                        icon: Icon(Feather.bell),
                        color: _kTheme.colorScheme.onBackground,
                        onPressed: () {
                          // context.navigator.push(
                          //     Routes.homePage + HomePageRoutes.notificationsPage);
                        },
                      ),
                      if (_isLoggedIn &&
                          state is SuccessState<Stream<BaseArtisan>>) ...{
                        StreamBuilder<BaseArtisan>(
                            stream: state.data,
                            builder: (_, snapshot) {
                              final user = snapshot.data;
                              return GestureDetector(
                                onTap: () {
                                  // context.navigator.push(Routes.homePage +
                                  //     HomePageRoutes.profilePage);
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
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
