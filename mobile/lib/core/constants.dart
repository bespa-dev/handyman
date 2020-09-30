import 'package:algolia/algolia.dart';
import 'package:flutter/material.dart';

/// Dimensions
const double kSpacingNone = 0.0;
const double kSpacingX2 = 2.0;
const double kSpacingX4 = 4.0;
const double kSpacingX8 = 8.0;
const double kSpacingX12 = 12.0;
const double kSpacingX16 = 16.0;
const double kSpacingX24 = 24.0;
const double kSpacingX36 = 36.0;
const double kSpacingX42 = 42.0;
const double kSpacingX48 = 48.0;
const double kSpacingX64 = 64.0;
const double kSpacingX72 = 72.0;
const double kSpacingX96 = 96.0;
const double kSpacingX120 = 120.0;
const double kSpacingX200 = 200.0;
const double kSpacingX230 = 230.0;
const double kSpacingX250 = 250.0;
const double kSpacingX300 = 300.0;
const double kSpacingX320 = 320.0;
const double kOpacityX14 = 0.14;
const double kOpacityX35 = 0.35;
const double kOpacityX50 = 0.5;
const double kOpacityX70 = 0.7;
const double kOpacityX90 = 0.9;

/// App
const kAppName = "Handyman";
const kAppSlogan = "Simple. Safe. Reliable.";
const kProviderString = "Artisan";
const kClientString = "Customer";
const kLogoAsset = "assets/logo/app_title.webp";
const kBannerAsset = "assets/banner/banner_two.webp";
const kBackgroundAsset = "assets/bg/bg.webp";
const kLoremText =
    "You can set your own location and search preferences to filter out whom you'd like to talk to. It has never been easier to find dates, love and romance. Seeking companionship with our app is easy so start. Flirt with hot chicks and guys now! Forget about searching for dates out in bars and night clubs when you can meet new people and chat right from your phone. With this dating app you can find cool girls and guys in your area to hang out with.";

/// [Algolia]
const kAlgoliaAppId = "AIBRVBFA4W";
const kAlgoliaKey = "604022a17d65f30d23e80a38f285be57";

/// Durations
const kScaleDuration = const Duration(milliseconds: 350);

/// Others
const kScrollPhysics = const BouncingScrollPhysics();
const kSlideOffset = 50.0;

/// Colors
const kGreenColor = Color(0xFF009688);
const kWhiteColor = Colors.white;
const kChatBackgroundLight = Color(0xFFF5F5F5);
const kChatBackgroundDark = Color(0xFF222222);
const kTransparent = Colors.transparent;
const kPlaceholderColor = Color(0x70000000);
const kDisabledColor = Color(0xFF666666);
// const kDisabledColorDark = Color(0x1f000000);

// const kPrimaryColor = Color(0xFF5d1049);
// const kSecondaryLightColor = Color(0xFFe30425);
const kPrimaryColor = Color(0xFF0E37EA);
const kSecondaryLightColor = Color(0xFFEBB609);
const kErrorLightColor = Color(0xffE91E63);
const kAccentLightColor = kSecondaryLightColor;
const kBackgroundLightColor = kWhiteColor;
const kCardLightColor = kWhiteColor;

const kPrimaryColorDark = Color(0xFFFF7597);
const kSecondaryDarkColor = Color(0xFFFF7597);
const kErrorDarkColor = Color(0xffEC407A);
const kAccentDarkColor = kWhiteColor;
const kBackgroundDarkColor = Color(0xFF151515);
// const kBackgroundDarkColor = Color(0xFF202124);
// const kBackgroundDarkColor = Color(0xFF24191C);
const kCardDarkColor = Color(0xFF272727);
// const kCardDarkColor = Color(0xFF3C4043);
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

const kBodyTextColorDark = Color(0xFF7C7C7C);
const kUnselectedLabelColorDark = Color(0xFF5F6368);
const kTitleTextColorDark = Color(0xFF7C7C7C);

const kShadowColor = Color(0xFFDEDEDE);
const kShadowDarkColor = Color(0xFF7C7C7C);
