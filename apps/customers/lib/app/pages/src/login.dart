/*
 * Copyright (c) 2021.
 * This application is owned by HandyMan LLC,
 * developed & designed by Quabynah Codelabs LLC.
 *
 *
 * author: codelbas.quabynah@gmail.com
 */

import 'package:flutter/material.dart';
import 'package:lite/shared/shared.dart';
import 'package:auto_route/auto_route.dart';
import 'package:lite/app/routes/routes.gr.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final kTheme = Theme.of(context);

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              color: kTheme.colorScheme.secondary,
              padding: EdgeInsets.fromLTRB(
                kSpacingX24,
                kSpacingX36,
                kSpacingX24,
                kSpacingX48,
              ),
              // child: ,
            ),
          ),
          /// back button
          Positioned(
            top: kSpacingX36,
            left: kSpacingX16,
            child: IconButton(
              icon: Icon(kBackIcon),
              color: kTheme.colorScheme.onSecondary,
              onPressed: () => context.navigator.pop(),
            ),
          ),
        ],
      ),
    );
  }
}
