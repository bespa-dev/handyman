import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:handyman/app/model/prefs_provider.dart';
import 'package:handyman/app/routes/route.gr.dart';
import 'package:handyman/app/widget/buttons.dart';
import 'package:handyman/app/widget/fields.dart';
import 'package:handyman/core/constants.dart';
import 'package:handyman/core/service_locator.dart';
import 'package:handyman/core/size_config.dart';
import 'package:handyman/domain/models/user.dart';
import 'package:handyman/domain/services/auth.dart';
import 'package:handyman/domain/services/data.dart';
import 'package:handyman/domain/services/storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AccountCompletionPage extends StatefulWidget {
  @override
  _AccountCompletionPageState createState() => _AccountCompletionPageState();
}

class _AccountCompletionPageState extends State<AccountCompletionPage> {
  final _storageService = sl.get<StorageService>();

  // region Form
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _emailController = TextEditingController(),
      _nameController = TextEditingController();

  // endregion

  // region Image Picker
  File _avatar;
  String _userId;
  final picker = ImagePicker();

  // endregion

  ThemeData _themeData;

  Future<void> _getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      debugPrint("Image picked as -> ${pickedFile.path}");
      _avatar = File(pickedFile.path);
    } else {
      debugPrint('No image selected.');
    }
    setState(() {});
    await _storageService.uploadFile(_avatar, path: _userId);
  }

  @override
  void initState() {
    super.initState();
    _storageService.onStorageUploadResponse.listen((event) {
      debugPrint(event.state.toString());
    });
  }

  @override
  void dispose() {
    _storageService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _themeData = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final kWidth = size.width;
    final kHeight = size.height;

    return Consumer<AuthService>(
      builder: (_, authService, __) => StreamBuilder<BaseUser>(
        stream: authService.currentUser(),
        builder: (context, userSnapshot) => Consumer<PrefsProvider>(
          builder: (_, prefs, __) {
            _userId = prefs.userId;
            return Scaffold(
              key: _scaffoldKey,
              extendBodyBehindAppBar: true,
              extendBody: true,
              body: Container(
                height: kHeight,
                width: kWidth,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    prefs.isLightTheme
                        ? Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(kBackgroundAsset),
                                fit: BoxFit.cover,
                              ),
                            ),
                          )
                        : SizedBox.shrink(),
                    Positioned.fill(
                      child: SafeArea(
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                  height: getProportionateScreenHeight(
                                      kSpacingX96)),
                              _avatar == null
                                  ? _buildImagePickerWidget()
                                  : _buildAvatarWidget(),
                              SizedBox(
                                  height: getProportionateScreenHeight(
                                      kSpacingX24)),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: getProportionateScreenWidth(
                                        kSpacingX24)),
                                child: Form(
                                  key: _formKey,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      TextFormInput(
                                        labelText: "Full Name",
                                        enabled: true,
                                        controller: _nameController,
                                        validator: (value) => value == null ||
                                                value.isEmpty ||
                                                value.length < 6
                                            ? "Provide your full name"
                                            : null,
                                        color: _themeData
                                            .textTheme.bodyText1.color,
                                      ),
                                      TextFormInput(
                                        labelText: "Email Address",
                                        enabled: false,
                                        validator: (value) => null,
                                        color: _themeData
                                            .textTheme.bodyText1.color,
                                        controller: _emailController
                                          ..text =
                                              userSnapshot.data?.user?.email,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                  height: getProportionateScreenHeight(
                                      kSpacingX24)),
                              Consumer<DataService>(
                                builder: (_, dataService, __) => ButtonOutlined(
                                  width:
                                      getProportionateScreenWidth(kSpacingX200),
                                  themeData: _themeData,
                                  onTap: () async {
                                    _formKey.currentState.save();
                                    if (_formKey.currentState.validate()) {
                                      debugPrint("Validated form successfully");
                                      await dataService
                                          .updateUser(userSnapshot.data);
                                      context.navigator.popAndPush(
                                        userSnapshot.data?.isCustomer ?? false
                                            ? Routes.homePage
                                            : Routes.dashboardPage,
                                      );
                                    }
                                  },
                                  enabled: true,
                                  label: "Save",
                                ),
                              ),
                              // SizedBox(height: getProportionateScreenHeight(kSpacingX24)),
                            ],
                          ),
                        ),
                      ),
                    ),
                    prefs.userType == kArtisanString
                        ? SizedBox.shrink()
                        : Positioned(
                            top: getProportionateScreenHeight(kSpacingX64),
                            right: kSpacingNone,
                            child: InkWell(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(
                                    getProportionateScreenWidth(kSpacingX24)),
                                bottomLeft: Radius.circular(
                                    getProportionateScreenWidth(kSpacingX24)),
                              ),
                              onTap: () => context.navigator.popAndPush(
                                prefs.userType == kCustomerString
                                    ? Routes.homePage
                                    : Routes.dashboardPage,
                              ),
                              child: Container(
                                height: kToolbarHeight,
                                width: kWidth * 0.3,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: _themeData.primaryColor,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(
                                        getProportionateScreenWidth(
                                            kSpacingX24)),
                                    bottomLeft: Radius.circular(
                                        getProportionateScreenWidth(
                                            kSpacingX24)),
                                  ),
                                ),
                                child: Text(
                                  "Skip".toUpperCase(),
                                  style: _themeData.textTheme.button.copyWith(
                                    color: _themeData.colorScheme.onPrimary,
                                  ),
                                ),
                              ),
                            ),
                          ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildImagePickerWidget() => GestureDetector(
        onTap: () async => await _getImage(),
        child: Container(
          clipBehavior: Clip.hardEdge,
          alignment: Alignment.center,
          height: getProportionateScreenHeight(kSpacingX200),
          width: getProportionateScreenWidth(kSpacingX200),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _themeData.disabledColor.withOpacity(kEmphasisLow),
            border: Border.all(
              color:
                  _themeData.colorScheme.onBackground.withOpacity(kOpacityX70),
              width: kSpacingX2,
            ),
          ),
          child: Icon(
            Feather.image,
            size: kSpacingX64,
            color: _themeData.colorScheme.onBackground.withOpacity(kOpacityX70),
          ),
        ),
      );

  Widget _buildAvatarWidget() => Container(
        child: Stack(
          children: [
            Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: Image.file(
                _avatar,
                fit: BoxFit.cover,
                height: getProportionateScreenHeight(kSpacingX200),
                width: getProportionateScreenWidth(kSpacingX200),
              ),
            ),
            Positioned(
              bottom: getProportionateScreenHeight(kSpacingX16),
              right: getProportionateScreenWidth(kSpacingNone),
              child: InkWell(
                borderRadius: BorderRadius.all(Radius.circular(kSpacingX56)),
                onTap: () async => await _getImage(),
                child: Container(
                  alignment: Alignment.center,
                  height: getProportionateScreenHeight(kSpacingX56),
                  width: getProportionateScreenWidth(kSpacingX56),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _themeData.colorScheme.primary,
                  ),
                  child: Icon(
                    Feather.image,
                    size: kSpacingX24,
                    color: _themeData.colorScheme.onPrimary,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
}
