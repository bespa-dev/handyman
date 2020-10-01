import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:handyman/app/model/prefs_provider.dart';
import 'package:handyman/app/routes/route.gr.dart';
import 'package:handyman/app/widget/buttons.dart';
import 'package:handyman/core/constants.dart';
import 'package:handyman/core/size_config.dart';
import 'package:handyman/data/services/auth.dart';
import 'package:handyman/domain/services/auth.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  bool _isLoading = false;
  final _authService = FirebaseAuthService.instance;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    if (mounted) {
      _authService.onProcessingStateChanged.listen((state) {
        _isLoading = state == AuthState.AUTHENTICATING;
        setState(() {});
        if (state == AuthState.ERROR)
          _scaffoldKey.currentState
            ..removeCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text("An error occurred. Try again later"),
                behavior: SnackBarBehavior.floating,
              ),
            );
        else if (state == AuthState.AUTHENTICATING)
          _scaffoldKey.currentState
            ..removeCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text("Authenticating..."),
                behavior: SnackBarBehavior.floating,
                duration: const Duration(minutes: 1),
              ),
            );
      });

      _authService.onAuthStateChanged.listen((user) {
        debugPrint(user.toString());
      });
    }
  }

  @override
  void dispose() {
    _authService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final kWidth = size.width;

    return Scaffold(
      key: _scaffoldKey,
      body: Consumer<PrefsProvider>(
        builder: (_, provider, __) => SafeArea(
          child: Stack(
            fit: StackFit.expand,
            children: [
              provider.isLightTheme
                  ? Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(kBackgroundAsset),
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  : SizedBox.shrink(),
              Container(
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: getProportionateScreenHeight(kSpacingX120),
                      width: getProportionateScreenWidth(kSpacingX120),
                      clipBehavior: Clip.hardEdge,
                      margin: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenWidth(kSpacingX64),
                      ),
                      decoration: BoxDecoration(),
                      child: Image(
                        image: Svg(kLogoAsset),
                        fit: BoxFit.contain,
                        height: getProportionateScreenHeight(kSpacingX120),
                        width: getProportionateScreenWidth(kSpacingX120),
                      ),
                    ),
                    SizedBox(height: getProportionateScreenHeight(kSpacingX48)),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: getProportionateScreenWidth(kSpacingX16)),
                      child: Column(
                        children: [
                          Text(
                            kAppSlogan,
                            style: themeData.textTheme.headline3,
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                              height:
                                  getProportionateScreenHeight(kSpacingX12)),
                          Text(
                            kAppSloganDesc,
                            style: themeData.textTheme.bodyText1,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: getProportionateScreenHeight(kSpacingX96)),
                    ButtonPrimary(
                      width: kWidth * 0.9,
                      themeData: themeData,
                      onTap: () => context.navigator.popAndPush(
                        provider.isLoggedIn
                            ? provider.userType == null
                                ? Routes.accountSelectionPage
                                : provider.userType == kCustomerString
                                    ? Routes.homePage
                                    : Routes.dashboardPage
                            : Routes.registerPage,
                      ),
                      enabled: !_isLoading,
                      label: provider.isLoggedIn
                          ? "Proceed"
                          : "Sign up with Email ID",
                    ),
                    SizedBox(height: getProportionateScreenHeight(kSpacingX16)),
                    provider.isLoggedIn
                        ? SizedBox.shrink()
                        : ButtonOutlined(
                            width: kWidth * 0.9,
                            themeData: themeData,
                            onTap: () async =>
                                await _authService.signInWithGoogle(),
                            gravity: ButtonIconGravity.START,
                            icon: AntDesign.google,
                            enabled: !_isLoading,
                            label: "Sign up with Google",
                          ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
