// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../domain/models/models.dart';
import '../pages/pages.dart';

class Routes {
  static const String splashPage = '/';
  static const String loginPage = '/login-page';
  static const String conversationPage = '/conversation-page';
  static const String requestPage = '/request-page';
  static const String homePage = '/home-page';
  static const String registerPage = '/register-page';
  static const String unknownRoutePage = '*';
  static const all = <String>{
    splashPage,
    loginPage,
    conversationPage,
    requestPage,
    homePage,
    registerPage,
    unknownRoutePage,
  };
}

class Router extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.splashPage, page: SplashPage),
    RouteDef(Routes.loginPage, page: LoginPage),
    RouteDef(Routes.conversationPage, page: ConversationPage),
    RouteDef(Routes.requestPage, page: RequestPage),
    RouteDef(
      Routes.homePage,
      page: HomePage,
      generator: HomePageRouter(),
    ),
    RouteDef(Routes.registerPage, page: RegisterPage),
    RouteDef(Routes.unknownRoutePage, page: UnknownRoutePage),
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
    ConversationPage: (data) {
      final args = data.getArgs<ConversationPageArguments>(nullOk: false);
      return PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) =>
            ConversationPage(
          key: args.key,
          recipientId: args.recipientId,
          recipient: args.recipient,
        ),
        settings: data,
      );
    },
    RequestPage: (data) {
      final args = data.getArgs<RequestPageArguments>(nullOk: false);
      return PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) => RequestPage(
          key: args.key,
          artisan: args.artisan,
        ),
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
    UnknownRoutePage: (data) {
      return PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) =>
            UnknownRoutePage(),
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

  Future<dynamic> pushConversationPage({
    Key key,
    @required String recipientId,
    BaseUser recipient,
  }) =>
      push<dynamic>(
        Routes.conversationPage,
        arguments: ConversationPageArguments(
            key: key, recipientId: recipientId, recipient: recipient),
      );

  Future<dynamic> pushRequestPage({
    Key key,
    @required BaseArtisan artisan,
  }) =>
      push<dynamic>(
        Routes.requestPage,
        arguments: RequestPageArguments(key: key, artisan: artisan),
      );

  Future<dynamic> pushHomePage() => push<dynamic>(Routes.homePage);

  Future<dynamic> pushRegisterPage() => push<dynamic>(Routes.registerPage);

  Future<dynamic> pushUnknownRoutePage() =>
      push<dynamic>(Routes.unknownRoutePage);
}

class HomePageRoutes {
  static const String bookingsPage = '/bookings-page';
  static const String searchPage = '/search-page';
  static const String artisansPage = '/';
  static const String notificationsPage = '/notifications-page';
  static const String profilePage = '/profile-page';
  static const String artisanInfoPage = '/artisan-info-page';
  static const all = <String>{
    bookingsPage,
    searchPage,
    artisansPage,
    notificationsPage,
    profilePage,
    artisanInfoPage,
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
    RouteDef(HomePageRoutes.artisanInfoPage, page: ArtisanInfoPage),
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
    ArtisanInfoPage: (data) {
      final args = data.getArgs<ArtisanInfoPageArguments>(nullOk: false);
      return PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) =>
            ArtisanInfoPage(
          key: args.key,
          artisan: args.artisan,
        ),
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

  Future<dynamic> pushArtisanInfoPage({
    Key key,
    @required BaseArtisan artisan,
  }) =>
      push<dynamic>(
        HomePageRoutes.artisanInfoPage,
        arguments: ArtisanInfoPageArguments(key: key, artisan: artisan),
      );
}

/// ************************************************************************
/// Arguments holder classes
/// *************************************************************************

/// ConversationPage arguments holder class
class ConversationPageArguments {
  final Key key;
  final String recipientId;
  final BaseUser recipient;
  ConversationPageArguments(
      {this.key, @required this.recipientId, this.recipient});
}

/// RequestPage arguments holder class
class RequestPageArguments {
  final Key key;
  final BaseArtisan artisan;
  RequestPageArguments({this.key, @required this.artisan});
}

/// ArtisanInfoPage arguments holder class
class ArtisanInfoPageArguments {
  final Key key;
  final BaseArtisan artisan;
  ArtisanInfoPageArguments({this.key, @required this.artisan});
}
