import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:handyman/app/bloc/bloc.dart';
import 'package:handyman/app/routes/routes.gr.dart';
import 'package:handyman/domain/models/models.dart';
import 'package:handyman/shared/shared.dart';
import 'package:meta/meta.dart';

class BookingListItem extends StatefulWidget {
  const BookingListItem(
      {Key key, @required this.booking, this.shouldUpdateUI, this.onLongPress})
      : super(key: key);

  final BaseBooking booking;
  final Function onLongPress;
  final Function(bool) shouldUpdateUI;

  @override
  _BookingListItemState createState() => _BookingListItemState();
}

class _BookingListItemState extends State<BookingListItem> {
  /// blocs
  final _userBloc = UserBloc(repo: Injection.get());
  final _locationBloc = LocationBloc(repo: Injection.get());
  final _bookingBloc = BookingBloc(repo: Injection.get());
  final _serviceBloc = ArtisanServiceBloc(repo: Injection.get());

  BaseUser _customer;

  @override
  void dispose() {
    _userBloc.close();
    _locationBloc.close();
    _bookingBloc.close();
    _serviceBloc.close();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    if (mounted) {
      _userBloc
        ..add(UserEvent.getCustomerByIdEvent(id: widget.booking.customerId))
        ..add(UserEvent.getArtisanByIdEvent(id: widget.booking.artisanId))
        ..listen((state) {
          if (state is SuccessState<BaseUser> && !(state.data is BaseArtisan)) {
            _customer = state.data;
            if (mounted) setState(() {});
          }
        });

      /// get request location details
      _locationBloc.add(
          LocationEvent.getLocationName(location: widget.booking.position));

      /// observe booking state
      _bookingBloc.add(BookingEvent.observeBookingById(id: widget.booking.id));

      /// get service details
      _serviceBloc.add(
          ArtisanServiceEvent.getServiceById(id: widget.booking.serviceType));
    }
  }

  @override
  Widget build(BuildContext context) {
    final kTheme = Theme.of(context);
    final userTextColor =
    kTheme.colorScheme.onBackground.withOpacity(kEmphasisHigh);
    final stateTextColor = widget.booking.isCancelled
        ? kCancelledJobTextColor
        : widget.booking.isComplete
        ? kCompletedJobTextColor
        : kPendingJobTextColor;
    final stateBgColor = widget.booking.isCancelled
        ? kCancelledJobColor
        : widget.booking.isComplete
        ? kCompletedJobColor
        : kPendingJobColor;

    var booking = widget.booking;

    return Padding(
      padding: const EdgeInsets.only(
        left: kSpacingX16,
        right: kSpacingX16,
        bottom: kSpacingX12,
      ),
      child: InkWell(
        onTap: () => context.navigator.pushBookingDetailsPage(
          booking: booking,
          customer: _customer,
          bookingId: booking.id,
        ),
        child: BlocBuilder<ArtisanServiceBloc, BlocState>(
          cubit: _serviceBloc,
          builder: (_, serviceState) => BlocBuilder<UserBloc, BlocState>(
            cubit: _userBloc,
            builder: (_, userState) => userState is SuccessState<BaseArtisan> &&
                widget.booking != null
                ? Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                color: kTheme.cardColor,
                borderRadius: BorderRadius.circular(kSpacingX4),
              ),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: kSpacingX12),
                    width: SizeConfig.screenWidth,
                    padding: EdgeInsets.symmetric(
                      horizontal: kSpacingX12,
                      vertical: kSpacingX6,
                    ),
                    decoration: BoxDecoration(color: stateBgColor),
                    child: Text(
                      booking.currentState.toUpperCase(),
                      style: kTheme.textTheme.button
                          .copyWith(color: stateTextColor),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: kSpacingX8,
                      vertical: kSpacingX4,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              userState.data.name ?? 'Anonymous',
                              style: kTheme.textTheme.headline6.copyWith(
                                fontSize:
                                kTheme.textTheme.bodyText2.fontSize,
                                color: userTextColor,
                              ),
                            ),
                            SizedBox(height: kSpacingX4),
                            serviceState
                            is SuccessState<BaseArtisanService>
                                ? Text(
                              serviceState.data.name ?? '...',
                              style: kTheme.textTheme.bodyText1
                                  .copyWith(
                                color: kTheme
                                    .textTheme.bodyText1.color
                                    .withOpacity(kEmphasisLow),
                              ),
                            )
                                : SizedBox.shrink(),
                          ],
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              parseFromTimestamp(booking.dueDate),
                              style: kTheme.textTheme.bodyText1.copyWith(
                                color: kTheme.textTheme.bodyText1.color
                                    .withOpacity(kEmphasisLow),
                              ),
                            ),
                            SizedBox(height: kSpacingX4),
                            Text(
                              parseFromTimestamp(booking.dueDate,
                                  isChatFormat: true),
                              style: kTheme.textTheme.button.copyWith(
                                fontSize:
                                kTheme.textTheme.bodyText2.fontSize,
                                color: userTextColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
                : SizedBox.shrink(),
          ),
        ),
      ),
    );
  }
}
