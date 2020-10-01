import 'package:auto_route/auto_route.dart';
import 'package:handyman/app/model/prefs_provider.dart';
import 'package:handyman/core/constants.dart';
import 'package:provider/provider.dart';

class AuthGuard extends RouteGuard {
  @override
  Future<bool> canNavigate(ExtendedNavigatorState<RouterBase> navigator,
      String routeName, Object args) async {
    final ctx = navigator.context;
    final prefsProvider = Provider.of<PrefsProvider>(ctx);
    return prefsProvider.isLoggedIn;
  }
}

class ProviderGuard extends RouteGuard {
  @override
  Future<bool> canNavigate(ExtendedNavigatorState<RouterBase> navigator,
      String routeName, Object args) async {
    final ctx = navigator.context;
    final prefsProvider = Provider.of<PrefsProvider>(ctx);
    return prefsProvider.isLoggedIn &&
        prefsProvider.userType != null &&
        prefsProvider.userType == kArtisanString;
  }
}

class ClientGuard extends RouteGuard {
  @override
  Future<bool> canNavigate(ExtendedNavigatorState<RouterBase> navigator,
      String routeName, Object args) async {
    final ctx = navigator.context;
    final prefsProvider = Provider.of<PrefsProvider>(ctx);
    return prefsProvider.isLoggedIn &&
        prefsProvider.userType != null &&
        prefsProvider.userType == kCustomerString;
  }
}
