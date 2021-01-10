import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:handyman/app/bloc/bloc.dart';
import 'package:handyman/app/routes/routes.gr.dart';
import 'package:handyman/domain/models/models.dart';
import 'package:handyman/shared/shared.dart';

class BusinessDetailsPage extends StatefulWidget {
  final BaseBusiness business;
  final BaseArtisan artisan;

  const BusinessDetailsPage({
    Key key,
    @required this.business,
    this.artisan,
  }) : super(key: key);

  @override
  _BusinessDetailsPageState createState() => _BusinessDetailsPageState();
}

class _BusinessDetailsPageState extends State<BusinessDetailsPage> {
  /// blocs
  final _userBloc = UserBloc(repo: Injection.get());
  final _categoryBloc = CategoryBloc(repo: Injection.get());
  final _businessBloc = BusinessBloc(repo: Injection.get());
  final _updateBusinessBloc = BusinessBloc(repo: Injection.get());
  final _locationBloc = LocationBloc(repo: Injection.get());

  /// UI
  ThemeData _kTheme;
  GoogleMapController _mapController;
  final _pageController = PageController();
  BaseBusiness _business;
  LatLng _businessLocation;
  int _currentPage = 0;
  BaseArtisan _currentUser;

  /// setup map details
  void _setupMap() async {
    /// set initial location
    await _mapController?.animateCamera(
        CameraUpdate.newLatLngZoom(_businessLocation, kSpacingX16));

    /// set map style
    await Future.delayed(kNoDuration);
    final mapStyle = await getMapStyle(
        isLightTheme: Theme.of(context).brightness == Brightness.light);
    await _mapController?.setMapStyle(mapStyle);
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _userBloc.close();
    _categoryBloc.close();
    _businessBloc.close();
    _updateBusinessBloc.close();
    _locationBloc.close();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    if (mounted) {
      /// get business for artisan
      _businessBloc.add(
        BusinessEvent.observeBusinessById(id: widget.business.id),
      );

      /// get location coordinates from name
      _locationBloc
        ..add(LocationEvent.getLocationCoordinates(
            address: widget.business.location))
        ..listen((state) {
          if (state is SuccessState<BaseLocationMetadata> &&
              state.data != null) {
            _businessLocation = LatLng(state.data.lat, state.data.lng);
            if (mounted) setState(() {});
          }
        });

      /// observe current user
      _userBloc
        ..add(UserEvent.currentUserEvent())
        ..listen((state) {
          if (state is SuccessState<Stream<BaseArtisan>>) {
            state.data.listen((user) {
              _currentUser = user;
              if (mounted) setState(() {});

              /// get category for user
              _categoryBloc
                  .add(CategoryEvent.observeCategoryById(id: user.category));
            });
          }
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    _kTheme = Theme.of(context);

    return Scaffold(
      body: BlocBuilder<BusinessBloc, BlocState>(
          cubit: _businessBloc,
          builder: (_, state) => StreamBuilder<BaseBusiness>(
              initialData: widget.business,
              stream: state is SuccessState<Stream<BaseBusiness>>
                  ? state.data
                  : Stream.value(widget.business),
              builder: (_, snapshot) {
                _business = snapshot.data;
                return Stack(
                  fit: StackFit.expand,
                  children: [
                    /// content
                    Positioned.fill(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AnimatedContainer(
                              duration: kScaleDuration,
                              width: SizeConfig.screenWidth,
                              height: _businessLocation == null
                                  ? kSpacingNone
                                  : SizeConfig.screenHeight * 0.3,
                              child: AnimatedOpacity(
                                duration: kScaleDuration,
                                opacity: _businessLocation == null ? 0 : 1,
                                child: _businessLocation == null
                                    ? SizedBox.shrink()
                                    : GoogleMap(
                                        initialCameraPosition: CameraPosition(
                                          target: _businessLocation,
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
                                            markerId: MarkerId(_business.id),
                                            position: _businessLocation,
                                            icon: BitmapDescriptor
                                                .defaultMarkerWithHue(
                                                    BitmapDescriptor.hueGreen),
                                          ),
                                        },
                                        onMapCreated: (controller) async {
                                          _mapController = controller;
                                          _setupMap();
                                        },
                                        mapType: MapType.normal,
                                      ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                top: kSpacingX16,
                                left: kSpacingX16,
                                right: kSpacingX16,
                                bottom: kSpacingNone,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.business.name,
                                    style: _kTheme.textTheme.headline5,
                                  ),
                                  SizedBox(height: kSpacingX8),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(kLocationIcon, size: kSpacingX12),
                                      SizedBox(width: kSpacingX6),
                                      Text(
                                        widget.business.location,
                                        style: _kTheme.textTheme.bodyText1,
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: kSpacingX24),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      _buildTabItem(
                                        title: "Services",
                                        index: 0,
                                        active: _currentPage == 0,
                                      ),
                                      _buildTabItem(
                                        title: "Profile",
                                        index: 1,
                                        active: _currentPage == 1,
                                      ),
                                      _buildTabItem(
                                        title: "Earnings",
                                        index: 2,
                                        active: _currentPage == 2,
                                      ),
                                    ],
                                  ),
                                  // Form(
                                  //   child: Container(
                                  //     padding: EdgeInsets.symmetric(
                                  //       horizontal: kSpacingX16,
                                  //     ),
                                  //     decoration: BoxDecoration(
                                  //       color: kTheme.disabledColor,
                                  //       borderRadius: BorderRadius.circular(kSpacingX12),
                                  //     ),
                                  //     clipBehavior: Clip.hardEdge,
                                  //     child: TextFormField(
                                  //       controller: _priceController,
                                  //       decoration: InputDecoration(
                                  //         hintText: hintText,
                                  //         border: InputBorder.none,
                                  //         fillColor: kTheme.disabledColor,
                                  //         filled: true,
                                  //       ),
                                  //     ),
                                  //   ),
                                  // ),
                                  Container(
                                    width: SizeConfig.screenWidth,
                                    height: SizeConfig.screenHeight * 0.75,
                                    child: PageView.builder(
                                      physics: NeverScrollableScrollPhysics(),
                                      itemBuilder: (_, index) {
                                        return index == 0
                                            ? _buildServicesTab()
                                            : index == 1
                                                ? _buildBusinessProfileTab()
                                                : _buildEarningsTab();
                                      },
                                      controller: _pageController,
                                      onPageChanged: (index) {
                                        _currentPage = index;
                                        setState(() {});
                                      },
                                    ),
                                  ),
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
                        onPressed: () => context.navigator.pop(),
                      ),
                    ),

                    /// edit button
                    Positioned(
                      top: kSpacingX36,
                      right: kSpacingX16,
                      child: IconButton(
                        icon: Icon(kEditIcon),
                        onPressed: () => context.navigator
                            .pushBusinessProfilePage(business: _business),
                      ),
                    ),
                  ],
                );
              })),
    );
  }

  /// tab item
  Widget _buildTabItem(
          {@required String title, @required int index, bool active = false}) =>
      Padding(
        padding: EdgeInsets.only(bottom: kSpacingX24),
        child: InkWell(
          splashColor: kTransparent,
          borderRadius:
              BorderRadius.circular(active ? kSpacingX24 : kSpacingNone),
          onTap: () {
            _pageController.animateToPage(
              index,
              duration: kSheetDuration,
              curve: Curves.fastLinearToSlowEaseIn,
            );
          },
          child: AnimatedContainer(
            duration: kScaleDuration,
            width: SizeConfig.screenWidth * 0.25,
            height: kSpacingX36,
            decoration: BoxDecoration(
              border: Border.all(
                color: active ? _kTheme.colorScheme.onBackground : kTransparent,
              ),
              borderRadius:
                  BorderRadius.circular(active ? kSpacingX24 : kSpacingNone),
            ),
            alignment: Alignment.center,
            child: Text(
              title,
              style: _kTheme.textTheme.button.copyWith(
                color: active
                    ? _kTheme.colorScheme.onBackground
                    : _kTheme.colorScheme.onBackground
                        .withOpacity(kEmphasisLow),
              ),
            ),
          ),
        ),
      );

  /// services tab
  Widget _buildServicesTab() => Container(color: kGreenColor);

  /// business profile tab
  Widget _buildBusinessProfileTab() => Container(color: kAmberColor);

  /// earnings tab
  Widget _buildEarningsTab() => Container(color: _kTheme.colorScheme.error);
}
