import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:handyman/app/bloc/bloc.dart';
import 'package:handyman/app/routes/routes.gr.dart';
import 'package:handyman/app/widgets/widgets.dart';
import 'package:handyman/domain/models/models.dart';
import 'package:handyman/shared/shared.dart';
import 'package:uuid/uuid.dart';

/// fixme -> uploading document keeps throwing storage exception error
/// https://pub.dev/packages/google_maps_place_picker
class BusinessProfilePage extends StatefulWidget {
  const BusinessProfilePage({Key key, this.business}) : super(key: key);

  final BaseBusiness business;

  @override
  _BusinessProfilePageState createState() => _BusinessProfilePageState();
}

class _BusinessProfilePageState extends State<BusinessProfilePage> {
  /// blocs
  final _userBloc = UserBloc(repo: Injection.get());
  final _prefsBloc = PrefsBloc(repo: Injection.get());
  final _businessBloc = BusinessBloc(repo: Injection.get());
  final _storageBloc = StorageBloc(repo: Injection.get());
  final _locationBloc = LocationBloc(repo: Injection.get());

  /// UI
  bool _isLoading = false, _hasResetFields = false;
  ThemeData kTheme;

  /// Business
  File _businessDocument, _birthCertDoc, _nationalIdDoc;
  String _busFileName,
      _birthCertFileName,
      _idFileName,
      _locationName,
      _userId,
      _docUrl;
  final _timestamp = DateTime.now().millisecondsSinceEpoch.toString();

  /// Form
  final _nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  /// Location
  LatLng _initialLocation;

  /// User
  BaseArtisan _currentUser;

  @override
  void initState() {
    super.initState();

    if (mounted) {
      _hasResetFields = widget.business == null;
      _nameController.text = widget.business?.name;
      _locationName = widget.business?.location;
      _docUrl = widget.business?.docUrl;

      /// user update status
      _userBloc.listen((state) async {
        if (state is SuccessState<BaseArtisan>) {
          _currentUser = state.data;
          _birthCertFileName = _currentUser?.birthCert;
          _idFileName = _currentUser?.nationalId;
          if (mounted) setState(() {});
        } else if (state is SuccessState<void>) {
          if (mounted) {
            showSnackBarMessage(context,
                message: 'Business registered successfully');
            await context.navigator.pushAndRemoveUntil(
              Routes.homePage,
              (route) => false,
            );
          }
        } else if (state is ErrorState) {
          if (mounted) {
            showSnackBarMessage(context, message: 'Failed to update profile');
          }
        }
      });

      /// get current location
      _locationBloc
        ..add(LocationEvent.getCurrentLocation())
        ..listen((state) {
          if (state is SuccessState<BaseLocationMetadata>) {
            _initialLocation = LatLng(state.data.lat, state.data.lng);
            logger.d('Location -> ${state.data}');
            if (mounted) setState(() {});
          }
        });

      /// observe business upload state
      _businessBloc.listen((state) async {
        if (state is LoadingState) {
          _isLoading = true;
          if (mounted) setState(() {});
        } else if (state is SuccessState) {
          _isLoading = false;
          if (mounted) {
            setState(() {});
            showSnackBarMessage(context, message: 'Updated business profile');

            if (state.data != null) {
              _userBloc.add(
                UserEvent.updateUserEvent(
                  user: _currentUser.copyWith(
                    businessId: state.data,
                    birthCert: _birthCertFileName,
                    nationalId: _idFileName,
                  ),
                ),
              );
            }

            // navigate to home page
            await context.navigator
                .pushAndRemoveUntil(Routes.homePage, (_) => false);
          }
        }
      });

      /// storage upload progress
      _storageBloc.listen((state) async {
        if (state is LoadingState) {
          _isLoading = true;
          if (mounted) setState(() {});
        } else if (state is ErrorState) {
          _isLoading = false;
          if (mounted) {
            setState(() {});
            showSnackBarMessage(context,
                message: 'Failed to save business information');
          }
        } else if (state is SuccessState<String>) {
          _docUrl = state.data;
          _isLoading = false;
          if (mounted) setState(() {});
          logger.i('Document upload complete');
        }
      });

      /// observe current user
      _prefsBloc
        ..add(PrefsEvent.getUserIdEvent())
        ..listen((userIdState) {
          if (userIdState is SuccessState<String> && userIdState.data != null) {
            _userId = userIdState.data;
            if (mounted) setState(() {});

            /// get artisan by id
            _userBloc.add(UserEvent.getArtisanByIdEvent(id: userIdState.data));
          }
        });
    }
  }

