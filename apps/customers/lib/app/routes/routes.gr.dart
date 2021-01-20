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
  static const String categoryDetailsPage = '/category-details-page';
  static const String requestPage = '/request-page';
  static const String serviceRatingsPage = '/service-ratings-page';
  static const String imagePreviewPage = '/image-preview-page';
  static const String bookingDetailsPage = '/booking-details-page';
  static const String searchPage = '/search-page';
  static const String bookingsPage = '/bookings-page';
  static const String artisansPage = '/artisans-page';
  static const String notificationsPage = '/notifications-page';
  static const String profilePage = '/profile-page';
  static const String artisanInfoPage = '/artisan-info-page';
  static const String homePage = '/home-page';
  static const String registerPage = '/register-page';
  static const String businessDetailsPage = '/business-details-page';
  static const String unknownRoutePage = '*';
  static const all = <String>{
    splashPage,
    loginPage,
    conversationPage,
    categoryDetailsPage,
    requestPage,
    serviceRatingsPage,
    imagePreviewPage,
    bookingDetailsPage,
    searchPage,
    bookingsPage,
    artisansPage,
    notificationsPage,
    profilePage,
    artisanInfoPage,
    homePage,
    registerPage,
    businessDetailsPage,
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
    RouteDef(Routes.categoryDetailsPage, page: CategoryDetailsPage),
    RouteDef(Routes.requestPage, page: RequestPage),
    RouteDef(Routes.serviceRatingsPage, page: ServiceRatingsPage),
    RouteDef(Routes.imagePreviewPage, page: ImagePreviewPage),
    RouteDef(Routes.bookingDetailsPage, page: BookingDetailsPage),
    RouteDef(Routes.searchPage, page: SearchPage),
    RouteDef(Routes.bookingsPage, page: BookingsPage),
    RouteDef(Routes.artisansPage, page: ArtisansPage),
    RouteDef(Routes.notificationsPage, page: NotificationsPage),
    RouteDef(Routes.profilePage, page: ProfilePage),
    RouteDef(Routes.artisanInfoPage, page: ArtisanInfoPage),
    RouteDef(Routes.homePage, page: HomePage),
    RouteDef(Routes.registerPage, page: RegisterPage),
    RouteDef(Routes.businessDetailsPage, page: BusinessDetailsPage),
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
    CategoryDetailsPage: (data) {
      final args = data.getArgs<CategoryDetailsPageArguments>(nullOk: false);
      return PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) =>
            CategoryDetailsPage(
          key: args.key,
          category: args.category,
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
    ServiceRatingsPage: (data) {
      return PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) =>
            ServiceRatingsPage(),
        settings: data,
      );
    },
    ImagePreviewPage: (data) {
      final args = data.getArgs<ImagePreviewPageArguments>(nullOk: false);
      return PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) =>
            ImagePreviewPage(
          key: args.key,
          url: args.url,
        ),
        settings: data,
      );
    },
    BookingDetailsPage: (data) {
      final args = data.getArgs<BookingDetailsPageArguments>(nullOk: false);
      return PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) =>
            BookingDetailsPage(
          key: args.key,
          booking: args.booking,
          customer: args.customer,
        ),
        settings: data,
      );
    },
    SearchPage: (data) {
      return PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) => SearchPage(),
        settings: data,
      );
    },
    BookingsPage: (data) {
      return PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) => BookingsPage(),
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
    BusinessDetailsPage: (data) {
      final args = data.getArgs<BusinessDetailsPageArguments>(nullOk: false);
      return PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) =>
            BusinessDetailsPage(
          key: args.key,
          business: args.business,
          artisan: args.artisan,
        ),
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

  Future<dynamic> pushCategoryDetailsPage({
    Key key,
    @required BaseServiceCategory category,
  }) =>
      push<dynamic>(
        Routes.categoryDetailsPage,
        arguments: CategoryDetailsPageArguments(key: key, category: category),
      );

  Future<dynamic> pushRequestPage({
    Key key,
    @required BaseArtisan artisan,
  }) =>
      push<dynamic>(
        Routes.requestPage,
        arguments: RequestPageArguments(key: key, artisan: artisan),
      );

  Future<dynamic> pushServiceRatingsPage() =>
      push<dynamic>(Routes.serviceRatingsPage);

  Future<dynamic> pushImagePreviewPage({
    Key key,
    @required String url,
  }) =>
      push<dynamic>(
        Routes.imagePreviewPage,
        arguments: ImagePreviewPageArguments(key: key, url: url),
      );

  Future<dynamic> pushBookingDetailsPage({
    Key key,
    @required BaseBooking booking,
    @required BaseUser customer,
  }) =>
      push<dynamic>(
        Routes.bookingDetailsPage,
        arguments: BookingDetailsPageArguments(
            key: key, booking: booking, customer: customer),
      );

  Future<dynamic> pushSearchPage() => push<dynamic>(Routes.searchPage);

  Future<dynamic> pushBookingsPage() => push<dynamic>(Routes.bookingsPage);

  Future<dynamic> pushArtisansPage() => push<dynamic>(Routes.artisansPage);

  Future<dynamic> pushNotificationsPage() =>
      push<dynamic>(Routes.notificationsPage);

  Future<dynamic> pushProfilePage() => push<dynamic>(Routes.profilePage);

  Future<dynamic> pushArtisanInfoPage({
    Key key,
    @required BaseArtisan artisan,
  }) =>
      push<dynamic>(
        Routes.artisanInfoPage,
        arguments: ArtisanInfoPageArguments(key: key, artisan: artisan),
      );

  Future<dynamic> pushHomePage() => push<dynamic>(Routes.homePage);

  Future<dynamic> pushRegisterPage() => push<dynamic>(Routes.registerPage);

  Future<dynamic> pushBusinessDetailsPage({
    Key key,
    @required BaseBusiness business,
    BaseArtisan artisan,
  }) =>
      push<dynamic>(
        Routes.businessDetailsPage,
        arguments: BusinessDetailsPageArguments(
            key: key, business: business, artisan: artisan),
      );

  Future<dynamic> pushUnknownRoutePage() =>
      push<dynamic>(Routes.unknownRoutePage);
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

/// CategoryDetailsPage arguments holder class
class CategoryDetailsPageArguments {
  final Key key;
  final BaseServiceCategory category;
  CategoryDetailsPageArguments({this.key, @required this.category});
}

/// RequestPage arguments holder class
class RequestPageArguments {
  final Key key;
  final BaseArtisan artisan;
  RequestPageArguments({this.key, @required this.artisan});
}

/// ImagePreviewPage arguments holder class
class ImagePreviewPageArguments {
  final Key key;
  final String url;
  ImagePreviewPageArguments({this.key, @required this.url});
}

/// BookingDetailsPage arguments holder class
class BookingDetailsPageArguments {
  final Key key;
  final BaseBooking booking;
  final BaseUser customer;
  BookingDetailsPageArguments(
      {this.key, @required this.booking, @required this.customer});
}

/// ArtisanInfoPage arguments holder class
class ArtisanInfoPageArguments {
  final Key key;
  final BaseArtisan artisan;
  ArtisanInfoPageArguments({this.key, @required this.artisan});
}

/// BusinessDetailsPage arguments holder class
class BusinessDetailsPageArguments {
  final Key key;
  final BaseBusiness business;
  final BaseArtisan artisan;
  BusinessDetailsPageArguments(
      {this.key, @required this.business, this.artisan});
}
