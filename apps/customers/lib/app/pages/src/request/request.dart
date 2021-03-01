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
import 'package:flutter/foundation.dart';
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

/// fixme -> last page of service request
class RequestPage extends StatefulWidget {
  const RequestPage({
    Key key,
    @required this.artisan,
    this.service,
  }) : super(key: key);

  final BaseArtisan artisan;
  final BaseArtisanService service;

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
  final _categoryBloc = CategoryBloc(repo: Injection.get());
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
  int _currentPage = 0;
  final _numPages = 3;
  final _pageController = PageController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String _userId;
  final _timestamp = DateTime.now().millisecondsSinceEpoch.toString();
  bool _isRequesting = false,
      _showActionIcon = true,
      _useCurrentLocation = false,
      _isHomeAddress = false,
      _isWorkAddress = false;
  List<BaseArtisanService> _services = const [];
  BaseArtisanService _selectedService;
  ThemeData kTheme;

  /// request service
  void _requestService() async {
    if (_formKey.currentState == null) return;
    if (_formKey.currentState.validate() &&
        _location != null &&
        _selectedService != null &&
        _userId != null) {
      _formKey.currentState.save();
      _isRequesting = true;
      setState(() {});

      if (_imageFile != null && _fileUrl == null) {
        /// perform upload
        _storageBloc.add(StorageEvent.uploadFile(
            path: _timestamp,
            filePath: _imageFile.absolute.path,
            isImage: true));
      } else {
        _bookingBloc.add(
          BookingEvent.requestBooking(
            artisan: widget.artisan.id,
            customer: _userId,
            category: widget.artisan.category,
            description: _bodyController.text?.trim(),
            image: _fileUrl,
            cost: _selectedService.price,
            location: _location,
            serviceType: _selectedService.id,
          ),
        );
      }
    } else {
      await showCustomDialog(
          context: context,
          builder: (_) => InfoDialog(
              message: Text(
                  'Please select a service and fill in any required details first')));
    }
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
              title: 'Select source',
              onComplete: (_) async {
                logger.d('Item -> ${_.title}');
                if (_.icon == kGalleryIcon) {
                  pickedFile =
                      await picker.getImage(source: ImageSource.gallery);
                } else {
                  pickedFile =
                      await picker.getImage(source: ImageSource.camera);
                }

                if (pickedFile != null) {
                  _imageFile = File(pickedFile.path);
                  if (mounted) setState(() {});
                }
              },
              items: [
                PickerMenuItem(
                  title: 'Camera',
                  icon: kCameraIcon,
                ),
                PickerMenuItem(
                  title: 'Gallery',
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
    _categoryBloc.close();
    _pageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    if (mounted) {
      _focusNode = FocusNode();

      if (widget.service != null) {
        _selectedService = widget.service;
        setState(() {});
        Future.delayed(kSheetDuration)
            .then((value) => _pageController.animateToPage(
                  ++_currentPage,
                  duration: kSheetDuration,
                  curve: Curves.fastLinearToSlowEaseIn,
                ));
      }

      if (widget.artisan.services == null || widget.artisan.services.isEmpty) {
        _categoryBloc
          ..add(CategoryEvent.observeCategoryById(id: widget.artisan.category))
          ..listen((state) {
            if (state is SuccessState<Stream<BaseServiceCategory>>) {
              state.data.listen((event) {
                _serviceBloc.add(ArtisanServiceEvent.getCategoryServices(
                    categoryId: event.hasParent ? event.parent : event.id));
              });
            }
          });
      } else {
        _serviceBloc
            .add(ArtisanServiceEvent.getArtisanServices(id: widget.artisan.id));
      }

      /// get user id for upload
      PrefsBloc(repo: Injection.get())
        ..add(PrefsEvent.getUserIdEvent())
        ..listen((state) {
          if (state is SuccessState<String> && state.data != null) {
            _userId = state.data;
            if (mounted) setState(() {});
          }
        });

      /// get home address
      _homeAddressBloc.add(PrefsEvent.getHomeAddressEvent());

      /// get work address
      _workAddressBloc.add(PrefsEvent.getWorkAddressEvent());

      /// get business profiles
      _businessBloc.add(
          BusinessEvent.getBusinessesForArtisan(artisanId: widget.artisan.id));

      /// get services for category
      _serviceBloc
        ..add(ArtisanServiceEvent.getArtisanServices(id: widget.artisan.id))
        ..listen((state) {
          if (state is SuccessState<List<BaseArtisanService>>) {
            _services = state.data;
            if (mounted) setState(() {});
          }
        });

      /// get location
      _locationBloc.listen((state) {
        if (state is SuccessState<BaseLocationMetadata>) {
          logger.d('Location -> ${state.data}');
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
          } else {
            _location = state.data;
          }
          if (mounted) setState(() {});
        } else if (state is SuccessState<String>) {
          logger.d('Location address -> ${state.data}');

          /// todo -> show location name
        }
      });

      /// observe booking state
      _bookingBloc.listen((state) async {
        if (state is LoadingState) {
          _isRequesting = true;
          setState(() {});
        } else {
          _isRequesting = false;
          setState(() {});
          if (state is ErrorState) {
            await showCustomDialog(
              context: context,
              builder: (_) => InfoDialog(
                title: 'An error occurred',
                message: Text(state.failure?.toString() ??
                    'Failed to complete your booking'),
              ),
            );
          } else {
            await showCustomDialog(
              context: context,
              builder: (_) => InfoDialog(
                message: Text('Request sent successfully'),
              ),
            );
            context.navigator.pop();
          }
        }
      });

      /// observe file upload state
      _storageBloc.listen((state) {
        if (state is SuccessState<String>) {
          _fileUrl = state.data;
          _showActionIcon = true;
          if (mounted) setState(() {});
          if (_isRequesting) {
            _bookingBloc.add(
              BookingEvent.requestBooking(
                artisan: widget.artisan.id,
                customer: _userId,
                category: widget.artisan.category,
                description: _bodyController.text?.trim(),
                image: _fileUrl,
                cost: _selectedService.price,
                location: _location,
                serviceType: _selectedService.id,
              ),
            );
          }
        } else if (state is ErrorState) {
          logger.e('Failed to upload image');
          showCustomDialog(
            context: context,
            builder: (_) => InfoDialog(
              message: Text('Failed to upload image'),
            ),
          );
          _isRequesting = false;
          _showActionIcon = true;
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
                onPageChanged: (index) => setState(() => _currentPage = index),
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
                itemCount: _numPages,
              ),
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
              height: _currentPage == 1 ? kSpacingNone : kToolbarHeight,
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
                      'Available services...',
                      style: kTheme.textTheme.headline6.copyWith(
                        color: kTheme.colorScheme.onBackground
                            .withOpacity(kEmphasisHigh),
                      ),
                    ),
                    SizedBox(height: kSpacingX4),
                    Text(
                      'Tap on any service below to get started',
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
                  if (query.isEmpty) {
                    _serviceBloc.add(ArtisanServiceEvent.getArtisanServices(
                        id: widget.artisan.id));
                  } else {
                    _services = _services
                        .where((element) => element.name.contains(query))
                        .toList();
                    setState(() {});
                  }
                },
                onQueryComplete: (query) {
                  logger.d('Query -> $query');
                  _focusNode.unfocus();
                  _serviceBloc.add(ArtisanServiceEvent.getArtisanServices(
                      id: widget.artisan.id));
                  _services = _services
                      .where((element) => element.name.contains(query))
                      .toList();
                  setState(() {});
                },
              ),
              Expanded(
                flex: 6,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: kSpacingX16),
                  child: ArtisanServiceListView(
                    services: _services,
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
              ),
            ],
          ),
        ),
      );

  /// location picker -> pick a location where service will be rendered
  Widget _buildLocationPicker() => _location == null
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
              extendBody: true,
              backdropColor:
                  kTheme.colorScheme.background.withOpacity(kEmphasisLow),
              snapSpec: const SnapSpec(snappings: [0.5, 0.7, 1.0]),
              cornerRadius: kSpacingX8,
              footerBuilder: (_, __) => SizedBox(
                width: SizeConfig.screenWidth,
                height: kToolbarHeight,
                child: _buildActionButton(text: 'Next'),
              ),
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
                        'Where do you need this service?',
                        style: kTheme.textTheme.headline6,
                      ),
                    ),
                    SizedBox(height: kSpacingX12),
                    SearchView(
                      onQueryComplete: (_) {},
                      onQueryChange: (_) {},
                      focusNode: _focusNode,
                      hint: 'Enter a location',
                    ),
                    SizedBox(height: kSpacingX12),
                    SwitchListTile.adaptive(
                      value: _useCurrentLocation,
                      secondary: Icon(kLocationIcon),
                      onChanged: (checked) {
                        _useCurrentLocation = checked;
                        setState(() {});
                        if (_useCurrentLocation) {
                          _locationBloc.add(LocationEvent.getCurrentLocation());
                        }
                      },
                      title: Text('Use current location'),
                    ),
                    BlocBuilder<PrefsBloc, BlocState>(
                      cubit: _homeAddressBloc,
                      builder: (_, state) => ListTile(
                        leading: Icon(kHomeIcon),
                        title: Text('Add home address'),
                        trailing: IconButton(
                          icon: Icon(kEditIcon),
                          onPressed: _pickHomeAddress,
                        ),
                        subtitle:
                            state is SuccessState<String> && state.data != null
                                ? Text(state.data)
                                : null,
                        enabled: !_useCurrentLocation,
                        onTap: () {
                          _homeAddressBloc
                            ..add(PrefsEvent.getHomeAddressEvent())
                            ..listen((addressState) {
                              if (addressState is SuccessState<String>) {
                                final address = addressState.data;
                                if (address != null) {
                                  _locationBloc.add(
                                      LocationEvent.getLocationCoordinates(
                                          address: address));
                                } else {
                                  _pickHomeAddress();
                                }
                              }
                            });
                        },
                      ),
                    ),
                    BlocBuilder<PrefsBloc, BlocState>(
                      cubit: _workAddressBloc,
                      builder: (_, state) => ListTile(
                        leading: Icon(kBriefcaseIcon),
                        title: Text('Add work address'),
                        trailing: IconButton(
                          icon: Icon(kEditIcon),
                          onPressed: _pickWorkAddress,
                        ),
                        subtitle:
                            state is SuccessState<String> && state.data != null
                                ? Text(state.data)
                                : null,
                        enabled: !_useCurrentLocation,
                        onTap: () {
                          _workAddressBloc
                            ..add(PrefsEvent.getWorkAddressEvent())
                            ..listen((addressState) {
                              if (addressState is SuccessState<String>) {
                                final address = addressState.data;
                                if (address != null) {
                                  _locationBloc.add(
                                      LocationEvent.getLocationCoordinates(
                                          address: address));
                                } else {
                                  _pickWorkAddress();
                                }
                              }
                            });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              closeOnBackdropTap: true,
              body: BlocBuilder<LocationBloc, BlocState>(
                cubit: _locationBloc,
                // buildWhen: (p, c) =>
                //     p is SuccessState<BaseLocationMetadata> &&
                //     c is SuccessState<BaseLocationMetadata>,
                builder: (_, __) => Container(
                  width: SizeConfig.screenWidth,
                  height: SizeConfig.screenHeight * 0.6,
                  alignment: Alignment.center,
                  color: kTheme.colorScheme.background,
                  child: GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: LatLng(_location?.lat, _location?.lng),
                      zoom: kSpacingX20,
                    ),
                    zoomControlsEnabled: false,
                    compassEnabled: true,
                    zoomGesturesEnabled: true,
                    mapToolbarEnabled: false,
                    myLocationButtonEnabled: false,
                    myLocationEnabled: false,
                    tiltGesturesEnabled: true,
                    onTap: (_) {
                      logger.i('Tapped -> ${_.latitude} : ${_.longitude}');
                      _location =
                          LocationMetadata(lat: _.latitude, lng: _.longitude);
                      setState(() {});
                      _locationBloc.add(
                          LocationEvent.getLocationName(location: _location));
                    },
                    markers: <Marker>{
                      Marker(
                        markerId: MarkerId(widget.artisan.id),
                        position: LatLng(_location?.lat, _location?.lng),
                        icon: BitmapDescriptor.defaultMarkerWithHue(
                            kTheme.colorScheme.secondary.computeLuminance()),
                        zIndex: 9,
                        infoWindow:
                            InfoWindow(title: _location?.name ?? 'Use here'),
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
            ),
          ),
        );

  /// request description -> send description with image to artisan
  Widget _buildRequestDescription() => Container(
        height: SizeConfig.screenHeight,
        width: SizeConfig.screenWidth,
        color: kPlaceholderColor,
        child: SingleChildScrollView(
          padding: EdgeInsets.only(
            left: kSpacingX24,
            right: kSpacingX24,
            top: SizeConfig.screenHeight * 0.15,
          ),
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
                      labelText: 'Short Description*',
                      controller: _bodyController,
                      validator: (_) => _.isEmpty
                          ? 'Add a short description of your problem'
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
      );

  /// handles back pressed action
  Future<bool> _handleBackPressed() async {
    if (_isRequesting) {
      await showCustomDialog(
        context: context,
        builder: (_) => BasicDialog(
          message: 'Do you wish to cancel this request?',
          onComplete: () => context.navigator.pop(),
        ),
      );
      return Future<bool>.value(false);
    } else if (_currentPage != 0) {
      await _pageController.animateToPage(
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
  Widget _buildActionButton({String text = 'Send Request'}) {
    kTheme = Theme.of(context);
    var isLastPage = _currentPage == _numPages - 1;
    return InkWell(
      onTap: isLastPage
          ? _requestService
          : () {
              switch (_currentPage) {
                case 0:
                  if (_selectedService == null) {
                    showCustomDialog(
                      context: context,
                      builder: (_) => InfoDialog(
                        title: 'Heads up',
                        message: Text('Select a service first'),
                      ),
                    );
                  } else {
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
                        title: 'Heads up',
                        message: Text('Select a destination for this service'),
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
      child: AnimatedContainer(
        duration: kSheetDuration,
        height: _showActionIcon ? kToolbarHeight : kSpacingNone,
        width: SizeConfig.screenWidth,
        alignment: Alignment.center,
        decoration: BoxDecoration(color: kTheme.colorScheme.secondary),
        child: _isRequesting
            ? Loading(
                circular: true,
                color: kTheme.colorScheme.onSecondary,
              )
            : Text(
                isLastPage ? text : 'Next',
                style: kTheme.textTheme.button.copyWith(
                  color: kTheme.colorScheme.onSecondary,
                ),
              ),
      ),
    );
  }

  void _pickHomeAddress() async {
    var address = await showCustomDialog(
      context: context,
      builder: (_) => ReplyMessageDialog(
        title: 'Home address',
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
    var address = await showCustomDialog(
      context: context,
      builder: (_) => ReplyMessageDialog(
        title: 'Work address',
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
