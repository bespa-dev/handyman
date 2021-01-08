import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:handyman/app/bloc/bloc.dart';
import 'package:handyman/app/routes/routes.gr.dart';
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
      /// todo -> change to getCustomerByIdEvent
      _userBloc
          .add(UserEvent.getArtisanByIdEvent(id: widget.booking.customerId));
    }
  }

  @override
  Widget build(BuildContext context) {
    final kTheme = Theme.of(context);

    return BlocBuilder<UserBloc, BlocState>(
      cubit: _userBloc,
      builder: (_, userState) => Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(),
        padding: EdgeInsets.symmetric(horizontal: kSpacingX16),
        margin: EdgeInsets.only(bottom: kSpacingX12),
        child: userState is SuccessState<BaseUser>
            ? InkWell(
                onTap: () => context.navigator.push(
                  Routes.bookingDetailsPage,
                  arguments: BookingDetailsPageArguments(
                    booking: widget.booking,
                    customer: userState.data,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Quabynah Bilson",
                      style: kTheme.textTheme.bodyText1.copyWith(
                        fontFamily: kTheme.textTheme.headline6.fontFamily,
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "\$1250",
                          style: kTheme.textTheme.button.copyWith(
                            color: kTheme.colorScheme.onBackground
                                .withOpacity(kEmphasisMedium),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: kSpacingX8),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: kTheme.colorScheme.secondary
                                .withOpacity(kEmphasisLow),
                            borderRadius: BorderRadius.circular(kSpacingX4),
                          ),
                          padding: EdgeInsets.symmetric(
                              vertical: kSpacingX4, horizontal: kSpacingX8),
                          child: Text(
                            "Paid",
                            style: kTheme.textTheme.button.copyWith(
                              color: kTheme.colorScheme.onBackground
                                  .withOpacity(kEmphasisMedium),
                              fontSize: kTheme.textTheme.caption.fontSize,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            : SizedBox.shrink(),
      ),
    );
  }
}
