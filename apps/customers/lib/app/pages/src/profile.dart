/*
 * Copyright (c) 2021.
 * This application is owned by HandyMan LLC,
 * developed & designed by Quabynah Codelabs LLC.
 *
 *
 * author: codelbas.quabynah@gmail.com
 */

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:lite/app/bloc/bloc.dart';
import 'package:lite/app/widgets/widgets.dart';
import 'package:lite/domain/models/models.dart';
import 'package:lite/shared/shared.dart';
import 'package:share/share.dart';
import 'package:sliding_sheet/sliding_sheet.dart';

/// design inspiration from:
/// https://dribbble.com/shots/11357800-Profile-Page-UI?utm_source=Clipboard_Shot&utm_campaign=jameelsocorro&utm_content=Profile%20Page%20UI&utm_medium=Social_Share
///
/// User profile page
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
  ThemeData _kTheme;
  File _avatarFile;
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController(),
      _lastNameController = TextEditingController(),
      _phoneNumberController = TextEditingController();

  /// User
  BaseUser _currentUser;

  @override
  void dispose() {
    _authBloc.close();
    _prefsBloc.close();
    _userBloc.close();
    _updateUserBloc.close();
    _storageBloc.close();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    if (mounted) {
      /// observe current user info
      _userBloc.add(UserEvent.currentUserEvent());

      /// observe profile update state
      _updateUserBloc.listen((state) {
        if (state is SuccessState) {
          _userBloc.add(UserEvent.currentUserEvent());
        }
      });

      /// observe upload state
      _storageBloc.listen((state) {
        if (state is SuccessState<String>) {
          _avatarFile = null;
          if (mounted) setState(() {});
          _currentUser = _currentUser.copyWith(avatar: state.data);

          /// update user profile image
          _updateUserBloc.add(UserEvent.updateUserEvent(user: _currentUser));
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
            toolbarColor: _kTheme.colorScheme.primary,
            toolbarWidgetColor: _kTheme.colorScheme.onPrimary,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false,
          ),
          iosUiSettings: IOSUiSettings(
            minimumAspectRatio: 1.0,
          ));

      if (_avatarFile != null) {
        setState(() {});

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
    _kTheme = Theme.of(context);

    return BlocBuilder<UserBloc, BlocState>(
      cubit: _userBloc,
      builder: (_, state) => state is SuccessState<Stream<BaseUser>>
          ? StreamBuilder<BaseUser>(
              stream: state.data,
              builder: (_, snapshot) {
                _currentUser ??= snapshot.data;
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        alignment: Alignment.center,
                        width: kSpacingX120,
                        height: kSpacingX120,
                        margin: EdgeInsets.only(top: kSpacingX28),
                        child: Stack(
                          clipBehavior: Clip.none,
                          overflow: Overflow.visible,
                          children: <Widget>[
                            UserAvatar(
                              url: _avatarFile == null? _currentUser?.avatar : _avatarFile.absolute.path,
                              isFileAsset: _avatarFile != null,
                              onTap: () {
                                if (_currentUser.avatar != null) {
                                  context.navigator.pushImagePreviewPage(
                                      url: _currentUser.avatar);
                                }
                              },
                              radius: kSpacingX120,
                              isCircular: true,
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: GestureDetector(
                                onTap: _pickAvatar,
                                child: Container(
                                  height: kSpacingX36,
                                  width: kSpacingX36,
                                  decoration: BoxDecoration(
                                    color: _kTheme.colorScheme.secondary,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Center(
                                    heightFactor: kSpacingX16,
                                    widthFactor: kSpacingX16,
                                    child: Icon(
                                      LineAwesomeIcons.pen,
                                      color: _kTheme.colorScheme.onSecondary,
                                      size: kSpacingX16,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: kSpacingX20),
                      Text(
                        _currentUser?.name ?? 'No username set',
                        style: _kTheme.textTheme.headline6,
                      ),
                      SizedBox(height: kSpacingX8),
                      Text(
                        _currentUser?.email ?? 'No email address',
                        style: _kTheme.textTheme.caption,
                      ),
                      SizedBox(height: kSpacingX20),
                      ProfileListItem(
                        icon: LineAwesomeIcons.user_shield,
                        text: 'Privacy',
                        onTap: () =>
                            launchUrl(url: 'https://handyman.com/privacy'),
                      ),
                      ProfileListItem(
                        icon: LineAwesomeIcons.history,
                        text: 'Booking History',
                        onTap: () => context.navigator.pushBookingsPage(),
                      ),
                      ProfileListItem(
                        icon: LineAwesomeIcons.question_circle,
                        text: 'Help & Support',
                        onTap: () =>
                            launchUrl(url: 'https://handyman.com/support'),
                      ),
                      ProfileListItem(
                        icon: LineAwesomeIcons.cog,
                        text: 'Settings',
                        onTap: _showBottomSheetForSettings,
                      ),
                      ProfileListItem(
                        icon: LineAwesomeIcons.user_plus,
                        text: 'Invite a Friend',
                        onTap: () => Share.share(
                            'Try $kAppName for free today!\nhttps://play.google.com/store/apps/details?id=dev.azaware.handyman.lite'),
                      ),
                      ProfileListItem(
                        icon: LineAwesomeIcons.alternate_sign_out,
                        text: 'Logout',
                        hasNavigation: false,
                        onTap: () async => showCustomDialog(
                          context: context,
                          builder: (_) => BasicDialog(
                            message: kSignOutText,
                            onComplete: () {
                              _authBloc.add(AuthEvent.authSignOutEvent());
                              context.navigator
                                ..popUntilRoot()
                                ..pushSplashPage();
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              })
          : Loading(),
    );
  }

  void _showBottomSheetForSettings() async {
    await showSlidingBottomSheet(context,
        useRootNavigator: true,
        builder: (context) => SlidingSheetDialog(
              elevation: kSpacingX8,
              cornerRadius: kSpacingX16,
              snapSpec: const SnapSpec(
                snap: true,
                snappings: [0.4, 0.7, 1.0],
                positioning: SnapPositioning.relativeToAvailableSpace,
              ),
              headerBuilder: (_, state) => Material(
                type: MaterialType.transparency,
                child: Container(
                  height: kToolbarHeight,
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(horizontal: kSpacingX16),
                  color: _kTheme.colorScheme.primary,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Settings',
                        style: _kTheme.textTheme.headline6
                            .copyWith(color: _kTheme.colorScheme.onPrimary),
                      ),
                      IconButton(
                        icon: Icon(kCloseIcon),
                        onPressed: () => context.navigator.pop(),
                      ),
                    ],
                  ),
                ),
              ),
              footerBuilder: (_, __) => Material(
                type: MaterialType.transparency,
                child: InkWell(
                  onTap: () async {
                    if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();
                      _currentUser = _currentUser.copyWith(
                        name:
                            '${_firstNameController.text} ${_lastNameController.text}',
                        phone: _phoneNumberController.text ??=
                            _currentUser.phone,
                      );
                      _updateUserBloc
                          .add(UserEvent.updateUserEvent(user: _currentUser));
                      context.navigator.pop();
                    }
                  },
                  child: Container(
                    height: kToolbarHeight,
                    alignment: Alignment.center,
                    color: _kTheme.colorScheme.secondary,
                    child: Text(
                      'Save & continue'.toUpperCase(),
                      style: _kTheme.textTheme.button
                          .copyWith(color: _kTheme.colorScheme.onSecondary),
                    ),
                  ),
                ),
              ),
              builder: (context, state) => Container(
                height: SizeConfig.screenHeight * 0.4,
                // color: _kTheme.colorScheme.background,
                padding: EdgeInsets.fromLTRB(
                  kSpacingX16,
                  kSpacingX24,
                  kSpacingX16,
                  kSpacingX8,
                ),
                child: Material(
                  type: MaterialType.transparency,
                  // color: _kTheme.colorScheme.background,
                  child: Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextFormInput(
                            labelText: 'First name',
                            keyboardType: TextInputType.name,
                            textCapitalization: TextCapitalization.words,
                            textInputAction: TextInputAction.next,
                            validator: (_) =>
                                _.isEmpty ? 'First name required' : null,
                            controller: _firstNameController
                              ..text = _currentUser.name
                                  .substring(0, _currentUser.name.indexOf(' ')),
                          ),
                          TextFormInput(
                            labelText: 'Last name',
                            keyboardType: TextInputType.name,
                            textCapitalization: TextCapitalization.words,
                            textInputAction: TextInputAction.next,
                            validator: (_) =>
                                _.isEmpty ? 'Last name required' : null,
                            controller: _lastNameController
                              ..text = _currentUser.name.substring(
                                  _currentUser.name.indexOf(' ') + 1),
                          ),
                          TextFormInput(
                            labelText: 'Phone number',
                            keyboardType: TextInputType.phone,
                            textCapitalization: TextCapitalization.none,
                            textInputAction: TextInputAction.done,
                            validator: (_) =>
                                _.isEmpty ? 'Phone number required' : null,
                            controller: _phoneNumberController
                              ..text = _currentUser.phone,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ));
  }
}
