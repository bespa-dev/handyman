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
import 'package:lite/app/bloc/bloc.dart';
import 'package:lite/app/pages/pages.dart';
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
  int _currentPage = 0;
  final _navStates = <GlobalKey<NavigatorState>>[];
  final _artisansNavKey = GlobalKey<NavigatorState>();
  final _searchNavKey = GlobalKey<NavigatorState>();
  final _notificationsNavKey = GlobalKey<NavigatorState>();
  final _profileNavKey = GlobalKey<NavigatorState>();

  /// blocs
  final _prefsBloc = PrefsBloc(repo: Injection.get());
  final _userBloc = UserBloc(repo: Injection.get());

  /// handles tab changes
  void _onTabPressed(int index) {
    if (_currentPage == index)
      switch (_currentPage) {
        case 0:
          _artisansNavKey.currentState.popUntil((route) => route.isFirst);
          break;
        case 1:
          _searchNavKey.currentState.popUntil((route) => route.isFirst);
          break;
        case 2:
          _profileNavKey.currentState.popUntil((route) => route.isFirst);
          break;
        case 3:
          _notificationsNavKey.currentState.popUntil((route) => route.isFirst);
          break;
        default:
          _profileNavKey.currentState.popUntil((route) => route.isFirst);
          break;
      }
    else if (mounted)
      setState(() {
        _currentPage = index;
      });
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
          top: _navStates[_currentPage] == _artisansNavKey ||
              _navStates[_currentPage] == _profileNavKey,
          bottom: true,
          child: IndexedStack(
            index: _currentPage,
            children: [
              /// dashboard
              Navigator(
                key: _artisansNavKey,
                onGenerateRoute: (route) => MaterialPageRoute(
                    settings: route, builder: (__) => ArtisansPage()),
              ),

              /// search
              Navigator(
                key: _searchNavKey,
                onGenerateRoute: (route) => MaterialPageRoute(
                    settings: route, builder: (__) => SearchPage()),
              ),

              /// notifications
              Navigator(
                key: _notificationsNavKey,
                onGenerateRoute: (route) => MaterialPageRoute(
                    settings: route, builder: (__) => NotificationsPage()),
              ),

              /// profile
              Navigator(
                key: _profileNavKey,
                onGenerateRoute: (route) => MaterialPageRoute(
                    settings: route, builder: (__) => ProfilePage()),
              ),
            ],
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
                        onPressed: () => _onTabPressed(0),
                      ),
                      IconButton(
                        icon: Icon(Feather.search),
                        color: _kTheme.colorScheme.onBackground,
                        onPressed: () => _onTabPressed(1),
                      ),
                      if (_isLoggedIn &&
                          state is SuccessState<Stream<BaseUser>>) ...{
                        StreamBuilder<BaseUser>(
                            stream: state.data,
                            builder: (_, snapshot) {
                              final user = snapshot.data;
                              return GestureDetector(
                                onTap: () => _onTabPressed(2),
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
                        onPressed: () => _onTabPressed(3),
                      ),
                      IconButton(
                        icon: Icon(Feather.briefcase),
                        color: _kTheme.colorScheme.onBackground,
                        onPressed: () => _onTabPressed(4),
                      ),
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
