import 'package:flutter/material.dart';
import 'package:handyman/domain/models/models.dart';

class BookingDetailsPage extends StatefulWidget {
  final BaseBooking booking;
  final BaseUser customer;

  const BookingDetailsPage({
    Key key,
    @required this.booking,
    @required this.customer,
  }) : super(key: key);

  @override
  _BookingDetailsPageState createState() => _BookingDetailsPageState();
}

class _BookingDetailsPageState extends State<BookingDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
