import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:handyman/app/bloc/bloc.dart';
import 'package:handyman/app/routes/routes.gr.dart';
import 'package:handyman/app/widgets/widgets.dart';
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
  final _updateBookingBloc = BookingBloc(repo: Injection.get());

  /// UI
  ThemeData kTheme;
  GoogleMapController _mapController;

  /// setup map details
  void _setupMap() async {
    /// set initial location
    await _mapController?.animateCamera(CameraUpdate.newLatLngZoom(
      LatLng(widget.booking.position.lat, widget.booking.position.lng),
      kSpacingX16,
    ));

    /// set map style
    await Future.delayed(kNoDuration);
    final mapStyle = await getMapStyle(
        isLightTheme: Theme.of(context).brightness == Brightness.light);
    await _mapController?.setMapStyle(mapStyle);
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _bookingBloc.close();
    _updateBookingBloc.close();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    if (mounted) {
      /// observe current booking
      _bookingBloc.add(BookingEvent.observeBookingById(id: widget.booking.id));
    }
  }

  @override
  Widget build(BuildContext context) {
    kTheme = Theme.of(context);

    final stateTextColor =
        kTheme.colorScheme.onBackground.withOpacity(kEmphasisMedium);
    final stateBgColor = widget.booking.isPending
        ? kAmberColor.withOpacity(kEmphasisLow)
        : widget.booking.isComplete
            ? kGreenColor.withOpacity(kEmphasisLow)
            : kTheme.colorScheme.error.withOpacity(kEmphasisLow);

    return BlocBuilder(
      cubit: _bookingBloc,
      builder: (_, bookingState) => StreamBuilder<BaseBooking>(
          stream: bookingState is SuccessState<Stream<BaseBooking>>
              ? bookingState.data
              : Stream.empty(),
          initialData: widget.booking,
          builder: (context, snapshot) {
            final booking = snapshot.data;
            final customer = widget.customer;

            /// location where request was made
            final bookingPosition =
                LatLng(booking.position.lat, booking.position.lng);
            return Scaffold(
              body: SafeArea(
                top: false,
                child: Stack(
                  children: [
                    /// content
                    Positioned.fill(
                      child: SingleChildScrollView(
                        padding: EdgeInsets.only(bottom: kSpacingX64),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (booking.hasImage) ...{
                              ImageView(
                                imageUrl: booking.imageUrl,
                                fit: BoxFit.cover,
                                height: SizeConfig.screenHeight * 0.35,
                                onTap: () =>
                                    context.navigator.pushImagePreviewPage(
                                  url: booking.imageUrl,
                                ),
                              ),
                              SizedBox(height: kSpacingX16),
                            },

                            /// request details
                            Container(
                              margin: EdgeInsets.only(
                                top: booking.hasImage
                                    ? kSpacingNone
                                    : SizeConfig.screenHeight * 0.15,
                              ),
                              padding:
                                  EdgeInsets.symmetric(horizontal: kSpacingX16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      ConstrainedBox(
                                        constraints: BoxConstraints.tightFor(
                                          width: SizeConfig.screenWidth * 0.7,
                                        ),
                                        child: Text.rich(
                                          TextSpan(
                                            children: [
                                              TextSpan(text: customer.name),
                                              TextSpan(
                                                text: "\nrequests that...",
                                                style:
                                                    kTheme.textTheme.bodyText1,
                                              ),
                                            ],
                                          ),
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                          style: kTheme.textTheme.headline5,
                                        ),
                                      ),

                                      /// current state
                                      Container(
                                        height: kSpacingX24,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: stateBgColor,
                                          borderRadius:
                                              BorderRadius.circular(kSpacingX4),
                                        ),
                                        padding: EdgeInsets.symmetric(
                                            vertical: kSpacingX4,
                                            horizontal: kSpacingX8),
                                        child: Text(
                                          booking.currentState,
                                          style:
                                              kTheme.textTheme.button.copyWith(
                                            color: stateTextColor,
                                            fontSize: kTheme
                                                .textTheme.caption.fontSize,
                                          ),
                                        ),
                                      ),
                                    ],
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                  ),
                                  SizedBox(height: kSpacingX36),
                                  Text(
                                    booking.description,
                                    style: kTheme.textTheme.bodyText1,
                                  ),

                                  /// map -> shows user's location
                                  Container(
                                    constraints: BoxConstraints.tightFor(
                                      height: SizeConfig.screenHeight * 0.3,
                                      width: SizeConfig.screenWidth,
                                    ),
                                    margin: EdgeInsets.symmetric(
                                        vertical: kSpacingX16),
                                    decoration: BoxDecoration(
                                      color: kTheme.colorScheme.onBackground,
                                      borderRadius:
                                          BorderRadius.circular(kSpacingX4),
                                    ),
                                    clipBehavior: Clip.hardEdge,
                                    child: GoogleMap(
                                      initialCameraPosition: CameraPosition(
                                        target: bookingPosition,
                                        zoom: kSpacingX16,
                                      ),
                                      zoomControlsEnabled: false,
                                      compassEnabled: true,
                                      liteModeEnabled: Platform.isAndroid,
                                      zoomGesturesEnabled: true,
                                      mapToolbarEnabled: false,
                                      myLocationButtonEnabled: false,
                                      myLocationEnabled: false,
                                      tiltGesturesEnabled: true,
                                      markers: <Marker>{
                                        Marker(
                                          markerId: MarkerId(booking.id),
                                          position: bookingPosition,
                                        ),
                                      },
                                      onMapCreated: (controller) async {
                                        _mapController = controller;
                                        _setupMap();
                                      },
                                      mapType: MapType.normal,
                                    ),
                                  ),

                                  /// metadata -> cost & timestamp
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Service charge...",
                                            style: kTheme.textTheme.caption,
                                          ),
                                          Text(
                                            "\$${booking.cost}",
                                            style: kTheme.textTheme.headline4
                                                .copyWith(color: kGreenColor),
                                          ),
                                        ],
                                      ),

                                      /// timestamp & user profile image
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                "Sent on...",
                                                style: kTheme.textTheme.caption,
                                              ),
                                              SizedBox(height: kSpacingX4),
                                              Text(
                                                parseFromTimestamp(
                                                    booking.createdAt),
                                                style: kTheme
                                                    .textTheme.bodyText2
                                                    .copyWith(
                                                  color: kTheme
                                                      .colorScheme.onBackground
                                                      .withOpacity(
                                                          kEmphasisMedium),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(width: kSpacingX8),
                                          UserAvatar(
                                            url: customer.avatar,
                                            radius: kSpacingX48,
                                            isCircular: true,
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    /// back button
                    Positioned(
                      top: kSpacingX36,
                      left: kSpacingX16,
                      child: IconButton(
                        icon: Icon(kBackIcon),
                        color: booking.hasImage
                            ? kTheme.colorScheme.background
                            : kTheme.colorScheme.onBackground,
                        onPressed: () => context.navigator.pop(),
                      ),
                    ),

                    /// action button
                    Positioned(
                      bottom: kSpacingNone,
                      child: InkWell(
                        splashColor: kTheme.splashColor,
                        onTap: () => booking.isCancelled || booking.isComplete
                            ? null
                            : showCustomDialog(
                                context: context,
                                builder: (_) => BasicDialog(
                                  message:
                                      "Do you wish to mark this service as completed?",
                                  onComplete: () {
                                    _updateBookingBloc.add(
                                      BookingEvent.updateBooking(
                                        booking: booking.copyWith(
                                          currentState:
                                              BookingState.complete().name(),
                                          dueDate:
                                              DateTime.now().toIso8601String(),
                                        ),
                                      ),
                                    );
                                    _bookingBloc.add(
                                        BookingEvent.observeBookingById(
                                            id: booking.id));
                                  },
                                ),
                              ),
                        child: Container(
                          height: kToolbarHeight,
                          width: SizeConfig.screenWidth,
                          decoration: BoxDecoration(
                            color: booking.isCancelled || booking.isComplete
                                ? kTheme.disabledColor
                                : kTheme.colorScheme.secondary,
                          ),
                          clipBehavior: Clip.hardEdge,
                          alignment: Alignment.center,
                          child: Text(
                            booking.isCancelled
                                ? "Cancelled".toUpperCase()
                                : booking.isComplete
                                    ? "Completed on ${parseFromTimestamp(booking.dueDate)}"
                                        .toUpperCase()
                                    : "Mark as complete".toUpperCase(),
                            style: kTheme.textTheme.button.copyWith(
                              color: booking.isCancelled || booking.isComplete
                                  ? kTheme.colorScheme.onBackground
                                      .withOpacity(kEmphasisLow)
                                  : kTheme.colorScheme.onSecondary,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
