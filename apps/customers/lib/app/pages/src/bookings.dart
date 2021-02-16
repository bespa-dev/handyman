/*
 * Copyright (c) 2021.
 * This application is owned by HandyMan LLC,
 * developed & designed by Quabynah Codelabs LLC.
 *
 *
 * author: codelbas.quabynah@gmail.com
 */

import 'package:flutter/material.dart';
import 'package:lite/app/bloc/bloc.dart';
import 'package:lite/app/widgets/widgets.dart';
import 'package:lite/domain/models/models.dart';
import 'package:lite/shared/shared.dart';

class BookingsPage extends StatefulWidget {
  @override
  _BookingsPageState createState() => _BookingsPageState();
}

class _BookingsPageState extends State<BookingsPage> {
  /// blocs
  final _bookingBloc = BookingBloc(repo: Injection.get());
  final _updateBookingBloc = BookingBloc(repo: Injection.get());
  final _prefsBloc = PrefsBloc(repo: Injection.get());

  var _bookings = <BaseBooking>[];

  /// UI
  ThemeData _kTheme;
  String _userId;

  @override
  void dispose() {
    _prefsBloc.close();
    _bookingBloc.close();
    _updateBookingBloc.close();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    if (mounted) {
      _prefsBloc
        ..add(PrefsEvent.getUserIdEvent())
        ..listen((state) {
          if (state is SuccessState<String>) {
            _userId = state.data;
            if (mounted) setState(() {});
            if (_userId != null) {
              _bookingBloc
                  .add(BookingEvent.observeBookingForCustomer(id: _userId));
            }
          }
        });

      _bookingBloc.listen((state) {
        if (state is SuccessState<Stream<List<BaseBooking>>>) {
          state.data.listen((event) async {
            _bookings = event.where((element) => !element.isCancelled).toList();
            if (mounted) setState(() {});
          });
        } else if (state is SuccessState<void>) {
          if (mounted) setState(() {});
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    _kTheme = Theme.of(context);

    return SafeArea(
      top: true,
      bottom: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: kSpacingX8),
            height: kToolbarHeight,
            width: SizeConfig.screenWidth,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(kCloseIcon),
                  onPressed: () => context.navigator.canPop()
                      ? context.navigator.pop()
                      : null,
                ),
                Text('My Bookings', style: _kTheme.textTheme.headline6),
                IconButton(
                  icon: Icon(kTrashIcon),
                  onPressed: () async => await showCustomDialog(
                    context: context,
                    builder: (_) => BasicDialog(
                      message: 'Do you wish to cancel all job requests?',
                      onComplete: () {
                        _bookings
                          ..forEach((element) {
                            element = element.copyWith(
                                currentState: BookingState.cancelled().name());
                            _updateBookingBloc.add(
                                BookingEvent.updateBooking(booking: element));
                          });
                        _bookingBloc.add(BookingEvent.observeBookingForCustomer(
                            id: _userId));
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (_, index) => BookingListItem(
                booking: _bookings[index],
                shouldUpdateUI: (reload) {
                  if (reload) setState(() {});
                },
              ),
              itemCount: _bookings.length,
            ),
          ),
        ],
      ),
    );
  }
}
