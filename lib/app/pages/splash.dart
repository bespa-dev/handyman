import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:handyman/app/model/theme_provider.dart';
import 'package:handyman/app/widget/buttons.dart';
import 'package:handyman/core/constants.dart';
import 'package:handyman/core/size_config.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    // Must be called on initial page
    SizeConfig().init(context);
    ThemeData themeData = Theme.of(context);

    return Consumer<ThemeProvider>(
      builder: (_, theme, child) => Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              icon: Icon(theme.isLightTheme ? Feather.moon : Feather.sun),
              color: themeData.iconTheme.color,
              onPressed: () => theme.toggleTheme(),
            )
          ],
        ),
        body: Container(
          width: double.infinity,
          child: Column(
            children: [
              Text(
                kAppName,
                style: themeData.textTheme.headline3,
              ),
              SizedBox(height: getProportionateScreenHeight(8)),
              Text(
                kAppSlogan,
                style: themeData.textTheme.bodyText1,
              ),
              SizedBox(height: getProportionateScreenHeight(24)),
              AspectRatio(
                aspectRatio: 1,
                child: Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(64),
                  ),
                  decoration: BoxDecoration(
                      color: themeData.colorScheme.surface,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, 0),
                          color: kShadowColor.withOpacity(0.14),
                          blurRadius: 64,
                        ),
                      ]),
                  child: Icon(
                    Icons.handyman_outlined,
                    size: getProportionateScreenHeight(96),
                  ),
                ),
              ),
              SizedBox(height: getProportionateScreenHeight(16)),
              ButtonPrimary(
                icon: Icons.arrow_right_alt,
                width: getProportionateScreenWidth(250),
                themeData: themeData,
                onTap: () {},
                label: "Get started",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
