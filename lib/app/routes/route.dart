import 'package:auto_route/auto_route_annotations.dart';
import 'package:handyman/app/pages/account_completion.dart';
import 'package:handyman/app/pages/account_selection.dart';
import 'package:handyman/app/pages/client/home.dart';
import 'package:handyman/app/pages/client/provider_details.dart';
import 'package:handyman/app/pages/client/service_details.dart';
import 'package:handyman/app/pages/login.dart';
import 'package:handyman/app/pages/onboarding.dart';
import 'package:handyman/app/pages/provider/dashboard.dart';
import 'package:handyman/app/pages/provider/settings.dart';
import 'package:handyman/app/pages/register.dart';
import 'package:handyman/app/pages/splash.dart';

import 'guard.dart';

@MaterialAutoRouter(
  routes: [
    AdaptiveRoute(page: SplashPage, initial: true),
    AdaptiveRoute(page: LoginPage),
    AdaptiveRoute(page: RegisterPage),
    AdaptiveRoute(page: OnboardingPage),
    AdaptiveRoute(page: AccountCompletionPage/*, guards: [AuthGuard]*/),
    AdaptiveRoute(page: AccountSelectionPage/*, guards: [AuthGuard]*/),
    AdaptiveRoute(page: HomePage/*, guards: [AuthGuard, ClientGuard]*/),
    AdaptiveRoute(
        page: ServiceProviderDetails/*, guards: [AuthGuard, ClientGuard]*/),
    AdaptiveRoute(
        page: ProviderSettingsPage/*, guards: [AuthGuard, ProviderGuard]*/),
    AdaptiveRoute(page: DashboardPage/*, guards: [AuthGuard, ProviderGuard]*/),
    AdaptiveRoute(page: ServiceDetailsPage/*, guards: [AuthGuard, ClientGuard]*/),
  ],
)
class $Router {}
