import 'package:flutter/material.dart';
import 'package:handyman/data/entities/booking.dart';
import 'package:handyman/data/local_database.dart';
import 'package:meta/meta.dart';

/// [Booking] card item
class BookingCardItem extends StatefulWidget {
  final Booking booking;
  final Function onTap;
  final BookingType bookingType;

  const BookingCardItem({
    Key key,
    @required this.booking,
    @required this.onTap,
    @required this.bookingType,
  }) : super(key: key);

  @override
  _BookingCardItemState createState() => _BookingCardItemState();
}

class _BookingCardItemState extends State<BookingCardItem> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
