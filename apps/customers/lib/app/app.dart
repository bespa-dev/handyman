import 'package:flutter/material.dart';
import 'package:lite/shared/shared.dart';

/// application instance -> entry point
class LiteApp extends StatefulWidget {
  @override
  _LiteAppState createState() => _LiteAppState();
}

class _LiteAppState extends State<LiteApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: kAppName,
      debugShowCheckedModeBanner: false,
      theme: themeData(context),
      darkTheme: darkThemeData(context),
    );
  }
}
