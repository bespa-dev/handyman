// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../pages/pages.dart';

class Routes {
  static const String splashPage = '/';
  static const String loginPage = '/login-page';
  static const String homePage = '/home-page';
  static const String registerPage = '/register-page';
  static const String unknownRoute = '*';
  static const all = <String>{
    splashPage,
    loginPage,
    homePage,
    registerPage,
    unknownRoute,
  };
}

class Router extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.splashPage, page: SplashPage),
    RouteDef(Routes.loginPage, page: LoginPage),
    RouteDef(
      Routes.homePage,
      page: HomePage,
      generator: HomePageRouter(),
    ),
    RouteDef(Routes.registerPage, page: RegisterPage),
    RouteDef(Routes.unknownRoute, page: UnknownRoute),
  ];
  @override
  Map<Type, AutoRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, AutoRouteFactory>{
    SplashPage: (data) {
      return PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) => SplashPage(),
        settings: data,
      );
    },
    LoginPage: (data) {
      return PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) => LoginPage(),
        settings: data,
      );
    },
    HomePage: (data) {
      return PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) => HomePage(),
        settings: data,
      );
    },
    RegisterPage: (data) {
      return PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) => RegisterPage(),
        settings: data,
      );
    },
    UnknownRoute: (data) {
      return PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) => UnknownRoute(),
        settings: data,
      );
    },
  };
}

/// ************************************************************************
/// Navigation helper methods extension
/// *************************************************************************

extension RouterExtendedNavigatorStateX on ExtendedNavigatorState {
  Future<dynamic> pushSplashPage() => push<dynamic>(Routes.splashPage);

  Future<dynamic> pushLoginPage() => push<dynamic>(Routes.loginPage);

  Future<dynamic> pushHomePage() => push<dynamic>(Routes.homePage);

  Future<dynamic> pushRegisterPage() => push<dynamic>(Routes.registerPage);

  Future<dynamic> pushUnknownRoute() => push<dynamic>(Routes.unknownRoute);
}

class HomePageRoutes {
  static const String bookingsPage = '/bookings-page';
  static const String searchPage = '/search-page';
  static const String artisansPage = '/';
  static const String notificationsPage = '/notifications-page';
  static const String profilePage = '/profile-page';
  static const all = <String>{
    bookingsPage,
    searchPage,
    artisansPage,
    notificationsPage,
    profilePage,
  };
}

class HomePageRouter extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(HomePageRoutes.bookingsPage, page: BookingsPage),
    RouteDef(HomePageRoutes.searchPage, page: SearchPage),
    RouteDef(HomePageRoutes.artisansPage, page: ArtisansPage),
    RouteDef(HomePageRoutes.notificationsPage, page: NotificationsPage),
    RouteDef(HomePageRoutes.profilePage, page: ProfilePage),
  ];
  @override
  Map<Type, AutoRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, AutoRouteFactory>{
    BookingsPage: (data) {
      return PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) => BookingsPage(),
        settings: data,
      );
    },
    SearchPage: (data) {
      return PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) => SearchPage(),
        settings: data,
      );
    },
    ArtisansPage: (data) {
      return PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) => ArtisansPage(),
        settings: data,
      );
    },
    NotificationsPage: (data) {
      return PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) =>
            NotificationsPage(),
        settings: data,
      );
    },
    ProfilePage: (data) {
      return PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) => ProfilePage(),
        settings: data,
      );
    },
  };
}

/// ************************************************************************
/// Navigation helper methods extension
/// *************************************************************************

extension HomePageRouterExtendedNavigatorStateX on ExtendedNavigatorState {
  Future<dynamic> pushBookingsPage() =>
      push<dynamic>(HomePageRoutes.bookingsPage);

  Future<dynamic> pushSearchPage() => push<dynamic>(HomePageRoutes.searchPage);

  Future<dynamic> pushArtisansPage() =>
      push<dynamic>(HomePageRoutes.artisansPage);

  Future<dynamic> pushNotificationsPage() =>
      push<dynamic>(HomePageRoutes.notificationsPage);

  Future<dynamic> pushProfilePage() =>
      push<dynamic>(HomePageRoutes.profilePage);
}
