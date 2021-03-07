// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i1;
import 'package:flutter/material.dart' as _i3;
import 'package:flutter/widgets.dart' as _i4;

import '../../domain/models/models.dart' as _i5;
import '../pages/pages.dart' as _i2;

class Router extends _i1.RootStackRouter {
  Router();

  @override
  final Map<String, _i1.PageFactory> pagesMap = {
    SplashPageRoute.name: (entry) {
      return _i1.CustomPage(entry: entry, child: _i2.SplashPage());
    },
    LoginPageRoute.name: (entry) {
      return _i1.CustomPage(entry: entry, child: _i2.LoginPage());
    },
    ConversationPageRoute.name: (entry) {
      var route = entry.routeData.as<ConversationPageRoute>();
      return _i1.CustomPage(
          entry: entry,
          child: _i2.ConversationPage(
              key: route.key,
              recipientId: route.recipientId,
              recipient: route.recipient));
    },
    CategoryDetailsPageRoute.name: (entry) {
      var route = entry.routeData.as<CategoryDetailsPageRoute>();
      return _i1.CustomPage(
          entry: entry,
          child: _i2.CategoryDetailsPage(
              key: route.key, category: route.category));
    },
    RequestPageRoute.name: (entry) {
      var route = entry.routeData.as<RequestPageRoute>();
      return _i1.CustomPage(
          entry: entry,
          child: _i2.RequestPage(
              key: route.key, artisan: route.artisan, service: route.service));
    },
    ServiceRatingsPageRoute.name: (entry) {
      var route = entry.routeData.as<ServiceRatingsPageRoute>();
      return _i1.CustomPage(
          entry: entry,
          child:
              _i2.ServiceRatingsPage(key: route.key, payload: route.payload));
    },
    ImagePreviewPageRoute.name: (entry) {
      var route = entry.routeData.as<ImagePreviewPageRoute>();
      return _i1.CustomPage(
          entry: entry,
          child: _i2.ImagePreviewPage(key: route.key, url: route.url));
    },
    BookingDetailsPageRoute.name: (entry) {
      var route = entry.routeData.as<BookingDetailsPageRoute>();
      return _i1.CustomPage(
          entry: entry,
          child: _i2.BookingDetailsPage(
              key: route.key,
              booking: route.booking,
              customer: route.customer,
              bookingId: route.bookingId));
    },
    SearchPageRoute.name: (entry) {
      return _i1.CustomPage(entry: entry, child: _i2.SearchPage());
    },
    BookingsPageRoute.name: (entry) {
      return _i1.CustomPage(entry: entry, child: _i2.BookingsPage());
    },
    ArtisansPageRoute.name: (entry) {
      return _i1.CustomPage(entry: entry, child: _i2.ArtisansPage());
    },
    ProfilePageRoute.name: (entry) {
      return _i1.CustomPage(entry: entry, child: _i2.ProfilePage());
    },
    ArtisanInfoPageRoute.name: (entry) {
      var route = entry.routeData.as<ArtisanInfoPageRoute>();
      return _i1.CustomPage(
          entry: entry,
          child: _i2.ArtisanInfoPage(key: route.key, artisan: route.artisan));
    },
    HomePageRoute.name: (entry) {
      return _i1.CustomPage(entry: entry, child: _i2.HomePage());
    },
    RegisterPageRoute.name: (entry) {
      return _i1.CustomPage(entry: entry, child: _i2.RegisterPage());
    },
    BusinessDetailsPageRoute.name: (entry) {
      var route = entry.routeData.as<BusinessDetailsPageRoute>();
      return _i1.CustomPage(
          entry: entry,
          child: _i2.BusinessDetailsPage(
              key: route.key,
              business: route.business,
              artisan: route.artisan));
    },
    UnknownRoutePageRoute.name: (entry) {
      return _i1.CustomPage(entry: entry, child: _i2.UnknownRoutePage());
    }
  };

