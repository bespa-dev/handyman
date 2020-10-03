// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../pages/account_completion.dart';
import '../pages/account_selection.dart';
import '../pages/client/home.dart';
import '../pages/client/profile.dart';
import '../pages/client/provider_details.dart';
import '../pages/client/providers.dart';
import '../pages/client/request_booking.dart';
import '../pages/conversation.dart';
import '../pages/login.dart';
import '../pages/onboarding.dart';
import '../pages/provider/dashboard.dart';
import '../pages/provider/settings.dart';
import '../pages/register.dart';
import '../pages/splash.dart';

class Routes {
  static const String onboardingPage = '/';
  static const String splashPage = '/splash-page';
  static const String loginPage = '/login-page';
  static const String registerPage = '/register-page';
  static const String accountCompletionPage = '/account-completion-page';
  static const String accountSelectionPage = '/account-selection-page';
  static const String conversationPage = '/conversation-page';
  static const String homePage = '/home-page';
  static const String profilePage = '/profile-page';
  static const String requestBookingPage = '/request-booking-page';
  static const String categoryProvidersPage = '/category-providers-page';
  static const String serviceProviderDetails = '/service-provider-details';
  static const String providerSettingsPage = '/provider-settings-page';
  static const String dashboardPage = '/dashboard-page';
  static const all = <String>{
    onboardingPage,
    splashPage,
    loginPage,
    registerPage,
    accountCompletionPage,
    accountSelectionPage,
    conversationPage,
    homePage,
    profilePage,
    requestBookingPage,
    categoryProvidersPage,
    serviceProviderDetails,
    providerSettingsPage,
    dashboardPage,
  };
}

class Router extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.onboardingPage, page: OnboardingPage),
    RouteDef(Routes.splashPage, page: SplashPage),
    RouteDef(Routes.loginPage, page: LoginPage),
    RouteDef(Routes.registerPage, page: RegisterPage),
    RouteDef(Routes.accountCompletionPage, page: AccountCompletionPage),
    RouteDef(Routes.accountSelectionPage, page: AccountSelectionPage),
    RouteDef(Routes.conversationPage, page: ConversationPage),
    RouteDef(Routes.homePage, page: HomePage),
    RouteDef(Routes.profilePage, page: ProfilePage),
    RouteDef(Routes.requestBookingPage, page: RequestBookingPage),
    RouteDef(Routes.categoryProvidersPage, page: CategoryProvidersPage),
    RouteDef(Routes.serviceProviderDetails, page: ServiceProviderDetails),
    RouteDef(Routes.providerSettingsPage, page: ProviderSettingsPage),
    RouteDef(Routes.dashboardPage, page: DashboardPage),
  ];
  @override
  Map<Type, AutoRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, AutoRouteFactory>{
    OnboardingPage: (data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => OnboardingPage(),
        settings: data,
      );
    },
    SplashPage: (data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => SplashPage(),
        settings: data,
      );
    },
    LoginPage: (data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => LoginPage(),
        settings: data,
      );
    },
    RegisterPage: (data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => RegisterPage(),
        settings: data,
      );
    },
    AccountCompletionPage: (data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => AccountCompletionPage(),
        settings: data,
      );
    },
    AccountSelectionPage: (data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => AccountSelectionPage(),
        settings: data,
      );
    },
    ConversationPage: (data) {
      final args = data.getArgs<ConversationPageArguments>(
        orElse: () => ConversationPageArguments(),
      );
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => ConversationPage(
          key: args.key,
          recipient: args.recipient,
          isCustomer: args.isCustomer,
        ),
        settings: data,
      );
    },
    HomePage: (data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => HomePage(),
        settings: data,
      );
    },
    ProfilePage: (data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => ProfilePage(),
        settings: data,
      );
    },
    RequestBookingPage: (data) {
      final args = data.getArgs<RequestBookingPageArguments>(
        orElse: () => RequestBookingPageArguments(),
      );
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => RequestBookingPage(
          key: args.key,
          artisan: args.artisan,
        ),
        settings: data,
      );
    },
    CategoryProvidersPage: (data) {
      final args = data.getArgs<CategoryProvidersPageArguments>(
        orElse: () => CategoryProvidersPageArguments(),
      );
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => CategoryProvidersPage(
          key: args.key,
          category: args.category,
        ),
        settings: data,
      );
    },
    ServiceProviderDetails: (data) {
      final args = data.getArgs<ServiceProviderDetailsArguments>(
        orElse: () => ServiceProviderDetailsArguments(),
      );
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => ServiceProviderDetails(
          key: args.key,
          artisan: args.artisan,
        ),
        settings: data,
      );
    },
    ProviderSettingsPage: (data) {
      final args = data.getArgs<ProviderSettingsPageArguments>(
        orElse: () => ProviderSettingsPageArguments(),
      );
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => ProviderSettingsPage(
          key: args.key,
          activeTabIndex: args.activeTabIndex,
        ),
        settings: data,
      );
    },
    DashboardPage: (data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => DashboardPage(),
        settings: data,
      );
    },
  };
}

/// ************************************************************************
/// Arguments holder classes
/// *************************************************************************

/// ConversationPage arguments holder class
class ConversationPageArguments {
  final Key key;
  final String recipient;
  final bool isCustomer;
  ConversationPageArguments({this.key, this.recipient, this.isCustomer});
}

/// RequestBookingPage arguments holder class
class RequestBookingPageArguments {
  final Key key;
  final dynamic artisan;
  RequestBookingPageArguments({this.key, this.artisan});
}

/// CategoryProvidersPage arguments holder class
class CategoryProvidersPageArguments {
  final Key key;
  final dynamic category;
  CategoryProvidersPageArguments({this.key, this.category});
}

/// ServiceProviderDetails arguments holder class
class ServiceProviderDetailsArguments {
  final Key key;
  final dynamic artisan;
  ServiceProviderDetailsArguments({this.key, this.artisan});
}

/// ProviderSettingsPage arguments holder class
class ProviderSettingsPageArguments {
  final Key key;
  final int activeTabIndex;
  ProviderSettingsPageArguments({this.key, this.activeTabIndex = 1});
}
