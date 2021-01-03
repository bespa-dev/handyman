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
import 'package:handyman/shared/shared.dart';

class ExpandedAppBarContainer extends StatelessWidget {
  final String title;
  final Widget child;
  final Widget actionButton;
  final bool showNavIcon;

  const ExpandedAppBarContainer({
    Key key,
    @required this.title,
    @required this.child,
    this.showNavIcon = false,
    this.actionButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final kTheme = Theme.of(context);
    return SafeArea(
      child: Column(
        children: [
          Material(
            type: MaterialType.card,
            elevation: kSpacingX2,
            child: Container(
              width: SizeConfig.screenWidth,
              padding: EdgeInsets.only(
                top: kSpacingX24,
                bottom: kSpacingX16,
                left: kSpacingX4,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (showNavIcon) ...{
                    IconButton(
                      icon: Icon(kBackIcon),
                      color: kTheme.colorScheme.onBackground,
                      onPressed: () {
                        context.navigator.pop();
                      },
                    )
                  } else ...{
                    SizedBox(height: kSpacingX24, width: kSpacingX24),
                  },
                  Container(
                    margin: EdgeInsets.only(left: kSpacingX12),
                    alignment: Alignment.bottomLeft,
                    child: Text(title,
                        style: kTheme.textTheme.headline6.copyWith(
                          fontWeight: FontWeight.w600,
                        )),
                  ),
                  if (actionButton != null) ...{
                    actionButton,
                  } else ...{
                    SizedBox(height: kSpacingX24, width: kSpacingX24),
                  },
                ],
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(child: child),
          ),
        ],
      ),
    );
  }
}
