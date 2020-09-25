import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'constants.dart';

/// Light theme
ThemeData themeData(BuildContext context) => ThemeData(
      appBarTheme: appBarTheme,
      primaryColor: kPrimaryColor,
      accentColor: kAccentLightColor,
      scaffoldBackgroundColor: Colors.white,
      colorScheme: ColorScheme.light(
        secondary: kSecondaryLightColor,
      ),
      backgroundColor: Colors.white,
      iconTheme: IconThemeData(color: kBodyTextColorLight),
      accentIconTheme: IconThemeData(color: kAccentIconLightColor),
      primaryIconTheme: IconThemeData(color: kPrimaryIconLightColor),
      textTheme: GoogleFonts.rubikTextTheme().copyWith(
        headline3: TextStyle(color: kTitleTextColorLight),
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
      textTheme: GoogleFonts.rubikTextTheme().copyWith(
        headline3: TextStyle(color: kTitleTextColorDark),
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
