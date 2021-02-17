import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:handyman/app/bloc/bloc.dart';
import 'package:handyman/app/widgets/widgets.dart';
import 'package:handyman/domain/models/models.dart';
import 'package:handyman/shared/shared.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sliding_sheet/sliding_sheet.dart';
import 'package:uuid/uuid.dart';

/// fixme -> save prices for each service to remote database
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
  final _categoryBloc = CategoryBloc(repo: Injection.get());
  final _storageBloc = StorageBloc(repo: Injection.get());

  /// UI
  ThemeData _kTheme;
  GoogleMapController _mapController;
  BaseBusiness _business;
  LatLng _businessLocation;
  int _currentPage = 0;
  BaseArtisan _currentUser;
  var _servicesForCategory = const <BaseArtisanService>[];
  var _categories = const <BaseServiceCategory>[];
  var _selectedServices = const <BaseArtisanService>[];
  final _sheetController = SheetController();
  File _galleryImage;
  bool _isLoading = false;

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
    _categoryBloc.close();
    _storageBloc.close();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    if (mounted) {
      /// get all categories
      _categoryBloc
        ..add(CategoryEvent.observeAllCategories(
            group: ServiceCategoryGroup.featured()))
        ..listen((state) {
          if (state is SuccessState<Stream<List<BaseServiceCategory>>>) {
            state.data.listen((event) {
              _categories = event;
              if (mounted) setState(() {});
            });
          }
        });

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
            state.data.listen((user) async {
              _currentUser = user;
              if (_currentUser.services == null) {
                _currentUser =
                    _currentUser.copyWith(services: _selectedServices);
                _updateUserBloc.add(
                  UserEvent.updateUserEvent(user: _currentUser),
                );
              } else {
                _selectedServices = _currentUser.services;
              }
              if (mounted) setState(() {});
              logger.d('User category -> ${user.category}');

              /// get services for category
              if (user.category != null) {
                _serviceBloc.add(ArtisanServiceEvent.getArtisanServices(
                    category: user.category));
              } else {
                await showCustomDialog(
                  context: context,
                  builder: (_) => BasicDialog(
                    message:
                        'You need to select a category for this business first',
                    positiveButtonText: 'Add new',
                    negativeButtonText: 'Later',
                    title: 'Heads up...',
                    onComplete: () => context.navigator
                      ..pop()
                      ..pushProfilePage(),
                  ),
                );
              }
            });
          }
        });

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

      /// storage
      _storageBloc.listen((state) async {
        if (state is LoadingState) {
          _isLoading = true;
          if (mounted) setState(() {});
        } else if (state is ErrorState) {
          _isLoading = false;
          if (mounted) setState(() {});
          await showCustomDialog(
            context: context,
            builder: (_) => InfoDialog(
              message: Text(state.failure.toString()),
            ),
          );
        } else if (state is SuccessState<String>) {
          logger.d(state.data);
          _isLoading = false;
          if (mounted) setState(() {});
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    _kTheme = Theme.of(context);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: _currentPage == 0
            ? _showBottomSheetForServices
            : _addImageToGallery,
        child: Icon(kPlusIcon),
      ),
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
            if (_currentUser != null &&
                _currentUser.services != null &&
                _currentUser.services.isNotEmpty) ...{
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
              ..._currentUser.services
                  .map(
                    (service) => ArtisanServiceListTile(
                      service: service,
                      showLeadingIcon: false,
                      selected: false,
                      showPrice: true,
                    ),
                  )
                  .toList(),
              SizedBox(height: SizeConfig.screenHeight * 0.1),
            } else ...{
              Container(
                margin: EdgeInsets.only(top: kSpacingX24),
                width: SizeConfig.screenWidth,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('No services added',
                        style: _kTheme.textTheme.headline6),
                  ],
                ),
              ),
            }
          ],
        ),
      );

  /// business gallery tab
  Widget _buildBusinessGalleryTab() => _isLoading
      ? SizedBox(
          height: SizeConfig.screenHeight * 0.3,
          width: SizeConfig.screenWidth,
          child: Loading())
      : Container(
          height: SizeConfig.screenHeight * 0.35,
          width: SizeConfig.screenWidth,
          padding: EdgeInsets.symmetric(horizontal: kSpacingX24),
          child: _currentUser.hasHighRatings
              ? _buildGalleryUI()
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(kBadgeIcon, size: kSpacingX56),
                    SizedBox(height: kSpacingX16),
                    Text(
                      'Earn a badge first',
                      style: _kTheme.textTheme.headline6,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: kSpacingX8),
                    Text(
                      'Get more jobs & good reviews from customers to unlock this feature',
                      style: _kTheme.textTheme.subtitle1,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
        );

  void _addImageToGallery() async {
    final picker = ImagePicker();
    var pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      _galleryImage = await ImageCropper.cropImage(
          sourcePath: pickedFile.path,
          aspectRatioPresets: [
            CropAspectRatioPreset.square,
            CropAspectRatioPreset.ratio3x2,
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.ratio4x3,
            CropAspectRatioPreset.ratio16x9
          ],
          androidUiSettings: AndroidUiSettings(
            toolbarTitle: kAppName,
            toolbarColor: _kTheme.colorScheme.primary,
            toolbarWidgetColor: _kTheme.colorScheme.onPrimary,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false,
          ),
          iosUiSettings: IOSUiSettings(
            minimumAspectRatio: 1.0,
          ));

      if (_galleryImage != null) {
        /// Upload image
        _storageBloc.add(
          StorageEvent.uploadFile(
            path: Uuid().v4(),
            filePath: _galleryImage.absolute.path,
            isImage: true,
          ),
        );
      }
    }
  }

  void _showBottomSheetForServices() async {
    await showSlidingBottomSheet(context,
        useRootNavigator: true,
        builder: (context) => SlidingSheetDialog(
              elevation: kSpacingX8,
              cornerRadius: kSpacingX16,
              dismissOnBackdropTap: _selectedServices.isEmpty,
              controller: _sheetController,
              snapSpec: const SnapSpec(
                snap: true,
                snappings: [0.4, 0.7, 1.0],
                positioning: SnapPositioning.relativeToAvailableSpace,
              ),
              headerBuilder: (_, state) => Container(
                height: kToolbarHeight,
                alignment: Alignment.center,
                color: _kTheme.colorScheme.primary,
                child: Text(
                  'Available services',
                  style: _kTheme.textTheme.headline6
                      .copyWith(color: _kTheme.colorScheme.onPrimary),
                ),
              ),
              footerBuilder: (_, __) => _selectedServices.isEmpty
                  ? null
                  : Material(
                      type: MaterialType.transparency,
                      child: InkWell(
                        onTap: () async {
                          context.navigator.pop();
                          setState(() {});
                          _currentUser = _currentUser.copyWith(
                              services: _selectedServices);
                          _updateUserBloc.add(
                              UserEvent.updateUserEvent(user: _currentUser));
                        },
                        child: Container(
                          height: kToolbarHeight,
                          alignment: Alignment.center,
                          color: _kTheme.colorScheme.secondary,
                          child: Text(
                            'Save & continue'.toUpperCase(),
                            style: _kTheme.textTheme.button.copyWith(
                                color: _kTheme.colorScheme.onSecondary),
                          ),
                        ),
                      ),
                    ),
              builder: (context, state) {
                return BlocBuilder<ArtisanServiceBloc, BlocState>(
                  cubit: _serviceBloc,
                  builder: (_, state) => Container(
                    height: state is SuccessState<List<BaseArtisanService>> &&
                            _selectedServices.isNotEmpty
                        ? SizeConfig.screenHeight * 0.6
                        : SizeConfig.screenHeight * 0.25,
                    color: _kTheme.cardColor,
                    padding: EdgeInsets.symmetric(horizontal: kSpacingX12),
                    child: Material(
                      type: MaterialType.transparency,
                      child: state is SuccessState<List<BaseArtisanService>> &&
                              _selectedServices.isNotEmpty
                          ? SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ..._servicesForCategory
                                      .map(
                                        (service) => ArtisanServiceListTile(
                                          service: service,
                                          showLeadingIcon: false,
                                          showTrailingIcon: false,
                                          selected: _selectedServices
                                              .contains(service.id),
                                          onTap: () {
                                            _selectedServices
                                                .toggleAddOrRemove(service.id);
                                            _sheetController.rebuild();
                                          },
                                        ),
                                      )
                                      .toList(),
                                ],
                              ),
                            )
                          : BlocBuilder<CategoryBloc, BlocState>(
                              cubit: _categoryBloc,
                              builder: (_, state) => Center(
                                child: InkWell(
                                  onTap: _pickCategory,
                                  child: Padding(
                                    padding: const EdgeInsets.all(kSpacingX16),
                                    child: Text(
                                      'Tap here to register a business category first',
                                      style: _kTheme.textTheme.bodyText1,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                    ),
                  ),
                );
              },
            ));
  }

  void _pickCategory() async => await showCustomDialog(
        context: context,
        builder: (_) => MenuItemPickerDialog(
          title: 'Select a category',
          onComplete: (item) {
            if (_currentUser.category != item.key.value.toString()) {
              _currentUser = _currentUser.copyWith(
                category: item.key.value.toString(),
                categoryGroup: item.title,
                services: _currentUser.services ?? <BaseArtisanService>[],
              );

              _updateUserBloc
                  .add(UserEvent.updateUserEvent(user: _currentUser));
              _serviceBloc.add(
                ArtisanServiceEvent.getArtisanServices(
                  category: item.key.toString(),
                ),
              );
            }
          },
          items: _categories.isNotEmpty
              ? _categories
                  .map(
                    (e) => PickerMenuItem(
                      title: e.name,
                      icon: kPlusIcon,
                      key: ValueKey(e.id),
                    ),
                  )
                  .toList()
              : [],
        ),
      );

  /// build UI for gallery
  Widget _buildGalleryUI() => Center(
        child: Text(
          'Contact the administrator to be granted access to this feature',
          style: _kTheme.textTheme.bodyText1,
        ),
      );
}
