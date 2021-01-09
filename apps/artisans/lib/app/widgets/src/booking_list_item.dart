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

  const BookingListItem({Key key, @required this.booking}) : super(key: key);

  @override
  _BookingListItemState createState() => _BookingListItemState();
}

class _BookingListItemState extends State<BookingListItem> {
  final _userBloc = UserBloc(repo: Injection.get());

  @override
  void dispose() {
    _userBloc.close();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    if (mounted) {
      /// get customer details
      _userBloc
          .add(UserEvent.getCustomerByIdEvent(id: widget.booking.customerId));
    }
  }

  @override
  Widget build(BuildContext context) {
    final kTheme = Theme.of(context);
    final stateTextColor =
        kTheme.colorScheme.onBackground.withOpacity(kEmphasisMedium);
    final stateBgColor = widget.booking.isPending
        ? kAmberColor.withOpacity(kEmphasisLow)
        : widget.booking.isComplete
            ? kGreenColor.withOpacity(kEmphasisLow)
            : kTheme.colorScheme.error.withOpacity(kEmphasisLow);

    return BlocBuilder<UserBloc, BlocState>(
      cubit: _userBloc,
      builder: (_, userState) => userState is SuccessState<BaseUser> &&
              widget.booking != null
          ? Padding(
              padding: EdgeInsets.only(
                left: kSpacingX12,
                right: kSpacingX12,
              ),
              child: GestureDetector(
                onTap: () => context.navigator.push(
                  Routes.bookingDetailsPage,
                  arguments: BookingDetailsPageArguments(
                    booking: widget.booking,
                    customer: userState.data,
                  ),
                ),
                child: Card(
                  child: Container(
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(kSpacingX4),
                    ),
                    padding: EdgeInsets.symmetric(
                      vertical: kSpacingX8,
                      horizontal: kSpacingX4,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            /// avatar
                            UserAvatar(
                              url: userState.data.avatar,
                              radius: kSpacingX32,
                              isCircular: true,
                            ),
                            SizedBox(width: kSpacingX8),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                /// customer details
                                Padding(
                                  padding: EdgeInsets.only(bottom: kSpacingX2),
                                  child: Text(
                                    userState.data.name,
                                    style: kTheme.textTheme.bodyText1.copyWith(
                                      fontFamily:
                                          kTheme.textTheme.headline6.fontFamily,
                                    ),
                                  ),
                                ),

                                /// duration
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
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            /// cost
                            Text(
                              formatCurrency(widget.booking.cost),
                              style: kTheme.textTheme.button.copyWith(
                                color: kTheme.colorScheme.onBackground
                                    .withOpacity(kEmphasisMedium),
                              ),
                            ),

                            /// current state
                            Container(
                              height: kSpacingX24,
                              margin:
                                  EdgeInsets.symmetric(horizontal: kSpacingX8),
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
              ),
            )
          : SizedBox.shrink(),
    );
  }
}
