import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:handyman/app/bloc/bloc.dart';
import 'package:handyman/app/routes/routes.gr.dart';
import 'package:handyman/app/widgets/src/service_list_item.dart';
import 'package:handyman/domain/models/models.dart';
import 'package:handyman/shared/shared.dart';

/// todo -> complete other tabs
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
  final _updateUserBloc = UserBloc(repo: Injection.get());
  final _businessBloc = BusinessBloc(repo: Injection.get());
  final _updateBusinessBloc = BusinessBloc(repo: Injection.get());
  final _locationBloc = LocationBloc(repo: Injection.get());
  final _serviceBloc = ArtisanServiceBloc(repo: Injection.get());

  /// UI
  ThemeData _kTheme;
  GoogleMapController _mapController;
  BaseBusiness _business;
  LatLng _businessLocation;
  int _currentPage = 0;
  BaseArtisan _currentUser;
  List<BaseArtisanService> _servicesForCategory = const [];
  List<String> _selectedServices = [];

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
    _businessBloc.close();
    _updateBusinessBloc.close();
    _locationBloc.close();
    _serviceBloc.close();
    _updateUserBloc.close();
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
              if (_currentUser.services == null) {
                _currentUser =
                    _currentUser.copyWith(services: _selectedServices);
                _updateUserBloc.add(
                  UserEvent.updateUserEvent(user: _currentUser),
                );
              } else
                _selectedServices = _currentUser.services;
              if (mounted) setState(() {});

              /// get services for category
              _serviceBloc.add(
                ArtisanServiceEvent.getArtisanServices(
                  category:
                      user.category /*"bb7c0d03-add2-49cb-bdd5-9a55f67adb30"*/,
                ),
              );
            });
          }
        });

      /// observe list of services for category
      _serviceBloc.listen((state) {
        if (state is SuccessState<List<BaseArtisanService>>) {
          _servicesForCategory = state.data;
          if (mounted) setState(() {});
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
                return CustomScrollView(
                  slivers: [
                    /// app bar
                    SliverAppBar(
                      actions: [
                        IconButton(
                          icon: Icon(kEditIcon),
                          onPressed: () => context.navigator
                              .pushBusinessProfilePage(business: _business),
                        ),
                      ],
                      floating: true,
                      flexibleSpace: FlexibleSpaceBar(
                        collapseMode: CollapseMode.parallax,
                        stretchModes: [
                          StretchMode.zoomBackground,
                          StretchMode.blurBackground,
                        ],
                      ),
                      leading: IconButton(
                        icon: Icon(kBackIcon),
                        onPressed: () => context.navigator.pop(),
                      ),
                    ),

                    /// content
                    SliverList(
                      delegate: SliverChildListDelegate.fixed(
                        [
                          /// map
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
                                  : FutureBuilder(
                                      future: Future.delayed(kSheetDuration),
                                      builder: (_, __) => GoogleMap(
                                            initialCameraPosition:
                                                CameraPosition(
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
                                                markerId:
                                                    MarkerId(_business.id),
                                                position: _businessLocation,
                                                icon: BitmapDescriptor
                                                    .defaultMarkerWithHue(
                                                        BitmapDescriptor
                                                            .hueGreen),
                                              ),
                                            },
                                            onMapCreated: (controller) async {
                                              _mapController = controller;
                                              _setupMap();
                                            },
                                            mapType: MapType.normal,
                                          )),
                            ),
                          ),

                          /// body
                          AnimatedPadding(
                            duration: kScaleDuration,
                            padding: EdgeInsets.only(
                              top: _businessLocation == null
                                  ? kSpacingX24
                                  : kSpacingX16,
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

                                /// tabs
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

                                /// pages
                                if (_currentPage == 0) ...{
                                  _buildServicesTab()
                                } else if (_currentPage == 1) ...{
                                  _buildBusinessProfileTab()
                                } else ...{
                                  _buildEarningsTab()
                                },
                              ],
                            ),
                          ),
                        ],
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
        padding: EdgeInsets.only(bottom: kSpacingX16, top: kSpacingX24),
        child: InkWell(
          splashColor: kTransparent,
          borderRadius:
              BorderRadius.circular(active ? kSpacingX24 : kSpacingNone),
          onTap: () {
            _currentPage = index;
            setState(() {});
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
  Widget _buildServicesTab() => Container(
    color: kGreenColor,

  );

  /// business profile tab
  Widget _buildBusinessProfileTab() => Container(/*color: kAmberColor*/);

  /// earnings tab
  Widget _buildEarningsTab() => Container(/*color: _kTheme.colorScheme.error*/);
}
