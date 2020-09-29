import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
      body: Consumer<ThemeProvider>(
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
                  padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(16),
                    vertical: getProportionateScreenHeight(64),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Spacer(),
                      Expanded(
                        flex: 3,
                        child: Container(
                          child:
                              // FIXME: Replace with appropriate images
                              Image.asset("assets/artisans/${index + 1}.webp"),
                        ),
                      ),
                      SizedBox(height: getProportionateScreenHeight(36)),
                      Text(
                        _titles[index].toUpperCase(),
                        textAlign: TextAlign.center,
                        style: themeData.textTheme.headline4.copyWith(
                          fontFamily: themeData.textTheme.bodyText1.fontFamily,
                        ),
                      ),
                      SizedBox(height: getProportionateScreenHeight(16)),
                      Text(
                        kLoremText,
                        style: themeData.textTheme.bodyText1,
                        textAlign: TextAlign.center,
                      ),
                      Spacer(),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: getProportionateScreenHeight(64),
              right: 0,
              child: InkWell(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(getProportionateScreenWidth(24)),
                  bottomLeft: Radius.circular(getProportionateScreenWidth(24)),
                ),
                onTap: () => context.navigator.popAndPush(Routes.loginPage),
                child: Container(
                  height: kToolbarHeight,
                  width: kWidth * 0.3,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: themeData.primaryColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(getProportionateScreenWidth(24)),
                      bottomLeft:
                          Radius.circular(getProportionateScreenWidth(24)),
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
              bottom: getProportionateScreenHeight(48),
              left: getProportionateScreenWidth(16),
              child: PageIndicator(
                pages: 3,
                showSkip: false,
                currentPage: _currentPage,
              ),
            )
          ],
        ),
      ),
    );
  }
}
