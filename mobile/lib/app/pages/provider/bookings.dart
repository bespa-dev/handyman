import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:handyman/app/model/prefs_provider.dart';
import 'package:handyman/app/routes/route.gr.dart';
import 'package:handyman/app/widget/artisan_settings_widgets.dart';
import 'package:handyman/app/widget/marker_generator.dart';
import 'package:handyman/core/constants.dart';
import 'package:handyman/core/service_locator.dart';
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
  DataService _dataService = sl.get<DataService>();
  double _kWidth = SizeConfig.screenWidth, _kHeight = SizeConfig.screenHeight;
  ThemeData _themeData;
  GoogleMapController _controller;
  var markers = <Marker>[];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _themeData = Theme.of(context);
  }

  @override
  void initState() {
    super.initState();
    if (mounted) {
      MarkerGenerator([
        Text("Hello"),
      ], (bitmaps) {
        setState(() {
          // markers = mapBitmapsToMarkers(bitmaps);
        });
      }).generate(context);

      // Listen for theme changes and update map accordingly
      Provider.of<PrefsProvider>(context, listen: false)
          .onThemeChanged
          .listen((isLightTheme) async {
        debugPrint(
            "BookingsDetailsPage.initState : Current theme value => $isLightTheme");
        final mapStyle = await getMapStyle(isLightTheme: isLightTheme);
        _controller?.setMapStyle(mapStyle);
        setState(() {});
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthService>(
      builder: (_, service, __) => Consumer<PrefsProvider>(
          builder: (_, provider, __) => Scaffold(
                key: _scaffoldKey,
                extendBody: true,
                body: StreamBuilder<Booking>(
                    initialData: widget.booking,
                    stream: _dataService.getBookingById(id: widget.booking.id),
                    builder: (_, bs) {
                      final booking = bs.data;
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
                                markers: (markers
                                      ..add(
                                        Marker(
                                          markerId: MarkerId(booking.id),
                                          position: LatLng(
                                            booking.locationLat,
                                            booking.locationLng,
                                          ),
                                          draggable: false,
                                          // icon: ,
                                        ),
                                      ))
                                    .toSet(),
                                liteModeEnabled: true,
                                myLocationButtonEnabled: true,
                                myLocationEnabled: true,
                                rotateGesturesEnabled: true,
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
                                    style:
                                        _themeData.textTheme.headline5.copyWith(
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
                                        style: _themeData.textTheme.caption
                                            .copyWith(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        "${(widget.booking.progress * 100).round()}%",
                                        style: _themeData.textTheme.caption
                                            .copyWith(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                      height: getProportionateScreenHeight(
                                          kSpacingX8)),
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
                                    onTap: () =>
                                        showNotAvailableDialog(context),
                                  ),
                                  SizedBox(
                                    height: getProportionateScreenHeight(
                                        kSpacingX16),
                                  ),
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
                floatingActionButton: FloatingActionButton(
                  child: Icon(Feather.message_circle),
                  onPressed: () => context.navigator.push(
                    Routes.conversationPage,
                    arguments: ConversationPageArguments(
                      isCustomer: provider.userType == kCustomerString,
                      recipient: widget.booking.customerId,
                    ),
                  ),
                ),
              )),
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
                    IconButton(
                      tooltip: "Toggle theme",
                      icon: Icon(
                        provider.isLightTheme ? Feather.moon : Feather.sun,
                      ),
                      onPressed: () => provider.toggleTheme(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}
