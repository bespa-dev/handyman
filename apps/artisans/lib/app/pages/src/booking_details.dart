import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:handyman/app/bloc/bloc.dart';
import 'package:handyman/domain/models/models.dart';
import 'package:handyman/shared/shared.dart';

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
  /// blocs
  final _bookingBloc = BookingBloc(repo: Injection.get());

  /// UI
  ThemeData kTheme;

  @override
  void dispose() {
    _bookingBloc.close();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    if (mounted) {
      _bookingBloc.add(BookingEvent.observeBookingById(id: widget.booking.id));
    }
  }

  @override
  Widget build(BuildContext context) {
    kTheme = Theme.of(context);

    return BlocBuilder(
      cubit: _bookingBloc,
      builder: (_, bookingState) => StreamBuilder<BaseBooking>(
          stream: bookingState is SuccessState<Stream<BaseBooking>>
              ? bookingState.data
              : Stream.empty(),
          builder: (context, snapshot) {
            return Scaffold(
              body: Stack(
                children: [
                  /// back button
                  Positioned(
                    top: kSpacingX36,
                    left: kSpacingX16,
                    child: IconButton(
                      icon: Icon(kBackIcon),
                      color: kTheme.colorScheme.onPrimary,
                      onPressed: () => context.navigator.pop(),
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
