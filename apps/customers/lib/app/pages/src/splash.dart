import 'package:flutter/material.dart';
import 'package:lite/app/widgets/src/buttons.dart';
import 'package:lite/shared/shared.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final kTheme = Theme.of(context);

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
          vertical: kSpacingX24,
          horizontal: kSpacingX36,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Spacer(flex: 1),
            Text(
              kAppName,
              textAlign: TextAlign.center,
              style: kTheme.textTheme.headline4,
            ),
            SizedBox(height: kSpacingX8),
            Text(
              kAppSloganDesc,
              textAlign: TextAlign.center,
              style: kTheme.textTheme.subtitle1,
            ),
            Spacer(flex: 4),
            ButtonPrimary(
              width: SizeConfig.screenWidth * 0.8,
              themeData: kTheme,
              onTap: () {},
              label: "Get Started",
            ),
            Spacer(flex: 1),
          ],
        ),
      ),
    );
  }
}
