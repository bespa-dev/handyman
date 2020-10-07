import 'package:flutter/material.dart';
import 'package:handyman/core/service_locator.dart';
import 'package:handyman/domain/services/data.dart';
import 'package:meta/meta.dart';

class SearchPage extends StatefulWidget {


  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _dataService = sl.get<DataService>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  double _kWidth, _kHeight;
  ThemeData _themeData;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _themeData = Theme.of(context);
    final size = MediaQuery.of(context).size;
    _kWidth = size.width;
    _kHeight = size.height;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
    );
  }
}
