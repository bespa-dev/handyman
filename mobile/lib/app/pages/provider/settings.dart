import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:geolocator/geolocator.dart' as geo;
import 'package:handyman/app/model/prefs_provider.dart';
import 'package:handyman/app/pages/login.dart';
import 'package:handyman/app/routes/route.gr.dart';
import 'package:handyman/app/widget/artisan_settings_widgets.dart';
import 'package:handyman/app/widget/badgeable_tab_bar.dart';
import 'package:handyman/app/widget/buttons.dart';
import 'package:handyman/app/widget/user_avatar.dart';
import 'package:handyman/core/constants.dart';
import 'package:handyman/core/service_locator.dart';
import 'package:handyman/core/size_config.dart';
import 'package:handyman/data/entities/artisan_model.dart';
import 'package:handyman/data/local_database.dart';
import 'package:handyman/data/services/data.dart';
import 'package:handyman/data/services/storage.dart';
import 'package:handyman/domain/models/user.dart';
import 'package:handyman/domain/services/auth.dart';
import 'package:handyman/domain/services/data.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

/// activeTabIndex legend:
/// 0 => calendar
/// 1 => profile
/// 2 => history
class ProviderSettingsPage extends StatefulWidget {
  final int activeTabIndex;

  const ProviderSettingsPage({
    Key key,
    this.activeTabIndex = 1,
  }) : super(key: key);

  @override
  _ProviderSettingsPageState createState() => _ProviderSettingsPageState();
}

