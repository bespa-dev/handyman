import 'package:flutter/material.dart';
import 'package:handyman/domain/models/models.dart';

class CategoryDetailsPage extends StatefulWidget {
  final BaseServiceCategory category;

  const CategoryDetailsPage({Key key, @required this.category})
      : super(key: key);

  @override
  _CategoryDetailsPageState createState() => _CategoryDetailsPageState();
}

class _CategoryDetailsPageState extends State<CategoryDetailsPage> {
  ThemeData kTheme;

  @override
  Widget build(BuildContext context) {
    kTheme = Theme.of(context);
    return Scaffold(
      body: Center(
        child: Text(
          "Category details",
          style: kTheme.textTheme.headline4,
        ),
      ),
    );
  }
}
