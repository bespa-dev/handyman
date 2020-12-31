import 'package:flutter/material.dart';
import 'package:lite/shared/shared.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          kAppName,
          style: Theme.of(context).textTheme.headline4,
        ),
      ),
    );
  }
}