class _ProviderSettingsPageState extends State<ProviderSettingsPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  double _kWidth, _kHeight;
  ThemeData _themeData;
  Artisan _currentUser;
  bool _shouldDismissEarnPointsSheet = true,
      _isEditingAboutMe = false,
      _isEditingPhone = false,
      _isEditingBusinessName = false;
  int _activeTabIndex;
  TextEditingController _businessNameController = TextEditingController(),
      _aboutController = TextEditingController(),
      _phoneController = TextEditingController();

  CalendarController _calendarController;
  DataService _dataService = DataServiceImpl.create();
  final _storageService = StorageServiceImpl.create();

  File _avatar;
  String _userId;
  final picker = ImagePicker();

  _showPickerDialog(BuildContext ctx) => AlertDialog(
        title: Text("Select an option"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text("View"),
              leading: Icon(Feather.eye),
              onTap: () {
                ctx.navigator.pop();
                showNotAvailableDialog(ctx);
              },
            ),
            ListTile(
              title: Text("Change avatar"),
              leading: Icon(Feather.user),
              onTap: () async {
                ctx.navigator.pop();
                await _getImage();
              },
            ),
          ],
        ),
        actions: [
          ButtonClear(
            text: "Dismiss",
            onPressed: () => ctx.navigator.pop(),
            themeData: Theme.of(context),
          )
        ],
      );

  Future<void> _getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _avatar = File(pickedFile.path);
      await _storageService.uploadFile(_avatar, path: _userId);
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();
    if (mounted) {
      _storageService.onStorageUploadResponse.listen((event) {
        debugPrint(event.state.toString());
      });
      _activeTabIndex = widget.activeTabIndex;
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _themeData = Theme.of(context);
    final size = MediaQuery.of(context).size;
    _kWidth = size.width;
    _kHeight = size.height;
  }

  @override
  void dispose() {
    Focus.of(context).unfocus();
    _calendarController?.dispose();
    _dataService.updateUser(ArtisanModel(artisan: _currentUser), sync: true);
    _businessNameController.dispose();
    _aboutController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthService>(
      builder: (_, service, __) {
        return StreamBuilder<BaseUser>(
            stream: service.currentUser(),
            builder: (context, snapshot) {
              _currentUser = snapshot.data?.user;
              return Scaffold(
                key: _scaffoldKey,
                extendBody: true,
                body: Consumer<PrefsProvider>(
                  builder: (_, provider, __) => SafeArea(
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        provider.isLightTheme
                            ? Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(kBackgroundAsset),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              )
                            : SizedBox.shrink(),
                        Positioned(
                          top: kSpacingNone,
                          width: _kWidth,
                          child: _buildAppBar(provider),
                        ),
                        Positioned(
                          width: _kWidth,
                          top: getProportionateScreenHeight(kSpacingX64),
                          bottom: kSpacingNone,
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal:
                                      getProportionateScreenWidth(kSpacingX24),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      children: [
                                        _avatar == null
                                            ? UserAvatar(
                                                onTap: () => showDialog(
                                                  context: context,
                                                  builder: (ctx) =>
                                                      _showPickerDialog(ctx),
                                                ),
                                                url: _currentUser?.avatar,
                                                radius: kSpacingX72,
                                                isCircular: true,
                                                ringColor:
                                                    _currentUser?.isAvailable ??
                                                            false
                                                        ? kGreenColor
                                                        : _themeData
                                                            .colorScheme.error,
                                              )
                                            : InkWell(
                                                onTap: () => showDialog(
                                                  context: context,
                                                  builder: (ctx) =>
                                                      _showPickerDialog(ctx),
                                                ),
                                                child: Container(
                                                  height:
                                                      getProportionateScreenHeight(
                                                          kSpacingX72),
                                                  width:
                                                      getProportionateScreenHeight(
                                                          kSpacingX72),
                                                  child: Stack(
                                                    children: [
                                                      Container(
                                                        clipBehavior:
                                                            Clip.hardEdge,
                                                        decoration:
                                                            BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                        ),
                                                        child: Image.file(
                                                          _avatar,
                                                          fit: BoxFit.cover,
                                                          height:
                                                              getProportionateScreenHeight(
                                                                  kSpacingX72),
                                                          width:
                                                              getProportionateScreenHeight(
                                                                  kSpacingX72),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                        SizedBox(
                                          width: getProportionateScreenWidth(
                                              kSpacingX12),
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              _currentUser?.name ?? "",
                                              style: _themeData
                                                  .textTheme.headline6,
                                            ),
                                            SizedBox(
                                              height:
                                                  getProportionateScreenHeight(
                                                      kSpacingX8),
                                            ),
                                            _currentUser?.business == null
                                                ? SizedBox.shrink()
                                                : Text(
                                                    _currentUser?.business,
                                                    style: _themeData
                                                        .textTheme.bodyText2,
                                                  ),
                                            SizedBox(
                                                height:
                                                    getProportionateScreenHeight(
                                                        kSpacingX4)),
                                            RatingBarIndicator(
                                              rating:
                                                  _currentUser?.rating ?? 0.00,
                                              direction: Axis.horizontal,
                                              itemCount: 5,
                                              itemSize: kSpacingX12,
                                              itemPadding: EdgeInsets.symmetric(
                                                  horizontal: 4.0),
                                              itemBuilder: (context, _) => Icon(
                                                  kRatingStar,
                                                  color: kAmberColor),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    ButtonPrimary(
                                      width: _kWidth * 0.25,
                                      themeData: _themeData,
                                      color: _themeData.colorScheme.error,
                                      enabled: _currentUser != null,
                                      textColor: _themeData.colorScheme.onError,
                                      onTap: () => showDialog(
                                        context: context,
                                        builder: (ctx) => AlertDialog(
                                          title: Text("Leaving already?"),
                                          content: Text(
                                            kSignOutText,
                                          ),
                                          actions: [
                                            ButtonClear(
                                              text: "No",
                                              onPressed: () =>
                                                  ctx.navigator.pop(),
                                              themeData: _themeData,
                                            ),
                                            ButtonClear(
                                              text: "Yes",
                                              onPressed: () async {
                                                ctx.navigator.pop();
                                                await sl
                                                    .get<AuthService>()
                                                    .signOut();
                                                context.navigator
                                                    .pushAndRemoveUntil(
                                                  Routes.loginPage,
                                                  (route) => route is LoginPage,
                                                );
                                              },
                                              themeData: _themeData,
                                            ),
                                          ],
                                        ),
                                      ),
                                      label: "Sign out",
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height:
                                    getProportionateScreenHeight(kSpacingX24),
                              ),
                              _buildTabBar(),
                              SizedBox(
                                height:
                                    getProportionateScreenHeight(kSpacingX16),
                              ),
                              Expanded(
                                child: _activeTabIndex == 0
                                    ? _buildCalendarSection()
                                    : _activeTabIndex == 1
                                        ? _buildProfileSection()
                                        : _buildHistorySection(),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          width: _kWidth,
                          bottom: kSpacingNone,
                          child: _buildBottomBar(),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            });
      },
    );
  }

  Widget _buildAppBar(PrefsProvider provider) => Container(
        padding: EdgeInsets.symmetric(
          vertical: getProportionateScreenHeight(kSpacingX8),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: _kWidth,
              padding: EdgeInsets.only(
                right: getProportionateScreenWidth(kSpacingX12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    tooltip: "Go back",
                    icon: Icon(Feather.x),
                    onPressed: () => context.navigator.pop(),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        tooltip: "Toggle theme",
                        icon: Icon(
                          provider.isLightTheme ? Feather.moon : Feather.sun,
                        ),
                        onPressed: () => provider.toggleTheme(),
                      ),
                      IconButton(
                        icon: Icon(Feather.help_circle),
                        onPressed: () => showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            title: Text("Help"),
                            content: Text(kArtisanReviewHelpDialogContent),
                            actions: [
                              ButtonClear(
                                text: "Dismiss",
                                onPressed: () => ctx.navigator.pop(),
                                themeData: _themeData,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  Widget _buildBottomBar() => _isEditingBusinessName ||
          _isEditingAboutMe ||
          _isEditingPhone
      ? SizedBox.shrink()
      : AnimatedContainer(
          duration: kScaleDuration,
          width: _kWidth,
          height: getProportionateScreenHeight(
              _shouldDismissEarnPointsSheet ? kSpacingX160 : kSpacingX250),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(kSpacingX24),
              topRight: Radius.circular(kSpacingX24),
            ),
            border: Border.all(
              color: _themeData.disabledColor,
              style: BorderStyle.none,
            ),
          ),
          child: Material(
            clipBehavior: Clip.hardEdge,
            type: MaterialType.card,
            elevation: kSpacingX4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(kSpacingX24),
                topRight: Radius.circular(kSpacingX24),
              ),
            ),
            child: Stack(
              fit: StackFit.passthrough,
              children: [
                _shouldDismissEarnPointsSheet
                    ? Container(
                        alignment: Alignment.topRight,
                        height: getProportionateScreenHeight(
                            kSpacingX250 - kSpacingX160),
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          color: _themeData.colorScheme.secondary,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(kSpacingX24),
                            topRight: Radius.circular(kSpacingX24),
                          ),
                        ),
                        padding: EdgeInsets.only(
                          left: getProportionateScreenWidth(kSpacingX16),
                          right: getProportionateScreenWidth(kSpacingX16),
                        ),
                        child: AnimatedOpacity(
                          opacity: _shouldDismissEarnPointsSheet ? 1.0 : 0.0,
                          duration: kSheetDuration,
                          child: IconButton(
                            icon: Icon(Feather.chevron_up),
                            onPressed: () {
                              setState(() {
                                _shouldDismissEarnPointsSheet =
                                    !_shouldDismissEarnPointsSheet;
                              });
                            },
                            color: _themeData.colorScheme.onSecondary,
                          ),
                        ),
                      )
                    : Positioned(
                        bottom: kSpacingNone,
                        width: _kWidth,
                        child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.only(
                            left: getProportionateScreenWidth(kSpacingX16),
                            right: getProportionateScreenWidth(kSpacingX16),
                            bottom: kSpacingNone,
                          ),
                          height: getProportionateScreenHeight(kSpacingX360),
                          width: _kWidth,
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                            color: _themeData.colorScheme.secondary,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(kSpacingX24),
                              topRight: Radius.circular(kSpacingX24),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Earn Skills Badge",
                                    style:
                                        _themeData.textTheme.headline6.copyWith(
                                      color: _themeData.colorScheme.onSecondary,
                                    ),
                                  ),
                                  SizedBox(
                                      height: getProportionateScreenHeight(
                                          kSpacingX8)),
                                  // Allow prospective customers to book your services. Turning this off will make you invisible
                                  ConstrainedBox(
                                    constraints: BoxConstraints.tightFor(
                                      width: _kWidth * 0.7,
                                    ),
                                    child: RichText(
                                      textAlign: TextAlign.left,
                                      text: TextSpan(
                                        text:
                                            "Skills assessment helps you to stand out to customers",
                                        style: _themeData.textTheme.bodyText2
                                            .copyWith(
                                          color: _themeData
                                              .colorScheme.onSecondary,
                                        ),
                                      ),
                                      softWrap: true,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  ButtonIconOnly(
                                    icon: Icons.arrow_right_alt_outlined,
                                    color: _themeData.colorScheme.onSecondary,
                                    iconColor:
                                        _themeData.colorScheme.onSecondary,
                                    onPressed: () =>
                                        showNotAvailableDialog(context),
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      Feather.chevron_down,
                                    ),
                                    color: _themeData.colorScheme.onSecondary,
                                    onPressed: () {
                                      setState(() {
                                        _shouldDismissEarnPointsSheet =
                                            !_shouldDismissEarnPointsSheet;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                Positioned(
                  bottom: kSpacingNone,
                  width: _kWidth,
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(kSpacingX16),
                    ),
                    height: getProportionateScreenHeight(kSpacingX120),
                    width: _kWidth,
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                        color: _themeData.cardColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(kSpacingX24),
                          topRight: Radius.circular(kSpacingX24),
                        )),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Toggle Visibility",
                              style: _themeData.textTheme.headline6,
                            ),
                            SizedBox(
                                height:
                                    getProportionateScreenHeight(kSpacingX8)),
                            // Allow prospective customers to book your services. Turning this off will make you invisible
                            ConstrainedBox(
                              constraints: BoxConstraints.tightFor(
                                width: _kWidth * 0.7,
                              ),
                              child: RichText(
                                textAlign: TextAlign.left,
                                text: TextSpan(
                                  text:
                                      "Allow prospective customers to book your services. Turning this off will make you invisible",
                                  style: _themeData.textTheme.bodyText2,
                                ),
                                softWrap: true,
                              ),
                            ),
                          ],
                        ),
                        Switch.adaptive(
                          activeColor: _themeData.colorScheme.primary,
                          value: _currentUser?.isAvailable ?? false,
                          onChanged: (visibility) async {
                            await _dataService.updateUser(
                                ArtisanModel(
                                  artisan: _currentUser.copyWith(
                                      isAvailable: visibility),
                                ),
                                sync: false);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );

  // Gets user's current location and finds the name of that address
  Future<geo.Position> _getUserLocation() async =>
      await geo.getCurrentPosition(desiredAccuracy: geo.LocationAccuracy.high);

  Widget _buildTabBar() => Container(
        margin: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(kSpacingX24)),
        child: BadgeableTabBar(
          tabs: <BadgeableTabBarItem>[
            BadgeableTabBarItem(
              title: "Calendar",
              badgeCount: 0,
            ),
            BadgeableTabBarItem(
              title: "Profile",
              badgeCount: 0,
            ),
            BadgeableTabBarItem(
              title: "History",
              badgeCount: 0,
            ),
          ],
          onTabSelected: (index) {
            _activeTabIndex = index;
            setState(() {});
          },
          color: _themeData.primaryColor,
          activeIndex: _activeTabIndex,
        ),
      );

  Widget _buildHistorySection() => ListView(
        children: [
          buildFunctionalityNotAvailablePanel(context),
        ],
      );

  Widget _buildCalendarSection() => ListView(
        children: [
          buildCalendarTable(
              _themeData, context, _currentUser, _calendarController),
        ],
      );

  Widget _buildProfileSection() => ListView(
        padding: EdgeInsets.only(
          bottom: getProportionateScreenHeight(
              _shouldDismissEarnPointsSheet ? kSpacingX160 : kSpacingX250),
        ),
        children: [
          buildArtisanMetadataBar(
            context,
            _themeData,
            artisan: _currentUser,
          ),
          FutureBuilder<geo.Position>(
            future: _getUserLocation(),
            builder: (_, locationSnapshot) {
              return locationSnapshot.hasError
                  ? SizedBox.shrink()
                  : buildMapPreviewForBusinessLocation(
                      position: locationSnapshot.data,
                    );
            },
          ),
          Container(
            margin: EdgeInsets.only(
              left: getProportionateScreenWidth(kSpacingX24),
              right: getProportionateScreenWidth(kSpacingX24),
              bottom: getProportionateScreenHeight(kSpacingX16),
            ),
            child: buildProfileDescriptor(
              context,
              themeData: _themeData,
              isEditing: _isEditingAboutMe,
              iconData: _isEditingAboutMe ? Feather.check : Feather.edit_2,
              title: "About Me",
              content: _currentUser?.aboutMe ??
                  "Brand yourself to your prospective customers",
              onTap: () async {
                _isEditingAboutMe = !_isEditingAboutMe;
                _aboutController.text = _currentUser?.aboutMe;
                setState(() {});
                if (_isEditingAboutMe)
                  await _dataService.updateUser(ArtisanModel(
                      artisan: _currentUser.copyWith(
                          aboutMe: _aboutController.text)));
              },
              inputAction: TextInputAction.done,
              controller: _aboutController,
              hint: "Tell us about yourself...",
              onEditComplete: (content) {
                _isEditingAboutMe = !_isEditingAboutMe;
                setState(() {});
                if (_isEditingAboutMe)
                  _dataService.updateUser(ArtisanModel(
                      artisan: _currentUser.copyWith(
                          aboutMe: _aboutController.text)));
              },
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              left: getProportionateScreenWidth(kSpacingX24),
              right: getProportionateScreenWidth(kSpacingX24),
              bottom: getProportionateScreenHeight(kSpacingX16),
            ),
            child: buildProfileDescriptor(
              context,
              themeData: _themeData,
              title: "Phone Number",
              content: _currentUser?.phone ?? "Create one...",
              isEditing: _isEditingPhone,
              iconData: _isEditingPhone ? Feather.check : Feather.edit_2,
              onTap: () async {
                _isEditingPhone = !_isEditingPhone;
                _phoneController.text = _currentUser?.phone;
                setState(() {});
                if (_isEditingPhone)
                  _dataService.updateUser(ArtisanModel(
                      artisan:
                          _currentUser.copyWith(phone: _phoneController.text)));
              },
              inputAction: TextInputAction.done,
              controller: _phoneController,
              hint: "Create one...",
              onEditComplete: (content) {
                _isEditingPhone = !_isEditingPhone;
                _phoneController.text = content;
                setState(() {});
                if (_isEditingPhone)
                  _dataService.updateUser(ArtisanModel(
                      artisan:
                          _currentUser.copyWith(phone: _phoneController.text)));
              },
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              left: getProportionateScreenWidth(kSpacingX24),
              right: getProportionateScreenWidth(kSpacingX24),
              bottom: getProportionateScreenHeight(kSpacingX16),
            ),
            child: buildProfileDescriptor(
              context,
              themeData: _themeData,
              title: "Business Name",
              content: _currentUser?.business ?? "Create one...",
              isEditing: _isEditingBusinessName,
              iconData: _isEditingBusinessName ? Feather.check : Feather.edit_2,
              onTap: () async {
                _isEditingBusinessName = !_isEditingBusinessName;
                _businessNameController.text = _currentUser?.business;
                setState(() {});
                if (_isEditingBusinessName)
                  _dataService.updateUser(ArtisanModel(
                      artisan: _currentUser.copyWith(
                          business: _businessNameController.text)));
              },
              inputAction: TextInputAction.done,
              controller: _businessNameController,
              hint: "What\'s your business name?",
              onEditComplete: (content) {
                _isEditingBusinessName = !_isEditingBusinessName;
                _businessNameController.text = content;
                setState(() {});
                if (_isEditingBusinessName)
                  _dataService.updateUser(ArtisanModel(
                      artisan: _currentUser.copyWith(
                          business: _businessNameController.text)));
              },
            ),
          ),
        ],
      );
}
