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
import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:handyman/app/bloc/bloc.dart';
import 'package:handyman/app/pages/pages.dart';
import 'package:handyman/app/routes/routes.gr.dart';
import 'package:handyman/app/widgets/widgets.dart';
import 'package:handyman/domain/models/models.dart';
import 'package:handyman/shared/shared.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sliding_sheet/sliding_sheet.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  /// blocs
  final _authBloc = AuthBloc(repo: Injection.get());
  final _prefsBloc = PrefsBloc(repo: Injection.get());
  final _userBloc = UserBloc(repo: Injection.get());
  final _updateUserBloc = UserBloc(repo: Injection.get());
  final _storageBloc = StorageBloc(repo: Injection.get());

  /// UI
  ThemeData kTheme;
  bool _isLoading = false;
  File _avatarFile;
  final _textController = TextEditingController();

  /// User
  BaseArtisan _currentUser;

  @override
  void dispose() {
    _authBloc.close();
    _prefsBloc.close();
    _userBloc.close();
    _storageBloc.close();
    _updateUserBloc.close();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    if (mounted) {
      /// observe current user info
      _userBloc
        ..add(UserEvent.currentUserEvent())
        ..listen((state) {
          if (state is SuccessState<void>) {
            _isLoading = false;
            _avatarFile = null;
            if (mounted) setState(() {});
          }
        });

      _storageBloc.listen((state) {
        if (state is LoadingState) {
          _isLoading = true;
          if (mounted) setState(() {});
        } else if (state is SuccessState<String>) {
          _isLoading = false;
          _avatarFile = null;
          if (mounted) setState(() {});
          _currentUser = _currentUser.copyWith(avatar: state.data);

          /// update user profile image
          _updateUserBloc.add(UserEvent.updateUserEvent(user: _currentUser));
        } else {
          _isLoading = false;
          if (mounted) setState(() {});
        }
      });
    }
  }

  void _pickAvatar() async {
    final picker = ImagePicker();
    var pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      _avatarFile = await ImageCropper.cropImage(
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
            toolbarColor: kTheme.colorScheme.primary,
            toolbarWidgetColor: kTheme.colorScheme.onPrimary,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false,
          ),
          iosUiSettings: IOSUiSettings(
            minimumAspectRatio: 1.0,
          ));

      if (_avatarFile != null) {
        /// Upload image
        _storageBloc.add(
          StorageEvent.uploadFile(
              path: _currentUser.id,
              filePath: _avatarFile.absolute.path,
              isImage: true),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    kTheme = Theme.of(context);

    return BlocBuilder<UserBloc, BlocState>(
      cubit: _userBloc,
      builder: (_, state) => state is SuccessState<Stream<BaseArtisan>>
          ? StreamBuilder<BaseArtisan>(
              stream: state.data,
              builder: (_, snapshot) {
                if (_currentUser == null) _currentUser = snapshot.data;
                return AnimatedOpacity(
                  opacity: _currentUser == null ? 0 : 1,
                  duration: kScaleDuration,
                  child: _currentUser == null
                      ? SizedBox.shrink()
                      : Stack(
                          children: [
                            /// content
                            Positioned.fill(
                              top: kSpacingX36,
                              child: SingleChildScrollView(
                                padding: EdgeInsets.only(
                                  top: kSpacingX64,
                                  left: kSpacingX24,
                                  right: kSpacingX16,
                                  bottom: kSpacingX56,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    /// header
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            ConstrainedBox(
                                              constraints:
                                                  BoxConstraints.tightFor(
                                                width: SizeConfig.screenWidth *
                                                    0.7,
                                              ),
                                              child: Text(
                                                _currentUser?.name ??
                                                    "No username",
                                                style:
                                                    kTheme.textTheme.headline6,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            SizedBox(height: kSpacingX4),
                                            Text.rich(
                                              TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text: parseFromTimestamp(
                                                        _currentUser
                                                            ?.createdAt),
                                                  ),
                                                  TextSpan(
                                                    text:
                                                        "\n${_currentUser.email}",
                                                  ),
                                                ],
                                              ),
                                              style: kTheme.textTheme.caption,
                                            ),
                                          ],
                                        ),
                                        UserAvatar(
                                          url: _avatarFile?.absolute?.path ??
                                              _currentUser?.avatar,
                                          onTap: _showOptionsSheet,
                                          isFileAsset: _avatarFile != null,
                                          radius: kSpacingX72,
                                        ),
                                      ],
                                    ),

                                    Container(
                                      padding: EdgeInsets.only(
                                        top: kSpacingX24,
                                        bottom: kSpacingX12,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            "Personal profile",
                                            style: kTheme.textTheme.headline6
                                                .copyWith(
                                              color: kTheme
                                                  .colorScheme.onBackground
                                                  .withOpacity(kEmphasisMedium),
                                            ),
                                          ),
                                          SizedBox(height: kSpacingX2),
                                          Divider(
                                            endIndent:
                                                SizeConfig.screenWidth * 0.7,
                                          ),
                                        ],
                                      ),
                                    ),

                                    /// full name
                                    Card(
                                      child: ListTile(
                                        leading: Icon(
                                          Feather.user,
                                          color: kTheme.colorScheme.onBackground
                                              .withOpacity(kEmphasisLow),
                                        ),
                                        title: Text(_currentUser?.name ??
                                            "No username"),
                                        subtitle: Text("Tap to edit"),
                                        dense: true,
                                        onTap: () async {
                                          _textController.text =
                                              _currentUser?.name;
                                          final data = await showCustomDialog(
                                            context: context,
                                            builder: (_) => ReplyMessageDialog(
                                              title: "Full Name",
                                              controller: _textController,
                                              maxLines: 1,
                                              hintText: _currentUser?.name,
                                            ),
                                          );
                                          if (data != null && data.isNotEmpty) {
                                            _currentUser = _currentUser
                                                .copyWith(name: data);
                                            _updateUserBloc.add(
                                                UserEvent.updateUserEvent(
                                                    user: _currentUser));
                                            if (mounted) setState(() {});
                                          }
                                        },
                                        trailing:
                                            Icon(kEditIcon, size: kSpacingX16),
                                      ),
                                    ),

                                    /// phone number
                                    Card(
                                      child: ListTile(
                                        leading: Icon(
                                          Feather.phone,
                                          color: kTheme.colorScheme.onBackground
                                              .withOpacity(kEmphasisLow),
                                        ),
                                        title: Text(_currentUser?.phone ??
                                            "No number set"),
                                        subtitle: Text("Tap to edit"),
                                        dense: true,
                                        onTap: () async {
                                          _textController.text =
                                              _currentUser?.phone;
                                          final data = await showCustomDialog(
                                            context: context,
                                            builder: (_) => ReplyMessageDialog(
                                              title: "Phone number",
                                              controller: _textController,
                                              maxLines: 1,
                                              hintText: _currentUser?.phone,
                                            ),
                                          );
                                          if (data != null &&
                                              data.isNotEmpty &&
                                              Validators.validatePhoneNumber(
                                                  data)) {
                                            _currentUser = _currentUser
                                                .copyWith(phone: data);
                                            _updateUserBloc.add(
                                                UserEvent.updateUserEvent(
                                                    user: _currentUser));
                                            if (mounted) setState(() {});
                                          }
                                        },
                                        trailing:
                                            Icon(kEditIcon, size: kSpacingX16),
                                      ),
                                    ),

                                    /// start working hours
                                    Card(
                                      child: ListTile(
                                        leading: Icon(
                                          Icons.history,
                                          color: kTheme.colorScheme.onBackground
                                              .withOpacity(kEmphasisLow),
                                        ),
                                        title: Text(
                                          parseFromTimestamp(
                                                _currentUser?.startWorkingHours,
                                                isChatFormat: true,
                                              ) ??
                                              "Start working hours",
                                        ),
                                        subtitle: Text("Start working hours"),
                                        dense: true,
                                        onTap: () async {
                                          Navigator.of(context).push(
                                            showPicker(
                                              context: context,
                                              value: DateTime.parse(_currentUser
                                                      .startWorkingHours)
                                                  .toTimeOfDay(),
                                              onChange: (time) {
                                                _currentUser =
                                                    _currentUser.copyWith(
                                                        startWorkingHours: time
                                                            .toDateTime()
                                                            .toIso8601String());
                                                _updateUserBloc.add(
                                                    UserEvent.updateUserEvent(
                                                        user: _currentUser));
                                                if (mounted) setState(() {});
                                              },
                                            ),
                                          );
                                        },
                                        trailing:
                                            Icon(kEditIcon, size: kSpacingX16),
                                      ),
                                    ),

                                    /// end working hours
                                    Card(
                                      child: ListTile(
                                        leading: Icon(
                                          Icons.history,
                                          color: kTheme.colorScheme.onBackground
                                              .withOpacity(kEmphasisLow),
                                        ),
                                        title: Text(
                                          parseFromTimestamp(
                                                _currentUser?.endWorkingHours,
                                                isChatFormat: true,
                                              ) ??
                                              "Closing work hours",
                                        ),
                                        subtitle: Text("Closing work hours"),
                                        dense: true,
                                        onTap: () async {
                                          Navigator.of(context).push(
                                            showPicker(
                                              context: context,
                                              value: DateTime.parse(_currentUser
                                                      .endWorkingHours)
                                                  .toTimeOfDay(),
                                              onChange: (time) {
                                                _currentUser =
                                                    _currentUser.copyWith(
                                                        endWorkingHours: time
                                                            .toDateTime()
                                                            .toIso8601String());
                                                _updateUserBloc.add(
                                                    UserEvent.updateUserEvent(
                                                        user: _currentUser));
                                                if (mounted) setState(() {});
                                              },
                                            ),
                                          );
                                        },
                                        trailing:
                                            Icon(kEditIcon, size: kSpacingX16),
                                      ),
                                    ),
                                    SizedBox(height: kSpacingX64),
                                    ButtonPrimary(
                                      width: SizeConfig.screenWidth * 0.85,
                                      color: kTheme.colorScheme.error,
                                      textColor: kTheme.colorScheme.onError,
                                      onTap: () {
                                        showCustomDialog(
                                          context: context,
                                          builder: (_) => BasicDialog(
                                            message: kSignOutText,
                                            onComplete: () {
                                              _authBloc.add(
                                                  AuthEvent.authSignOutEvent());
                                              context.navigator
                                                  .pushAndRemoveUntil(
                                                      Routes.homePage,
                                                      (_) => _.isFirst);
                                            },
                                          ),
                                        );
                                      },
                                      label: "Sign out",
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
                                onPressed: () => context.navigator.pop(),
                              ),
                            ),
                          ],
                        ),
                );
              })
          : Loading(),
    );
  }

  /// profile image options
  void _showOptionsSheet() async {
    await showSlidingBottomSheet(context, builder: (context) {
      return SlidingSheetDialog(
        elevation: kSpacingX8,
        cornerRadius: kSpacingX16,
        snapSpec: const SnapSpec(
          snap: true,
          snappings: [0.4, 0.7, 1.0],
          positioning: SnapPositioning.relativeToAvailableSpace,
        ),
        duration: kSheetDuration,
        headerBuilder: (context, state) {
          return Container(
            height: kSpacingX56,
            width: SizeConfig.screenWidth,
            color: kTheme.colorScheme.primary,
            alignment: Alignment.center,
            child: Center(
              child: Container(
                width: kSpacingX36,
                height: kSpacingX4,
                decoration: BoxDecoration(
                  color: kTheme.colorScheme.onPrimary.withOpacity(kEmphasisLow),
                  borderRadius: BorderRadius.circular(kSpacingX24),
                ),
              ),
            ),
          );
        },
        builder: (context, state) {
          return Material(
            type: MaterialType.transparency,
            color: kTheme.cardColor,
            child: Container(
              height: SizeConfig.screenHeight * 0.18,
              width: SizeConfig.screenWidth,
              color: kTheme.cardColor,
              child: ListView(
                children: [
                  ListTile(
                    onTap: () {
                      context.navigator.pop();
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) =>
                              ImagePreviewPage(url: _currentUser?.avatar)));
                    },
                    title: Text("View picture"),
                  ),
                  ListTile(
                    onTap: () {
                      context.navigator.pop();
                      _pickAvatar();
                    },
                    title: Text("Update profile picture"),
                  ),
                ],
              ),
            ),
          );
        },
      );
    });
  }
}
