/*
 * Copyright (c) 2021.
 * This application is owned by HandyMan LLC,
 * developed & designed by Quabynah Codelabs LLC.
 *
 *
 * author: codelbas.quabynah@gmail.com
 */

import 'package:flutter/material.dart';

/// service ratings page
class ServiceRatingsPage extends StatefulWidget {
  @override
  _ServiceRatingsPageState createState() => _ServiceRatingsPageState();
}

class _ServiceRatingsPageState extends State<ServiceRatingsPage> {
  ThemeData kTheme;

  @override
  Widget build(BuildContext context) {
    kTheme = Theme.of(context);

    return Scaffold(
      body: Center(
        child: Text(
          'Hello',
          style: kTheme.textTheme.headline4,
        ),
      ),
    );
  }
}
