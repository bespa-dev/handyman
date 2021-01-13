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
  final _updateUserBloc = UserBloc(repo: Injection.get());

  /// current user
  BaseArtisan _currentUser;

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
    _updateUserBloc.close();
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
      _updateUserBloc.listen((state) {
        if (state is SuccessState<BaseArtisan>) {
          _currentUser = state.data;
          if (mounted) setState(() {});
        }
      });

      /// observe current user's id
      _prefsBloc
        ..add(PrefsEvent.getUserIdEvent())
        ..listen((state) {
          if (state is SuccessState<String> && state.data != null) {
            _isLoggedIn = state.data.isNotEmpty;

            /// get current artisan by id
            _updateUserBloc.add(UserEvent.getArtisanByIdEvent(id: state.data));

            /// observe current user
            if (_isLoggedIn) _userBloc.add(UserEvent.currentUserEvent());
            if (mounted) setState(() {});
          }
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    _kTheme = Theme.of(context);
    final available = _currentUser?.isAvailable ?? false;

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
              /// dashboard
              Navigator(
                key: _dashboardNavKey,
                onGenerateRoute: (route) => MaterialPageRoute(
                    settings: route, builder: (__) => DashboardPage()),
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
          decoration: BoxDecoration(color: _kTheme.colorScheme.primary),
          child: Material(
            type: MaterialType.transparency,
            elevation: kSpacingX2,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: kSpacingX16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(kHomeIcon),
                    color: _kTheme.colorScheme.onPrimary,
                    onPressed: () => _onTabPressed(0),
                  ),
                  IconButton(
                    icon: Icon(kSearchIcon),
                    color: _kTheme.colorScheme.onPrimary,
                    onPressed: () => _onTabPressed(1),
                  ),

                  /// toggle availability
                  if (_isLoggedIn &&
                      state is SuccessState<Stream<BaseArtisan>>) ...{
                    InkWell(
                      borderRadius: BorderRadius.circular(kSpacingX16),
                      onTap: () {
                        if (available) {
                          /// show confirmation dialog
                          showCustomDialog(
                            context: context,
                            builder: (_) => BasicDialog(
                              message:
                                  "Do you wish to go offline?\nYou will not receive new requests from prospective customers until you turn this back on.",
                              onComplete: () {
                                /// toggle offline mode
                                _currentUser = _currentUser.copyWith(
                                    isAvailable: !available);
                                setState(() {});

                                /// update user's availability
                                _updateUserBloc.add(
                                  UserEvent.updateUserEvent(user: _currentUser),
                                );

                                /// observe current user state
                                _userBloc.add(UserEvent.currentUserEvent());
                              },
                            ),
                          );
                        } else {
                          /// toggle online mode
                          _currentUser =
                              _currentUser.copyWith(isAvailable: !available);
                          setState(() {});

                          /// update user's availability
                          _updateUserBloc.add(
                            UserEvent.updateUserEvent(user: _currentUser),
                          );

                          /// observe current user state
                          _userBloc.add(UserEvent.currentUserEvent());
                        }
                      },
                      child: AnimatedContainer(
                        duration: kScaleDuration,
                        width: kSpacingX84,
                        height: kSpacingX32,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(kSpacingX16),
                          color: _kTheme.cardColor,
                          border: Border.all(
                            color: available
                                ? kGreenColor
                                : _kTheme.colorScheme.error,
                          ),
                        ),
                        alignment: available
                            ? Alignment.centerLeft
                            : Alignment.centerRight,
                        padding: EdgeInsets.all(kSpacingX4),
                        child: Container(
                          alignment: Alignment.center,
                          height: kSpacingX24,
                          width: kSpacingX24,
                          decoration: BoxDecoration(
                            color: available
                                ? kGreenColor
                                : _kTheme.colorScheme.error,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            available ? kOnlineIcon : kOfflineIcon,
                            size: kSpacingX12,
                          ),
                        ),
                      ),
                    )
                  },
                  IconButton(
                    icon: Icon(kNotificationIcon),
                    color: _kTheme.colorScheme.onPrimary,
                    onPressed: () => _onTabPressed(2),
                  ),

                  /// toggle profile info
                  if (_isLoggedIn &&
                      state is SuccessState<Stream<BaseArtisan>>) ...{
                    StreamBuilder<BaseArtisan>(
                        stream: state.data,
                        builder: (_, snapshot) {
                          /// update current user info
                          if (_currentUser == null && snapshot.hasData)
                            _currentUser = snapshot.data;
                          return InkWell(
                            splashColor: _kTheme.splashColor,
                            borderRadius: BorderRadius.circular(kSpacingX36),
                            onTap: () => _onTabPressed(3),
                            child: SizedBox(
                              height: kSpacingX36,
                              width: kSpacingX36,
                              child: UserAvatar(
                                url: snapshot.data?.avatar,
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
        ),
      ),
    );
  }
}
