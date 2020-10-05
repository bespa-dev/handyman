import 'package:auto_route/auto_route_annotations.dart';
import 'package:handyman/app/pages/account_completion.dart';
import 'package:handyman/app/pages/account_selection.dart';
import 'package:handyman/app/pages/client/home.dart';
import 'package:handyman/app/pages/client/profile.dart';
import 'package:handyman/app/pages/client/provider_details.dart';
import 'package:handyman/app/pages/client/providers.dart';
import 'package:handyman/app/pages/client/request_booking.dart';
import 'package:handyman/app/pages/conversation.dart';
import 'package:handyman/app/pages/login.dart';
import 'package:handyman/app/pages/notification.dart';
import 'package:handyman/app/pages/onboarding.dart';
import 'package:handyman/app/pages/provider/bookings.dart';
import 'package:handyman/app/pages/provider/dashboard.dart';
import 'package:handyman/app/pages/provider/settings.dart';
import 'package:handyman/app/pages/register.dart';
import 'package:handyman/app/pages/splash.dart';

import 'guard.dart';

/// Router paths and guards registration
@MaterialAutoRouter(
  routes: [
    AdaptiveRoute(page: OnboardingPage, initial: true),
    AdaptiveRoute(page: SplashPage),
    AdaptiveRoute(page: LoginPage),
    AdaptiveRoute(page: RegisterPage),
    AdaptiveRoute(page: AccountCompletionPage, guards: [AuthGuard]),
    AdaptiveRoute(page: NotificationPage, guards: [AuthGuard]),
    AdaptiveRoute(page: BookingsDetailsPage, guards: [AuthGuard]),
    AdaptiveRoute(page: AccountSelectionPage, guards: [AuthGuard]),
    AdaptiveRoute(page: ConversationPage, guards: [AuthGuard]),
    AdaptiveRoute(page: HomePage, guards: [AuthGuard, ClientGuard]),
    AdaptiveRoute(page: ProfilePage, guards: [AuthGuard, ClientGuard]),
    AdaptiveRoute(page: RequestBookingPage, guards: [AuthGuard, ClientGuard]),
    AdaptiveRoute(
        page: CategoryProvidersPage, guards: [AuthGuard, ClientGuard]),
    AdaptiveRoute(
        page: ServiceProviderDetails, guards: [AuthGuard, ClientGuard]),
    AdaptiveRoute(
        page: ProviderSettingsPage, guards: [AuthGuard, ProviderGuard]),
    AdaptiveRoute(page: DashboardPage, guards: [AuthGuard, ProviderGuard]),
  ],
)
class $Router {}
