import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:handyman/app/model/theme_provider.dart';
import 'package:handyman/app/pages/client/search.dart';
import 'package:handyman/app/widget/artisan_card.dart';
import 'package:handyman/core/service_locator.dart';
import 'package:handyman/core/size_config.dart';
import 'package:handyman/data/local_database.dart';
import 'package:handyman/data/provider/artisan_api_provider.dart';
import 'package:provider/provider.dart';

class CategoryProvidersPage extends StatefulWidget {
  final String category;

  const CategoryProvidersPage({Key key, this.category}) : super(key: key);

  @override
  _CategoryProvidersPageState createState() => _CategoryProvidersPageState();
}

class _CategoryProvidersPageState extends State<CategoryProvidersPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _preferGridFormat = false;
  String _currentFilter = "Availability";
  final _dropdownItems = <String>["Availability", "Price", "Rating"];

  @override
  void initState() {
    super.initState();
    _fetchProviderForCategory();
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final kHeight = MediaQuery.of(context).size.height;
    final kWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Feather.x),
          color: themeData.iconTheme.color,
          onPressed: () => context.navigator.pop(),
        ),
        actions: [
          IconButton(
            tooltip: "Search",
            icon: Icon(Feather.search),
            color: themeData.iconTheme.color,
            onPressed: () => showSearch(
              context: context,
              delegate: SearchPage(),
            ),
          ),
        ],
      ),
      body: Consumer<ThemeProvider>(
        builder: (_, provider, __) => Container(
          width: kWidth,
          height: kHeight,
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(16)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: getProportionateScreenHeight(8)),
              Text(
                "Showing results for...",
                style: themeData.textTheme.caption,
              ),
              Text(
                widget.category,
                style: themeData.textTheme.headline3,
              ),
              SizedBox(height: getProportionateScreenHeight(4)),
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
                        _fetchProviderForCategory();
                      });
                    },
                    icon: Icon(Feather.chevron_down),
                    underline: Container(
                      color: themeData.scaffoldBackgroundColor,
                      height: 2,
                    ),
                  ),
                  Spacer(),
                  IconButton(
                    tooltip: "Toggle view",
                    icon: Icon(_preferGridFormat ? Icons.sort : Feather.grid),
                    onPressed: () => setState(() {
                      _preferGridFormat = !_preferGridFormat;
                    }),
                  ),
                ],
              ),
              SizedBox(height: getProportionateScreenHeight(16)),
              FutureBuilder<List<Artisan>>(
                  future: sl.get<ArtisanProvider>().getArtisans(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting)
                      return Container(
                        height: kHeight -
                            getProportionateScreenHeight(kHeight * 0.3),
                        width: kWidth,
                        child: Center(
                          child: Text("Fetching providers"),
                        ),
                      );
                    else if (snapshot.hasError)
                      return Container(
                        height: kHeight -
                            getProportionateScreenHeight(kHeight * 0.3),
                        width: kWidth,
                        child: Center(
                          child: Text("Error while fetching providers"),
                        ),
                      );
                    final artisans = snapshot.data;
                    return Expanded(
                      child: _preferGridFormat
                          ? GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing:
                                    getProportionateScreenWidth(8),
                                mainAxisSpacing:
                                    getProportionateScreenHeight(4),
                              ),
                              physics: BouncingScrollPhysics(),
                              itemBuilder: (_, index) => GridArtisanCardItem(
                                artisan: artisans[index],
                              ),
                              itemCount: artisans.length,
                            )
                          : ListView.separated(
                              clipBehavior: Clip.hardEdge,
                              physics: BouncingScrollPhysics(),
                              itemBuilder: (_, index) => ListArtisanCardItem(
                                artisan: artisans[index],
                              ),
                              separatorBuilder: (_, __) => SizedBox(
                                  height: getProportionateScreenHeight(2)),
                              itemCount: artisans.length,
                            ),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }

  // TODO: Get providers for this category
  void _fetchProviderForCategory() async {
    // await sl.get<ArtisanProvider>().getArtisans();
  }
}
