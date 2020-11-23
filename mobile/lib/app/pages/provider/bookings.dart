import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:handyman/app/model/prefs_provider.dart';
import 'package:handyman/app/routes/route.gr.dart';
import 'package:handyman/app/widget/artisan_settings_widgets.dart';
import 'package:handyman/app/widget/buttons.dart';
import 'package:handyman/app/widget/marker_generator.dart';
import 'package:handyman/core/constants.dart';
import 'package:handyman/core/size_config.dart';
import 'package:handyman/data/local_database.dart';
import 'package:handyman/domain/services/auth.dart';
import 'package:handyman/domain/services/data.dart';
import 'package:meta/meta.dart';
import 'package:provider/provider.dart';

class BookingsDetailsPage extends StatefulWidget {
  final Booking booking;

  const BookingsDetailsPage({Key key, @required this.booking})
      : super(key: key);

  @override
  _BookingsDetailsPageState createState() => _BookingsDetailsPageState();
}

class _BookingsDetailsPageState extends State<BookingsDetailsPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  double _kWidth = SizeConfig.screenWidth, _kHeight = SizeConfig.screenHeight;
  ThemeData _themeData;
  GoogleMapController _controller;
  bool _isAccepted = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _themeData = Theme.of(context);

    getMapStyle(isLightTheme: _themeData.brightness == Brightness.light)
        .then((mapStyle) => _controller?.setMapStyle(mapStyle));
  }

  @override
  void initState() {
    super.initState();
    if (mounted) {
      MarkerGenerator([
        Text("Hello"),
      ], (bitmaps) {
        setState(() {});
      }).generate(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthService>(
      builder: (_, service, __) => Consumer<PrefsProvider>(
        builder: (_, provider, __) => Scaffold(
          key: _scaffoldKey,
          extendBody: true,
          body: Consumer<DataService>(
            builder: (_, dataService, __) => StreamBuilder<Booking>(
                initialData: widget.booking,
                stream: dataService.getBookingById(id: widget.booking.id),
                builder: (_, bs) {
                  final booking = bs.data;
                  _isAccepted = booking?.isAccepted ?? false;
                  return Stack(
                    fit: StackFit.expand,
                    children: [
                      provider.isLightTheme
                          ? Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(kBackgroundAsset),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )
                          : SizedBox.shrink(),
                      Positioned(
                        height: _kHeight * 0.45,
                        width: _kWidth,
                        child: Container(
                          height: _kHeight * 0.45,
                          width: _kWidth,
                          child: GoogleMap(
                            initialCameraPosition: CameraPosition(
                              target: LatLng(
                                booking.locationLat,
                                booking.locationLng,
                              ),
                              zoom: 16.0,
                            ),
                            mapToolbarEnabled: false,
                            buildingsEnabled: true,
                            compassEnabled: false,
                            indoorViewEnabled: false,
                            markers: Set.from(
                              [
                                Marker(
                                  markerId: MarkerId(booking.id),
                                  position: LatLng(
                                    booking.locationLat,
                                    booking.locationLng,
                                  ),
                                  draggable: false,
                                  // icon: ,
                                ),
                              ],
                            ),
                            trafficEnabled: true,
                            zoomControlsEnabled: false,
                            zoomGesturesEnabled: true,
                            onMapCreated: (controller) async {
                              setState(() {
                                _controller = controller;
                              });
                            },
                          ),
                        ),
                      ),
                      Positioned(
                        width: _kWidth,
                        top: _kHeight * 0.43,
                        bottom: kSpacingNone,
                        child: Container(
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                            color: _themeData.cardColor,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(kSpacingX24),
                              topRight: Radius.circular(kSpacingX24),
                            ),
                          ),
                          padding: EdgeInsets.only(
                            top: getProportionateScreenHeight(kSpacingX16),
                          ),
                          height: _kHeight,
                          width: _kWidth,
                          child: ListView(
                            padding: EdgeInsets.symmetric(
                              horizontal:
                                  getProportionateScreenWidth(kSpacingX24),
                              vertical:
                                  getProportionateScreenHeight(kSpacingX16),
                            ),
                            children: [
                              Text(
                                widget.booking.reason,
                                style: _themeData.textTheme.headline5.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                  height: getProportionateScreenHeight(
                                      kSpacingX16)),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Overall progress",
                                    style:
                                        _themeData.textTheme.caption.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "${(widget.booking.progress * 100).round()}%",
                                    style:
                                        _themeData.textTheme.caption.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                  height:
                                      getProportionateScreenHeight(kSpacingX8)),
                              LinearProgressIndicator(
                                minHeight: kSpacingX4,
                                value: widget.booking.progress,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  _themeData.colorScheme.primary,
                                ),
                                backgroundColor: _themeData.disabledColor
                                    .withOpacity(kEmphasisLow),
                              ),
                              SizedBox(
                                  height: getProportionateScreenHeight(
                                      kSpacingX16)),
                              buildProfileDescriptor(
                                context,
                                themeData: _themeData,
                                title: "Description",
                                isEditable: false,
                                content: widget.booking.description,
                                onTap: () => showNotAvailableDialog(context),
                              ),
                              booking.imageUrl == null
                                  ? SizedBox.shrink()
                                  : Column(
                                      children: [
                                        SizedBox(
                                          height: getProportionateScreenHeight(
                                              kSpacingX16),
                                        ),
                                        AnimatedContainer(
                                          width: _kWidth,
                                          height: _kHeight * 0.2,
                                          duration: kScaleDuration,
                                          clipBehavior: Clip.hardEdge,
                                          padding: EdgeInsets.fromLTRB(
                                            getProportionateScreenWidth(
                                                kSpacingX16),
                                            getProportionateScreenHeight(
                                                kSpacingX8),
                                            getProportionateScreenWidth(
                                                kSpacingX16),
                                            getProportionateScreenHeight(
                                                kSpacingX8),
                                          ),
                                          decoration: BoxDecoration(
                                            color: _themeData
                                                .scaffoldBackgroundColor
                                                .withOpacity(kEmphasisLow),
                                            borderRadius: BorderRadius.circular(
                                                kSpacingX16),
                                            border: Border.all(
                                                color: _themeData.disabledColor
                                                    .withOpacity(kEmphasisLow)),
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text("Image",
                                                  style: _themeData
                                                      .textTheme.headline6),
                                              SizedBox(
                                                height:
                                                    getProportionateScreenHeight(
                                                        kSpacingX8),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  context.navigator.push(
                                                    Routes.photoPreviewPage,
                                                    arguments:
                                                        PhotoPreviewPageArguments(
                                                      imageUrl:
                                                          booking.imageUrl,
                                                    ),
                                                  );
                                                },
                                                child: CachedNetworkImage(
                                                  imageUrl: booking.imageUrl,
                                                  fit: BoxFit.cover,
                                                  width: _kWidth,
                                                  height: _kHeight * 0.14,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                              SizedBox(
                                height:
                                    getProportionateScreenHeight(kSpacingX16),
                              ),
                              _isAccepted
                                  ? _buildJobWidget(
                                      provider, booking, dataService)
                                  : _buildActionsWidget(
                                      provider, booking, dataService),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: kSpacingNone,
                        width: _kWidth,
                        child: _buildAppBar(provider),
                      ),
                    ],
                  );
                }),
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar(PrefsProvider provider) => SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: getProportionateScreenHeight(kSpacingX8),
          ),
          color: _themeData.scaffoldBackgroundColor.withOpacity(kOpacityX14),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: _kWidth,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      tooltip: "Go back",
                      icon: Icon(Feather.x),
                      onPressed: () => context.navigator.pop(),
                    ),
                    Row(
                      children: [
                        IconButton(
                          tooltip: "Toggle theme",
                          icon: Icon(
                            provider.isLightTheme ? Feather.moon : Feather.sun,
                          ),
                          onPressed: () => provider.toggleTheme(),
                        ),
                        IconButton(
                            icon: Icon(Feather.message_circle),
                            onPressed: () => context.navigator.push(
                                  Routes.conversationPage,
                                  arguments: ConversationPageArguments(
                                    isCustomer: true,
                                    recipient: widget.booking.customerId,
                                  ),
                                ))
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );

  Widget _buildJobWidget(
          PrefsProvider provider, Booking booking, DataService service) =>
      Column(
        children: [
          ButtonOutlined(
            width: _kWidth,
            themeData: _themeData,
            onTap: () {
              ScaffoldMessenger.of(context)
                ..removeCurrentSnackBar()
                ..showSnackBar(SnackBar(
                  content: Text("Task completed successfully"),
                ));
              context.navigator.pop();
              service.updateBooking(
                booking: booking.copyWith(
                  progress: 1.0,
                  dueDate: DateTime.now().millisecondsSinceEpoch,
                ),
              );
            },
            label: "Mark as complete",
          ),
        ],
      );

  Widget _buildActionsWidget(
          PrefsProvider provider, Booking booking, DataService service) =>
      Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ButtonPrimary(
              width: _kWidth * 0.4,
              themeData: _themeData,
              onTap: () {
                service.updateBooking(
                  booking: booking.copyWith(isAccepted: true),
                );
                _isAccepted = true;
                setState(() {});
              },
              label: "Accept",
            ),
            ButtonPrimary(
              width: _kWidth * 0.4,
              themeData: _themeData,
              color: _themeData.colorScheme.error,
              textColor: _themeData.colorScheme.onError,
              onTap: () {
                context.navigator.pop();
                service.deleteBooking(booking: booking);
              },
              label: "Decline",
            ),
          ],
        ),
      );
}