  @override
  void dispose() {
    _businessBloc.close();
    _storageBloc.close();
    _userBloc.close();
    _locationBloc.close();
    _prefsBloc.close();
    super.dispose();
  }

  /// pick file from docs
  void _pickDocument({
    bool birthCert = false,
    bool nationalId = false,
  }) async {
    var result = await FilePicker.platform.pickFiles(
      allowedExtensions: ['pdf'], // only pdf document files
      allowCompression: true,
      type: FileType.custom,
      withData: true,
    );

    if (result != null) {
      final file = File(result.files.single.path);
      if (nationalId) {
        /// get id document
        _nationalIdDoc = file;
        _idFileName = result.names.single.trim();
        if (mounted) setState(() {});

        /// perform upload
        StorageBloc(repo: Injection.get())
          ..add(
            StorageEvent.uploadFile(
              path: Uuid().v4(),
              filePath: _nationalIdDoc.absolute.path,
              isImage: false,
            ),
          )
          ..listen((state) {
            if (state is SuccessState<String>) {
              _idFileName = state.data;
              if (mounted) setState(() {});
            }
          });
      } else if (birthCert) {
        /// get birth cert document
        _birthCertDoc = file;
        _birthCertFileName = result.names.single.trim();
        if (mounted) setState(() {});

        /// perform upload
        StorageBloc(repo: Injection.get())
          ..add(
            StorageEvent.uploadFile(
              path: Uuid().v4(),
              filePath: _birthCertDoc.absolute.path,
              isImage: false,
            ),
          )
          ..listen((state) {
            if (state is SuccessState<String>) {
              _birthCertFileName = state.data;
              if (mounted) setState(() {});
            }
          });
      } else {
        /// get business document
        _businessDocument = file;
        _busFileName = result.names.single.trim();
        if (mounted) setState(() {});

        /// perform upload
        _storageBloc.add(
          StorageEvent.uploadFile(
            path: widget.business == null ? _timestamp : widget.business.id,
            filePath: _businessDocument.absolute.path,
            isImage: false,
          ),
        );
      }
    }
  }

