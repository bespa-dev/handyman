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
/// flutter packages pub run build_runner build --delete-conflicting-outputs
/// flutter packages pub run build_runner watch --delete-conflicting-outputs
@CustomAutoRouter(
  transitionsBuilder: TransitionsBuilders.fadeIn,
  generateNavigationHelperExtension: true,
  routes: <AutoRoute>[
    CustomRoute(page: SplashPage, initial: true),
    CustomRoute(page: LoginPage),
    CustomRoute(page: ConversationPage),
    CustomRoute(page: RequestPage),
    CustomRoute(page: CategoryPickerPage),
    CustomRoute(page: BusinessProfilePage),
    CustomRoute(page: CategoryDetailsPage),
    CustomRoute(
      page: HomePage,
      children: <AutoRoute>[
        CustomRoute(page: BookingsPage),
        CustomRoute(page: SearchPage),
        CustomRoute(page: DashboardPage, path: "/"),
        CustomRoute(page: NotificationsPage),
        CustomRoute(page: ProfilePage),
        CustomRoute(page: ArtisanInfoPage),
      ],
    ),
    CustomRoute(page: RegisterPage),

    /// keep at the bottom
    CustomRoute(page: UnknownRoutePage, path: "*"),
  ],
)
class $Router {}
