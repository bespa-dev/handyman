import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:handyman/app/model/prefs_provider.dart';
import 'package:handyman/app/widget/marker_generator.dart';
import 'package:handyman/core/constants.dart';
import 'package:handyman/core/service_locator.dart';
import 'package:handyman/core/size_config.dart';
import 'package:handyman/data/local_database.dart';
import 'package:handyman/domain/services/auth.dart';
import 'package:handyman/domain/services/data.dart';
import 'package:provider/provider.dart';
import 'package:meta/meta.dart';
import 'package:auto_route/auto_route.dart';

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
  double _kWidth, _kHeight;
  ThemeData _themeData;
  var markers = <Marker>[];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _themeData = Theme.of(context);
    final size = MediaQuery.of(context).size;
    _kWidth = size.width;
    _kHeight = size.height;
  }

  @override
  void initState() {
    super.initState();
    MarkerGenerator([
      Text("Hello"),
    ], (bitmaps) {
      setState(() {
        // markers = mapBitmapsToMarkers(bitmaps);
      });
    }).generate(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      extendBody: true,
      body: Consumer<AuthService>(
        builder: (_, service, __) => Consumer<PrefsProvider>(
          builder: (_, provider, __) => StreamBuilder<Booking>(
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
                      height: getProportionateScreenHeight(kSpacingX360),
                      width: _kWidth,
                      child: Container(
                        height: getProportionateScreenHeight(kSpacingX360),
                        width: _kWidth,
                        child: GoogleMap(
                          initialCameraPosition: CameraPosition(
                            target: LatLng(
                              booking.locationLat,
                              booking.locationLng,
                            ),
                            zoom: 16.0,
                          ),
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
                          liteModeEnabled:
                              defaultTargetPlatform == TargetPlatform.android,
                          myLocationButtonEnabled: true,
                          myLocationEnabled: true,
                          rotateGesturesEnabled: true,
                          trafficEnabled: true,
                          zoomControlsEnabled: false,
                          zoomGesturesEnabled: true,
                          onMapCreated: (controller) async {
                            final mapStyle = await getMapStyle();
                            controller.setMapStyle(mapStyle);
                            setState(() {});
                          },
                        ),
                      ),
                    ),
                    Positioned(
                      width: _kWidth,
                      top: getProportionateScreenHeight(kSpacingX320),
                      bottom: kSpacingNone,
                      child: ListView(
                        padding: EdgeInsets.zero,
                        children: [
                          Container(
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                              color: kGreenColor,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(kSpacingX24),
                                topRight: Radius.circular(kSpacingX24),
                              ),
                            ),
                            height: _kHeight,
                            width: _kWidth,
                          ),
                        ],
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
    );
  }

  Widget _buildAppBar(PrefsProvider provider) => SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: getProportionateScreenHeight(kSpacingX8),
          ),
          color: _themeData.scaffoldBackgroundColor.withOpacity(kOpacityX50),
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
