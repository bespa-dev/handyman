import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:handyman/app/bloc/bloc.dart';
import 'package:handyman/app/routes/routes.gr.dart';
import 'package:handyman/app/widgets/widgets.dart';
import 'package:handyman/domain/models/models.dart';
import 'package:handyman/shared/shared.dart';
import 'package:meta/meta.dart';

class BookingListItem extends StatefulWidget {
  final BaseBooking booking;
  final Function onLongPress;

  const BookingListItem({Key key, @required this.booking, this.onLongPress})
      : super(key: key);

  @override
  _BookingListItemState createState() => _BookingListItemState();
}

class _BookingListItemState extends State<BookingListItem> {
  final _userBloc = UserBloc(repo: Injection.get());
  final _locationBloc = LocationBloc(repo: Injection.get());

  @override
  void dispose() {
    _userBloc.close();
    _locationBloc.close();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    if (mounted) {
      /// get customer details
      _userBloc
          .add(UserEvent.getCustomerByIdEvent(id: widget.booking.customerId));

      /// get request location details
      _locationBloc.add(
          LocationEvent.getLocationName(location: widget.booking.position));
    }
  }

  @override
  Widget build(BuildContext context) {
    final kTheme = Theme.of(context);
    final stateTextColor =
        kTheme.colorScheme.onBackground.withOpacity(kEmphasisMedium);
    final stateBgColor = widget.booking.isPending
        ? kAmberColor.withOpacity(kEmphasisMedium)
        : widget.booking.isComplete
            ? kGreenColor.withOpacity(kEmphasisMedium)
            : kTheme.colorScheme.error.withOpacity(kEmphasisLow);

    return BlocBuilder<UserBloc, BlocState>(
      cubit: _userBloc,
      builder: (_, userState) => userState is SuccessState<BaseUser> &&
              widget.booking != null
          ? Padding(
              padding: EdgeInsets.only(
                left: kSpacingX12,
                right: kSpacingX12,
                bottom: kSpacingX8,
              ),
              child: InkWell(
                splashColor: kTheme.splashColor,
                borderRadius: BorderRadius.circular(kSpacingX4),
                onLongPress: () => widget.onLongPress(),
                onTap: () => context.navigator.push(
                  Routes.bookingDetailsPage,
                  arguments: BookingDetailsPageArguments(
                    booking: widget.booking,
                    customer: userState.data,
                  ),
                ),
                child: Container(
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(kSpacingX4),
                    border: Border.all(
                      color: kTheme.colorScheme.onBackground
                          .withOpacity(kEmphasisLow),
                      width: 0.5,
                    ),
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: kSpacingX8,
                    horizontal: kSpacingX8,
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              /// avatar
                              UserAvatar(
                                url: userState.data.avatar,
                                radius: kSpacingX42,
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  left: kSpacingX8,
                                  bottom: kSpacingX2,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      userState.data.name,
                                      style:
                                          kTheme.textTheme.bodyText1.copyWith(
                                        fontFamily: kTheme
                                            .textTheme.headline6.fontFamily,
                                      ),
                                    ),
                                    SizedBox(height: kSpacingX4),
                                    BlocBuilder<LocationBloc, BlocState>(
                                      cubit: _locationBloc,
                                      builder: (_, locationState) =>
                                          locationState is SuccessState<String>
                                              ? Text(
                                                  locationState.data,
                                                  style: kTheme
                                                      .textTheme.caption
                                                      .copyWith(
                                                    fontFamily: kTheme.textTheme
                                                        .headline6.fontFamily,
                                                  ),
                                                )
                                              : SizedBox.shrink(),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          /// cost
                          Text(
                            formatCurrency(widget.booking.cost),
                            style: kTheme.textTheme.button.copyWith(
                              color: kTheme.colorScheme.onBackground
                                  .withOpacity(kEmphasisMedium),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: kSpacingX12),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          /// duration
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                kHistoryIcon,
                                size: kSpacingX16,
                                color: kTheme.colorScheme.onBackground
                                    .withOpacity(kEmphasisLow),
                              ),
                              SizedBox(width: kSpacingX8),
                              Text.rich(
                                TextSpan(children: [
                                  TextSpan(
                                      text: parseFromTimestamp(
                                          widget.booking.createdAt)),
                                  TextSpan(text: "\t\u2192\t"),
                                  TextSpan(
                                      text: parseFromTimestamp(
                                          widget.booking.dueDate)),
                                ]),
                                style: kTheme.textTheme.caption,
                              ),
                            ],
                          ),

                          /// current state
                          Container(
                            height: kSpacingX24,
                            margin: EdgeInsets.only(left: kSpacingX8),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: stateBgColor,
                              borderRadius: BorderRadius.circular(kSpacingX4),
                            ),
                            padding: EdgeInsets.symmetric(
                                vertical: kSpacingX4, horizontal: kSpacingX8),
                            child: Text(
                              widget.booking.currentState,
                              style: kTheme.textTheme.button.copyWith(
                                color: stateTextColor,
                                fontSize: kTheme.textTheme.caption.fontSize,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            )
          : SizedBox.shrink(),
    );
  }
}
