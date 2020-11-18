import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:handyman/app/model/prefs_provider.dart';
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
  int _currentPage = 2;

  final PageController _pageController =
      PageController(initialPage: 2, keepPage: true);

  final _titles = const <String>[
    "Earn Skills Badge",
    "Save time",
    "$kAppName is Here for You",
    "Simple Booking",
    "1000+ Services",
  ];

  final _subtitles = const <String>[
    "$kAppName provides badges to its artisans based on the services provided by the artisans and reviews made by customers",
    "$kAppName allows you to book service of an artisan within the shortest time period. Save yourself with stress and let $kAppName handle your the right artisan for the perfect service",
    "$kAppName is here to connect customers and artisans at a more simple and specific way",
    "$kAppName provides you with the option to book any artisan at any point in time and place you need the artisans service",
    "With the $kAppName platform customers are able to get in contact with 1000 and more artisans available for a service needed",
  ];

  final _images = <String>[
    kLogoDarkAsset,
    kTimeSvgAsset,
    kLogoAsset,
    kBookingSvgAsset,
    kPeopleSvgAsset,
  ];

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final themeData = Theme.of(context);

    return Scaffold(
      key: _scaffoldKey,
      extendBody: true,
      body: Consumer<PrefsProvider>(
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
                itemCount: _titles.length,
                controller: _pageController,
                onPageChanged: (newIndex) {
                  setState(() {
                    _currentPage = newIndex;
                  });
                },
                itemBuilder: (_, index) => Container(
                  width: SizeConfig.screenWidth,
                  height: SizeConfig.screenHeight,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Positioned(
                        top: SizeConfig.screenHeight * 0.25,
                        bottom: SizeConfig.screenHeight * 0.5,
                        width: SizeConfig.screenWidth,
                        child: Container(
                          height: getProportionateScreenHeight(
                              index == 2 ? kSpacingX100 : kSpacingX120),
                          width: getProportionateScreenWidth(
                              index == 2 ? kSpacingX100 : kSpacingX120),
                          child: Image(
                            fit: BoxFit.contain,
                            height: getProportionateScreenHeight(
                                index == 2 ? kSpacingX100 : kSpacingX120),
                            width: getProportionateScreenWidth(
                                index == 2 ? kSpacingX100 : kSpacingX120),
                            image: Svg(_images[index]),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: kSpacingNone,
                        top: SizeConfig.screenHeight * 0.6,
                        width: SizeConfig.screenWidth,
                        child: Container(
                          width: SizeConfig.screenWidth,
                          padding: EdgeInsets.symmetric(
                            horizontal:
                                getProportionateScreenWidth(kSpacingX16),
                            vertical: getProportionateScreenHeight(kSpacingX64),
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
                                style: themeData.textTheme.headline4,
                              ),
                              SizedBox(
                                  height: getProportionateScreenHeight(
                                      kSpacingX16)),
                              Text(
                                _subtitles[index],
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
                  topLeft:
                      Radius.circular(getProportionateScreenWidth(kSpacingX24)),
                  bottomLeft:
                      Radius.circular(getProportionateScreenWidth(kSpacingX24)),
                ),
                onTap: () => context.navigator.popAndPush(
                  provider.userType == kArtisanString
                      ? Routes.dashboardPage
                      : Routes.homePage,
                ),
                child: Container(
                  height: kToolbarHeight,
                  width: SizeConfig.screenWidth * 0.3,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: themeData.colorScheme.primary,
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
                pages: _titles.length,
                currentPage: _currentPage,
              ),
            )
          ],
        ),
      ),
    );
  }
}
