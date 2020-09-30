import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:handyman/app/model/theme_provider.dart';
import 'package:handyman/app/pages/client/search.dart';
import 'package:handyman/app/widget/artisan_card.dart';
import 'package:handyman/core/constants.dart';
import 'package:handyman/core/service_locator.dart';
import 'package:handyman/core/size_config.dart';
import 'package:handyman/data/local_database.dart';
import 'package:handyman/data/provider/artisan_api_provider.dart';
import 'package:provider/provider.dart';

class CategoryProvidersPage extends StatefulWidget {
  final ServiceCategory category;

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
          onPressed: () => context.navigator.pop(),
        ),
        actions: [
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
      extendBodyBehindAppBar: true,
      body: Consumer<ThemeProvider>(
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
                width: kWidth,
                height: kHeight,
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(kSpacingX16)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: getProportionateScreenHeight(kSpacingX8)),
                    Text(
                      "Showing results for...",
                      style: themeData.textTheme.caption,
                    ),
                    Text(
                      widget.category.name,
                      style: themeData.textTheme.headline3,
                    ),
                    SizedBox(height: getProportionateScreenHeight(kSpacingX4)),
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
                            color: kTransparent,
                            height: 2,
                          ),
                        ),
                        Spacer(),
                        IconButton(
                          tooltip: "Toggle view",
                          icon: Icon(
                              _preferGridFormat ? Icons.sort : Feather.grid),
                          onPressed: () => setState(() {
                            _preferGridFormat = !_preferGridFormat;
                          }),
                        ),
                      ],
                    ),
                    SizedBox(height: getProportionateScreenHeight(kSpacingX16)),
                    FutureBuilder<List<Artisan>>(
                        future: sl
                            .get<ApiProviderService>()
                            .getArtisans(category: widget.category.id),
                        builder: (context, snapshot) {
                          final artisans = snapshot.data;
                          if (snapshot.connectionState ==
                              ConnectionState.waiting)
                            return Container(
                              height: kHeight -
                                  getProportionateScreenHeight(kHeight * 0.3),
                              width: kWidth,
                              child: Center(
                                child: Text("Fetching handymen..."),
                              ),
                            );
                          else if (snapshot.hasError || artisans.isEmpty)
                            return Container(
                              height: kHeight -
                                  getProportionateScreenHeight(kHeight * 0.3),
                              width: kWidth,
                              child: Center(
                                child: Text(
                                    "No registered service providers found"),
                              ),
                            );
                          return Expanded(
                            child: _preferGridFormat
                                ? AnimationLimiter(
                                    child: GridView.builder(
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        crossAxisSpacing:
                                            getProportionateScreenWidth(
                                                kSpacingX8),
                                        mainAxisSpacing:
                                            getProportionateScreenHeight(
                                                kSpacingX4),
                                      ),
                                      physics: kScrollPhysics,
                                      itemBuilder: (_, index) =>
                                          AnimationConfiguration.staggeredGrid(
                                        position: index,
                                        duration: kScaleDuration,
                                        columnCount: 2,
                                        child: ScaleAnimation(
                                          child: FadeInAnimation(
                                            child: GridArtisanCardItem(
                                              artisan: artisans[index],
                                            ),
                                          ),
                                        ),
                                      ),
                                      itemCount: artisans.length,
                                    ),
                                  )
                                : ListView.separated(
                                    clipBehavior: Clip.hardEdge,
                                    physics: kScrollPhysics,
                                    itemBuilder: (_, index) =>
                                        AnimationConfiguration.staggeredList(
                                      position: index,
                                      duration: kScaleDuration,
                                      child: SlideAnimation(
                                        verticalOffset: kSlideOffset,
                                        child: FadeInAnimation(
                                          child: ListArtisanCardItem(
                                            artisan: artisans[index],
                                          ),
                                        ),
                                      ),
                                    ),
                                    separatorBuilder: (_, __) => SizedBox(
                                        height: getProportionateScreenHeight(
                                            kSpacingX2)),
                                    itemCount: artisans.length,
                                  ),
                          );
                        }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // TODO: Get providers for this category
  void _fetchProviderForCategory() async {
    // await sl.get<ArtisanProvider>().getArtisans();
  }
}
