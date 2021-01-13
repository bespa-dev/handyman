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
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lite/app/bloc/bloc.dart';
import 'package:lite/app/widgets/widgets.dart';
import 'package:lite/data/entities/entities.dart';
import 'package:lite/domain/models/models.dart';
import 'package:lite/shared/shared.dart';
import 'package:sliding_sheet/sliding_sheet.dart';

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
  final _homeAddressBloc = PrefsBloc(repo: Injection.get());
  final _workAddressBloc = PrefsBloc(repo: Injection.get());
  final _storageBloc = StorageBloc(repo: Injection.get());
  final _locationBloc = LocationBloc(repo: Injection.get());
  final _serviceBloc = ArtisanServiceBloc(repo: Injection.get());

  /// form
  final _formKey = GlobalKey<FormState>();
  final _bodyController = TextEditingController(),
      _controller = TextEditingController();
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
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String _userId, _timestamp = DateTime.now().millisecondsSinceEpoch.toString();
  bool _complete = false,
      _isRequesting = false,
      _useCurrentLocation = false,
      _isHomeAddress = false,
      _isWorkAddress = false;
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

      if (_imageFile != null && _fileUrl == null) {
        logger.i("uploading image");

        /// perform upload
        _storageBloc.add(StorageEvent.uploadFile(
            path: _timestamp,
            filePath: _imageFile.absolute.path,
            isImage: true));
      } else {
        logger.i("Sending request");

        /// todo -> add service cost
        _bookingBloc.add(
          BookingEvent.requestBooking(
            artisan: widget.artisan.id,
            customer: _userId,
            category: widget.artisan.category,
            description: _bodyController.text?.trim(),
            image: _fileUrl,
            cost: 12.99,
            location: _location,
          ),
        );
      }
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

                  /// upload image
                  _storageBloc.add(
                    StorageEvent.uploadFile(
                        path: _timestamp,
                        filePath: pickedFile.path,
                        isImage: true),
                  );
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
    _homeAddressBloc.close();
    _workAddressBloc.close();
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

      /// get home address
      _homeAddressBloc.add(PrefsEvent.getHomeAddressEvent());

      /// get work address
      _workAddressBloc.add(PrefsEvent.getWorkAddressEvent());

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
            if (mounted) setState(() {});
          }
        });

      /// get location
      _locationBloc.listen((state) {
        if (state is SuccessState<BaseLocationMetadata>) {
          if (_isHomeAddress) {
            _homeAddressBloc
              ..add(PrefsEvent.saveHomeAddressEvent(address: state.data.name))
              ..add(PrefsEvent.getHomeAddressEvent());
            _isHomeAddress = !_isHomeAddress;
          } else if (_isWorkAddress) {
            _workAddressBloc
              ..add(PrefsEvent.saveWorkAddressEvent(address: state.data.name))
              ..add(PrefsEvent.getWorkAddressEvent());
            _isWorkAddress = !_isWorkAddress;
          } else
            _location = state.data;
          if (mounted) setState(() {});
        }
      });

      /// observe booking state
      _bookingBloc.listen((state) {
        if (state is LoadingState) {
          _isRequesting = true;
          setState(() {});
        } else {
          _isRequesting = false;
          setState(() {});
          if (state is ErrorState) {
            showCustomDialog(
              context: context,
              builder: (_) => InfoDialog(
                title: "An error occurred",
                message: Text(state.failure?.toString() ??
                    "Failed to complete your booking"),
              ),
            );
          } else {
            showSnackBarMessage(context, message: "Request sent successfully");
            context.navigator.pop();
          }
        }
      });

      /// observe file upload state
      _storageBloc.listen((state) {
        if (state is SuccessState<String>) {
          _fileUrl = state.data;
          if (mounted) setState(() {});
          if (_isRequesting)

            /// todo -> add service cost
            _bookingBloc.add(
              BookingEvent.requestBooking(
                artisan: widget.artisan.id,
                customer: _userId,
                category: widget.artisan.category,
                description: _bodyController.text?.trim(),
                image: _fileUrl,
                cost: 12.99,
                location: _location,
              ),
            );
        } else {
          logger.e("Failed to upload image");
          showSnackBarMessage(context, message: "Failed to upload image");
          _isRequesting = false;
          if (mounted) setState(() {});
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    kTheme = Theme.of(context);
    return WillPopScope(
      onWillPop: _handleBackPressed,
      child: Scaffold(
        key: _scaffoldKey,
        body: Stack(
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
                onPressed: () async => await _handleBackPressed(),
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
            AnimatedPositioned(
              duration: kScaleDuration,
              bottom: kSpacingNone,
              left: kSpacingNone,
              right: kSpacingNone,
              height: _currentPage != 1 ? kToolbarHeight : kSpacingNone,
              child: _buildActionButton(),
            ),
          ],
        ),
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
    return _location == null
        ? Loading()
        : AnimatedOpacity(
            opacity: _location == null ? 0 : 1,
            duration: kSheetDuration,
            child: Container(
              height: SizeConfig.screenHeight,
              width: SizeConfig.screenWidth,
              child: SlidingSheet(
                color: kTheme.colorScheme.background,
                duration: kSheetDuration,
                addTopViewPaddingOnFullscreen: true,
                isBackdropInteractable: true,
                snapSpec: const SnapSpec(snappings: [0.5, 0.7, 1.0]),
                cornerRadius: kSpacingX8,
                footerBuilder: (_, __) => SizedBox(
                    width: SizeConfig.screenWidth,
                    height: kToolbarHeight,
                    child: _buildActionButton()),
                builder: (_, __) => Padding(
                  padding: EdgeInsets.only(
                    top: kSpacingX36,
                    left: kSpacingX12,
                    right: kSpacingX12,
                    bottom: kSpacingX12,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Where do you need this service?",
                          style: kTheme.textTheme.headline6,
                        ),
                      ),
                      SizedBox(height: kSpacingX12),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Checkbox(
                            value: _useCurrentLocation,
                            onChanged: (use) {
                              _useCurrentLocation = use;
                              setState(() {});
                              _locationBloc
                                  .add(LocationEvent.getCurrentLocation());
                            },
                          ),
                          SizedBox(width: kSpacingX4),
                          Text(
                            "Use current location",
                            style: kTheme.textTheme.bodyText1,
                          ),
                        ],
                      ),
                      SearchView(
                        onQueryComplete: (_) {},
                        onQueryChange: (_) {},
                        focusNode: _focusNode,
                        hint: "Enter a location",
                      ),
                      SizedBox(height: kSpacingX12),
                      BlocBuilder<PrefsBloc, BlocState>(
                        cubit: _homeAddressBloc,
                        builder: (_, state) => ListTile(
                          leading: Icon(kHomeIcon),
                          title: Text("Add home address"),
                          trailing: IconButton(
                            icon: Icon(kEditIcon),
                            onPressed: _pickHomeAddress,
                          ),
                          subtitle: state is SuccessState<String> &&
                                  state.data != null
                              ? Text(state.data)
                              : null,
                          enabled: !_useCurrentLocation,
                          onTap: () {
                            _homeAddressBloc
                              ..add(PrefsEvent.getHomeAddressEvent())
                              ..listen((addressState) {
                                if (addressState is SuccessState<String>) {
                                  final address = addressState.data;
                                  if (address != null)
                                    _locationBloc.add(
                                        LocationEvent.getLocationCoordinates(
                                            address: address));
                                  else
                                    _pickHomeAddress();
                                }
                              });
                          },
                        ),
                      ),
                      BlocBuilder<PrefsBloc, BlocState>(
                        cubit: _workAddressBloc,
                        builder: (_, state) => ListTile(
                          leading: Icon(kBriefcaseIcon),
                          title: Text("Add work address"),
                          trailing: IconButton(
                            icon: Icon(kEditIcon),
                            onPressed: _pickWorkAddress,
                          ),
                          subtitle: state is SuccessState<String> &&
                                  state.data != null
                              ? Text(state.data)
                              : null,
                          enabled: !_useCurrentLocation,
                          onTap: () {
                            _workAddressBloc
                              ..add(PrefsEvent.getWorkAddressEvent())
                              ..listen((addressState) {
                                if (addressState is SuccessState<String>) {
                                  final address = addressState.data;
                                  if (address != null)
                                    _locationBloc.add(
                                        LocationEvent.getLocationCoordinates(
                                            address: address));
                                  else
                                    _pickWorkAddress();
                                }
                              });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                body: BlocBuilder<LocationBloc, BlocState>(
                  cubit: _locationBloc,
                  builder: (_, state) => AnimatedContainer(
                    duration: kSheetDuration,
                    width: SizeConfig.screenWidth,
                    height: SizeConfig.screenHeight * 0.6,
                    alignment: Alignment.center,
                    color: state is LoadingState
                        ? kTheme.colorScheme.error
                        : kTheme.colorScheme.background,
                    child: state is SuccessState<BaseLocationMetadata>
                        ? Text(state.data.name)
                        : state is LoadingState
                            ? Loading()
                            : SizedBox.shrink(),

                    /// fixme -> add google maps key
                    /// 1. AndroidManifest file
                    /// 2. AppDelegate file
                    /// 3. constants
                    // child: GoogleMap(
                    //   initialCameraPosition: CameraPosition(
                    //     target: LatLng(_location?.lat, _location?.lng),
                    //     zoom: kSpacingX16,
                    //   ),
                    //   zoomControlsEnabled: false,
                    //   compassEnabled: true,
                    //   zoomGesturesEnabled: true,
                    //   mapToolbarEnabled: false,
                    //   myLocationButtonEnabled: true,
                    //   myLocationEnabled: true,
                    //   tiltGesturesEnabled: true,
                    //   markers: <Marker>{
                    //     Marker(
                    //       markerId: MarkerId(widget.artisan.id),
                    //       position: LatLng(_location?.lat, _location?.lng),
                    //       icon: BitmapDescriptor.defaultMarkerWithHue(
                    //           BitmapDescriptor.hueGreen),
                    //     ),
                    //   },
                    //   onMapCreated: (controller) async {
                    //     _mapController = controller;
                    //     _setupMap();
                    //   },
                    //   onTap: (_) {
                    //     _location =
                    //         LocationMetadata(lat: _.latitude, lng: _.longitude);
                    //     setState(() {});
                    //   },
                    //   mapType: MapType.normal,
                    // ),
                  ),
                ),
              ),
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
            Positioned.fill(
              top: SizeConfig.screenHeight * 0.1,
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: kSpacingX24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                        top: kSpacingX12,
                        bottom: kSpacingX24,
                      ),
                      height: SizeConfig.screenHeight * 0.3,
                      width: SizeConfig.screenWidth,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(kSpacingX8),
                        color: kTheme.cardColor,
                      ),
                      clipBehavior: Clip.hardEdge,
                      child: ImageView(
                        imageUrl: _imageFile?.absolute?.path,
                        isFileImage: _imageFile != null,
                        onTap: _pickImage,
                        fit: BoxFit.cover,
                        height: SizeConfig.screenHeight * 0.3,
                        width: SizeConfig.screenWidth,
                      ),
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormInput(
                            labelText: "Short Description*",
                            controller: _bodyController,
                            validator: (_) => _.isEmpty
                                ? "Add a short description of your problem"
                                : null,
                            textCapitalization: TextCapitalization.words,
                            enabled: !_isRequesting,
                            cursorColor: kTheme.colorScheme.onBackground,
                            maxLines: 5,
                            keyboardType: TextInputType.multiline,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

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

  /// handles back pressed action
  Future<bool> _handleBackPressed() async {
    if (_currentPage != 0) {
      _pageController.animateToPage(
        --_currentPage,
        duration: kSheetDuration,
        curve: Curves.fastLinearToSlowEaseIn,
      );
      return Future<bool>.value(false);
    } else {
      context.navigator.pop();
      return Future<bool>.value(true);
    }
  }

  /// bottom action button
  Widget _buildActionButton() {
    kTheme = Theme.of(context);
    bool isLastPage = _currentPage == _numPages - 1;
    return InkWell(
      onTap: isLastPage
          ? _requestService
          : () {
              switch (_currentPage) {
                case 0:
                  if (_selectedService == null)
                    showCustomDialog(
                      context: context,
                      builder: (_) => InfoDialog(
                        title: "Heads up",
                        message: Text("Select a service first"),
                      ),
                    );
                  else {
                    _pageController.animateToPage(
                      ++_currentPage,
                      duration: kSheetDuration,
                      curve: Curves.fastLinearToSlowEaseIn,
                    );

                    /// get current location
                    _locationBloc.add(LocationEvent.getCurrentLocation());
                  }
                  break;
                case 1:
                  if (_location == null) {
                    showCustomDialog(
                      context: context,
                      builder: (_) => InfoDialog(
                        title: "Heads up",
                        message: Text("Select a destination for this service"),
                      ),
                    );
                  } else {
                    _pageController.animateToPage(
                      ++_currentPage,
                      duration: kSheetDuration,
                      curve: Curves.fastLinearToSlowEaseIn,
                    );
                  }
                  break;
              }
            },
      child: Container(
        width: SizeConfig.screenWidth,
        alignment: Alignment.center,
        decoration: BoxDecoration(color: kTheme.colorScheme.secondary),
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
    );
  }

  void _pickHomeAddress() async {
    String address = await showCustomDialog(
      context: context,
      builder: (_) => ReplyMessageDialog(
        title: "Home address",
        controller: _controller,
      ),
    );
    if (address != null && address.isNotEmpty) {
      _isHomeAddress = true;
      setState(() {});
      _locationBloc.add(
        LocationEvent.getLocationCoordinates(address: address),
      );
    }
  }

  void _pickWorkAddress() async {
    String address = await showCustomDialog(
      context: context,
      builder: (_) => ReplyMessageDialog(
        title: "Work address",
        controller: _controller,
      ),
    );
    if (address != null && address.isNotEmpty) {
      _isWorkAddress = true;
      setState(() {});
      _locationBloc.add(
        LocationEvent.getLocationCoordinates(address: address),
      );
    }
  }
}
