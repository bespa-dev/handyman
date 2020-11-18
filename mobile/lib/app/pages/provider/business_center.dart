import 'package:flutter/material.dart';
import 'package:handyman/core/size_config.dart';

/// Business profile page
class BusinessCenterPage extends StatefulWidget {
  @override
  _BusinessCenterPageState createState() => _BusinessCenterPageState();
}

class _BusinessCenterPageState extends State<BusinessCenterPage> {
  ThemeData _themeData;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Get the current theme
    _themeData = Theme.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: SizeConfig.screenHeight,
        width: SizeConfig.screenWidth,
        child: Stack(),
      ),
    );
  }
}
