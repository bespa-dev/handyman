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
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lite/domain/repositories/repositories.dart';
import 'package:lite/shared/shared.dart';
import 'package:meta/meta.dart';

import 'buttons.dart';

class SignOutButton extends StatelessWidget {
  final BaseAuthRepository authRepo;
  final double preferredWidth;
  final String logoutRoute;

  const SignOutButton({
    Key key,
    @required this.authRepo,
    @required this.logoutRoute,
    this.preferredWidth = double.infinity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _themeData = Theme.of(context);
    return InkWell(
      onTap: () async {
        await showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text("Leaving already?"),
            content: Text(
              kSignOutText,
            ),
            actions: [
              ButtonClear(
                text: "No",
                onPressed: () => ctx.navigator.pop(),
                themeData: _themeData,
              ),
              ButtonClear(
                text: "Yes",
                onPressed: () async {
                  await authRepo.signOut();
                  ctx.navigator.pop();
                },
                themeData: _themeData,
              ),
            ],
          ),
        );
      },
      child: Container(
        alignment: Alignment.center,
        width: double.infinity,
        height: kToolbarHeight,
        decoration: BoxDecoration(
          color: _themeData.errorColor,
        ),
        child: Text(
          "sign out".toUpperCase(),
          style: _themeData.textTheme.button,
        ),
      ),
    );
  }
}
