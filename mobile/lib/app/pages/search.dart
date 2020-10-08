import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:handyman/app/model/prefs_provider.dart';
import 'package:handyman/core/constants.dart';
import 'package:handyman/core/size_config.dart';
import 'package:handyman/data/services/data.dart';
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
              Positioned(
                  top: getProportionateScreenHeight(
                      kSpacingX120 + kToolbarHeight),
                  width: _kWidth,
                  child: _buildSearchContent(provider)),
              Positioned(
                  top: getProportionateScreenHeight(kSpacingX120),
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

  Widget _buildSearchBar() => Container(
        padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(kSpacingX24),
        ),
        margin: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(kSpacingX24),
        ),
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: _themeData.cardColor,
          borderRadius: BorderRadius.circular(kSpacingX16),
        ),
        child: Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: _searchController,
                textInputAction: TextInputAction.search,
                decoration: InputDecoration(
                  border: InputBorder.none,
                ),
                onFieldSubmitted: _performSearch,
                onChanged: (input) {
                  _isEditing = input != null && input.isNotEmpty;
                  setState(() {});
                },
              ),
            ),
            IconButton(
              icon: Icon(Feather.search),
              onPressed: () => _isEditing ? _performSearch(_searchController.text) : null,
            ),
          ],
        ),
      );

  void _performSearch(String value) async {
    var results =
        await _dataService.searchFor(value: value.toLowerCase().trim());
    debugPrint(results.toString());
  }

  Widget _buildSearchContent(PrefsProvider provider) => Container(
        height: _kHeight,
        width: _kWidth,
        margin: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(kSpacingX24),
        ),
        decoration: BoxDecoration(
          color: _themeData.colorScheme.error,
        ),
      );
}
