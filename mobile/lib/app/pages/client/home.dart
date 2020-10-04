import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:handyman/app/model/prefs_provider.dart';
import 'package:handyman/app/pages/client/search.dart';
import 'package:handyman/app/routes/route.gr.dart';
import 'package:handyman/app/widget/category_card.dart';
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
import 'package:provider/provider.dart';
import 'package:random_color/random_color.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _preferGridFormat = true;
  DataService _apiService = sl.get<DataService>();
  Stream<List<ServiceCategory>> _categoriesStream;

  final _categoryFilterMenu = Map.from({
    CategoryGroup.FEATURED: "Featured",
    CategoryGroup.MOST_RATED: "Most Rated",
    CategoryGroup.RECENT: "Recent",
    CategoryGroup.POPULAR: "Popular",
    CategoryGroup.RECOMMENDED: "Recommended",
  });
  String _categoryFilter = "Featured";

  @override
  void initState() {
    super.initState();
    if (mounted) _categoriesStream = _apiService.getCategories();
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Scaffold(
      key: _scaffoldKey,
      body: Consumer<AuthService>(
        builder: (_, authService, __) => Consumer<PrefsProvider>(
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
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: getProportionateScreenHeight(kSpacingX12)),
                    GestureDetector(
                      onTap: () => showSearch(
                        context: context,
                        delegate: SearchPage(),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal:
                                getProportionateScreenWidth(kSpacingX16)),
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
                            width: double.infinity,
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(kSpacingX8),
                              ),
                              color: themeData.cardColor,
                              shape: BoxShape.rectangle,
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal:
                                    getProportionateScreenWidth(kSpacingX16)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Search for artisans & more",
                                      style: themeData.textTheme.headline6
                                          .copyWith(
                                        color: themeData.iconTheme.color,
                                      ),
                                    ),
                                  ),
                                ),
                                StreamBuilder<BaseUser>(
                                    stream: authService.currentUser(),
                                    builder: (context, snapshot) {
                                      return UserAvatar(
                                        url: snapshot.hasData
                                            ? snapshot.data?.user?.avatar
                                            : "",
                                        radius: kSpacingX36,
                                        onTap: () => context.navigator
                                            .push(Routes.profilePage),
                                        ringColor: RandomColor(1).randomColor(
                                            colorBrightness:
                                                ColorBrightness.dark),
                                      );
                                    }),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: getProportionateScreenHeight(kSpacingX8)),
                    Expanded(
                      child: StreamBuilder<List<ServiceCategory>>(
                          stream: _categoriesStream,
                          builder: (context, snapshot) {
                            return Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal:
                                      getProportionateScreenWidth(kSpacingX16)),
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
                                  snapshot.hasData
                                      ? Expanded(
                                          child: _preferGridFormat
                                              ? GridCategoryCardItem(
                                                  categories: snapshot.data)
                                              : ListCategoryCardItem(
                                                  categories: snapshot.data),
                                        )
                                      : Container(),
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
