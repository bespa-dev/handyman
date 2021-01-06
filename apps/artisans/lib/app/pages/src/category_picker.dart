import 'package:flutter/material.dart';

class CategoryPickerPage extends StatefulWidget {
  @override
  _CategoryPickerPageState createState() => _CategoryPickerPageState();
}

class _CategoryPickerPageState extends State<CategoryPickerPage> {
  ThemeData kTheme;

  @override
  Widget build(BuildContext context) {
    kTheme = Theme.of(context);
    return Scaffold(
      body: Center(
        child: Text(
          "Category picker",
          style: kTheme.textTheme.headline4,
        ),
      ),
    );
  }
}
