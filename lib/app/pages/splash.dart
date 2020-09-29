import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:handyman/app/model/prefs_provider.dart';
import 'package:handyman/app/model/theme_provider.dart';
import 'package:handyman/app/routes/route.gr.dart';
import 'package:handyman/app/widget/buttons.dart';
import 'package:handyman/core/constants.dart';
import 'package:handyman/core/size_config.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    // Must be called on initial page
    SizeConfig().init(context);
    ThemeData themeData = Theme.of(context);

    return Consumer<ThemeProvider>(
      builder: (_, theme, child) => Scaffold(
        body: Consumer<PrefsProvider>(
          builder: (_, provider, __) => SafeArea(
            child: Stack(
              fit: StackFit.expand,
              children: [
                theme.isLightTheme
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
                    children: [
                      Spacer(),
                      Expanded(
                        child: Container(
                          height: getProportionateScreenHeight(250),
                          width: getProportionateScreenWidth(250),
                          clipBehavior: Clip.hardEdge,
                          margin: EdgeInsets.symmetric(
                            horizontal: getProportionateScreenWidth(64),
                          ),
                          decoration: BoxDecoration(
                              color: themeData.scaffoldBackgroundColor),
                          child: Image.asset(
                            kBannerAsset,
                            fit: BoxFit.contain,
                            height: getProportionateScreenHeight(250),
                            width: getProportionateScreenWidth(250),
                          ),
                        ),
                      ),
                      SizedBox(height: getProportionateScreenHeight(64)),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: getProportionateScreenWidth(16)),
                        child: Text(
                          kAppSlogan,
                          style: themeData.textTheme.headline3,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: getProportionateScreenHeight(24)),
                      ButtonPrimary(
                        icon: Icons.arrow_right_alt,
                        width: getProportionateScreenWidth(250),
                        themeData: themeData,
                        onTap: () =>
                            context.navigator.popAndPush(provider.isLoggedIn
                                ? provider.userType == kClientString
                                    ? Routes.homePage
                                    : Routes.dashboardPage
                                : Routes.loginPage),
                        label: provider.isLoggedIn ? "Proceed" : "Get started",
                      ),
                      Spacer(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
