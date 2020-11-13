import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:handyman/app/model/prefs_provider.dart';
import 'package:handyman/app/routes/route.gr.dart';
import 'package:handyman/app/widget/badgeable_tab_bar.dart';
import 'package:handyman/app/widget/booking_card_item.dart';
import 'package:handyman/app/widget/buttons.dart';
import 'package:handyman/core/constants.dart';
import 'package:handyman/core/size_config.dart';
import 'package:handyman/data/local_database.dart';
import 'package:handyman/domain/models/user.dart';
import 'package:handyman/domain/services/auth.dart';
import 'package:handyman/domain/services/data.dart';
import 'package:handyman/domain/services/messaging.dart';
import 'package:provider/provider.dart';

// C:\Users\Quabynah Bilson\Documents\GitHub\handyman\mobile\build\app\outputs\flutter-apk
/// Notifications Page: Shows notifications of
/// 1. Bookings
/// 2. Conversations
/// 3. and more
class NotificationPage extends StatefulWidget {
  final NotificationPayload payload;

  const NotificationPage({Key key, this.payload}) : super(key: key);

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  double _kWidth = SizeConfig.screenWidth, _kHeight = SizeConfig.screenHeight;
  ThemeData _themeData;
  int _currentTabIndex = 0;
  final _pageController = PageController(initialPage: 0, keepPage: true);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _themeData = Theme.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthService>(
      builder: (_, authService, __) => Consumer<PrefsProvider>(
        builder: (_, provider, __) => StreamBuilder<BaseUser>(
            stream: authService.currentUser(),
            builder: (context, snapshot) {
              final currentUser = snapshot.data?.user;
              return Scaffold(
                body: Container(
                  padding: EdgeInsets.only(
                    left: getProportionateScreenWidth(kSpacingX24),
                    right: getProportionateScreenWidth(kSpacingX24),
                    bottom: getProportionateScreenHeight(kSpacingX16),
                  ),
                  child: Column(
                    children: [
                      _buildAppBar(provider),
                      (snapshot.data != null &&
                              !snapshot.data.isCustomer &&
                              !snapshot.data.user.isApproved)
                          ? _buildWaitingApprovalHeader(currentUser)
                          : SizedBox.shrink(),
                      _buildNotificationsTab(provider),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }

  Widget _buildWaitingApprovalHeader(Artisan artisan) => artisan == null
      ? SizedBox.shrink()
      : Column(
          children: [
            RichText(
              text: TextSpan(
                children: <TextSpan>[
                  TextSpan(
                    text: "Your account is ",
                    style: _themeData.textTheme.bodyText1,
                  ),
                  TextSpan(
                    text:
                        artisan.isApproved ? "approved." : "pending approval.",
                    style: _themeData.textTheme.bodyText1.copyWith(
                      color: artisan.isApproved
                          ? kGreenColor
                          : _themeData.colorScheme.error,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: getProportionateScreenHeight(kSpacingX12),
                bottom: getProportionateScreenHeight(kSpacingX16),
              ),
              child: Column(
                children: [
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: _kHeight * 0.15,
                    ),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Positioned.fill(
                          child: Container(
                            width: _kWidth,
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(kSpacingX12),
                              color: artisan.isApproved
                                  ? kGreenColor
                                  : _themeData.colorScheme.error,
                            ),
                          ),
                        ),
                        Positioned(
                          left: kSpacingX2,
                          right: getProportionateScreenWidth(kSpacingX16),
                          top: kSpacingX2,
                          bottom: kSpacingX2,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal:
                                  getProportionateScreenWidth(kSpacingX16),
                              vertical:
                                  getProportionateScreenHeight(kSpacingX12),
                            ),
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                              color: _themeData.scaffoldBackgroundColor,
                              borderRadius: BorderRadius.circular(kSpacingX12),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  artisan?.name ?? "No name",
                                  style: _themeData.textTheme.headline6,
                                ),
                                SizedBox(
                                  height:
                                      getProportionateScreenHeight(kSpacingX8),
                                ),
                                Text(
                                  artisan.business ?? artisan?.email ?? "",
                                  style: _themeData.textTheme.caption,
                                ),
                                SizedBox(
                                  height:
                                      getProportionateScreenHeight(kSpacingX8),
                                ),
                                ButtonClear(
                                  text: "View profile",
                                  onPressed: () => context.navigator
                                      .push(Routes.providerSettingsPage),
                                  themeData: _themeData,
                                  textColor: artisan.isApproved
                                      ? kGreenColor
                                      : _themeData.colorScheme.primary,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            artisan.isApproved
                ? Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ButtonPrimary(
                        width: _kWidth * 0.6,
                        gravity: ButtonIconGravity.END,
                        icon: Icons.arrow_right_alt_outlined,
                        themeData: _themeData,
                        onTap: () =>
                            context.navigator.popAndPush(Routes.dashboardPage),
                        label: "View dashboard",
                      ),
                      SizedBox(
                          height: getProportionateScreenHeight(kSpacingX24)),
                    ],
                  )
                : SizedBox.shrink(),
          ],
        );

  Widget _buildAppBar(PrefsProvider provider) => SafeArea(
        child: Container(
          width: _kWidth,
          margin: EdgeInsets.only(
            bottom: getProportionateScreenHeight(kSpacingX12),
          ),
          height: getProportionateScreenHeight(kToolbarHeight),
          color: _themeData.scaffoldBackgroundColor.withOpacity(kOpacityX90),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              provider.userType == kCustomerString
                  ? IconButton(
                      tooltip: "Back",
                      icon: Icon(Feather.x),
                      onPressed: () => context.navigator.pop(),
                    )
                  : SizedBox.shrink(),
              IconButton(
                tooltip: "Toggle theme",
                icon: Icon(provider.isLightTheme ? Feather.moon : Feather.sun),
                onPressed: () => provider.toggleTheme(),
              )
            ],
          ),
        ),
      );

  // Notifications tab
  Widget _buildNotificationsTab(PrefsProvider provider) => Expanded(
        child: Column(
          children: [
            BadgeableTabBar(
              tabs: <BadgeableTabBarItem>[
                BadgeableTabBarItem(title: "Conversations"),
                BadgeableTabBarItem(title: "Requests"),
              ],
              onTabSelected: (index) {
                _currentTabIndex = index;
                _pageController.animateToPage(
                  index,
                  curve: Curves.fastOutSlowIn,
                  duration: kSheetDuration,
                );
                setState(() {});
              },
              color: _themeData.colorScheme.primary,
              activeIndex: _currentTabIndex,
            ),
            SizedBox(height: getProportionateScreenHeight(kSpacingX16)),
            Container(
              height: provider.userType == kCustomerString
                  ? _kHeight
                  : _kHeight * 0.5,
              width: _kWidth,
              child: Consumer<DataService>(
                builder: (_, dataService, __) => PageView.builder(
                  onPageChanged: (newIndex) {
                    setState(() {
                      _currentTabIndex = newIndex;
                    });
                  },
                  itemCount: 2,
                  itemBuilder: (_, index) {
                    return index == 0
                        ? _buildConversationNotificationsTab(
                            provider, dataService)
                        : _buildRequestNotificationsTab(provider, dataService);
                  },
                  controller: _pageController,
                ),
              ),
            )
          ],
        ),
      );

  // Shows all booking requests notifications
  Widget _buildRequestNotificationsTab(
          PrefsProvider provider, DataService service) =>
      StreamBuilder<List<dynamic>>(
        initialData: [],
        stream: service.getNotifications(
            userId: provider.userId, type: PayloadType.BOOKING),
        builder: (_, snapshot) {
          return ListView.separated(
            padding: EdgeInsets.zero,
            clipBehavior: Clip.hardEdge,
            itemBuilder: (_, index) {
              final item = snapshot.data[index];
              return AnimationConfiguration.staggeredList(
                position: index,
                duration: kScaleDuration,
                child: SlideAnimation(
                  verticalOffset: kSpacingNone,
                  child: FadeInAnimation(
                    child: BookingCardItem(
                      booking: item,
                      onTap: () => context.navigator.push(
                        Routes.bookingsDetailsPage,
                        arguments: BookingsDetailsPageArguments(booking: item),
                      ),
                    ),
                  ),
                ),
              );
            },
            separatorBuilder: (_, __) =>
                SizedBox(height: getProportionateScreenHeight(kSpacingX2)),
            itemCount: snapshot.data.length,
          );
        },
      );

  // Shows all conversation notifications
  Widget _buildConversationNotificationsTab(
          PrefsProvider provider, DataService service) =>
      StreamBuilder<List<dynamic>>(
        initialData: [],
        stream: service.getNotifications(
            userId: provider.userId, type: PayloadType.CONVERSATION),
        builder: (_, snapshot) {
          return ListView.separated(
            padding: EdgeInsets.zero,
            clipBehavior: Clip.hardEdge,
            itemBuilder: (_, index) {
              final item = snapshot.data[index];
              final isCustomer = provider.userType == kCustomerString;

              return AnimationConfiguration.staggeredList(
                position: index,
                duration: kScaleDuration,
                child: SlideAnimation(
                  verticalOffset: kSpacingNone,
                  child: FadeInAnimation(
                    child: StreamBuilder<BaseUser>(
                        stream: isCustomer
                            ? service.getArtisanById(id: item.author)
                            : service.getCustomerById(id: item.author),
                        builder: (context, chatSnapshot) {
                          return chatSnapshot.hasError
                              ? SizedBox.shrink()
                              : ListTile(
                                  /*TODO*/
                                  onTap: () => showNotAvailableDialog(context),
                                  title: Text(chatSnapshot.data?.user?.name ??
                                      "User not found"),
                                  subtitle:
                                      Text(item.message ?? "Nothing to show"),
                                );
                        }),
                  ),
                ),
              );
            },
            separatorBuilder: (_, __) =>
                SizedBox(height: getProportionateScreenHeight(kSpacingX2)),
            itemCount: snapshot.data.length,
          );
        },
      );
}
