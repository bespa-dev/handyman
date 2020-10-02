import 'package:flutter/material.dart';
import 'package:handyman/data/local_database.dart';

class RequestBookingPage extends StatefulWidget {
  final Artisan artisan;

  const RequestBookingPage({Key key, this.artisan}) : super(key: key);
  @override
  _RequestBookingPageState createState() => _RequestBookingPageState();
}

class _RequestBookingPageState extends State<RequestBookingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(widget.artisan.name ?? "no name found"),
      ),
    );
  }
}
