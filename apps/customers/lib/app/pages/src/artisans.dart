/*
 * Copyright (c) 2021.
 * This application is owned by HandyMan LLC,
 * developed & designed by Quabynah Codelabs LLC.
 *
 *
 * author: codelbas.quabynah@gmail.com
 */

import 'package:flutter/material.dart';

class ArtisansPage extends StatefulWidget {
  @override
  _ArtisansPageState createState() => _ArtisansPageState();
}

class _ArtisansPageState extends State<ArtisansPage> {
  @override
  Widget build(BuildContext context) {
    final kTheme = Theme.of(context);
    return Center(
      child: Text("Artisans", style: kTheme.textTheme.headline4),
    );
  }
}