  @override
  List<_i1.RouteConfig> get routes => [
        _i1.RouteConfig<SplashPageRoute>(SplashPageRoute.name,
            path: '/',
            routeBuilder: (match) => SplashPageRoute.fromMatch(match)),
        _i1.RouteConfig<LoginPageRoute>(LoginPageRoute.name,
            path: '/login-page',
            routeBuilder: (match) => LoginPageRoute.fromMatch(match)),
        _i1.RouteConfig<ConversationPageRoute>(ConversationPageRoute.name,
            path: '/conversation-page',
            routeBuilder: (match) => ConversationPageRoute.fromMatch(match)),
        _i1.RouteConfig<CategoryDetailsPageRoute>(CategoryDetailsPageRoute.name,
            path: '/category-details-page',
            routeBuilder: (match) => CategoryDetailsPageRoute.fromMatch(match)),
        _i1.RouteConfig<RequestPageRoute>(RequestPageRoute.name,
            path: '/request-page',
            routeBuilder: (match) => RequestPageRoute.fromMatch(match)),
        _i1.RouteConfig<ServiceRatingsPageRoute>(ServiceRatingsPageRoute.name,
            path: '/service-ratings-page',
            routeBuilder: (match) => ServiceRatingsPageRoute.fromMatch(match)),
        _i1.RouteConfig<ImagePreviewPageRoute>(ImagePreviewPageRoute.name,
            path: '/image-preview-page',
            routeBuilder: (match) => ImagePreviewPageRoute.fromMatch(match)),
        _i1.RouteConfig<BookingDetailsPageRoute>(BookingDetailsPageRoute.name,
            path: '/booking-details-page',
            routeBuilder: (match) => BookingDetailsPageRoute.fromMatch(match)),
        _i1.RouteConfig<SearchPageRoute>(SearchPageRoute.name,
            path: '/search-page',
            routeBuilder: (match) => SearchPageRoute.fromMatch(match)),
        _i1.RouteConfig<BookingsPageRoute>(BookingsPageRoute.name,
            path: '/bookings-page',
            routeBuilder: (match) => BookingsPageRoute.fromMatch(match)),
        _i1.RouteConfig<ArtisansPageRoute>(ArtisansPageRoute.name,
            path: '/artisans-page',
            routeBuilder: (match) => ArtisansPageRoute.fromMatch(match)),
        _i1.RouteConfig<ProfilePageRoute>(ProfilePageRoute.name,
            path: '/profile-page',
            routeBuilder: (match) => ProfilePageRoute.fromMatch(match)),
        _i1.RouteConfig<ArtisanInfoPageRoute>(ArtisanInfoPageRoute.name,
            path: '/artisan-info-page',
            routeBuilder: (match) => ArtisanInfoPageRoute.fromMatch(match)),
        _i1.RouteConfig<HomePageRoute>(HomePageRoute.name,
            path: '/home-page',
            routeBuilder: (match) => HomePageRoute.fromMatch(match)),
        _i1.RouteConfig<RegisterPageRoute>(RegisterPageRoute.name,
            path: '/register-page',
            routeBuilder: (match) => RegisterPageRoute.fromMatch(match)),
        _i1.RouteConfig<BusinessDetailsPageRoute>(BusinessDetailsPageRoute.name,
            path: '/business-details-page',
            routeBuilder: (match) => BusinessDetailsPageRoute.fromMatch(match)),
        _i1.RouteConfig<UnknownRoutePageRoute>(UnknownRoutePageRoute.name,
            path: '*',
            routeBuilder: (match) => UnknownRoutePageRoute.fromMatch(match))
      ];
}

class SplashPageRoute extends _i1.PageRouteInfo {
  const SplashPageRoute() : super(name, path: '/');

  SplashPageRoute.fromMatch(_i1.RouteMatch match) : super.fromMatch(match);

  static const String name = 'SplashPageRoute';
}

class LoginPageRoute extends _i1.PageRouteInfo {
  const LoginPageRoute() : super(name, path: '/login-page');

  LoginPageRoute.fromMatch(_i1.RouteMatch match) : super.fromMatch(match);

  static const String name = 'LoginPageRoute';
}

class ConversationPageRoute extends _i1.PageRouteInfo {
  ConversationPageRoute(
      {this.key, @_i3.required this.recipientId, this.recipient})
      : super(name, path: '/conversation-page');

  ConversationPageRoute.fromMatch(_i1.RouteMatch match)
      : key = null,
        recipientId = null,
        recipient = null,
        super.fromMatch(match);

  final _i4.Key key;

  final String recipientId;

  final _i5.BaseUser recipient;

  static const String name = 'ConversationPageRoute';
}

class CategoryDetailsPageRoute extends _i1.PageRouteInfo {
  CategoryDetailsPageRoute({this.key, @_i3.required this.category})
      : super(name, path: '/category-details-page');

  CategoryDetailsPageRoute.fromMatch(_i1.RouteMatch match)
      : key = null,
        category = null,
        super.fromMatch(match);

  final _i4.Key key;

  final _i5.BaseServiceCategory category;

  static const String name = 'CategoryDetailsPageRoute';
}

class RequestPageRoute extends _i1.PageRouteInfo {
  RequestPageRoute({this.key, @_i3.required this.artisan, this.service})
      : super(name, path: '/request-page');

  RequestPageRoute.fromMatch(_i1.RouteMatch match)
      : key = null,
        artisan = null,
        service = null,
        super.fromMatch(match);

  final _i4.Key key;

  final _i5.BaseArtisan artisan;

