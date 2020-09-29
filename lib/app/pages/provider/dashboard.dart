import 'package:flutter/material.dart';
import 'package:handyman/app/model/theme_provider.dart';
import 'package:handyman/core/constants.dart';
import 'package:provider/provider.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(),
      extendBodyBehindAppBar: true,
      extendBody: true,
      body: Consumer<ThemeProvider>(
        builder: (_, provider, __) => Stack(
          fit: StackFit.expand,
          children: [
            provider.isLightTheme
                ? Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(kBackgroundAsset),
                  fit: BoxFit.cover,
                ),
              ),
            )
                : SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
