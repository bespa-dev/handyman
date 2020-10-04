import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:geolocator/geolocator.dart' as geo;
import 'package:handyman/app/model/prefs_provider.dart';
import 'package:handyman/app/widget/artisan_settings_widgets.dart';
import 'package:handyman/app/widget/badgeable_tab_bar.dart';
import 'package:handyman/app/widget/buttons.dart';
import 'package:handyman/app/widget/user_avatar.dart';
import 'package:handyman/core/constants.dart';
import 'package:handyman/core/service_locator.dart';
import 'package:handyman/core/size_config.dart';
import 'package:handyman/data/entities/artisan_model.dart';
import 'package:handyman/data/local_database.dart';
import 'package:handyman/domain/models/user.dart';
import 'package:handyman/domain/services/auth.dart';
import 'package:handyman/domain/services/data.dart';
import 'package:provider/provider.dart';
import 'package:random_color/random_color.dart';

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
  DataService _dataService = sl.get<DataService>();
  double _kWidth, _kHeight;
  ThemeData _themeData;
  Artisan _currentUser;
  bool _shouldDismissEarnPointsSheet = false;
  int _activeTabIndex;

  @override
  void initState() {
    super.initState();
    if (mounted) {
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
    _dataService.updateUser(ArtisanModel(artisan: _currentUser), sync: true);
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
                          top: getProportionateScreenHeight(
                              kToolbarHeight + kSpacingX24),
                          bottom: kSpacingNone,
                          child: Column(
                            children: [
                              _buildInfoBar(),
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
                                        UserAvatar(
                                          onTap: () =>
                                              showNotAvailableDialog(context),
                                          url: _currentUser?.avatar,
                                          radius: kSpacingX72,
                                          isCircular: false,
                                          ringColor:
                                              _currentUser?.isAvailable ?? false
                                                  ? kGreenColor
                                                  : _themeData
                                                      .colorScheme.error,
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
                                                        kSpacingX8)),
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
                                    StreamBuilder<ServiceCategory>(
                                        stream: _dataService.getCategoryById(
                                            id: _currentUser?.category),
                                        builder: (_, categorySnapshot) {
                                          return categorySnapshot.hasError
                                              ? SizedBox.shrink()
                                              : Column(
                                                  children: [
                                                    Text(
                                                      "${categorySnapshot.data.name} Category",
                                                      style: _themeData
                                                          .textTheme.bodyText1,
                                                    ),
                                                    InkWell(
                                                      onTap: () =>
                                                          showNotAvailableDialog(
                                                              context),
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          color: _themeData
                                                              .primaryColor,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                );
                                        }),
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

  Widget _buildAppBar(PrefsProvider provider) => Padding(
        padding: EdgeInsets.symmetric(
          vertical: getProportionateScreenHeight(kSpacingX16),
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
                  IconButton(
                    tooltip: "Toggle theme",
                    icon: Icon(
                      provider.isLightTheme ? Feather.moon : Feather.sun,
                    ),
                    onPressed: () => provider.toggleTheme(),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: getProportionateScreenHeight(kSpacingX12),
            ),
          ],
        ),
      );

  Widget _buildBottomBar() => Container(
        width: _kWidth,
        height: getProportionateScreenHeight(
            _shouldDismissEarnPointsSheet ? kSpacingX120 : kSpacingX250),
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
                  ? SizedBox.shrink()
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
                                  "Earn Skill Badge",
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
                                        color:
                                            _themeData.colorScheme.onSecondary,
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
                                  iconColor: _themeData.colorScheme.onSecondary,
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
                              height: getProportionateScreenHeight(kSpacingX8)),
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
                        value: _currentUser?.isAvailable ?? false,
                        onChanged: (visibility) {
                          _currentUser =
                              _currentUser.copyWith(isAvailable: visibility);
                          _dataService.updateUser(
                            ArtisanModel(artisan: _currentUser),
                            sync: false,
                          );
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
  Future<geo.Position> _getUserLocation() async {
    return geo.getCurrentPosition(desiredAccuracy: geo.LocationAccuracy.high);
  }

  Widget _buildInfoBar() => Container();

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
          Container(
            color: RandomColor().randomColor(),
            height: _kHeight,
            width: _kWidth,
          ),
        ],
      );

  Widget _buildCalendarSection() => ListView(
        children: [
          Container(
            color: RandomColor().randomColor(),
            height: _kHeight,
            width: _kWidth,
          ),
        ],
      );

  Widget _buildProfileSection() => ListView(
        padding: EdgeInsets.only(
          bottom: getProportionateScreenHeight(
              _shouldDismissEarnPointsSheet ? kSpacingX120 : kSpacingX250),
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
                      position: locationSnapshot.data);
            },
          ),
          SizedBox(height: getProportionateScreenHeight(kSpacingX36)),
          buildProfileDescriptor(
            themeData: _themeData,
            title: "About Me",
            content: _currentUser?.aboutMe ??
                "Brand yourself to your prospective customers",
            onTap: () => showNotAvailableDialog(context),
          ),
          buildProfileDescriptor(
            themeData: _themeData,
            title: "Business Name",
            content: _currentUser?.business ?? "Create one...",
            onTap: () => showNotAvailableDialog(context),
          ),
        ],
      );
}
