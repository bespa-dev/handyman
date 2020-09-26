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
import '../pages/client/provider_details.dart';
import '../pages/client/service_details.dart';
import '../pages/login.dart';
import '../pages/onboarding.dart';
import '../pages/provider/dashboard.dart';
import '../pages/provider/settings.dart';
import '../pages/register.dart';
import '../pages/splash.dart';
import 'guard.dart';

class Routes {
  static const String splashPage = '/';
  static const String loginPage = '/login-page';
  static const String registerPage = '/register-page';
  static const String onboardingPage = '/onboarding-page';
  static const String accountCompletionPage = '/account-completion-page';
  static const String accountSelectionPage = '/account-selection-page';
  static const String homePage = '/home-page';
  static const String serviceProviderDetails = '/service-provider-details';
  static const String providerSettingsPage = '/provider-settings-page';
  static const String dashboardPage = '/dashboard-page';
  static const String serviceDetailsPage = '/service-details-page';
  static const all = <String>{
    splashPage,
    loginPage,
    registerPage,
    onboardingPage,
    accountCompletionPage,
    accountSelectionPage,
    homePage,
    serviceProviderDetails,
    providerSettingsPage,
    dashboardPage,
    serviceDetailsPage,
  };
}

class Router extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.splashPage, page: SplashPage),
    RouteDef(Routes.loginPage, page: LoginPage),
    RouteDef(Routes.registerPage, page: RegisterPage),
    RouteDef(Routes.onboardingPage, page: OnboardingPage),
    RouteDef(Routes.accountCompletionPage,
        page: AccountCompletionPage, guards: [AuthGuard]),
    RouteDef(Routes.accountSelectionPage,
        page: AccountSelectionPage, guards: [AuthGuard]),
    RouteDef(Routes.homePage, page: HomePage, guards: [AuthGuard, ClientGuard]),
    RouteDef(Routes.serviceProviderDetails,
        page: ServiceProviderDetails, guards: [AuthGuard, ClientGuard]),
    RouteDef(Routes.providerSettingsPage,
        page: ProviderSettingsPage, guards: [AuthGuard, ProviderGuard]),
    RouteDef(Routes.dashboardPage,
        page: DashboardPage, guards: [AuthGuard, ProviderGuard]),
    RouteDef(Routes.serviceDetailsPage,
        page: ServiceDetailsPage, guards: [AuthGuard, ClientGuard]),
  ];
  @override
  Map<Type, AutoRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, AutoRouteFactory>{
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
    OnboardingPage: (data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => OnboardingPage(),
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
    HomePage: (data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => HomePage(),
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
          provider: args.provider,
        ),
        settings: data,
      );
    },
    ProviderSettingsPage: (data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => ProviderSettingsPage(),
        settings: data,
      );
    },
    DashboardPage: (data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => DashboardPage(),
        settings: data,
      );
    },
    ServiceDetailsPage: (data) {
      final args = data.getArgs<ServiceDetailsPageArguments>(
        orElse: () => ServiceDetailsPageArguments(),
      );
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => ServiceDetailsPage(
          key: args.key,
          service: args.service,
        ),
        settings: data,
      );
    },
  };
}

/// ************************************************************************
/// Arguments holder classes
/// *************************************************************************

/// ServiceProviderDetails arguments holder class
class ServiceProviderDetailsArguments {
  final Key key;
  final dynamic provider;
  ServiceProviderDetailsArguments({this.key, this.provider});
}

/// ServiceDetailsPage arguments holder class
class ServiceDetailsPageArguments {
  final Key key;
  final dynamic service;
  ServiceDetailsPageArguments({this.key, this.service});
}
