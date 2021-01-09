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
  int _currentPage = 0;
  final _navStates = <GlobalKey<NavigatorState>>[];
  final _dashboardNavKey = GlobalKey<NavigatorState>();
  final _searchNavKey = GlobalKey<NavigatorState>();
  final _notificationsNavKey = GlobalKey<NavigatorState>();
  final _profileNavKey = GlobalKey<NavigatorState>();

  /// blocs
  final _prefsBloc = PrefsBloc(repo: Injection.get());
  final _userBloc = UserBloc(repo: Injection.get());

  /// https://stackoverflow.com/questions/56707392/how-can-i-use-willpopscope-inside-a-navigator-in-flutter
  Future<bool> _backPressed(GlobalKey<NavigatorState> _yourKey) async {
    // Checks if current Navigator still has screens on the stack.
    if (_yourKey.currentState.canPop()) {
      // 'maybePop' method handles the decision of 'pop' to another WillPopScope if they exist.
      // If no other WillPopScope exists, it returns true
      _yourKey.currentState.maybePop();
      return Future<bool>.value(false);
    }

    // if nothing remains in the stack, it simply pops
    return Future<bool>.value(true);
  }

  /// handles tab changes
  void _onTabPressed(int index) {
    if (_currentPage == index)
      switch (_currentPage) {
        case 0:
          _dashboardNavKey.currentState.popUntil((route) => route.isFirst);
          break;
        case 1:
          _searchNavKey.currentState.popUntil((route) => route.isFirst);
          break;
        case 2:
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
    _navStates.addAll([
      _notificationsNavKey,
      _searchNavKey,
      _notificationsNavKey,
      _profileNavKey,
    ]);
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
    _kTheme = Theme.of(context);

    return BlocBuilder<UserBloc, BlocState>(
      cubit: _userBloc,
      builder: (_, state) => Scaffold(
        body: SafeArea(
          top: _navStates[_currentPage] == _dashboardNavKey ||
              _navStates[_currentPage] == _profileNavKey,
          bottom: true,
          child: IndexedStack(
            index: _currentPage,
            children: [
              Navigator(
                key: _dashboardNavKey,
                onGenerateRoute: (route) => MaterialPageRoute(
                    settings: route, builder: (__) => DashboardPage()),
              ),
              Navigator(
                key: _searchNavKey,
                onGenerateRoute: (route) => MaterialPageRoute(
                    settings: route, builder: (__) => SearchPage()),
              ),
              Navigator(
                key: _notificationsNavKey,
                onGenerateRoute: (route) => MaterialPageRoute(
                    settings: route, builder: (__) => NotificationsPage()),
              ),
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
                      IconButton(
                        icon: Icon(Feather.bell),
                        color: _kTheme.colorScheme.onBackground,
                        onPressed: () => _onTabPressed(2),
                      ),
                      if (_isLoggedIn &&
                          state is SuccessState<Stream<BaseArtisan>>) ...{
                        StreamBuilder<BaseArtisan>(
                            stream: state.data,
                            builder: (_, snapshot) {
                              final user = snapshot.data;
                              return GestureDetector(
                                onTap: () => _onTabPressed(3),
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
