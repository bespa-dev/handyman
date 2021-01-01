/*
 * Copyright (c) 2021.
 * This application is owned by HandyMan LLC,
 * developed & designed by Quabynah Codelabs LLC.
 *
 *
 * author: codelbas.quabynah@gmail.com
 */

import 'package:flutter/material.dart';
import 'package:lite/app/widgets/src/buttons.dart';
import 'package:lite/shared/shared.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final kTheme = Theme.of(context);

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(
          kSpacingX24,
          kSpacingX36,
          kSpacingX24,
          kSpacingX24,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Spacer(flex: 1),
            Text(
              kAppName,
              textAlign: TextAlign.center,
              style: kTheme.textTheme.headline4,
            ),
            SizedBox(height: kSpacingX8),
            Text(
              kAppSloganDesc,
              textAlign: TextAlign.center,
              style: kTheme.textTheme.subtitle1,
            ),
            Spacer(flex: 4),
            Align(
              alignment: Alignment.center,
              child: ButtonPrimary(
                width: SizeConfig.screenWidth * 0.85,
                themeData: kTheme,
                onTap: () {},
                label: "Get Started",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