  /// pick user's location
  void _pickLocation() async {
    var apiKey = DotEnv().env['mapsKey'];

    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PlacePicker(
          apiKey: apiKey,
          onPlacePicked: (result) {
            _locationName = result.name;
            Navigator.of(context).pop();
            if (mounted) setState(() {});
          },
          initialPosition: _initialLocation,
          useCurrentLocation: true,
          enableMyLocationButton: true,
          enableMapTypeButton: false,
          initialMapType: MapType.normal,
          usePinPointingSearch: true,
          forceAndroidLocationManager: Platform.isAndroid,
          searchingText: 'Search business address',
          autocompleteComponents: [Component(Component.country, 'gh')],
        ),
      ),
    );
  }

  Future<bool> _handleBackPressed() async {
    final result = await showCustomDialog(
      context: context,
      builder: (_) => BasicDialog(
        message: 'Do you wish to cancel your business registration?',
        onComplete: () {
          context.navigator.pop();
        },
      ),
    );
    return Future<bool>.value(result);
  }

  @override
  Widget build(BuildContext context) {
    kTheme = Theme.of(context);

    return WillPopScope(
      onWillPop: _handleBackPressed,
      child: BlocBuilder<BusinessBloc, BlocState>(
        cubit: _businessBloc,
        builder: (_, state) => Scaffold(
          backgroundColor: kTheme.colorScheme.primary,
          body: Stack(
            children: [
              /// content
              if (_isLoading) ...{
                Loading(),
              } else ...{
                Positioned.fill(
                  top: kSpacingX96,
                  child: SingleChildScrollView(
                    padding: EdgeInsets.fromLTRB(
                      kSpacingX24,
                      kSpacingNone,
                      kSpacingX24,
                      kSpacingX8,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Business Profile',
                          style: kTheme.textTheme.headline4.copyWith(
                            color: kTheme.colorScheme.onPrimary,
                          ),
                        ),
                        SizedBox(height: kSpacingX8),
                        Text(
                          'Complete your business profile details by uploading a supporting document for approval',
                          style: kTheme.textTheme.bodyText1.copyWith(
                            color: kTheme.colorScheme.onPrimary,
                          ),
                        ),
                        SizedBox(height: kSpacingX48),

                        /// business name
                        Form(
                          key: _formKey,
                          child: TextFormInput(
                            labelText: 'Business name',
                            controller: _nameController,
                            color: kTheme.colorScheme.onPrimary,
                            cursorColor: kTheme.colorScheme.onBackground,
                            validator: (_) =>
                                _.isEmpty ? 'Name is required' : null,
                            textCapitalization: TextCapitalization.words,
                            enabled: !_isLoading,
                          ),
                        ),

                        /// business doc
                        Card(
                          child: ListTile(
                            onTap: _pickDocument,
                            title: Text('Upload Business Document'),
                            subtitle: Text(
                              _busFileName == null || _hasResetFields
                                  ? 'This is required for approval (Only PDFs supported)'
                                  : 'File uploaded',
                            ),
                            dense: true,
                            trailing: Icon(
                              _busFileName == null ? kArrowIcon : kDoneIcon,
                              color: kTheme.colorScheme.onBackground,
                            ),
                          ),
                        ),

                        Card(
                          child: ListTile(
                            onTap: () => _pickDocument(birthCert: true),
                            title: Text('Upload Birth Certificate'),
                            subtitle: Text(
                              _birthCertFileName == null || _hasResetFields
                                  ? 'This is required for approval (Only PDFs supported)'
                                  : 'File uploaded',
                            ),
                            dense: true,
                            trailing: Icon(
                              _birthCertFileName == null
                                  ? kArrowIcon
                                  : kDoneIcon,
                              color: kTheme.colorScheme.onBackground,
                            ),
                          ),
                        ),

                        Card(
                          child: ListTile(
                            onTap: () => _pickDocument(nationalId: true),
                            title: Text('Upload National ID'),
                            subtitle: Text(
                              _idFileName == null || _hasResetFields
                                  ? 'This is required for approval (Only PDFs supported)'
                                  : 'File uploaded',
                            ),
                            dense: true,
                            trailing: Icon(
                              _idFileName == null ? kArrowIcon : kDoneIcon,
                              color: kTheme.colorScheme.onBackground,
                            ),
                          ),
                        ),

                        /// business location
                        Card(
                          child: ListTile(
                            onTap: _pickLocation,
                            title: Text('Business Location'),
                            subtitle: Text(
                              _locationName ?? 'This is required for approval',
                            ),
                            dense: true,
                            trailing: Icon(
                              _locationName == null ? kArrowIcon : kDoneIcon,
                              color: kTheme.colorScheme.onBackground,
                            ),
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
                    color: kTheme.colorScheme.onPrimary,
                    onPressed: () => _handleBackPressed(),
                  ),
                ),

                /// reset fields button
                Positioned(
                  top: kSpacingX36,
                  right: kSpacingX16,
                  child: IconButton(
                    icon: Icon(kClearIcon),
                    color: kTheme.colorScheme.onPrimary,
                    onPressed: () async {
                      await showCustomDialog(
                        context: context,
                        builder: (_) => BasicDialog(
                          message:
                              'This will reset all fields and selected files. Do you wish to continue?',
                          onComplete: () {
                            _locationName = null;
                            _busFileName = null;
                            _birthCertFileName = null;
                            _idFileName = null;
                            _nameController.clear();
                            _hasResetFields = true;
                            setState(() {});
                          },
                        ),
                      );
                    },
                  ),
                ),

                Align(
                  alignment: Alignment.bottomCenter,
                  child: InkWell(
                    splashColor: kTheme.splashColor,
                    onTap: () async {
                      if (!_formKey.currentState.validate()) return;
                      _formKey.currentState.save();

                      /// save business
                      if (widget.business == null) {
                        if (_locationName != null &&
                            _busFileName != null &&
                            _birthCertFileName != null &&
                            _idFileName != null) {
                          _businessBloc.add(
                            BusinessEvent.uploadBusiness(
                              docUrl: _docUrl,
                              name: _nameController.text?.trim(),
                              artisan: _userId,
                              location: _locationName,
                              nationalId: _idFileName,
                              birthCert: _birthCertFileName,
                            ),
                          );
                        } else {
                          showSnackBarMessage(context,
                              message:
                                  'Please add all required documents first');
                        }
                      } else {
                        _businessBloc.add(BusinessEvent.updateBusiness(
                          business: widget.business.copyWith(
                            docUrl: _docUrl,
                            name: _nameController.text?.trim(),
                            artisanId: _userId,
                            location: _locationName,
                          ),
                        ));
                      }
                    },
                    child: Container(
                      width: SizeConfig.screenWidth,
                      alignment: Alignment.center,
                      height: kToolbarHeight,
                      decoration: BoxDecoration(
                        color: kTheme.colorScheme.secondary,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Save & Continue',
                            style: kTheme.textTheme.button.copyWith(
                              color: kTheme.colorScheme.onSecondary,
                            ),
                          ),
                          SizedBox(width: kSpacingX12),
                          Icon(
                            kArrowIcon,
                            color: kTheme.colorScheme.onSecondary,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              },
            ],
          ),
        ),
      ),
    );
  }
}
