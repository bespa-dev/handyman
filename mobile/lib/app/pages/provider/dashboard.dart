import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:handyman/app/model/prefs_provider.dart';
import 'package:handyman/app/routes/route.gr.dart';
import 'package:handyman/app/widget/badgeable_tab_bar.dart';
import 'package:handyman/app/widget/booking_card_item.dart';
import 'package:handyman/app/widget/buttons.dart';
import 'package:handyman/app/widget/menu_icon.dart';
import 'package:handyman/app/widget/sign_out_button.dart';
import 'package:handyman/app/widget/user_avatar.dart';
import 'package:handyman/core/constants.dart';
import 'package:handyman/core/size_config.dart';
import 'package:handyman/data/entities/booking.dart';
import 'package:handyman/data/local_database.dart';
import 'package:handyman/domain/models/user.dart';
import 'package:handyman/domain/services/auth.dart';
import 'package:handyman/domain/services/data.dart';
import 'package:handyman/domain/services/messaging.dart';
import 'package:provider/provider.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  double _kWidth, _kHeight;
  ThemeData _themeData;
  int _currentTabIndex = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _themeData = Theme.of(context);
    final size = MediaQuery.of(context).size;
    _kWidth = size.width;
    _kHeight = size.height;
  }

  @override
  Widget build(BuildContext context) => Consumer<AuthService>(
        builder: (_, authService, __) => Consumer<DataService>(
          builder: (_, dataService, __) {
            return Consumer<PrefsProvider>(
              builder: (_, provider, __) => StreamBuilder<BaseUser>(
                stream: authService.currentUser(),
                builder: (_, snapshot) {
                  final artisan = snapshot.data?.user;

                  return Scaffold(
                    key: _scaffoldKey,
                    extendBody: true,
                    body: Stack(
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
                        SafeArea(
                          child: Container(
                            height: _kHeight,
                            width: _kWidth,
                            child: ListView(
                              children: [
                                _buildAppBar(provider, artisan),
                                SizedBox(
                                  height:
                                      getProportionateScreenHeight(kSpacingX16),
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: getProportionateScreenWidth(
                                          kSpacingX24)),
                                  child: BadgeableTabBar(
                                    tabs: <BadgeableTabBarItem>[
                                      BadgeableTabBarItem(
                                        title: "Ongoing Tasks",
                                        badgeCount:
                                            artisan?.ongoingBookingsCount ?? 0,
                                      ),
                                      BadgeableTabBarItem(
                                        title: "New Requests",
                                        badgeCount: artisan?.requestsCount ?? 0,
                                      ),
                                    ],
                                    onTabSelected: (index) {
                                      _currentTabIndex = index;
                                      setState(() {});
                                    },
                                    color: _themeData.colorScheme.primary,
                                    activeIndex: _currentTabIndex,
                                  ),
                                ),
                                _buildSearchBar(margin: kSpacingX24),
                                StreamBuilder<List<Booking>>(
                                  stream: dataService
                                      .getBookingsForProvider(artisan?.id),
                                  initialData: [],
                                  builder: (_, snapshot) {
                                    if (snapshot.data.isEmpty)
                                      return _buildEmptyListView();
                                    return _currentTabIndex == 0
                                        ? _buildOngoingTasksWidget(
                                            snapshot.data)
                                        : _buildRequestsWidget(snapshot.data);
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    endDrawer: _buildSideBar(artisan, authService),
                  );
                },
              ),
            );
          },
        ),
      );

  Widget _buildAppBar(PrefsProvider provider, Artisan artisan) => Padding(
        padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(kSpacingX16),
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
                    tooltip: "Toggle theme",
                    icon: Icon(
                      provider.isLightTheme ? Feather.moon : Feather.sun,
                    ),
                    onPressed: () => provider.toggleTheme(),
                  ),
                  Tooltip(
                    message: "Open drawer",
                    child: RotatedBox(
                      quarterTurns: 2,
                      child: MenuIcon(
                        onTap: () => _scaffoldKey.currentState.openEndDrawer(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: getProportionateScreenHeight(kSpacingX12),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  borderRadius: BorderRadius.all(
                    Radius.circular(kSpacingX8),
                  ),
                  onTap: () => context.navigator.push(
                    Routes.providerSettingsPage,
                    arguments: ProviderSettingsPageArguments(
                      activeTabIndex: 0,
                    ),
                  ),
                  child: SizedBox(
                    width: _kWidth * 0.65,
                    child: Card(
                      clipBehavior: Clip.hardEdge,
                      elevation: kSpacingX2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(kSpacingX8),
                        ),
                      ),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: getProportionateScreenHeight(kSpacingX16),
                          horizontal: getProportionateScreenWidth(kSpacingX12),
                        ),
                        decoration: BoxDecoration(
                          color: _themeData.colorScheme.secondary
                              .withOpacity(kOpacityX70),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              FlutterIcons.calendar_outline_mco,
                              size: getProportionateScreenHeight(kSpacingX36),
                              color: _themeData.colorScheme.onBackground,
                            ),
                            SizedBox(
                              height: getProportionateScreenHeight(kSpacingX8),
                            ),
                            Text(
                              "Calendar",
                              style: _themeData.textTheme.headline6.copyWith(
                                fontWeight: FontWeight.bold,
                                color: _themeData.colorScheme.onBackground,
                              ),
                            ),
                            SizedBox(
                              height: getProportionateScreenHeight(kSpacingX4),
                            ),
                            Text(
                              "${artisan?.ongoingBookingsCount ?? "No"} active tasks this week",
                              style: _themeData.textTheme.caption.copyWith(
                                fontWeight: FontWeight.bold,
                                color: _themeData.colorScheme.onBackground
                                    .withOpacity(kEmphasisMedium),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  borderRadius: BorderRadius.all(
                    Radius.circular(kSpacingX8),
                  ),
                  onTap: () => context.navigator.push(
                    Routes.providerSettingsPage,
                    arguments: ProviderSettingsPageArguments(
                      activeTabIndex: 2,
                    ),
                  ),
                  child: SizedBox(
                    width: _kWidth * 0.25,
                    child: Card(
                      clipBehavior: Clip.hardEdge,
                      elevation: kSpacingX2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(kSpacingX8),
                        ),
                      ),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: getProportionateScreenHeight(kSpacingX16),
                          horizontal: getProportionateScreenWidth(kSpacingX12),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              FlutterIcons.history_mco,
                              size: getProportionateScreenHeight(kSpacingX36),
                              color: _themeData.colorScheme.onBackground,
                            ),
                            SizedBox(
                              height: getProportionateScreenHeight(kSpacingX8),
                            ),
                            Text(
                              "History",
                              style: _themeData.textTheme.headline6.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: getProportionateScreenHeight(kSpacingX4),
                            ),
                            Text(
                              "${artisan?.completedBookingsCount ?? "No"} projects",
                              style: _themeData.textTheme.caption.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );

  Widget _buildSearchBar({double margin}) => Container(
        margin: EdgeInsets.symmetric(
            vertical: getProportionateScreenHeight(kSpacingX16),
            horizontal: getProportionateScreenWidth(margin ??= kSpacingX8)),
        child: InkWell(
          onTap: () => showNotAvailableDialog(context),
          borderRadius: BorderRadius.all(Radius.circular(kSpacingX8)),
          child: Card(
            clipBehavior: Clip.hardEdge,
            elevation: kSpacingX2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(kSpacingX8)),
            ),
            child: Container(
              height: kToolbarHeight,
              // width: preferredWidth,
              padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(kSpacingX16),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Feather.search,
                    color: _themeData.colorScheme.onBackground,
                  ),
                  SizedBox(width: getProportionateScreenWidth(kSpacingX12)),
                  Text(
                    "Search",
                  ),
                ],
              ),
            ),
          ),
        ),
      );

  /// Get ongoing [Booking]s
  Widget _buildOngoingTasksWidget(List<Booking> bookings) => Padding(
        padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(kSpacingX24),
        ),
        child: AnimationLimiter(
          child: AnimationConfiguration.synchronized(
            duration: kScaleDuration,
            child: Column(
              children: [
                ...bookings
                    .where((element) =>
                        element.dueDate >=
                        DateTime.now().millisecondsSinceEpoch)
                    .map(
                      (item) => BookingCardItem(
                        booking: item,
                        bookingType: BookingType.ONGOING,
                        onTap: () => context.navigator.push(
                          Routes.bookingsDetailsPage,
                          arguments:
                              BookingsDetailsPageArguments(booking: item),
                        ),
                      ),
                    ),
              ],
            ),
          ),
        ),
      );

  /// Get newly requested [Booking]s
  Widget _buildRequestsWidget(List<Booking> bookings) {
    final filteredBooking = bookings.where((element) =>
        element.createdAt <= DateTime.now().millisecondsSinceEpoch &&
        element.dueDate == null);
    return filteredBooking.isNotEmpty
        ? Padding(
            padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(kSpacingX24),
            ),
            child: AnimationLimiter(
              child: AnimationConfiguration.synchronized(
                duration: kScaleDuration,
                child: Column(
                  children: [
                    ...filteredBooking.map(
                      (item) => BookingCardItem(
                        booking: item,
                        onTap: () => context.navigator.push(
                          Routes.bookingsDetailsPage,
                          arguments:
                              BookingsDetailsPageArguments(booking: item),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        : _buildEmptyListView();
  }

  Drawer _buildSideBar(Artisan artisan, AuthService authService) => Drawer(
        child: Column(
          children: [
            SafeArea(
              child: Container(
                color: kTransparent,
                height: getProportionateScreenHeight(kSpacingX100),
                padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(kSpacingX24),
                ),
                alignment: Alignment.centerLeft,
                child: Image(
                  image: Svg(kLogoAsset),
                  height: getProportionateScreenHeight(kSpacingX56),
                  width: getProportionateScreenWidth(kSpacingX56),
                ),
              ),
            ),
            _buildSearchBar(),
            ListTile(
              title: Text("My Account"),
              onTap: () => context.navigator.popAndPush(
                Routes.providerSettingsPage,
              ),
              leading: Icon(Entypo.user),
              selected: false,
              selectedTileColor: _themeData.selectedRowColor,
            ),
            ListTile(
              title: Text("Notifications"),
              // TODO: Fix notifications UI
              onTap: () => context.navigator.push(
                Routes.notificationPage,
                arguments: NotificationPageArguments(
                  payload: NotificationPayload.empty(),
                ),
              ),
              leading: Icon(Entypo.bell),
            ),
            ListTile(
              title: Text("Conversations"),
              // TODO: Add conversations page for provider
              onTap: () => showNotAvailableDialog(context),
              leading: Icon(Entypo.chat),
            ),
            Divider(),
            ListTile(
              onTap: () =>
                  context.navigator.popAndPush(Routes.providerSettingsPage),
              title: Text(
                artisan?.name ?? "Create a username",
                // style: _themeData.textTheme.bodyText1,
              ),
              leading: UserAvatar(
                url: artisan?.avatar,
                radius: kSpacingX42,
                ringColor: _themeData.colorScheme.primary,
              ),
              trailing: IconButton(
                icon: Icon(Feather.help_circle),
                onPressed: () => showNotAvailableDialog(context),
              ),
            ),
            Divider(),
            Spacer(),
            SignOutButton(
              authService: authService,
              logoutRoute: Routes.loginPage,
              onConfirmSignOut: () async {
                final isLoggedOut = await authService.signOut();
                if (isLoggedOut)
                  context.navigator.popAndPush(Routes.loginPage);
                else
                  _scaffoldKey.currentState
                    ..removeCurrentSnackBar()
                    ..showSnackBar(SnackBar(
                      content: Text("Unable to sign out. Try again later"),
                      behavior: SnackBarBehavior.floating,
                    ));
              },
            ),
          ],
        ),
      );

  Widget _buildEmptyListView() => Container(
        height: kSpacingX320,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Entypo.bucket,
              size: getProportionateScreenHeight(kSpacingX96),
              color: _themeData.colorScheme.onBackground,
            ),
            SizedBox(
              height: getProportionateScreenHeight(kSpacingX16),
            ),
            Text(
              "You have no bookings for today",
              style: _themeData.textTheme.bodyText2.copyWith(
                color: _themeData.colorScheme.onBackground,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: getProportionateScreenHeight(kSpacingX24),
            ),
            ButtonOutlined(
              width: _kWidth * 0.6,
              themeData: _themeData,
              gravity: ButtonIconGravity.END,
              icon: Icons.arrow_right_alt_outlined,
              onTap: () => showNotAvailableDialog(context),
              label: "Earn Skills Badge",
            ),
          ],
        ),
      );
}
