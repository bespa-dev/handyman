/*
 * Copyright (c) 2021.
 * This application is owned by HandyMan LLC,
 * developed & designed by Quabynah Codelabs LLC.
 *
 *
 * author: codelbas.quabynah@gmail.com
 */

import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lite/app/bloc/bloc.dart';
import 'package:lite/app/widgets/widgets.dart';
import 'package:lite/data/entities/entities.dart';
import 'package:lite/domain/models/models.dart';
import 'package:lite/shared/shared.dart';

class RequestPage extends StatefulWidget {
  final BaseArtisan artisan;

  const RequestPage({
    Key key,
    @required this.artisan,
  }) : super(key: key);

  @override
  _RequestPageState createState() => _RequestPageState();
}

class _RequestPageState extends State<RequestPage> {
  /// blocs
  final _bookingBloc = BookingBloc(repo: Injection.get());
  final _businessBloc = BusinessBloc(repo: Injection.get());
  final _prefsBloc = PrefsBloc(repo: Injection.get());
  final _storageBloc = StorageBloc(repo: Injection.get());
  final _locationBloc = LocationBloc(repo: Injection.get());
  final _serviceBloc = ArtisanServiceBloc(repo: Injection.get());

  /// form
  final _formKey = GlobalKey<FormState>();
  final _bodyController = TextEditingController();
  FocusNode _focusNode;

  /// map
  GoogleMapController _mapController;
  LocationMetadata _location;

  /// file
  File _imageFile;
  String _fileUrl;

  /// UI
  int _currentPage = 0, _numPages = 3;
  final _pageController = PageController();
  String _userId, _timestamp = DateTime.now().millisecondsSinceEpoch.toString();
  bool _complete = false, _isRequesting = false;
  List<BaseArtisanService> _servicesForCategory = const [];
  BaseArtisanService _selectedService;
  ThemeData kTheme;

  /// request service
  void _requestService() {
    if (_formKey.currentState == null) return;
    if (_formKey.currentState.validate() &&
        _location != null &&
        _selectedService != null) {
      _formKey.currentState.save();
      /// todo
      // _bookingBloc.add(
      //   BookingEvent.requestBooking(
      //     artisan: widget.artisan.id,
      //     customer: _userId,
      //     category: widget.artisan.category,
      //     description: _bodyController.text?.trim(),
      //     image: _fileUrl,
      //     cost: 12.99,
      //     location: _location,
      //   ),
      // );
    } else
      showSnackBarMessage(context,
          message:
              "Please select a service and fill in any required details first");
  }

  /// setup map details
  void _setupMap() async {
    /// set initial location
    await _mapController?.animateCamera(CameraUpdate.newLatLngZoom(
        LatLng(_location.lat, _location.lng), kSpacingX16));

    /// set map style
    await Future.delayed(kNoDuration);
    final mapStyle = await getMapStyle(
        isLightTheme: Theme.of(context).brightness == Brightness.light);
    await _mapController?.setMapStyle(mapStyle);
    if (mounted) setState(() {});
  }

  /// pick & upload file
  void _pickImage() async {
    var picker = ImagePicker();
    PickedFile pickedFile;
    await showCustomDialog(
        context: context,
        builder: (_) {
          return MenuItemPickerDialog(
              title: "Select source",
              onComplete: (_) async {
                logger.d("Item -> ${_.title}");
                if (_.icon == kGalleryIcon)
                  pickedFile =
                      await picker.getImage(source: ImageSource.gallery);
                else
                  pickedFile =
                      await picker.getImage(source: ImageSource.camera);

                if (pickedFile != null) {
                  _imageFile = File(pickedFile.path);
                  if (mounted) setState(() {});
                  /// todo
                  // _storageBloc.add(StorageEvent.uploadFile(
                  //     path: _timestamp,
                  //     filePath: pickedFile.path,
                  //     isImage: true));
                }
              },
              items: [
                PickerMenuItem(
                  title: "Camera",
                  icon: kCameraIcon,
                ),
                PickerMenuItem(
                  title: "Gallery",
                  icon: kGalleryIcon,
                ),
              ]);
        });
  }

