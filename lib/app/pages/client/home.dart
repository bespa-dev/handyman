import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:handyman/app/model/prefs_provider.dart';
import 'package:handyman/app/model/theme_provider.dart';
import 'package:handyman/app/pages/client/search.dart';
import 'package:handyman/app/routes/route.gr.dart';
import 'package:handyman/core/constants.dart';
import 'package:handyman/core/size_config.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _preferGridFormat = true;
  final _dropdownItems = const <String>[
    "Featured",
    "Most Rated",
    "Recent",
    "Popular",
    "Recommended",
  ];
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
                    SizedBox(height: getProportionateScreenHeight(12)),
                    GestureDetector(
                      onTap: () {},
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: getProportionateScreenWidth(16)),
                        child: Material(
                          clipBehavior: Clip.hardEdge,
                          elevation: 1,
                          type: MaterialType.card,
                          borderOnForeground: false,
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                          child: Container(
                            height: kToolbarHeight,
                            width: double.infinity,
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                              color: themeData.colorScheme.surface,
                              shape: BoxShape.rectangle,
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: getProportionateScreenWidth(4)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  tooltip: "Toggle theme",
                                  icon: Icon(themeProvider.isLightTheme
                                      ? Feather.moon
                                      : Feather.sun),
                                  onPressed: () =>
                                      themeProvider.toggleTheme(context),
                                ),
                                Image.asset(
                                  kLogoAsset,
                                  height: kToolbarHeight - 8,
                                ),
                                IconButton(
                                  tooltip: "Search",
                                  icon: Icon(Feather.search),
                                  onPressed: () => showSearch(
                                    context: context,
                                    delegate: SearchPage(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: getProportionateScreenHeight(8)),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: getProportionateScreenWidth(16)),
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                DropdownButton(
                                  value: _currentFilter,
                                  items: _dropdownItems
                                      .map<DropdownMenuItem<String>>(
                                        (value) => DropdownMenuItem<String>(
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
                                    _preferGridFormat = !_preferGridFormat;
                                  }),
                                ),
                              ],
                            ),
                            SizedBox(height: getProportionateScreenHeight(16)),
                            Expanded(
                              child: _preferGridFormat
                                  ? GridView(
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        childAspectRatio: 4 / 3,
                                        crossAxisSpacing:
                                            getProportionateScreenWidth(8),
                                        mainAxisSpacing:
                                            getProportionateScreenHeight(4),
                                      ),
                                      clipBehavior: Clip.hardEdge,
                                      children: _dropdownItems
                                          .map(
                                            (e) => Card(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                  getProportionateScreenWidth(
                                                      12),
                                                ),
                                              ),
                                              color: Colors.redAccent,
                                              clipBehavior: Clip.hardEdge,
                                              child: InkWell(
                                                borderRadius: BorderRadius.circular(
                                                    getProportionateScreenWidth(
                                                        12)),
                                                onTap: () =>
                                                    context.navigator.push(
                                                  Routes.categoryProvidersPage,
                                                  arguments:
                                                      CategoryProvidersPageArguments(
                                                          category: e),
                                                ),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Flexible(
                                                      child: Image.asset(
                                                        kBannerAsset,
                                                        width: double.infinity,
                                                        height:
                                                            getProportionateScreenHeight(
                                                                300),
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          )
                                          .toList(),
                                      physics: BouncingScrollPhysics(),
                                    )
                                  : ListView.builder(
                                      physics: BouncingScrollPhysics(),
                                      itemBuilder: (_, index) => ListTile(
                                        onTap: () => context.navigator.push(
                                          Routes.categoryProvidersPage,
                                          arguments:
                                              CategoryProvidersPageArguments(
                                                  category:
                                                      _dropdownItems[index]),
                                        ),
                                        onLongPress: () {},
                                        title: Text(_dropdownItems[index]),
                                      ),
                                      itemCount: _dropdownItems.length,
                                    ),
                            ),
                          ],
                        ),
                      ),
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

  // TODO: Order the categories based on the current filter
  void _getCategoriesWithFilter() async {}
}
