import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:handyman/app/model/prefs_provider.dart';
import 'package:handyman/app/model/theme_provider.dart';
import 'package:handyman/app/routes/route.gr.dart';
import 'package:handyman/app/widget/page_indicator.dart';
import 'package:handyman/core/constants.dart';
import 'package:handyman/core/size_config.dart';
import 'package:provider/provider.dart';

class OnboardingPage extends StatefulWidget {
  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  int _currentPage = 0;

  final _titles = const <String>[
    "Save time",
    "Simple booking",
    "1000+ services",
  ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    var darkTheme =
        Provider.of<PrefsProvider>(context, listen: false).isDarkTheme;
    Provider.of<ThemeProvider>(context, listen: false)
        .toggleTheme(value: darkTheme);
  }

  @override
  Widget build(BuildContext context) {
    // Must be called on initial page
    SizeConfig().init(context);
    final themeData = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final kWidth = size.width;
    final kHeight = size.height;

    return Scaffold(
      key: _scaffoldKey,
      extendBody: true,
      body: Consumer<PrefsProvider>(
        builder: (_, prefs, __) => Consumer<ThemeProvider>(
          builder: (_, provider, __) => Stack(
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
              Positioned.fill(
                child: PageView.builder(
                  itemCount: 3,
                  physics: BouncingScrollPhysics(),
                  onPageChanged: (newIndex) {
                    setState(() {
                      _currentPage = newIndex;
                    });
                  },
                  itemBuilder: (_, index) => Container(
                    width: kWidth,
                    height: kHeight,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Positioned(
                          top: getProportionateScreenHeight(kSpacingX120),
                          width: kWidth,
                          child: Container(
                            child: Image(
                              height: kHeight * 0.45,
                              width: kWidth,
                              image: Svg(
                                index == 0
                                    ? kTimeSvgAsset
                                    : index == 1
                                        ? kPeopleSvgAsset
                                        : kBookingSvgAsset,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: kSpacingNone,
                          top: kHeight * 0.6,
                          width: kWidth,
                          child: Container(
                            width: kWidth,
                            padding: EdgeInsets.symmetric(
                              horizontal:
                                  getProportionateScreenWidth(kSpacingX16),
                              vertical:
                                  getProportionateScreenHeight(kSpacingX64),
                            ),
                            decoration: BoxDecoration(
                              color: themeData.scaffoldBackgroundColor,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  _titles[index],
                                  textAlign: TextAlign.center,
                                  style: themeData.textTheme.headline4.copyWith(
                                    fontFamily: themeData
                                        .textTheme.bodyText1.fontFamily,
                                  ),
                                ),
                                SizedBox(
                                    height: getProportionateScreenHeight(
                                        kSpacingX16)),
                                Text(
                                  kLoremText,
                                  style: themeData.textTheme.bodyText1,
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: getProportionateScreenHeight(kSpacingX64),
                right: 0,
                child: InkWell(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(
                        getProportionateScreenWidth(kSpacingX24)),
                    bottomLeft: Radius.circular(
                        getProportionateScreenWidth(kSpacingX24)),
                  ),
                  onTap: () => context.navigator.popAndPush(
                    /*prefs.isLoggedIn
                        ? prefs.userType == kClientString
                            ? Routes.homePage
                            : Routes.dashboardPage
                        : */
                    Routes.registerPage,
                  ),
                  child: Container(
                    height: kToolbarHeight,
                    width: kWidth * 0.3,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: themeData.primaryColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(
                            getProportionateScreenWidth(kSpacingX24)),
                        bottomLeft: Radius.circular(
                            getProportionateScreenWidth(kSpacingX24)),
                      ),
                    ),
                    child: Text(
                      "Skip".toUpperCase(),
                      style: themeData.textTheme.button.copyWith(
                        color: themeData.colorScheme.onPrimary,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: getProportionateScreenHeight(kSpacingX48),
                left: kSpacingNone,
                right: kSpacingNone,
                child: PageIndicator(
                  pages: 3,
                  currentPage: _currentPage,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
