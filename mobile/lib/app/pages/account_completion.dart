import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:handyman/app/model/prefs_provider.dart';
import 'package:handyman/app/routes/route.gr.dart';
import 'package:handyman/app/widget/buttons.dart';
import 'package:handyman/app/widget/fields.dart';
import 'package:handyman/core/constants.dart';
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
  StorageService _storageService;
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _emailController = TextEditingController(),
      _nameController = TextEditingController();
  File _avatar;
  final picker = ImagePicker();
  ThemeData _themeData;

  Future<void> _getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _avatar = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
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
          builder: (context, userSnapshot) => Consumer<StorageService>(
                builder: (_, storageService, __) {
                  _storageService = storageService;
                  return Consumer<PrefsProvider>(
                    builder: (_, prefs, __) => StreamBuilder<
                            StorageUploadResponse>(
                        stream: storageService.uploadFile(
                          _avatar,
                          path: prefs.userId,
                        ),
                        builder: (context, snapshot) {
                          final response = snapshot.data;
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
                                              image:
                                                  AssetImage(kBackgroundAsset),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        )
                                      : SizedBox.shrink(),
                                  Positioned.fill(
                                    child: SafeArea(
                                      child: SingleChildScrollView(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                                height:
                                                    getProportionateScreenHeight(
                                                        kSpacingX96)),
                                            _avatar == null
                                                ? _buildImagePickerWidget()
                                                : _buildAvatarWidget(),
                                            SizedBox(
                                                height:
                                                    getProportionateScreenHeight(
                                                        kSpacingX24)),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal:
                                                      getProportionateScreenWidth(
                                                          kSpacingX48)),
                                              child: Form(
                                                key: _formKey,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    TextFormInput(
                                                      labelText: "Full Name",
                                                      enabled:
                                                          response.isInComplete,
                                                      controller:
                                                          _nameController,
                                                      validator: (value) => value ==
                                                                  null ||
                                                              value.isEmpty ||
                                                              value.length < 6
                                                          ? "Provide your full name"
                                                          : null,
                                                      color: _themeData
                                                          .textTheme
                                                          .bodyText1
                                                          .color,
                                                    ),
                                                    TextFormInput(
                                                      labelText:
                                                          "Email Address",
                                                      enabled: false,
                                                      validator: (value) =>
                                                          null,
                                                      color: _themeData
                                                          .textTheme
                                                          .bodyText1
                                                          .color,
                                                      controller:
                                                          _emailController
                                                            ..text =
                                                                userSnapshot
                                                                    .data
                                                                    ?.user
                                                                    ?.email,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                                height:
                                                    getProportionateScreenHeight(
                                                        kSpacingX24)),
                                            Consumer<DataService>(
                                              builder: (_, dataService, __) =>
                                                  ButtonOutlined(
                                                width:
                                                    getProportionateScreenWidth(
                                                        kSpacingX200),
                                                themeData: _themeData,
                                                onTap: () async {
                                                  _formKey.currentState.save();
                                                  if (_formKey.currentState
                                                      .validate()) {
                                                    // TODO: Update user data
                                                    debugPrint(
                                                        "Validated form successfully");
                                                    await dataService
                                                        .updateUser(
                                                            userSnapshot.data);
                                                    context.navigator
                                                        .popAndPush(
                                                      userSnapshot.data
                                                                  ?.isCustomer ??
                                                              false
                                                          ? Routes.homePage
                                                          : Routes
                                                              .dashboardPage,
                                                    );
                                                  }
                                                },
                                                enabled: !response.isInComplete,
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
                                          top: getProportionateScreenHeight(
                                              kSpacingX64),
                                          right: 0,
                                          child: InkWell(
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(
                                                  getProportionateScreenWidth(
                                                      kSpacingX24)),
                                              bottomLeft: Radius.circular(
                                                  getProportionateScreenWidth(
                                                      kSpacingX24)),
                                            ),
                                            onTap: () =>
                                                context.navigator.popAndPush(
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
                                                style: _themeData
                                                    .textTheme.button
                                                    .copyWith(
                                                  color: _themeData
                                                      .colorScheme.onPrimary,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                ],
                              ),
                            ),
                          );
                        }),
                  );
                },
              )),
    );
  }

  Widget _buildImagePickerWidget() => GestureDetector(
        onTap: () => _getImage(),
        child: Container(
          clipBehavior: Clip.hardEdge,
          alignment: Alignment.center,
          height: getProportionateScreenHeight(kSpacingX200),
          width: getProportionateScreenWidth(kSpacingX200),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _themeData.disabledColor,
          ),
          child: Icon(Feather.image, size: kSpacingX64),
        ),
      );

  Widget _buildAvatarWidget() => Container(
        height: getProportionateScreenHeight(kSpacingX200),
        width: getProportionateScreenWidth(kSpacingX200),
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: _themeData.disabledColor.withOpacity(kOpacityX50),
        ),
        child: Stack(
          children: [
            Image.file(
              _avatar,
              fit: BoxFit.cover,
              height: getProportionateScreenHeight(kSpacingX200),
              width: getProportionateScreenWidth(kSpacingX200),
            ),
            Positioned.fill(
              child: GestureDetector(
                onTap: () => _getImage(),
                child: Container(
                  height: getProportionateScreenHeight(kSpacingX200),
                  width: getProportionateScreenWidth(kSpacingX200),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _themeData.disabledColor,
                  ),
                  child: Icon(Feather.image, size: kSpacingX64),
                ),
              ),
            ),
          ],
        ),
      );
}
