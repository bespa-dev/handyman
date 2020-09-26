import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'constants.dart';

/// Fonts
final _kTitleFontFamily = GoogleFonts.playfairDisplay().fontFamily;
final _kBodyFontFamily = GoogleFonts.raleway().fontFamily;

// latoTextTheme
/// Light theme
ThemeData themeData(BuildContext context) => ThemeData(
      appBarTheme: appBarTheme,
      primaryColor: kPrimaryColor,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      accentColor: kAccentLightColor,
      scaffoldBackgroundColor: Colors.white,
      colorScheme: ColorScheme.light(
        secondary: kSecondaryLightColor,
      ),
      backgroundColor: Colors.white,
      iconTheme: IconThemeData(color: kBodyTextColorLight),
      accentIconTheme: IconThemeData(color: kAccentIconLightColor),
      primaryIconTheme: IconThemeData(color: kPrimaryIconLightColor),
      textTheme: TextTheme(
        headline1: TextStyle(
            fontFamily: _kTitleFontFamily,
            color: kTitleTextColorLight,
            fontWeight: FontWeight.w500),
        headline2: TextStyle(
            fontFamily: _kTitleFontFamily,
            color: kTitleTextColorLight,
            fontWeight: FontWeight.w500),
        headline3: TextStyle(
            fontFamily: _kTitleFontFamily,
            color: kTitleTextColorLight,
            fontWeight: FontWeight.w500),
        headline4: TextStyle(
            fontFamily: _kTitleFontFamily,
            color: kTitleTextColorLight,
            fontWeight: FontWeight.w500),
        headline5: TextStyle(
            color: kTitleTextColorLight,
            fontFamily: _kTitleFontFamily,
            fontWeight: FontWeight.w500),
        headline6: TextStyle(
            color: kTitleTextColorLight,
            fontFamily: _kTitleFontFamily,
            fontWeight: FontWeight.w500),
        bodyText1:
            TextStyle(color: kBodyTextColorLight, fontFamily: _kBodyFontFamily),
        bodyText2:
            TextStyle(color: kBodyTextColorLight, fontFamily: _kBodyFontFamily),
        subtitle1:
            TextStyle(color: kBodyTextColorLight, fontFamily: _kBodyFontFamily),
        subtitle2:
            TextStyle(color: kBodyTextColorLight, fontFamily: _kBodyFontFamily),
        overline:
            TextStyle(color: kBodyTextColorLight, fontFamily: _kBodyFontFamily),
        caption:
            TextStyle(color: kBodyTextColorLight, fontFamily: _kBodyFontFamily),
        button: TextStyle(
            color: kBodyTextColorDark,
            fontFamily: _kBodyFontFamily,
            fontWeight: FontWeight.w500),
      ),
    );

/// Dark theme
ThemeData darkThemeData(BuildContext context) => ThemeData.dark().copyWith(
      appBarTheme: appBarTheme,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      primaryColor: kPrimaryColor,
      accentColor: kAccentDarkColor,
      scaffoldBackgroundColor: Color(0xFF0D0C0E),
      colorScheme: ColorScheme.light(
        secondary: kSecondaryDarkColor,
        surface: kSurfaceDarkColor,
      ),
      backgroundColor: kBackgroundDarkColor,
      iconTheme: IconThemeData(color: kBodyTextColorDark),
      accentIconTheme: IconThemeData(color: kAccentIconDarkColor),
      primaryIconTheme: IconThemeData(color: kPrimaryIconDarkColor),
      textTheme: TextTheme(
        headline1: TextStyle(
            color: kTitleTextColorDark,
            fontWeight: FontWeight.w500,
            fontFamily: _kTitleFontFamily),
        headline2: TextStyle(
            color: kTitleTextColorDark,
            fontWeight: FontWeight.w500,
            fontFamily: _kTitleFontFamily),
        headline3: TextStyle(
            color: kTitleTextColorDark,
            fontWeight: FontWeight.w500,
            fontFamily: _kTitleFontFamily),
        headline4: TextStyle(
            color: kTitleTextColorDark,
            fontFamily: _kTitleFontFamily,
            fontWeight: FontWeight.w500),
        headline5: TextStyle(
            color: kTitleTextColorDark,
            fontFamily: _kTitleFontFamily,
            fontWeight: FontWeight.w500),
        headline6: TextStyle(
            color: kTitleTextColorDark,
            fontFamily: _kTitleFontFamily,
            fontWeight: FontWeight.w500),
        bodyText1:
            TextStyle(color: kBodyTextColorDark, fontFamily: _kBodyFontFamily),
        bodyText2:
            TextStyle(color: kBodyTextColorDark, fontFamily: _kBodyFontFamily),
        subtitle1:
            TextStyle(color: kBodyTextColorDark, fontFamily: _kBodyFontFamily),
        subtitle2:
            TextStyle(color: kBodyTextColorDark, fontFamily: _kBodyFontFamily),
        overline:
            TextStyle(color: kBodyTextColorDark, fontFamily: _kBodyFontFamily),
        caption:
            TextStyle(color: kBodyTextColorDark, fontFamily: _kBodyFontFamily),
        button: TextStyle(
            color: kBodyTextColorLight,
            fontFamily: _kBodyFontFamily,
            fontWeight: FontWeight.w500),
      ),
    );

AppBarTheme appBarTheme = AppBarTheme(color: Colors.transparent, elevation: 0);
