/*
 * Copyright (c) 2021.
 * This application is owned by HandyMan LLC,
 * developed & designed by Quabynah Codelabs LLC.
 *
 *
 * author: codelbas.quabynah@gmail.com
 */

import 'package:auto_route/auto_route.dart';
import 'package:auto_route/auto_route_annotations.dart';
import 'package:handyman/app/pages/pages.dart';

/// Run this to generate new routes upon edit:
/// flutter packages pub run build_runner build --delete-conflicting-outputs --verbose
/// flutter packages pub run build_runner watch --delete-conflicting-outputs --verbose
@CustomAutoRouter(
  transitionsBuilder: TransitionsBuilders.fadeIn,
  generateNavigationHelperExtension: true,
  routes: <AutoRoute>[
    CustomRoute(page: SplashPage, initial: true),

    /// region auth
    CustomRoute(page: LoginPage),
    CustomRoute(page: RegisterPage),
    CustomRoute(page: BusinessProfilePage),
    CustomRoute(page: BusinessDetailsPage),
    CustomRoute(page: CategoryPickerPage),

    /// endregion

    /// region conversation
    CustomRoute(page: ConversationPage),

    /// endregion

    /// region booking
    CustomRoute(page: RequestPage),
    CustomRoute(page: CategoryDetailsPage),
    CustomRoute(page: BookingDetailsPage),

    /// endregion

    /// region others
    CustomRoute(page: NotificationsPage),
    CustomRoute(page: ImagePreviewPage),
    CustomRoute(page: HomePage),
    CustomRoute(page: ProfilePage),
    CustomRoute(page: DashboardPage),
    CustomRoute(page: SearchPage),
    CustomRoute(page: ArtisanInfoPage),

    /// endregion

    /// keep at the bottom
    CustomRoute(page: UnknownRoutePage, path: "*"),
  ],
)
class $Router {}
