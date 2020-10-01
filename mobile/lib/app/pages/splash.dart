import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:handyman/app/model/prefs_provider.dart';
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
    ThemeData themeData = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final kWidth = size.width;
    final kHeight = size.height;

    return Scaffold(
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
                      decoration: BoxDecoration(
                          color: themeData.scaffoldBackgroundColor),
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
                      // icon: Icons.arrow_right_alt,
                      width: kWidth * 0.9,
                      themeData: themeData,
                      onTap: () => context.navigator.popAndPush(
                        /*provider.isLoggedIn
                            ? provider.userType == null
                                ? Routes.accountSelectionPage
                                : provider.userType == kClientString
                                    ? Routes.homePage
                                    : Routes.dashboardPage
                            :*/
                        Routes.registerPage,
                      ),
                      label: provider.isLoggedIn
                          ? "Proceed"
                          : "Sign up with Email ID",
                    ),
                    SizedBox(height: getProportionateScreenHeight(kSpacingX16)),
                    ButtonOutlined(
                      width: kWidth * 0.9,
                      themeData: themeData,
                      onTap: null,
                      icon: AntDesign.google,
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
