/*
 * Copyright (c) 2021.
 * This application is owned by HandyMan LLC,
 * developed & designed by Quabynah Codelabs LLC.
 *
 *
 * author: codelbas.quabynah@gmail.com
 */

import 'package:algolia/algolia.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:logger/logger.dart';
import 'package:url_launcher/url_launcher.dart';

import 'size_config.dart';

/// Logger
final logger = Logger(printer: PrettyPrinter(printTime: true));

void showSnackBarMessage(BuildContext context, {@required String message}) {
  ScaffoldMessenger.of(context)
    ..removeCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
      ),
    );
}

Widget buildFunctionalityNotAvailablePanel(BuildContext context) => Container(
      height: getProportionateScreenHeight(kSpacingX320),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Entypo.feather,
            size: getProportionateScreenHeight(kSpacingX96),
            color: Theme.of(context).colorScheme.onBackground,
          ),
          SizedBox(height: getProportionateScreenHeight(kSpacingX24)),
          Text(
            "Functionality currently not available",
            style: Theme.of(context).textTheme.subtitle1,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: getProportionateScreenHeight(kSpacingX8)),
          Text(
            "Grab a beverage and check back later!",
            style: Theme.of(context).textTheme.bodyText2.copyWith(
                  color: Theme.of(context).disabledColor,
                ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );

/// Sets map style
Future getMapStyle({bool isLightTheme = false}) async =>
    await rootBundle.loadString(
        isLightTheme ? "assets/map_style.json" : "assets/dark_map_style.json");

/// Dimensions
const double kSpacingNone = 0.0;
const double kSpacingX2 = 2.0;
const double kSpacingX4 = 4.0;
const double kSpacingX6 = 6.0;
const double kSpacingX8 = 8.0;
const double kSpacingX12 = 12.0;
const double kSpacingX16 = 16.0;
const double kSpacingX20 = 20.0;
const double kSpacingX24 = 24.0;
const double kSpacingX36 = 36.0;
const double kSpacingX42 = 42.0;
const double kSpacingX48 = 48.0;
const double kSpacingX56 = 56.0;
const double kSpacingX64 = 64.0;
const double kSpacingX72 = 72.0;
const double kSpacingX84 = 84.0;
const double kSpacingX96 = 96.0;
const double kSpacingX100 = 100.0;
const double kSpacingX120 = 120.0;
const double kSpacingX140 = 120.0;
const double kSpacingX160 = 160.0;
const double kSpacingX200 = 200.0;
const double kSpacingX230 = 230.0;
const double kSpacingX250 = 250.0;
const double kSpacingX300 = 300.0;
const double kSpacingX320 = 320.0;
const double kSpacingX360 = 360.0;
const double kOpacityX14 = 0.14;
const double kOpacityX35 = 0.35;
const double kOpacityX50 = 0.5;
const double kOpacityX70 = 0.7;
const double kOpacityX90 = 0.9;
const double kEmphasisLow = 0.38;
const double kEmphasisMedium = 0.67;
const double kEmphasisHigh = 0.9;

/// App
const kAppName = "HandyMan Lite";
const kAppNameShort = "HandyMan";
const kAppSlogan = "Get some real work done";
const kAppVersion = "v1.2.0";
const kAppSloganDesc = "Find & book your services easily with $kAppNameShort";
const kArtisanReviewHelpDialogContent =
    "Sensitive data (like email addresses, phone numbers, user ids etc) will not be made public to customers on this platform.\nYour ratings are also based on the accumulated reviews by customers you have served over the last 6 months";
const kPasswordHint =
    "Your password must be 8 or more characters long & must contain a mix of upper & lower case letters,a number & a symbol";
const kSignOutText =
    "Signing out will set you offline until you sign in again. You may not be able to send/receive requests. Do you wish to continue?";
const kAccountCompletionHelperText =
    "In order to complete your mobile registration process, kindly setup your profile information and upload a business document. You will be notified within the next 72 hours. Thank you!";
const kArtisanString = "Artisan";
const kFunctionalityUnavailable =
    "Functionality is currently unavailable. Try again after the next update. Thank you";
const kCustomerString = "Customer";
const kLogoAsset = "assets/logo/logo.svg";
const kWelcomeAsset = "assets/wfh_2.png";
const k404Asset = "assets/svg/404.svg";
const kLogoDarkAsset = "assets/logo/logo_dark.svg";
const kTimeSvgAsset = "assets/svg/time.svg";
const kPeopleSvgAsset = "assets/svg/people.svg";
const kBookingSvgAsset = "assets/svg/booking.svg";
const kAlgoliaSvgAsset = "assets/svg/algolia_blue_mark.svg";
const kBackgroundAsset = "https://images.unsplash.com/photo-1454694220579-9d6672b1ec2a?ixid=MXwxMjA3fDB8MHxzZWFyY2h8Mnx8aGFuZHltYW58ZW58MHx8MHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=600&q=60";
const kLoremText =
    "Ipsum suspendisse ultrices gravida dictum fusce ut placerat. Cursus sit amet dictum sit amet. Vel elit scelerisque mauris pellentesque pulvinar pellentesque habitant morbi tristique";

/// icons
const kBackIcon = AntDesign.back;
const kRatingStar = Entypo.star;
const kMailIcon = Feather.mail;
const kGoogleIcon = AntDesign.google;
const kUserImageNotFound = Icons.link_off_outlined;
const kArrowIcon = Icons.arrow_right_alt_outlined;

/// [Algolia]
const kAlgoliaAppId = "AIBRVBFA4W";
const kAlgoliaKey = "604022a17d65f30d23e80a38f285be57";

/// Durations
const kScaleDuration = const Duration(milliseconds: 350);
const kTestDuration = const Duration(milliseconds: 2500);
const kSheetDuration = const Duration(milliseconds: 850);
const kSplashDuration = const Duration(milliseconds: 1550);

/// Others
const kScrollPhysics = const BouncingScrollPhysics();
const kSlideOffset = 50.0;

/// Colors
const kGreenColor = Color(0xFF009688);
const kWhiteColor = Colors.white;
const kBlackColor = Colors.black87;
const kAmberColor = Colors.amber;
const kChatBackgroundLight = Color(0xFFF5F5F5);
const kChatBackgroundDark = Color(0xFF222222);
const kTransparent = Colors.transparent;
const kPlaceholderColor = Color(0x70000000);
const kDisabledColor = Color(0xFF666666);

const kPrimaryColor = Color(0xFF0E37EA);
const kSecondaryLightColor = Color(0xFFEBB609);
const kErrorLightColor = Color(0xffE91E63);
const kAccentLightColor = kSecondaryLightColor;
const kBackgroundLightColor = Color(0xFFf1f0f2);
const kCardLightColor = Color(0xFFFFFFFF);

const kPrimaryColorDark = Color(0xFF05050B);
const kSecondaryDarkColor = Color(0xFF8AC185);
const kErrorDarkColor = Color(0xffEC407A);
const kAccentDarkColor = kWhiteColor;
const kCardDarkColor = Color(0xff212529);
const kBackgroundDarkColor = Color(0xFF05050B);
const kSurfaceDarkColor = Color(0xFF222225);

/// Icon Colors
const kAccentIconLightColor = kPrimaryColor;
const kPrimaryIconLightColor = kPrimaryColor;

const kAccentIconDarkColor = kWhiteColor;
const kPrimaryIconDarkColor = kWhiteColor;

/// Text Colors
const kBodyTextColorLight = Color(0xFF232323);
const kTitleTextColorLight = Color(0xFF131313);
const kUnselectedLabelColorLight = Color(0xFF7C7C7C);
const kBodyTextColorDark = Color(0xFFDEDEDE);
const kUnselectedLabelColorDark = Color(0xFFDEDEDE);
const kTitleTextColorDark = Color(0xFFDEDEDE);

const kShadowColor = Color(0xFFDEDEDE);
const kShadowDarkColor = Color(0xFF7C7C7C);

/// launch [url]
Future<void> launchUrl({@required String url}) async {
  if (await canLaunch(url)) {
    await launch(url);
  }
}
