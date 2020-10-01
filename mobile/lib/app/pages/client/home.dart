import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:handyman/app/model/prefs_provider.dart';
import 'package:handyman/app/model/theme_provider.dart';
import 'package:handyman/app/pages/client/search.dart';
import 'package:handyman/app/routes/route.gr.dart';
import 'package:handyman/app/widget/category_card.dart';
import 'package:handyman/app/widget/user_avatar.dart';
import 'package:handyman/core/constants.dart';
import 'package:handyman/core/service_locator.dart';
import 'package:handyman/core/size_config.dart';
import 'package:handyman/data/entities/category.dart';
import 'package:handyman/data/local_database.dart';
import 'package:handyman/data/provider/artisan_api_provider.dart';
import 'package:provider/provider.dart';
import 'package:random_color/random_color.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _preferGridFormat = true;
  Future<List<ServiceCategory>> _categoriesFuture =
      sl.get<ApiProviderService>().getCategories();

  final _dropdownItems = Map.from({
    CategoryGroup.FEATURED: "Featured",
    CategoryGroup.MOST_RATED: "Most Rated",
    CategoryGroup.RECENT: "Recent",
    CategoryGroup.POPULAR: "Popular",
    CategoryGroup.RECOMMENDED: "Recommended",
  });
  String _currentFilter = "Featured";
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Scaffold(
      key: _scaffoldKey,
      body: Consumer<ThemeProvider>(
        builder: (_, themeProvider, __) => Consumer<PrefsProvider>(
          builder: (_, prefsProvider, __) => SafeArea(
            child: Stack(
              fit: StackFit.expand,
              children: [
                themeProvider.isLightTheme
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
                        child: Material(
                          clipBehavior: Clip.hardEdge,
                          elevation: 2,
                          type: MaterialType.card,
                          color: themeData.cardColor,
                          borderOnForeground: false,
                          borderRadius: BorderRadius.all(
                            Radius.circular(kSpacingX8),
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
                                    themeProvider.isLightTheme
                                        ? Feather.moon
                                        : Feather.sun,
                                    // color: themeData.appBarTheme.iconTheme.color,
                                  ),
                                  onPressed: () => themeProvider.toggleTheme(),
                                ),
                                Expanded(
                                  child: Container(
                                    margin: EdgeInsets.only(
                                        left: getProportionateScreenWidth(
                                            kSpacingX8)),
                                    child: Text(
                                      "Search for artisans & more",
                                      style: themeData.textTheme.headline6
                                          .copyWith(
                                        color: themeData.iconTheme.color,
                                      ),
                                    ),
                                  ),
                                ),
                                UserAvatar(
                                  tag: "https://images.unsplash.com/photo-1598547461182-45d03f6661e4?ixlib=rb-1.2.1&auto=format&fit=crop&w=600&q=60",
                                  url:
                                      "https://images.unsplash.com/photo-1598547461182-45d03f6661e4?ixlib=rb-1.2.1&auto=format&fit=crop&w=600&q=60",
                                  radius: kSpacingX36,
                                  onTap: () => context.navigator
                                      .push(Routes.profilePage),
                                  ringColor: RandomColor(1).randomColor(
                                      colorBrightness: ColorBrightness.dark),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: getProportionateScreenHeight(kSpacingX8)),
                    Expanded(
                      child: FutureBuilder<List<ServiceCategory>>(
                          future: _categoriesFuture,
                          builder: (context, snapshot) {
                            return Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal:
                                      getProportionateScreenWidth(kSpacingX16)),
                              child: Column(
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      DropdownButton(
                                        value: _currentFilter,
                                        items: _dropdownItems.values
                                            .map<DropdownMenuItem<String>>(
                                              (value) =>
                                                  DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(value),
                                              ),
                                            )
                                            .toList(),
                                        onChanged: (String newItem) {
                                          setState(() {
                                            _currentFilter = newItem;
                                            _getCategoriesWithFilter();
                                          });
                                        },
                                        icon: Icon(Feather.chevron_down),
                                        underline: Container(
                                          color: kTransparent,
                                          height: 2,
                                        ),
                                      ),
                                      Spacer(),
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
    _categoriesFuture = sl.get<ApiProviderService>().getCategories(
          categoryGroup: _dropdownItems.keys
              .where((element) =>
                  _currentFilter ==
                  _dropdownItems.values.elementAt(element.index))
              .first,
        );
    setState(() {});
  }
}
