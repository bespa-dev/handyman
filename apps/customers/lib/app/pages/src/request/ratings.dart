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

/// todo -> service ratings page
class ServiceRatingsPage extends StatefulWidget {
  const ServiceRatingsPage({Key key, @required this.payload}) : super(key: key);

  final dynamic payload;

  @override
  _ServiceRatingsPageState createState() => _ServiceRatingsPageState();
}

class _ServiceRatingsPageState extends State<ServiceRatingsPage> {
  ThemeData kTheme;

  @override
  Widget build(BuildContext context) {
    kTheme = Theme.of(context);

    return Scaffold(
      body: Container(
        width: SizeConfig.screenWidth,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Hello',
              style: kTheme.textTheme.headline4,
            ),
            Text(
              widget.payload?.toString() ?? 'no data',
              style: kTheme.textTheme.bodyText2,
            ),
          ],
        ),
      ),
    );
  }
}
