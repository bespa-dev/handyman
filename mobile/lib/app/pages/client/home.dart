import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:handyman/app/model/prefs_provider.dart';
import 'package:handyman/app/pages/login.dart';
import 'package:handyman/app/routes/route.gr.dart';
import 'package:handyman/app/widget/buttons.dart';
import 'package:handyman/app/widget/category_card.dart';
import 'package:handyman/app/widget/emergency_ping_button.dart';
import 'package:handyman/app/widget/user_avatar.dart';
import 'package:handyman/core/constants.dart';
import 'package:handyman/core/service_locator.dart';
import 'package:handyman/core/size_config.dart';
import 'package:handyman/data/entities/category.dart';
import 'package:handyman/data/local_database.dart';
import 'package:handyman/data/services/data.dart';
import 'package:handyman/domain/models/user.dart';
import 'package:handyman/domain/services/auth.dart';
import 'package:handyman/domain/services/data.dart';
import 'package:handyman/domain/services/messaging.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _preferGridFormat = true;
  DataService _apiService = DataServiceImpl.instance;
  Stream<List<ServiceCategory>> _categoriesStream =
      sl.get<DataService>().getCategories();

  final _categoryFilterMenu = Map.from({
    CategoryGroup.FEATURED: "Featured",
    CategoryGroup.MOST_RATED: "Most Rated",
    CategoryGroup.RECENT: "Recent",
    CategoryGroup.POPULAR: "Popular",
    CategoryGroup.RECOMMENDED: "Recommended",
  });
  String _categoryFilter;

  @override
  void initState() {
    _categoryFilter = _categoryFilterMenu.values.first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Consumer<PrefsProvider>(
      builder: (_, provider, __) => Consumer<AuthService>(
        builder: (_, authService, __) => Scaffold(
          key: _scaffoldKey,
          drawer: Drawer(
            child: Column(
              children: [
                ListTile(
                  title: Text("My Account"),
                  onTap: () => context.navigator.popAndPush(
                    Routes.profilePage,
                  ),
                  leading: Icon(Entypo.user),
                  selected: false,
                  selectedTileColor: themeData.selectedRowColor,
                ),
                ListTile(
                  title: Text("Notifications"),
                  onTap: () => context.navigator.push(
                    Routes.notificationPage,
                    arguments: NotificationPageArguments(
                      payload: NotificationPayload.empty(),
                    ),
                  ),
                  leading: Icon(Entypo.bell),
                ),
                Divider(),
                AboutListTile(
                  applicationVersion: kAppVersion,
                  applicationName: kAppName,
                  applicationLegalese: kAppSloganDesc,
                  applicationIcon: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: getProportionateScreenHeight(kSpacingX16),
                    ),
                    child: Image(
                      image: Svg(
                          provider.isLightTheme ? kLogoAsset : kLogoDarkAsset),
                      height: getProportionateScreenHeight(kSpacingX48),
                      width: getProportionateScreenHeight(kSpacingX48),
                    ),
                  ),
                ),
                Divider(),
                Spacer(),
                _buildLogoutButton(authService),
                SizedBox(
                  height: getProportionateScreenHeight(kSpacingX4),
                ),
              ],
            ),
          ),
          body: SafeArea(
            child: EmergencyPingButton(
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
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                          height: getProportionateScreenHeight(kSpacingX12)),
                      GestureDetector(
                        onTap: () => context.navigator.push(Routes.searchPage),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal:
                                  getProportionateScreenWidth(kSpacingX8)),
                          child: Card(
                            clipBehavior: Clip.hardEdge,
                            elevation: kSpacingX2,
                            color: themeData.cardColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(kSpacingX8),
                              ),
                            ),
                            child: Container(
                              height: kToolbarHeight,
                              width: SizeConfig.screenWidth,
                              clipBehavior: Clip.hardEdge,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(kSpacingX8),
                                ),
                                color: themeData.cardColor,
                                shape: BoxShape.rectangle,
                              ),
                              padding: EdgeInsets.only(
                                left: getProportionateScreenWidth(kSpacingX4),
                                right: getProportionateScreenWidth(kSpacingX8),
                              ),
                              child: Row(
                                children: [
                                  IconButton(
                                    tooltip: "Toggle theme",
                                    icon: Icon(
                                      provider.isLightTheme
                                          ? Feather.moon
                                          : Feather.sun,
                                      // color: themeData.appBarTheme.iconTheme.color,
                                    ),
                                    onPressed: () => provider.toggleTheme(),
                                  ),
                                  Expanded(
                                    child: Text(
                                      "Search for artisans & more",
                                      style:
                                          themeData.textTheme.button.copyWith(
                                        color: themeData.iconTheme.color,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  StreamBuilder<BaseUser>(
                                      stream: authService.currentUser(),
                                      builder: (context, userSnapshot) => Row(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              IconButton(
                                                tooltip: "Notifications",
                                                icon: Icon(Entypo.bell),
                                                onPressed: () =>
                                                    context.navigator.push(
                                                  Routes.notificationPage,
                                                  arguments:
                                                      NotificationPageArguments(
                                                    payload: NotificationPayload
                                                        .empty(),
                                                  ),
                                                ),
                                              ),
                                              UserAvatar(
                                                url: userSnapshot
                                                    .data?.user?.avatar,
                                                radius: kSpacingX36,
                                                onTap: () => context.navigator
                                                    .push(Routes.profilePage),
                                                ringColor:
                                                    themeData.iconTheme.color,
                                              ),
                                            ],
                                          )),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                          height: getProportionateScreenHeight(kSpacingX8)),
                      Expanded(
                        child: StreamBuilder<List<ServiceCategory>>(
                            stream: _categoriesStream,
                            builder: (context, snapshot) {
                              return Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: getProportionateScreenWidth(
                                        kSpacingX16)),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        DropdownButton(
                                          value: _categoryFilter,
                                          items: _categoryFilterMenu.values
                                              .map<DropdownMenuItem<String>>(
                                                (value) =>
                                                    DropdownMenuItem<String>(
                                                  value: value,
                                                  child: Text(value),
                                                ),
                                              )
                                              .toList(),
                                          onChanged: (String newItem) {
                                            _categoryFilter = newItem;
                                            setState(() {});
                                            _getCategoriesWithFilter();
                                          },
                                          icon: Icon(Feather.chevron_down),
                                          underline: Container(
                                            color: kTransparent,
                                            height: 2,
                                          ),
                                        ),
                                        IconButton(
                                          tooltip: "Toggle view",
                                          icon: Icon(_preferGridFormat
                                              ? Icons.sort
                                              : Feather.grid),
                                          onPressed: () => setState(() {
                                            _preferGridFormat =
                                                !_preferGridFormat;
                                          }),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                        height: getProportionateScreenHeight(
                                            kSpacingX16)),
                                    snapshot.hasData && snapshot.data.isNotEmpty
                                        ? Expanded(
                                            child: _preferGridFormat
                                                ? GridCategoryCardItem(
                                                    categories: snapshot.data)
                                                : ListCategoryCardItem(
                                                    categories: snapshot.data),
                                          )
                                        : Container(
                                            height:
                                                getProportionateScreenHeight(
                                                    kSpacingX320),
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Entypo.bucket,
                                                  size:
                                                      getProportionateScreenHeight(
                                                          kSpacingX96),
                                                  color: themeData
                                                      .colorScheme.onBackground,
                                                ),
                                                SizedBox(
                                                  height:
                                                      getProportionateScreenHeight(
                                                          kSpacingX16),
                                                ),
                                                Text(
                                                  "No categories available for this filter",
                                                  style: themeData
                                                      .textTheme.bodyText2
                                                      .copyWith(
                                                    color: themeData.colorScheme
                                                        .onBackground,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ],
                                            ),
                                          ),
                                  ],
                                ),
                              );
                            }),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogoutButton(AuthService authService) {
    final _themeData = Theme.of(context);

    return InkWell(
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
              onPressed: () => ctx.navigator.pop(),
              themeData: _themeData,
            ),
            Consumer<AuthService>(
              builder: (_, authService, __) => ButtonClear(
                text: "Yes",
                onPressed: () {
                  ctx.navigator.pop();
                  authService.signOut();
                  context.navigator.pushAndRemoveUntil(
                    Routes.loginPage,
                    (route) => route is LoginPage,
                  );
                },
                themeData: _themeData,
              ),
            ),
          ],
        ),
      ),
      splashColor: _themeData.splashColor,
      child: Container(
        alignment: Alignment.center,
        height: getProportionateScreenHeight(kToolbarHeight),
        width: SizeConfig.screenWidth * 0.5,
        decoration: BoxDecoration(
          color: _themeData.colorScheme.error,
          borderRadius: BorderRadius.circular(kSpacingX36),
        ),
        child: Text(
          "Sign out".toUpperCase(),
          style: _themeData.textTheme.button.copyWith(
            color: _themeData.colorScheme.onError,
          ),
        ),
      ),
    );
  }

  void _getCategoriesWithFilter() {
    _categoriesStream = _apiService.getCategories(
      categoryGroup: _categoryFilterMenu.keys
          .where((element) =>
              _categoryFilter ==
              _categoryFilterMenu.values.elementAt(element.index))
          .first,
    );
  }
}
