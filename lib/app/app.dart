import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:handyman/app/model/theme_provider.dart';
import 'package:handyman/app/routes/route.gr.dart' as gr;
import 'package:handyman/core/theme.dart';
import 'package:provider/provider.dart';

class HandyManApp extends StatefulWidget {
  @override
  _HandyManAppState createState() => _HandyManAppState();
}

class _HandyManAppState extends State<HandyManApp> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ThemeProvider>(
      create: (context) => ThemeProvider(),
      child: Consumer<ThemeProvider>(
        builder: (context, theme, child) => MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: themeData(context),
          darkTheme: darkThemeData(context),
          themeMode: theme.isLightTheme ? ThemeMode.light : ThemeMode.dark,
          builder: ExtendedNavigator<gr.Router>(
            router: gr.Router(),
            guards: [],
          ),
        ),
      ),
    );
  }
}
