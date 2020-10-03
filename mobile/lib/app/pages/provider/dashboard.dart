import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:handyman/app/model/prefs_provider.dart';
import 'package:handyman/app/routes/route.gr.dart';
import 'package:handyman/app/widget/badgeable_tab_bar.dart';
import 'package:handyman/app/widget/user_avatar.dart';
import 'package:handyman/core/constants.dart';
import 'package:handyman/core/service_locator.dart';
import 'package:handyman/core/size_config.dart';
import 'package:handyman/core/utils.dart';
import 'package:handyman/data/local_database.dart';
import 'package:handyman/data/provider/artisan_api_provider.dart';
import 'package:handyman/domain/models/user.dart';
import 'package:provider/provider.dart';
import 'package:auto_route/auto_route.dart';
import 'package:random_color/random_color.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _apiService = sl.get<ApiProviderService>();
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
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      extendBody: true,
      body: Consumer<PrefsProvider>(
        builder: (_, provider, __) => Stack(
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
                child: StreamBuilder<BaseUser>(
                    stream: _apiService.getArtisanById(id: provider.userId),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) return Container();

                      final artisan = snapshot.data?.user;

                      return ListView(
                        children: [
                          _buildAppBar(provider, artisan),
                          SizedBox(
                            height: getProportionateScreenHeight(kSpacingX16),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal:
                                    getProportionateScreenWidth(kSpacingX24)),
                            child: BadgeableTabBar(
                              tabs: [
                                BadgeableTabBarItem(
                                  title: "Ongoing",
                                  badgeCount: artisan.ongoingBookingsCount,
                                ),
                                BadgeableTabBarItem(
                                  title: "Requests",
                                  badgeCount: artisan.requestsCount,
                                ),
                              ],
                              onTabSelected: (index) {
                                _currentTabIndex = index;
                                setState(() {});
                              },
                              color: _themeData.primaryColor,
                              activeIndex: _currentTabIndex,
                            ),
                          ),
                          _buildSearchBar(),
                          _currentTabIndex == 0
                              ? _buildOngoingTasksWidget(artisan)
                              : _buildRequestsWidget(artisan),
                        ],
                      );
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar(PrefsProvider provider, Artisan artisan) => Padding(
        padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(kSpacingX16),
          vertical: getProportionateScreenHeight(kSpacingX16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              clipBehavior: Clip.hardEdge,
              elevation: kSpacingX2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(kSpacingX8),
                ),
              ),
              child: Container(
                height: kToolbarHeight,
                width: double.infinity,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(kSpacingX8),
                  ),
                  color: _themeData.cardColor,
                  shape: BoxShape.rectangle,
                ),
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(kSpacingX16)),
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
                    Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        child: Text(
                          kAppName,
                          style: _themeData.textTheme.headline6,
                        ),
                      ),
                    ),
                    StreamBuilder<BaseUser>(
                      stream: _apiService.getCustomerById(id: provider.userId),
                      builder: (_, snapshot) => UserAvatar(
                        url: artisan.avatar,
                        radius: kSpacingX36,
                        onTap: () => context.navigator.push(
                          Routes.providerSettingsPage,
                        ),
                        ringColor: _themeData.iconTheme.color,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: getProportionateScreenHeight(kSpacingX12),
            ),
            Row(
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
                    width: _kWidth * 0.67,
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
                              color: _themeData.colorScheme.onSecondary,
                            ),
                            SizedBox(
                              height: getProportionateScreenHeight(kSpacingX8),
                            ),
                            Text(
                              "Calendar",
                              style: _themeData.textTheme.headline6.copyWith(
                                fontWeight: FontWeight.bold,
                                color: _themeData.colorScheme.onSecondary,
                              ),
                            ),
                            SizedBox(
                              height: getProportionateScreenHeight(kSpacingX4),
                            ),
                            Text(
                              "${artisan.ongoingBookingsCount} active tasks this week",
                              style: _themeData.textTheme.caption.copyWith(
                                fontWeight: FontWeight.bold,
                                color: _themeData.colorScheme.onSecondary
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
                              "${artisan.completedBookingsCount} projects",
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

  Widget _buildSearchBar() => Container(
        margin: EdgeInsets.symmetric(
            vertical: getProportionateScreenHeight(kSpacingX16),
            horizontal: getProportionateScreenWidth(kSpacingX24)),
        height: kToolbarHeight,
        width: double.infinity,
        child: Card(),
      );

  /// Get ongoing [Booking]s
  Widget _buildOngoingTasksWidget(Artisan artisan) =>
      StreamBuilder<List<Booking>>(
        stream: _apiService.getMyBookings(artisan.id),
        builder: (context, snapshot) {
          return Column();
        },
      );

  /// Get newly requested [Booking]s
  Widget _buildRequestsWidget(artisan) => StreamBuilder<List<Booking>>(
        stream: _apiService.getMyBookings(artisan.id),
        builder: (context, snapshot) {
          return Column();
        },
      );
}