  @override
  void dispose() {
    _bookingBloc.close();
    _businessBloc.close();
    _prefsBloc.close();
    _storageBloc.close();
    _locationBloc.close();
    _serviceBloc.close();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    if (mounted) {
      _focusNode = FocusNode();

      /// get business profiles
      _businessBloc.add(
          BusinessEvent.getBusinessesForArtisan(artisanId: widget.artisan.id));

      /// get services for category
      _serviceBloc
        ..add(
          ArtisanServiceEvent.getArtisanServices(
            category: widget.artisan.category,
          ),
        )
        ..listen((state) {
          if (state is SuccessState<List<BaseArtisanService>>) {
            _servicesForCategory = state.data;
            // if (state.data.isNotEmpty) _selectedService = state.data[0];
            if (mounted) setState(() {});
          }
        });

      /// get location
      _locationBloc
        ..add(LocationEvent.getCurrentLocation())
        ..listen((state) {
          if (state is SuccessState<BaseLocationMetadata> &&
              state.data != null) {
            _location = state.data;
            if (mounted) setState(() {});
          }
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    kTheme = Theme.of(context);
    bool isLastPage = _currentPage == _numPages - 1;

    return Scaffold(
      body: _location == null
          ? Loading()
          : Stack(
              fit: StackFit.expand,
              children: [
                /// pages
                Positioned.fill(
                  child: PageView.builder(
                      controller: _pageController,
                      onPageChanged: (index) =>
                          setState(() => _currentPage = index),
                      itemBuilder: (_, index) {
                        switch (index) {
                          case 0:
                            return _buildServicePicker();
                          case 1:
                            return _buildLocationPicker();
                          default:
                            return _buildRequestDescription();
                        }
                      },
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: _numPages),
                ),

                /// back button
                Positioned(
                  top: kSpacingX36,
                  left: kSpacingX16,
                  child: IconButton(
                    icon: Icon(kBackIcon),
                    color: kTheme.colorScheme.onBackground,
                    onPressed: _handleBackPressed,
                  ),
                ),

                /// page indicator
                Positioned(
                  top: kSpacingX56,
                  right: kSpacingX24,
                  child: PageIndicator(
                    pages: _numPages,
                    currentPage: _currentPage,
                    activeColor: kTheme.colorScheme.secondary,
                  ),
                ),

                /// action buttons
                Positioned(
                  bottom: kSpacingNone,
                  left: kSpacingNone,
                  right: kSpacingNone,
                  child: InkWell(
                    onTap: () => isLastPage
                        ? _requestService()
                        : _pageController.animateToPage(
                            ++_currentPage,
                            duration: kSheetDuration,
                            curve: Curves.fastLinearToSlowEaseIn,
                          ),
                    child: Container(
                      height: kToolbarHeight,
                      width: SizeConfig.screenWidth,
                      alignment: Alignment.center,
                      decoration:
                          BoxDecoration(color: kTheme.colorScheme.secondary),
                      child: _isRequesting
                          ? Loading(
                              circular: true,
                              color: kTheme.colorScheme.onSecondary,
                            )
                          : Text(
                              _currentPage == 2 ? "Send request" : "Next",
                              style: kTheme.textTheme.button.copyWith(
                                color: kTheme.colorScheme.onSecondary,
                              ),
                            ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  /// select type of service needed from artisan
  Widget _buildServicePicker() => SizedBox(
        width: SizeConfig.screenWidth,
        height: SizeConfig.screenHeight,
        child: Padding(
          padding: EdgeInsets.only(top: SizeConfig.screenHeight * 0.15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: kSpacingX24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Available services...",
                      style: kTheme.textTheme.headline6.copyWith(
                        color: kTheme.colorScheme.onBackground
                            .withOpacity(kEmphasisHigh),
                      ),
                    ),
                    SizedBox(height: kSpacingX4),
                    Text(
                      "Tap on any service below to get started",
                      style: kTheme.textTheme.caption.copyWith(
                        color: kTheme.colorScheme.onBackground
                            .withOpacity(kEmphasisMedium),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: kSpacingX12),
              SearchView(
                focusNode: _focusNode,
                onQueryChange: (query) {
                  if (query.isEmpty)
                    _serviceBloc.add(
                      ArtisanServiceEvent.getArtisanServices(
                          category: widget.artisan.category),
                    );
                  else {
                    _servicesForCategory = _servicesForCategory
                        .where((element) => element.name.contains(query))
                        .toList();
                    setState(() {});
                  }
                },
                onQueryComplete: (query) {
                  logger.d("Query -> $query");
                  _focusNode.unfocus();
                  _serviceBloc.add(
                    ArtisanServiceEvent.getArtisanServices(
                        category: widget.artisan.category),
                  );
                  _servicesForCategory = _servicesForCategory
                      .where((element) => element.name.contains(query))
                      .toList();
                  setState(() {});
                },
              ),
              Expanded(
                flex: 6,
                child: ArtisanServiceListView(
                  services: _servicesForCategory,
                  onItemSelected: (item) {
                    _selectedService = item;
                    setState(() {});
                  },
                  selected: _selectedService,
                  unselectedColor: kTransparent,
                  selectedColor: kTheme.colorScheme.secondary,
                  checkable: false,
                ),
              ),
              Spacer(flex: 1),
            ],
          ),
        ),
      );

  /// location picker -> pick a location where service will be rendered
  Widget _buildLocationPicker() {
    final target = LatLng(_location.lat, _location.lng);
    return AnimatedOpacity(
      opacity: _location == null ? 0 : 1,
      duration: kSheetDuration,
      child: _location == null
          ? SizedBox.shrink()
          : Container(
              height: SizeConfig.screenHeight,
              width: SizeConfig.screenWidth,
              // child:
              // GoogleMap(
              //   initialCameraPosition: CameraPosition(
              //     target: target,
              //     zoom: kSpacingX16,
              //   ),
              // zoomControlsEnabled: false,
              // compassEnabled: true,
              // zoomGesturesEnabled: true,
              // mapToolbarEnabled: false,
              // myLocationButtonEnabled: true,
              // myLocationEnabled: true,
              // tiltGesturesEnabled: true,
              // markers: <Marker>{
              //   Marker(
              //     markerId: MarkerId(widget.artisan.id),
              //     position: target,
              //     icon: BitmapDescriptor.defaultMarkerWithHue(
              //         BitmapDescriptor.hueGreen),
              //   ),
              // },
              // onMapCreated: (controller) async {
              //   _mapController = controller;
              //   _setupMap();
              // },
              // onTap: (_) {
              //   _location =
              //       LocationMetadata(lat: _.latitude, lng: _.longitude);
              //   setState(() {});
              // },
              // mapType: MapType.normal,
              // ),
            ),
    );
  }

  /// request description -> send description with image to artisan
  Widget _buildRequestDescription() => Container(
        height: SizeConfig.screenHeight,
        width: SizeConfig.screenWidth,
        color: kPlaceholderColor,
        child: Stack(
          children: [
            /// action buttons
            Positioned(
              bottom: kSpacingNone,
              left: kSpacingNone,
              right: kSpacingNone,
              child: InkWell(
                onTap: () => _complete ? _requestService() : null,
                child: Container(
                  height: kToolbarHeight,
                  width: SizeConfig.screenWidth,
                  alignment: Alignment.center,
                  decoration:
                      BoxDecoration(color: kTheme.colorScheme.secondary),
                  child: _isRequesting
                      ? Loading(
                          circular: true,
                          color: kTheme.colorScheme.onSecondary,
                        )
                      : Text(
                          "Send Request",
                          style: kTheme.textTheme.button.copyWith(
                            color: kTheme.colorScheme.onSecondary,
                          ),
                        ),
                ),
              ),
            ),
          ],
        ),
      );

  void _handleBackPressed() {
    if (_currentPage != 0)
      _pageController.animateToPage(
        --_currentPage,
        duration: kSheetDuration,
        curve: Curves.fastLinearToSlowEaseIn,
      );
    else
      context.navigator.pop();
  }
}
