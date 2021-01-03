/*
 * Copyright (c) 2021.
 * This application is owned by HandyMan LLC,
 * developed & designed by Quabynah Codelabs LLC.
 *
 *
 * author: codelbas.quabynah@gmail.com
 */

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:lite/app/routes/routes.gr.dart';
import 'package:lite/app/widgets/src/buttons.dart';
import 'package:lite/shared/shared.dart';

class UnknownRoutePage extends StatefulWidget {
  @override
  _UnknownRoutePageState createState() => _UnknownRoutePageState();
}

class _UnknownRoutePageState extends State<UnknownRoutePage> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final kTheme = Theme.of(context);

    return Scaffold(
      body: Stack(
        children: [
          /// content
          Positioned(
            top: SizeConfig.screenHeight * 0.1,
            left: kSpacingNone,
            right: kSpacingNone,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  kWelcomeAsset,
                  width: SizeConfig.screenWidth * 0.8,
                  height: SizeConfig.screenHeight * 0.5,
                ),
                SizedBox(height: kSpacingX36),
                Text("Oops...", style: kTheme.textTheme.headline5),
                SizedBox(height: kSpacingX8),
                Text(
                  "You seem to have wandered far from home",
                  style: kTheme.textTheme.bodyText2,
                ),
                SizedBox(height: kSpacingX16),
                ButtonOutlined(
                  width: SizeConfig.screenWidth * 0.5,
                  onTap: () => context.navigator
                    ..popUntilRoot()
                    ..pushHomePage(),
                  label: "Go home",
                ),
              ],
            ),
          ),

          /// back button
          Positioned(
            top: kSpacingX36,
            left: kSpacingX16,
            child: IconButton(
              icon: Icon(kBackIcon),
              onPressed: () => context.navigator
                ..popUntilRoot()
                ..pushHomePage(),
            ),
          ),
        ],
      ),
    );
  }
}
