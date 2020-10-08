import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:handyman/app/model/prefs_provider.dart';
import 'package:handyman/app/widget/artisan_card.dart';
import 'package:handyman/core/constants.dart';
import 'package:handyman/core/size_config.dart';
import 'package:handyman/data/local_database.dart';
import 'package:handyman/data/services/data.dart';
import 'package:handyman/domain/models/user.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _dataService = DataServiceImpl.create();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  double _kWidth, _kHeight;
  ThemeData _themeData;
  bool _isEditing = false;
  List<BaseUser> _artisans = <BaseUser>[];
  TextEditingController _searchController = TextEditingController();

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
              Positioned.fill(
                  top: getProportionateScreenHeight(_kHeight * 0.25),
                  left: kSpacingNone,
                  right: kSpacingNone,
                  bottom: kSpacingNone,
                  child: _buildSearchContent(provider)),
              Positioned(
                  top: getProportionateScreenHeight(kSpacingX96),
                  width: _kWidth,
                  child: _buildSearchBar()),
              Positioned(
                  height: getProportionateScreenHeight(kToolbarHeight),
                  width: _kWidth,
                  child: _buildAppbar(provider)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppbar(PrefsProvider provider) => Container(
        height: double.infinity,
        width: _kWidth,
        decoration: BoxDecoration(
          color: _themeData.scaffoldBackgroundColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
              tooltip: "Go back",
              icon: Icon(Feather.x),
              onPressed: () => context.navigator.pop(),
            ),
          ],
        ),
      );

  Widget _buildSearchBar() => Consumer<PrefsProvider>(
        builder: (_, provider, __) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: getProportionateScreenHeight(_kHeight * 0.12),
              padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(kSpacingX16),
              ),
              margin: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(kSpacingX24),
              ),
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                color: _themeData.cardColor,
                borderRadius: BorderRadius.circular(kSpacingX16),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        Feather.search,
                        color: _themeData.disabledColor
                            .withOpacity(kEmphasisMedium),
                      ),
                      SizedBox(
                        width: getProportionateScreenWidth(kSpacingX8),
                      ),
                      Expanded(
                        child: TextFormField(
                          controller: _searchController,
                          textInputAction: TextInputAction.search,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                          onFieldSubmitted: provider.userType == kCustomerString
                              ? _performArtisanSearch
                              : _performSearch,
                          textAlign: TextAlign.start,
                          autocorrect: true,
                          autofillHints: ["Search anything"],
                          onChanged: (_) => setState(() {
                            _isEditing = _.isNotEmpty;
                            if (_.isEmpty) _artisans = [];
                          }),
                        ),
                      ),
                      _isEditing
                          ? Row(
                              children: [
                                SizedBox(
                                  width:
                                      getProportionateScreenWidth(kSpacingX8),
                                ),
                                GestureDetector(
                                  onTap: () => _searchController.clear(),
                                  child: Icon(
                                    Feather.x,
                                    color: _themeData.disabledColor
                                        .withOpacity(kEmphasisMedium),
                                  ),
                                ),
                              ],
                            )
                          : SizedBox.shrink(),
                    ],
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(kSpacingX8),
                  ),
                  StreamBuilder<List<ServiceCategory>>(
                      stream: _dataService.getCategories(),
                      initialData: [],
                      builder: (context, snapshot) {
                        return Container(
                          width: double.infinity,
                          height: getProportionateScreenHeight(kSpacingX48),
                          child: ListView.separated(
                            physics: kScrollPhysics,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (_, index) {
                              final category = snapshot.data[index];
                              return InkWell(
                                onTap: () async {
                                  _searchController.text = category.name;
                                  var results = await _dataService.searchFor(
                                      value: "", categoryId: category.id);
                                  _artisans = results
                                      .where((element) =>
                                          element.user.category == category.id)
                                      .toList();
                                  _isEditing = false;
                                  setState(() {});
                                },
                                child: Chip(
                                  label: Text(category.name),
                                  padding: EdgeInsets.symmetric(
                                    horizontal:
                                        getProportionateScreenWidth(kSpacingX8),
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (_, __) => SizedBox(
                              width: getProportionateScreenWidth(kSpacingX8),
                            ),
                            itemCount: snapshot.data.length,
                          ),
                        );
                      }),
                ],
              ),
            ),
            _artisans.isEmpty
                ? SizedBox.shrink()
                : Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: getProportionateScreenHeight(kSpacingX8),
                      horizontal: getProportionateScreenWidth(kSpacingX24),
                    ),
                    child: Text(
                      "${_artisans.length} results found in your area",
                      style: TextStyle(
                        color: _themeData.disabledColor
                            .withOpacity(kEmphasisMedium),
                      ),
                    ),
                  )
          ],
        ),
      );

  void _performSearch(String value) async {
    var results =
        await _dataService.searchFor(value: value.toLowerCase().trim());
    debugPrint(results.toString());
    _artisans =
        results /*.where((element) => element.user.category.contains(_categoryId))*/;
    setState(() {});
  }

  void _performArtisanSearch(String value) async {
    var results =
        await _dataService.searchFor(value: value.toLowerCase().trim());
    debugPrint(results.toString());
    _artisans =
        results /*.where((element) => element.user.category.contains(_categoryId))*/;
    setState(() {});
  }

  Widget _buildSearchContent(PrefsProvider provider) => _artisans.isEmpty
      ? Container(
          height: getProportionateScreenHeight(kSpacingX320),
          width: _kWidth,
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
                "No artisans available",
                style: _themeData.textTheme.bodyText2.copyWith(
                  color: _themeData.colorScheme.onBackground,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        )
      : Container(
          height: _kHeight,
          width: _kWidth,
          margin: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(kSpacingX24),
          ),
          decoration: BoxDecoration(),
          child: AnimationLimiter(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: getProportionateScreenWidth(kSpacingX8),
                mainAxisSpacing: getProportionateScreenHeight(kSpacingX4),
              ),
              physics: kScrollPhysics,
              itemBuilder: (_, index) {
                final artisan = _artisans[index];
                return AnimationConfiguration.staggeredList(
                  position: index,
                  duration: kScaleDuration,
                  child: ScaleAnimation(
                    duration: kScaleDuration,
                    child: FadeInAnimation(
                      child: GridArtisanCardItem(artisan: artisan),
                    ),
                  ),
                );
              },
              itemCount: _artisans.length,
            ),
          ),
        );
}
