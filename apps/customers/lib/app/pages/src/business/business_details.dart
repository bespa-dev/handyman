import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lite/app/bloc/bloc.dart';
import 'package:lite/app/widgets/widgets.dart';
import 'package:lite/domain/models/models.dart';
import 'package:lite/shared/shared.dart';
import 'package:sliding_sheet/sliding_sheet.dart';

/// fixme -> show relevant prices for each service
class BusinessDetailsPage extends StatefulWidget {
  const BusinessDetailsPage({
    Key key,
    @required this.business,
    this.artisan,
  }) : super(key: key);

  final BaseBusiness business;
  final BaseArtisan artisan;

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
  final _storageBloc = StorageBloc(repo: Injection.get());

  /// UI
  ThemeData _kTheme;
  GoogleMapController _mapController;
  BaseBusiness _business;
  LatLng _businessLocation;
  int _currentPage = 0;
  var _servicesForCategory = const <BaseArtisanService>[];
  final _sheetController = SheetController();

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
    _storageBloc.close();
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

      /// get services for category
      if (widget.artisan.category != null) {
        _serviceBloc.add(ArtisanServiceEvent.getArtisanServices(
            category: widget.artisan.category));
      }

      /// observe list of services for category
      _serviceBloc.listen((state) {
        if (state is SuccessState<List<BaseArtisanService>>) {
          _servicesForCategory = state.data;
          if (mounted) setState(() {});
          if (_sheetController.state != null &&
              _sheetController.state.isShown) {
            _sheetController.rebuild();
          }
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
              : widget.business.asStream(),
          builder: (_, snapshot) {
            _business = snapshot.data;
            return CustomScrollView(
              slivers: [
                /// app bar
                SliverAppBar(
                  expandedHeight: _businessLocation == null
                      ? kSpacingNone
                      : SizeConfig.screenHeight * 0.35,
                  floating: true,
                  flexibleSpace: FlexibleSpaceBar(
                    collapseMode: CollapseMode.parallax,
                    stretchModes: [
                      StretchMode.zoomBackground,
                      StretchMode.blurBackground,
                    ],
                    background: _businessLocation == null
                        ? SizedBox.shrink()
                        : SizedBox(
                            width: SizeConfig.screenWidth,
                            height: SizeConfig.screenHeight * 0.35,
                            child: GoogleMap(
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
                                  icon: BitmapDescriptor.defaultMarkerWithHue(
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
                  leading: IconButton(
                    icon: Icon(kBackIcon),
                    onPressed: () => context.navigator.pop(),
                  ),
                ),

                /// content
                SliverList(
                  delegate: SliverChildListDelegate.fixed(
                    [
                      /// body
                      Padding(
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
                            TabSelector(
                              tabs: ['Services', 'Gallery'],
                              activeIndex: _currentPage,
                              onTabChanged: (index) =>
                                  setState(() => _currentPage = index),
                            ),

                            /// pages
                            AnimatedContainer(
                              duration: kScaleDuration,
                              child: _currentPage == 0
                                  ? _buildServicesTab()
                                  : _buildBusinessGalleryTab(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  /// services tab
  Widget _buildServicesTab() => Padding(
        padding: EdgeInsets.only(left: kSpacingX4),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// fixme -> artisan services
            /*if (widget.artisan != null &&
                widget.artisan.services != null &&
                widget.artisan.services.isNotEmpty) ...{
              Text(
                'Services rendered',
                style: _kTheme.textTheme.headline6.copyWith(
                  color: _kTheme.colorScheme.onBackground
                      .withOpacity(kEmphasisMedium),
                ),
              ),
              SizedBox(height: kSpacingX4),
              Text(
                'Tap to view more details',
                style: _kTheme.textTheme.caption.copyWith(
                  color: _kTheme.colorScheme.onBackground
                      .withOpacity(kEmphasisLow),
                ),
              ),
              SizedBox(height: kSpacingX24),
              ...widget.artisan.services.map(
                (id) {
                  var service = _servicesForCategory
                      .firstWhere((element) => element.id == id);
                  return ArtisanServiceListTile(
                    service: service,
                    showLeadingIcon: false,
                    selected: false,
                    showPrice: true,
                  );
                },
              ).toList(),
              SizedBox(height: SizeConfig.screenHeight * 0.1),
            } else ...{
              Container(
                height: SizeConfig.screenHeight * 0.35,
                width: SizeConfig.screenWidth,
                padding: EdgeInsets.symmetric(horizontal: kSpacingX24),
                child: emptyStateUI(context, message: 'No services registered'),
              ),
            }*/
          ],
        ),
      );

  /// business gallery tab
  Widget _buildBusinessGalleryTab() => Container(
        height: SizeConfig.screenHeight * 0.35,
        width: SizeConfig.screenWidth,
        padding: EdgeInsets.symmetric(horizontal: kSpacingX24),
        child:
            emptyStateUI(context, icon: kImageIcon, message: 'No images added'),
      );
}
