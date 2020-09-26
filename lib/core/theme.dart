import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'constants.dart';

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
      textTheme: GoogleFonts.latoTextTheme().copyWith(
        headline1:
            TextStyle(color: kTitleTextColorLight, fontWeight: FontWeight.w500),
        headline2:
            TextStyle(color: kTitleTextColorLight, fontWeight: FontWeight.w500),
        headline3:
            TextStyle(color: kTitleTextColorLight, fontWeight: FontWeight.w500),
        headline4: TextStyle(color: kTitleTextColorLight),
        headline5: TextStyle(color: kTitleTextColorLight),
        headline6: TextStyle(color: kTitleTextColorLight),
        bodyText1: TextStyle(color: kBodyTextColorLight),
        bodyText2: TextStyle(color: kBodyTextColorLight),
        subtitle1: TextStyle(color: kBodyTextColorLight),
        subtitle2: TextStyle(color: kBodyTextColorLight),
        overline: TextStyle(color: kBodyTextColorLight),
        caption: TextStyle(color: kBodyTextColorLight),
        button: TextStyle(color: kBodyTextColorDark),
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
      textTheme: GoogleFonts.latoTextTheme().copyWith(
        headline1:
            TextStyle(color: kTitleTextColorDark, fontWeight: FontWeight.w500),
        headline2:
            TextStyle(color: kTitleTextColorDark, fontWeight: FontWeight.w500),
        headline3:
            TextStyle(color: kTitleTextColorDark, fontWeight: FontWeight.w500),
        headline4: TextStyle(color: kTitleTextColorDark),
        headline5: TextStyle(color: kTitleTextColorDark),
        headline6: TextStyle(color: kTitleTextColorDark),
        bodyText1: TextStyle(color: kBodyTextColorDark),
        bodyText2: TextStyle(color: kBodyTextColorDark),
        subtitle1: TextStyle(color: kBodyTextColorDark),
        subtitle2: TextStyle(color: kBodyTextColorDark),
        overline: TextStyle(color: kBodyTextColorDark),
        caption: TextStyle(color: kBodyTextColorDark),
        button: TextStyle(color: kBodyTextColorLight),
      ),
    );

AppBarTheme appBarTheme = AppBarTheme(color: Colors.transparent, elevation: 0);
