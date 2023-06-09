/*
 * Copyright (c) 2021.
 * This application is owned by HandyMan LLC,
 * developed & designed by Quabynah Codelabs LLC.
 *
 *
 * author: codelbas.quabynah@gmail.com
 */

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:lite/shared/shared.dart';
import 'package:logger/logger.dart';
import 'package:url_launcher/url_launcher.dart';

/// Logger
final logger = Logger(printer: PrettyPrinter(printTime: true));

/// https://stackoverflow.com/questions/56707392/how-can-i-use-willpopscope-inside-a-navigator-in-flutter
Future<bool> backPressed(GlobalKey<NavigatorState> _yourKey) async {
  // Checks if current Navigator still has screens on the stack.
  if (_yourKey.currentState.canPop()) {
    // 'maybePop' method handles the decision of 'pop' to another WillPopScope if they exist.
    // If no other WillPopScope exists, it returns true
    await _yourKey.currentState.maybePop();
    return Future<bool>.value(false);
  }

  // if nothing remains in the stack, it simply pops
  return Future<bool>.value(true);
}

/// show [SnackBar] with a message
void showSnackBarMessage(
  BuildContext context, {
  @required String message,
  SnackBarDuration duration,
}) {
  duration ??= SnackBarDuration.shortLength();
  ScaffoldMessenger.of(context)
    ..removeCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        duration: Duration(
          seconds: duration is shortLength
              ? 5
              : duration is longLength
                  ? 10
                  : 1200,
        ),
      ),
    );
}

/// Sets map style
Future getMapStyle({@required bool isLightTheme}) async =>
    await rootBundle.loadString(
        isLightTheme ? 'assets/map_style.json' : 'assets/dark_map_style.json');

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
const double kSpacingX28 = 28.0;
const double kSpacingX32 = 32.0;
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
const double kBlurSigma = 5.0;

/// App
const kAppName = 'HandyMan';
const kAppNameShort = 'HandyMan';
const kAppSlogan =
    'A mobile application to gather all handyman service providers on a single platform and introduce them to potential service seekers and compare between providers and hire the best quote';
const kAppSloganDesc = 'Find & book your services easily with $kAppName';
const kArtisanReviewHelpDialogContent =
    'Sensitive data (like email addresses, phone numbers, user ids etc) will not be made public to customers on this platform.\nYour ratings are also based on the accumulated reviews by customers you have served over the last 6 months';
const kPasswordHint =
    'Your password must be 8 or more characters long & must contain a mix of upper & lower case letters,a number & a symbol';
const kSignOutText =
    'Signing out will set you offline until you sign in again. You may not be able to send/receive requests. Do you wish to continue?';
const kAccountCompletionHelperText =
    'In order to complete your mobile registration process, kindly setup your profile information and upload a business document. You will be notified within the next 72 hours. Thank you!';
const kServiceHelperText =
    'Details on services provided by this artisan are not made public. If you need more information regarding the procedure and arrangement for the performance of this job please contact the artisan directly through the \"chat\" option available on his/her profile.';
const kFunctionalityUnavailable =
    'Functionality is currently unavailable. Try again after the next update. Thank you';
const kLogoAsset = 'assets/logo/logo.svg';
const kWelcomeAsset = 'assets/svg/welcome.png';
const kRegisterAsset = 'assets/svg/register.png';
const kLoginAsset = 'assets/svg/login.png';
const k404Asset = 'assets/svg/404.svg';
const kLogoDarkAsset = 'assets/logo/logo_dark.svg';
const kAlgoliaSvgAsset = 'assets/svg/algolia_blue_mark.svg';
const kBackgroundAsset = 'assets/bg.png';
const kLoremText =
    'Ipsum suspendisse ultrices gravida dictum fusce ut placerat. Cursus sit amet dictum sit amet. Vel elit scelerisque mauris pellentesque pulvinar pellentesque habitant morbi tristique';

const kBackIcon = AntDesign.back;
const kPlusIcon = Feather.plus;
const kRatingStar = Entypo.star;
const kMailIcon = Feather.mail;
const kEditIcon = Feather.edit_2;
const kGoogleIcon = AntDesign.google;
const kEmptyIcon = Entypo.bucket;
const kDoneIcon = Icons.done;
const kHistoryIcon = Icons.history;
const kUserImageNotFound = Icons.link_off_outlined;
const kArrowIcon = Icons.arrow_right_alt_outlined;
const kOptionsIcon = Entypo.dots_two_vertical;
const kFilterIcon = Feather.filter;
const kOnlineIcon = Feather.wifi;
const kOfflineIcon = Feather.wifi_off;
const kCloseIcon = Feather.x;
const kSearchIcon = Feather.search;
const kLocationIcon = Feather.map_pin;
const kClearIcon = Icons.clear_all_outlined;
const kHelpIcon = Feather.help_circle;
const kCameraIcon = Entypo.camera;
const kGalleryIcon = Entypo.image;
const kHomeIcon = LineAwesomeIcons.home;
const kNotificationIcon = Feather.bell;
const kBriefcaseIcon = LineAwesomeIcons.business_time;
const kUserAddIcon = Feather.user_plus;
const kChatIcon = Entypo.message;
const kSendIcon = Feather.send;
const kImageIcon = Feather.image;
const kCallIcon = Feather.phone;
const kMoneyIcon = Entypo.wallet;
const kCategoryIcon = Icons.supervised_user_circle_outlined;
const kBadgeIcon = Feather.award;
const kTrashIcon = Feather.trash;
const kThreeDotsOptionsIcon = Entypo.dots_three_horizontal;

/// Others
const kScrollPhysics = BouncingScrollPhysics();
const kSlideOffset = 50.0;

/// Colors
const kGreenColor = Color(0xFF009688);
const kWhiteColor = Colors.white;
const kBlackColor = Colors.black87;
const kAmberColor = Colors.amber;
const kPendingJobColor = Color(0xFFFFEFD9);
const kPendingJobTextColor = Color(0xFFFFAF3F);
const kCompletedJobColor = Color(0xFFE1F7E6);
const kCompletedJobTextColor = Color(0xFF74D98D);
const kCancelledJobColor = Color(0xFFFFE2E0);
const kCancelledJobTextColor = Color(0xFFFF6057);
const kChatBackgroundLight = Color(0xFFF5F5F5);
const kChatBackgroundDark = Color(0xFF222222);
const kTransparent = Colors.transparent;
const kPlaceholderColor = Color(0x70000000);
const kDisabledColor = Color(0xFF666666);

const kPrimaryColor = Color(0xFF0E37EA);
const kSecondaryLightColor = Color(0xFFE6BD19);
const kErrorLightColor = Color(0xffE91E63);
const kAccentLightColor = kSecondaryLightColor;
const kBackgroundLightColor = Color(0xFFF2F2F2);
// const kBackgroundLightColor = Color(0xFFf1f0f2);
const kCardLightColor = Color(0xffF5F6FA);

const kPrimaryColorDark = Color(0xFF232323);
const kSecondaryDarkColor = Color(0xFF1875FB);
const kErrorDarkColor = Color(0xffEC407A);
const kAccentDarkColor = kWhiteColor;
const kCardDarkColor = Color(0xff212529);
const kBackgroundDarkColor = Color(0xFF05050B);
const kSurfaceDarkColor = Color(0xFF222225);

/// Icon Colors
const kAccentIconLightColor = kBlackColor;
const kPrimaryIconLightColor = kBlackColor;

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
  logger.d('Launching -> $url');
  if (await canLaunch(url)) {
    await launch(url);
  }
}
