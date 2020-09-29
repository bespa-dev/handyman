import 'package:flutter/material.dart';
import 'package:handyman/app/model/theme_provider.dart';
import 'package:handyman/core/constants.dart';
import 'package:provider/provider.dart';

class AccountSelectionPage extends StatefulWidget {
  @override
  _AccountSelectionPageState createState() => _AccountSelectionPageState();
}

class _AccountSelectionPageState extends State<AccountSelectionPage> {
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