  final _i5.BaseArtisanService service;

  static const String name = 'RequestPageRoute';
}

class ServiceRatingsPageRoute extends _i1.PageRouteInfo {
  ServiceRatingsPageRoute({this.key, @_i3.required this.payload})
      : super(name, path: '/service-ratings-page');

  ServiceRatingsPageRoute.fromMatch(_i1.RouteMatch match)
      : key = null,
        payload = null,
        super.fromMatch(match);

  final _i4.Key key;

  final dynamic payload;

  static const String name = 'ServiceRatingsPageRoute';
}

class ImagePreviewPageRoute extends _i1.PageRouteInfo {
  ImagePreviewPageRoute({this.key, @_i3.required this.url})
      : super(name, path: '/image-preview-page');

  ImagePreviewPageRoute.fromMatch(_i1.RouteMatch match)
      : key = null,
        url = null,
        super.fromMatch(match);

  final _i4.Key key;

  final String url;

  static const String name = 'ImagePreviewPageRoute';
}

class BookingDetailsPageRoute extends _i1.PageRouteInfo {
  BookingDetailsPageRoute(
      {this.key,
      @_i3.required this.booking,
      @_i3.required this.customer,
      this.bookingId})
      : super(name, path: '/booking-details-page');

  BookingDetailsPageRoute.fromMatch(_i1.RouteMatch match)
      : key = null,
        booking = null,
        customer = null,
        bookingId = null,
        super.fromMatch(match);

  final _i4.Key key;

  final _i5.BaseBooking booking;

  final _i5.BaseUser customer;

  final String bookingId;

  static const String name = 'BookingDetailsPageRoute';
}

class SearchPageRoute extends _i1.PageRouteInfo {
  const SearchPageRoute() : super(name, path: '/search-page');

  SearchPageRoute.fromMatch(_i1.RouteMatch match) : super.fromMatch(match);

  static const String name = 'SearchPageRoute';
}

class BookingsPageRoute extends _i1.PageRouteInfo {
  const BookingsPageRoute() : super(name, path: '/bookings-page');

  BookingsPageRoute.fromMatch(_i1.RouteMatch match) : super.fromMatch(match);

  static const String name = 'BookingsPageRoute';
}

class ArtisansPageRoute extends _i1.PageRouteInfo {
  const ArtisansPageRoute() : super(name, path: '/artisans-page');

  ArtisansPageRoute.fromMatch(_i1.RouteMatch match) : super.fromMatch(match);

  static const String name = 'ArtisansPageRoute';
}

class ProfilePageRoute extends _i1.PageRouteInfo {
  const ProfilePageRoute() : super(name, path: '/profile-page');

  ProfilePageRoute.fromMatch(_i1.RouteMatch match) : super.fromMatch(match);

  static const String name = 'ProfilePageRoute';
}

class ArtisanInfoPageRoute extends _i1.PageRouteInfo {
  ArtisanInfoPageRoute({this.key, @_i3.required this.artisan})
      : super(name, path: '/artisan-info-page');

  ArtisanInfoPageRoute.fromMatch(_i1.RouteMatch match)
      : key = null,
        artisan = null,
        super.fromMatch(match);

  final _i4.Key key;

  final _i5.BaseArtisan artisan;

  static const String name = 'ArtisanInfoPageRoute';
}

class HomePageRoute extends _i1.PageRouteInfo {
  const HomePageRoute() : super(name, path: '/home-page');

  HomePageRoute.fromMatch(_i1.RouteMatch match) : super.fromMatch(match);

  static const String name = 'HomePageRoute';
}

class RegisterPageRoute extends _i1.PageRouteInfo {
  const RegisterPageRoute() : super(name, path: '/register-page');

  RegisterPageRoute.fromMatch(_i1.RouteMatch match) : super.fromMatch(match);

  static const String name = 'RegisterPageRoute';
}

class BusinessDetailsPageRoute extends _i1.PageRouteInfo {
  BusinessDetailsPageRoute(
      {this.key, @_i3.required this.business, this.artisan})
      : super(name, path: '/business-details-page');

  BusinessDetailsPageRoute.fromMatch(_i1.RouteMatch match)
      : key = null,
        business = null,
        artisan = null,
        super.fromMatch(match);

  final _i4.Key key;

  final _i5.BaseBusiness business;

  final _i5.BaseArtisan artisan;

  static const String name = 'BusinessDetailsPageRoute';
}

class UnknownRoutePageRoute extends _i1.PageRouteInfo {
  const UnknownRoutePageRoute() : super(name, path: '*');

  UnknownRoutePageRoute.fromMatch(_i1.RouteMatch match)
      : super.fromMatch(match);

  static const String name = 'UnknownRoutePageRoute';
}
