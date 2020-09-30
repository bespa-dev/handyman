import 'package:flutter/material.dart';
import 'package:handyman/app/model/theme_provider.dart';
import 'package:handyman/core/constants.dart';
import 'package:provider/provider.dart';

class SearchPage extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) => <Widget>[];

  @override
  Widget buildLeading(BuildContext context) => IconButton(
        icon: Icon(Icons.keyboard_backspace),
        onPressed: () => this.close(context, []),
      );

  @override
  Widget buildResults(BuildContext context) {
    return Column();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Column();
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    var isLightTheme = Provider.of<ThemeProvider>(context).isLightTheme;
    // FIXME: Fix theme
    return isLightTheme
        ? ThemeData.light().copyWith(
            // primaryColor: kPrimaryColor,
            // primaryColorBrightness: Brightness.dark,
          )
        : ThemeData.dark();
  }
}
