/*
 * Copyright (c) 2021.
 * This application is owned by HandyMan LLC,
 * developed & designed by Quabynah Codelabs LLC.
 *
 *
 * author: codelbas.quabynah@gmail.com
 */

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'constants.dart';

/// Fonts
final _kTitleFontFamily = GoogleFonts.poppins().fontFamily;
final _kBodyFontFamily = GoogleFonts.rubik().fontFamily;

/// Light theme
ThemeData themeData(BuildContext context) => ThemeData(
      selectedRowColor: kSecondaryLightColor,
      appBarTheme: appBarTheme,
      disabledColor: kDisabledColor,
      errorColor: kErrorLightColor,
      toggleableActiveColor: kPrimaryColor,
      dividerTheme: DividerThemeData(
        thickness: kSpacingNone,
        color: kDisabledColor.withOpacity(kOpacityX70),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kSpacingX8),
        ),
        backgroundColor: kSecondaryLightColor,
      ),
      inputDecorationTheme: InputDecorationTheme(
        focusColor: kPrimaryColor,
        border: InputBorder.none,
        labelStyle: TextStyle(
          color: kBlackColor,
          fontFamily: _kBodyFontFamily,
        ),
        hintStyle: TextStyle(
          color: kPrimaryColor,
          fontFamily: _kBodyFontFamily,
          fontWeight: FontWeight.normal,
        ),
        suffixStyle: TextStyle(
          color: kPrimaryColor,
          fontFamily: _kBodyFontFamily,
          fontWeight: FontWeight.normal,
        ),
        fillColor: kCardLightColor,
        filled: true,
      ),
      tabBarTheme: TabBarTheme(
        labelColor: kPrimaryColor,
        indicatorSize: TabBarIndicatorSize.label,
        unselectedLabelColor: kUnselectedLabelColorLight,
      ),
      primaryColor: kPrimaryColor,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      accentColor: kAccentLightColor,
      scaffoldBackgroundColor: kBackgroundLightColor,
      cardColor: kCardLightColor,
      colorScheme: ColorScheme.light(
        secondary: kSecondaryLightColor,
        surface: kWhiteColor,
        primary: kPrimaryColor,
        onSecondary: kBlackColor,
        onPrimary: kWhiteColor,
      ),
      backgroundColor: kBackgroundLightColor,
      iconTheme: IconThemeData(color: kPrimaryIconLightColor),
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
            fontWeight: FontWeight.w600),
        headline5: TextStyle(
            color: kTitleTextColorLight,
            fontFamily: _kTitleFontFamily,
            fontWeight: FontWeight.w600),
        headline6: TextStyle(
            color: kTitleTextColorLight,
            fontFamily: _kTitleFontFamily,
            fontSize: 18,
            fontWeight: FontWeight.w600),
        bodyText1:
            TextStyle(color: kBodyTextColorLight, fontFamily: _kBodyFontFamily),
        bodyText2: TextStyle(
            color: kBodyTextColorLight.withOpacity(kEmphasisMedium),
            fontFamily: _kBodyFontFamily),
        subtitle1:
            TextStyle(color: kBodyTextColorLight, fontFamily: _kBodyFontFamily),
        subtitle2: TextStyle(
            color: kBodyTextColorLight.withOpacity(kEmphasisMedium),
            fontFamily: _kBodyFontFamily),
        overline:
            TextStyle(color: kBodyTextColorLight, fontFamily: _kBodyFontFamily),
        caption: TextStyle(
            color: kBodyTextColorLight.withOpacity(kEmphasisMedium),
            fontFamily: _kBodyFontFamily),
        button: TextStyle(
            color: kBodyTextColorDark,
            fontFamily: _kBodyFontFamily,
            fontWeight: FontWeight.w600),
      ),
    );

/// Dark theme
ThemeData darkThemeData(BuildContext context) => ThemeData.dark().copyWith(
      selectedRowColor: kSecondaryDarkColor,
      errorColor: kErrorDarkColor,
      appBarTheme: appBarTheme,
      disabledColor: kDisabledColor,
      toggleableActiveColor: kSecondaryDarkColor,
      dividerTheme: DividerThemeData(
        thickness: 1,
        color: kDisabledColor.withOpacity(kOpacityX70),
      ),
      // disabledColor: kDisabledColor,
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kSpacingX16),
        ),
        backgroundColor: kPrimaryColorDark,
      ),
      tabBarTheme: TabBarTheme(
        labelColor: kPrimaryColorDark,
        indicatorSize: TabBarIndicatorSize.label,
        unselectedLabelColor: kUnselectedLabelColorDark,
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: UnderlineInputBorder(),
      ),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      primaryColor: kPrimaryColorDark,
      accentColor: kAccentDarkColor,
      scaffoldBackgroundColor: kBackgroundDarkColor,
      colorScheme: ColorScheme.dark(
        secondary: kSecondaryDarkColor,
        surface: kSurfaceDarkColor,
        primary: kPrimaryColorDark,
        background: kBackgroundDarkColor,
        onPrimary: kWhiteColor,
      ),
      backgroundColor: kBackgroundDarkColor,
      iconTheme: IconThemeData(color: kPrimaryIconDarkColor),
      accentIconTheme: IconThemeData(color: kAccentIconDarkColor),
      primaryIconTheme: IconThemeData(color: kPrimaryIconDarkColor),
      cardColor: kCardDarkColor,
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
            fontWeight: FontWeight.w600),
        headline5: TextStyle(
            color: kTitleTextColorDark,
            fontFamily: _kTitleFontFamily,
            fontWeight: FontWeight.w600),
        headline6: TextStyle(
            color: kTitleTextColorDark,
            fontFamily: _kTitleFontFamily,
            fontSize: 18,
            fontWeight: FontWeight.w600),
        bodyText1:
            TextStyle(color: kBodyTextColorDark, fontFamily: _kBodyFontFamily),
        bodyText2: TextStyle(
            color: kBodyTextColorDark.withOpacity(kEmphasisMedium),
            fontFamily: _kBodyFontFamily),
        subtitle1:
            TextStyle(color: kBodyTextColorDark, fontFamily: _kBodyFontFamily),
        subtitle2: TextStyle(
            color: kBodyTextColorDark.withOpacity(kEmphasisMedium),
            fontFamily: _kBodyFontFamily),
        overline:
            TextStyle(color: kBodyTextColorDark, fontFamily: _kBodyFontFamily),
        caption: TextStyle(
            color: kBodyTextColorDark.withOpacity(kEmphasisMedium),
            fontFamily: _kBodyFontFamily),
        button: TextStyle(
          color: kBodyTextColorLight,
          fontFamily: _kBodyFontFamily,
          fontWeight: FontWeight.w600,
        ),
      ),
    );

AppBarTheme appBarTheme = AppBarTheme(
  color: kTransparent,
  centerTitle: true,
  elevation: 0,
  textTheme: TextTheme(
    headline6: TextStyle(
      fontFamily: _kBodyFontFamily,
      fontWeight: FontWeight.w500,
      fontSize: 18,
    ),
  ),
);
