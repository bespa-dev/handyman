import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lite/app/bloc/bloc.dart';
import 'package:lite/app/widgets/src/loaders.dart';
import 'package:lite/app/widgets/widgets.dart';
import 'package:lite/domain/models/models.dart';
import 'package:lite/shared/shared.dart';

class BookingDetailsPage extends StatefulWidget {
  const BookingDetailsPage({
    Key key,
    @required this.booking,
    @required this.customer,
    this.bookingId,
  }) : super(key: key);

  final BaseBooking booking;
  final String bookingId;
  final BaseUser customer;

  @override
  _BookingDetailsPageState createState() => _BookingDetailsPageState();
}

class _BookingDetailsPageState extends State<BookingDetailsPage> {
  /// blocs
  final _bookingBloc = BookingBloc(repo: Injection.get());
  final _updateBookingBloc = BookingBloc(repo: Injection.get());
  final _locationBloc = LocationBloc(repo: Injection.get());
  final _userBloc = UserBloc(repo: Injection.get());
  final _categoryBloc = CategoryBloc(repo: Injection.get());
  final _serviceBloc = ArtisanServiceBloc(repo: Injection.get());

  /// UI
  ThemeData kTheme;
  String _mapUrl;
  bool _bookingHasUpdated = false;

  @override
  void dispose() {
    _bookingBloc.close();
    _updateBookingBloc.close();
    _locationBloc.close();
    _userBloc.close();
    _serviceBloc.close();
    _categoryBloc.close();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    if (mounted) {
      _userBloc
          .add(UserEvent.getArtisanByIdEvent(id: widget.booking.artisanId));

      /// get service details
      _serviceBloc.add(
          ArtisanServiceEvent.getServiceById(id: widget.booking.serviceType));

      /// observe current booking
      _bookingBloc.add(BookingEvent.observeBookingById(
          id: widget.bookingId ?? widget.booking.id));

      _updateBookingBloc.listen((state) {
        if (state is SuccessState) {
          _bookingBloc.add(BookingEvent.observeBookingById(
              id: widget.booking?.id ?? widget.bookingId));
          _bookingHasUpdated = true;
        }
      });

      /// get current location of user
      _locationBloc
        ..add(LocationEvent.getCurrentLocation())
        ..listen((state) {
          if (state is SuccessState<BaseLocationMetadata>) {
            final origin = '${state.data.lat},${state.data.lng}';
            final destination =
                '${widget.booking.position.lat},${widget.booking.position.lng}';
            logger.i('Route -> $origin => $destination');

            /// https://developers.google.com/maps/documentation/urls/get-started#forming-the-url
            _mapUrl = Uri.encodeFull(
                'https://www.google.com/maps/dir/?api=1&origin=$origin&destination=$destination');
            logger.d(_mapUrl);
            if (mounted) setState(() {});
          }
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    kTheme = Theme.of(context);

    return WillPopScope(
      onWillPop: () {
        context.navigator.pop(_bookingHasUpdated);
        return Future<bool>.value(true);
      },
      child: BlocBuilder<ArtisanServiceBloc, BlocState>(
        cubit: _serviceBloc,
        builder: (_, serviceState) => BlocBuilder<UserBloc, BlocState>(
          cubit: _userBloc,
          builder: (_, userState) => userState is SuccessState<BaseArtisan> &&
                  serviceState is SuccessState<BaseArtisanService>
              ? BlocBuilder(
                  cubit: _bookingBloc,
                  builder: (_, bookingState) => StreamBuilder<BaseBooking>(
                      stream: bookingState is SuccessState<Stream<BaseBooking>>
                          ? bookingState.data
                          : Stream.empty(),
                      initialData: widget.booking,
                      builder: (context, snapshot) {
                        var booking = snapshot.data;
                        var artisan = userState.data;
                        var service = serviceState.data;

                        var stateTextColor = widget.booking.isCancelled
                            ? kCancelledJobTextColor
                            : widget.booking.isComplete
                                ? kCompletedJobTextColor
                                : kPendingJobTextColor;
                        var stateBgColor = widget.booking.isCancelled
                            ? kCancelledJobColor
                            : widget.booking.isComplete
                                ? kCompletedJobColor
                                : kPendingJobColor;

                        return Scaffold(
                          appBar: AppBar(
                            title: Text(booking.isComplete
                                ? 'Job Details'
                                : 'Due on ${parseFromTimestamp(booking.dueDate)}'),
                            centerTitle: true,
                            leading: IconButton(
                              icon: Icon(kCloseIcon),
                              onPressed: () => context.navigator.pop(),
                            ),
                          ),
                          body: SafeArea(
                            top: true,
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                /// top panel
                                Positioned(
                                  top: kSpacingNone,
                                  left: kSpacingNone,
                                  right: kSpacingNone,
                                  child: Container(
                                    alignment: Alignment.center,
                                    margin:
                                        EdgeInsets.only(bottom: kSpacingX12),
                                    width: SizeConfig.screenWidth,
                                    padding: EdgeInsets.symmetric(
                                      horizontal: kSpacingX12,
                                      vertical: kSpacingX6,
                                    ),
                                    decoration:
                                        BoxDecoration(color: stateBgColor),
                                    child: Text(
                                      booking.currentState.toUpperCase(),
                                      style: kTheme.textTheme.button
                                          .copyWith(color: stateTextColor),
                                    ),
                                  ),
                                ),

                                /// content
                                Positioned.fill(
                                  child: SingleChildScrollView(
                                    padding: EdgeInsets.only(
                                      top: kToolbarHeight,
                                      right: kSpacingX12,
                                      left: kSpacingX12,
                                      bottom: kSpacingX24,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        /// user card
                                        if (artisan != null &&
                                            service != null) ...{
                                          _buildUserCard(
                                              artisan, service, booking),
                                        },

                                        if (booking.position != null) ...{
                                          _buildJobCard(booking, artisan),
                                        },

                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(
                                                left: kSpacingX16,
                                                right: kSpacingX16,
                                                top: kSpacingX12,
                                                bottom: kSpacingX8,
                                              ),
                                              child: Text(
                                                'Job description',
                                                style:
                                                    kTheme.textTheme.headline6,
                                              ),
                                            ),
                                            _buildDescriptionCard(
                                                booking, service),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                                /// bottom bar
                                Positioned(
                                  bottom: kSpacingNone,
                                  left: kSpacingNone,
                                  right: kSpacingNone,
                                  height: kToolbarHeight,
                                  child: InkWell(
                                    splashColor: kTheme.splashColor,
                                    onTap: () async {
                                      await showCustomDialog(
                                        context: context,
                                        builder: (_) => BasicDialog(
                                          message:
                                              'Do you wish to cancel this job request?',
                                          onComplete: () {
                                            booking = booking.copyWith(
                                                currentState: booking.isPending
                                                    ? BookingState.complete()
                                                        .name()
                                                    : BookingState.cancelled()
                                                        .name());
                                            setState(() {});
                                            _updateBookingBloc.add(
                                                BookingEvent.updateBooking(
                                                    booking: booking));
                                          },
                                        ),
                                      );
                                    },
                                    child: Material(
                                      child: booking.currentState ==
                                              BookingState.none().name()
                                          ? Container(
                                              color: kTheme.colorScheme.error,
                                              alignment: Alignment.center,
                                              child: Text(
                                                'Cancel request'.toUpperCase(),
                                                style: kTheme.textTheme.button
                                                    .copyWith(
                                                  color: kTheme
                                                      .colorScheme.onError,
                                                ),
                                              ),
                                            )
                                          : booking.isComplete
                                              ? SizedBox.shrink()
                                              : Container(
                                                  width: SizeConfig.screenWidth,
                                                  color: kTheme
                                                      .colorScheme.background,
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [],
                                                  ),
                                                ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      }),
                )
              : Loading(),
        ),
      ),
    );
  }

  Widget _buildJobCard(BaseBooking booking, BaseArtisan artisan) => Card(
        child: Padding(
          padding: const EdgeInsets.all(kSpacingX12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  /// address
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Address'.toUpperCase(),
                        style: kTheme.textTheme.headline6.copyWith(
                          fontSize: kTheme.textTheme.bodyText2.fontSize,
                        ),
                      ),
                      SizedBox(height: kSpacingX4),
                      Text(
                        booking.position.name,
                        style: kTheme.textTheme.bodyText1.copyWith(
                          color: kTheme.textTheme.bodyText1.color
                              .withOpacity(kEmphasisLow),
                        ),
                      ),
                    ],
                  ),

                  GestureDetector(
                    onTap: () => launchUrl(url: _mapUrl),
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: kTheme.colorScheme.secondary
                            .withOpacity(kEmphasisMedium),
                      ),
                      padding: EdgeInsets.all(kSpacingX8),
                      child: Icon(
                        kLocationIcon,
                        size: kSpacingX20,
                      ),
                    ),
                  ),
                ],
              ),
              Divider(height: kSpacingX20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Contact'.toUpperCase(),
                        style: kTheme.textTheme.headline6.copyWith(
                          fontSize: kTheme.textTheme.bodyText2.fontSize,
                        ),
                      ),
                      SizedBox(height: kSpacingX4),
                      Text(
                        artisan.phone ?? 'Not available',
                        style: kTheme.textTheme.bodyText1.copyWith(
                          color: kTheme.textTheme.bodyText1.color
                              .withOpacity(kEmphasisLow),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: kTheme.colorScheme.secondary
                          .withOpacity(kEmphasisMedium),
                    ),
                    padding: EdgeInsets.all(kSpacingX8),
                    child: Icon(
                      kCallIcon,
                      size: kSpacingX20,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );

  Widget _buildUserCard(BaseArtisan artisan, BaseArtisanService service,
          BaseBooking booking) =>
      BlocBuilder<CategoryBloc, BlocState>(
        cubit: _categoryBloc
          ..add(CategoryEvent.observeCategoryById(id: artisan.category)),
        builder: (_, state) => Card(
          child: Padding(
            padding: const EdgeInsets.all(kSpacingX12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    UserAvatar(url: artisan.avatar, isCircular: true),
                    SizedBox(width: kSpacingX8),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          artisan.name ?? 'Anonymous',
                          style: kTheme.textTheme.headline6.copyWith(
                            fontSize: kTheme.textTheme.bodyText2.fontSize,
                          ),
                        ),
                        if (service != null) ...{
                          SizedBox(height: kSpacingX4),
                          StreamBuilder<BaseServiceCategory>(
                            stream: state
                                    is SuccessState<Stream<BaseServiceCategory>>
                                ? state.data
                                : Stream.empty(),
                            builder: (_, snapshot) => Text(
                              snapshot.hasData ? snapshot.data.name : '...',
                              style: kTheme.textTheme.bodyText1.copyWith(
                                color: kTheme.textTheme.bodyText1.color
                                    .withOpacity(kEmphasisLow),
                              ),
                            ),
                          ),
                        }
                      ],
                    ),
                  ],
                ),
                Text(
                  formatCurrency(booking.cost),
                  style: kTheme.textTheme.button.copyWith(
                    fontSize: kTheme.textTheme.headline5.fontSize,
                    color:
                        kTheme.colorScheme.secondary.withOpacity(kEmphasisHigh),
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  Widget _buildDescriptionCard(
          BaseBooking booking, BaseArtisanService service) =>
      Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: kSpacingX16, vertical: kSpacingX12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                service.name,
                style: kTheme.textTheme.headline6.copyWith(
                  fontSize: kTheme.textTheme.subtitle1.fontSize,
                ),
              ),
              Divider(height: kSpacingX16),
              Text(
                'Remarks'.toUpperCase(),
                style: kTheme.textTheme.headline6.copyWith(
                  fontSize: kTheme.textTheme.bodyText2.fontSize,
                ),
              ),
              SizedBox(height: kSpacingX8),
              Text(
                booking.description,
                style: kTheme.textTheme.bodyText1.copyWith(
                  color: kTheme.colorScheme.onBackground
                      .withOpacity(kEmphasisMedium),
                ),
              ),
              if (booking.hasImage) ...{
                Divider(height: kSpacingX16),
                Text(
                  'Attachments'.toUpperCase(),
                  style: kTheme.textTheme.headline6.copyWith(
                    fontSize: kTheme.textTheme.bodyText2.fontSize,
                  ),
                ),
                SizedBox(height: kSpacingX8),
                ImageView(
                  imageUrl: booking.imageUrl,
                  height: kSpacingX96,
                  width: kSpacingX96,
                  radius: kSpacingX8,
                  tag: booking.imageUrl,
                  onTap: () => context.navigator.pushImagePreviewPage(
                    url: booking.imageUrl,
                  ),
                ),
              }
            ],
          ),
        ),
      );
}
