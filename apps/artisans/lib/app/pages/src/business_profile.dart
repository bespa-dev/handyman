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

/// https://pub.dev/packages/google_maps_place_picker
class BusinessProfilePage extends StatefulWidget {
  final BaseBusiness business;

  const BusinessProfilePage({Key key, this.business}) : super(key: key);

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
  bool _isLoading = false;
  ThemeData kTheme;

  /// Business
  File _businessDocument;
  String _fileName, _locationName, _userId, _docUrl;
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
      _nameController.text = widget.business?.name;
      _locationName = widget.business?.location;

      /// user update status
      _userBloc.listen((state) {
        if (state is SuccessState<BaseArtisan>) {
          _currentUser = state.data;
          logger.i("Current user -> $_currentUser");
          if (mounted) setState(() {});
        } else if (state is SuccessState<void>) {
          if (mounted) {
            showSnackBarMessage(context,
                message: "Business registered successfully");
            context.navigator.pushAndRemoveUntil(
              Routes.homePage,
              (route) => false,
            );
          }
        } else if (state is ErrorState) {
          if (mounted)
            showSnackBarMessage(context, message: "Failed to update profile");
        }
      });

      /// get current location
      _locationBloc
        ..add(LocationEvent.getCurrentLocation())
        ..listen((state) {
          if (state is SuccessState<LocationMetadata>) {
            _initialLocation = LatLng(state.data.lat, state.data.lng);
            logger.d("Location -> ${state.data}");
            if (mounted) setState(() {});
          }
        });

      /// observe business upload state
      _businessBloc.listen((state) {
        if (state is LoadingState) {
          _isLoading = true;
          if (mounted) setState(() {});
        } else if (state is ErrorState) {
          _isLoading = false;
          if (mounted) {
            setState(() {});
            showSnackBarMessage(context,
                message: "Failed to save business information");
          }
        } else if (state is SuccessState) {
          _isLoading = false;
          if (mounted) {
            setState(() {});
            showSnackBarMessage(context,
                message: "Uploaded business profile completed");
            if (state.data != null)
              _userBloc.add(
                UserEvent.updateUserEvent(
                  user: _currentUser.copyWith(
                    businessId: state.data,
                  ),
                ),
              );
            else
              context.navigator.pop();
          }
        }
      });

      /// storage upload progress
      _storageBloc.listen((state) {
        logger.i(state.runtimeType);
        if (state is LoadingState) {
          _isLoading = true;
          if (mounted) setState(() {});
        } else if (state is ErrorState) {
          _isLoading = false;
          if (mounted) {
            setState(() {});
            showSnackBarMessage(context,
                message: "Failed to save business information");
          }
        } else if (state is SuccessState<String>) {
          _docUrl = state.data;
          _isLoading = false;
          if (mounted) setState(() {});
          logger.i("Document upload complete");
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
  void _pickDocument() async {
    FilePickerResult result = await FilePicker.platform.pickFiles(
      allowedExtensions: ["pdf", "docx", "doc"], // only document files
      allowCompression: true,
      type: FileType.custom,
      withData: true,
    );

    if (result != null) {
      /// get business document
      _businessDocument = File(result.files.single.path);
      _fileName = result.names.single.trim();
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

  /// pick user's location
  void _pickLocation() async {
    var apiKey = DotEnv().env["mapsKey"];

    Navigator.push(
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
          searchingText: "Search business address",
          autocompleteComponents: [Component(Component.country, "gh")],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    kTheme = Theme.of(context);

    return BlocBuilder<BusinessBloc, BlocState>(
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
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                    kSpacingX24,
                    kSpacingNone,
                    kSpacingX24,
                    kSpacingX8,
                  ),
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Business Profile",
                        style: kTheme.textTheme.headline4.copyWith(
                          color: kTheme.colorScheme.onPrimary,
                        ),
                      ),
                      SizedBox(height: kSpacingX8),
                      Text(
                        "Complete your business profile details by uploading a supporting document for approval",
                        style: kTheme.textTheme.bodyText1.copyWith(
                          color: kTheme.colorScheme.onPrimary,
                        ),
                      ),
                      SizedBox(height: kSpacingX48),

                      /// business name
                      Form(
                        key: _formKey,
                        child: TextFormInput(
                          labelText: "Business name",
                          controller: _nameController,
                          cursorColor: kTheme.colorScheme.onPrimary,
                          validator: (_) =>
                              _.isEmpty ? "Name is required" : null,
                          textCapitalization: TextCapitalization.words,
                          enabled: !_isLoading,
                        ),
                      ),

                      /// business doc
                      Card(
                        child: ListTile(
                          onTap: _pickDocument,
                          title: Text("Upload Business Document"),
                          subtitle: Text(
                            _fileName == null
                                ? "This is required for approval"
                                : _fileName,
                          ),
                          trailing: Icon(
                            kArrowIcon,
                            color: kTheme.colorScheme.onBackground,
                          ),
                        ),
                      ),

                      /// business location
                      Card(
                        child: ListTile(
                          onTap: _pickLocation,
                          title: Text("Business Location"),
                          subtitle: Text(
                            _locationName == null
                                ? "This is required for approval"
                                : _locationName,
                          ),
                          trailing: Icon(
                            kArrowIcon,
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
                  onPressed: () => context.navigator.pop(),
                ),
              ),

              if (_locationName != null &&
                  _businessDocument != null &&
                  _docUrl != null) ...{
                Align(
                  alignment: Alignment.bottomCenter,
                  child: InkWell(
                    splashColor: kTheme.splashColor,
                    onTap: () {
                      if (!_formKey.currentState.validate()) return;
                      _formKey.currentState.save();

                      /// save business
                      if (widget.business == null)
                        _businessBloc.add(
                          BusinessEvent.uploadBusiness(
                            docUrl: _docUrl,
                            name: _nameController.text?.trim(),
                            artisan: _userId,
                            location: _locationName,
                          ),
                        );
                      else {
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
                            "Save & Continue",
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
            },
          ],
        ),
      ),
    );
  }
}
