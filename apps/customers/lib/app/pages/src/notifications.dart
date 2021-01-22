/*
 * Copyright (c) 2021.
 * This application is owned by HandyMan LLC,
 * developed & designed by Quabynah Codelabs LLC.
 *
 *
 * author: codelbas.quabynah@gmail.com
 */

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lite/app/bloc/bloc.dart';
import 'package:lite/app/widgets/widgets.dart';
import 'package:lite/domain/models/models.dart';
import 'package:lite/shared/shared.dart';

class NotificationsPage extends StatefulWidget {
  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  /// blocs
  final _bookingBloc = BookingBloc(repo: Injection.get());
  final _prefsBloc = PrefsBloc(repo: Injection.get());

  /// UI
  String _userId;

  @override
  void dispose() {
    _bookingBloc.close();
    _prefsBloc.close();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    if (mounted) {
      /// get user id
      _prefsBloc
        ..add(PrefsEvent.getUserIdEvent())
        ..listen((state) {
          if (state is SuccessState<String>) {
            _userId = state.data;
            if (mounted) setState(() {});
            if (state.data != null) {
              /// fetch bookings for user
              _bookingBloc
                  .add(BookingEvent.observeBookingForCustomer(id: state.data));
            }
          }
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    final kTheme = Theme.of(context);
    return BlocBuilder<BookingBloc, BlocState>(
      cubit: _bookingBloc,
      builder: (_, bookingState) => StreamBuilder<List<BaseBooking>>(
          initialData: [],
          stream: bookingState is SuccessState<Stream<List<BaseBooking>>>
              ? bookingState.data
              : Stream.empty(),
          builder: (_, snapshot) {
            final bookings = snapshot.data
                .where((item) =>
                    item.currentState == BookingState.pending().name())
                .toList();
            return CustomScrollView(
              slivers: [
                /// app bar
                CustomSliverAppBar(title: 'Notifications'),

                SliverList(
                  delegate: SliverChildListDelegate.fixed(
                    [
                      if (bookingState
                          is SuccessState<Stream<List<BaseBooking>>>) ...{
                        /// bookings
                        Padding(
                          padding: EdgeInsets.only(
                            top: kSpacingX24,
                            left: kSpacingX16,
                            bottom: kSpacingX16,
                          ),
                          child: Text(
                            'Recent Job Requests',
                            style: kTheme.textTheme.headline6.copyWith(
                              color: kTheme.colorScheme.onBackground
                                  .withOpacity(kEmphasisMedium),
                            ),
                          ),
                        ),

                        if (bookings.isEmpty) ...{
                          emptyStateUI(
                            context,
                            message: 'No recent job requests',
                            onTap: () => _bookingBloc.add(
                              BookingEvent.observeBookingForArtisan(
                                  id: _userId),
                            ),
                          ),
                        } else ...{
                          /// bookings list
                          ...bookings
                              .map((item) => BookingListItem(
                                    booking: item,
                                    shouldUpdateUI: (_) {
                                      if (_) {
                                        _bookingBloc.add(BookingEvent
                                            .observeBookingForCustomer(
                                                id: _userId));
                                      }
                                    },
                                  ))
                              .toList(),
                        },
                      },
                    ],
                  ),
                ),
              ],
            );
          }),
    );
  }
}
