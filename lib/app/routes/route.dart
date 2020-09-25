import 'package:auto_route/auto_route_annotations.dart';
import 'package:handyman/app/pages/splash.dart';

@MaterialAutoRouter(
  routes: [
    AdaptiveRoute(page: SplashPage, initial: true),
  ],
)
class $Router {}
