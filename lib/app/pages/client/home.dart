import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:handyman/app/model/prefs_provider.dart';
import 'package:handyman/app/model/theme_provider.dart';
import 'package:handyman/app/pages/client/search.dart';
import 'package:handyman/core/constants.dart';
import 'package:handyman/core/size_config.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: Consumer<ThemeProvider>(
          builder: (_, themeProvider, __) => Consumer<PrefsProvider>(
            builder: (_, prefsProvider, __) => Stack(
              fit: StackFit.expand,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: getProportionateScreenHeight(8)),
                    GestureDetector(
                      onTap: () {},
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: getProportionateScreenWidth(16)),
                        child: Material(
                          clipBehavior: Clip.hardEdge,
                          elevation: 1,
                          type: MaterialType.card,
                          borderOnForeground: false,
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                          child: Container(
                            height: kToolbarHeight,
                            width: double.infinity,
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                              color: themeData.colorScheme.surface,
                              shape: BoxShape.rectangle,
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: getProportionateScreenWidth(4)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  icon: Icon(themeProvider.isLightTheme
                                      ? Feather.moon
                                      : Feather.sun),
                                  onPressed: () =>
                                      themeProvider.toggleTheme(context),
                                ),
                                Image.asset(
                                  kLogoAsset,
                                  height: kToolbarHeight - 8,
                                ),
                                IconButton(
                                  icon: Icon(Feather.search),
                                  onPressed: () => showSearch(
                                    context: context,
                                    delegate: SearchPage(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
