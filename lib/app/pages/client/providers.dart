import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:handyman/app/pages/client/search.dart';
import 'package:handyman/app/routes/route.gr.dart';
import 'package:handyman/core/constants.dart';
import 'package:handyman/core/size_config.dart';

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
      body: Container(
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
            Expanded(
              child: _preferGridFormat
                  ? GridView(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: getProportionateScreenWidth(8),
                        mainAxisSpacing: getProportionateScreenHeight(4),
                      ),
                      physics: BouncingScrollPhysics(),
                      children: [
                        Card(
                          clipBehavior: Clip.hardEdge,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              getProportionateScreenWidth(8),
                            ),
                          ),
                          child: GestureDetector(
                            onTap: () => context.navigator.push(
                              Routes.serviceDetailsPage,
                              arguments: ServiceDetailsPageArguments(
                                service: "Some dummy service",
                              ),
                            ),
                            child: Container(
                              height: getProportionateScreenHeight(300),
                              width: double.infinity,
                              child: Stack(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical:
                                            getProportionateScreenHeight(8)),
                                    child: Center(
                                        child: Image.asset(kBannerAsset,
                                            fit: BoxFit.cover)),
                                  ),
                                  Positioned(
                                    top: 0,
                                    right: 0,
                                    child: Container(
                                      height: getProportionateScreenHeight(48),
                                      width: getProportionateScreenWidth(48),
                                      decoration: BoxDecoration(
                                        color: kGreenColor,
                                        borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(24),
                                        ),
                                      ),
                                      child: Icon(
                                        Feather.award,
                                        color: kWhiteColor,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: getProportionateScreenHeight(80),
                                    left: 0,
                                    right: 0,
                                    bottom: 0,
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal:
                                              getProportionateScreenWidth(8)),
                                      decoration: BoxDecoration(
                                        color: themeData.scaffoldBackgroundColor
                                            .withOpacity(0.9),
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(8),
                                          topLeft: Radius.circular(8),
                                        ),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Quabynah Bilson Jr.",
                                            style:
                                                themeData.textTheme.headline6,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            textAlign: TextAlign.center,
                                          ),
                                          SizedBox(
                                              height:
                                                  getProportionateScreenHeight(
                                                      4)),
                                          Text(
                                            "Ali Connors AC Repairs",
                                            style: themeData.textTheme.caption,
                                            overflow: TextOverflow.fade,
                                            maxLines: 2,
                                            textAlign: TextAlign.center,
                                          ),
                                          SizedBox(
                                              height:
                                                  getProportionateScreenHeight(
                                                      8)),
                                          Text(
                                            "\$233",
                                            style: themeData.textTheme.headline6
                                                .copyWith(
                                              color: themeData.primaryColor,
                                              fontFamily: themeData.textTheme
                                                  .bodyText1.fontFamily,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  : ListView.separated(
                      clipBehavior: Clip.hardEdge,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (_, index) => Container(
                        margin: EdgeInsets.only(
                            bottom: getProportionateScreenHeight(4)),
                        width: kWidth,
                        child: Card(
                          clipBehavior: Clip.hardEdge,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              getProportionateScreenWidth(8),
                            ),
                          ),
                          child: GestureDetector(
                            onTap: () => context.navigator.push(
                              Routes.serviceDetailsPage,
                              arguments: ServiceDetailsPageArguments(
                                service: "Some dummy service",
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(
                                  getProportionateScreenHeight(8)),
                              child: Row(
                                children: [
                                  Container(
                                    clipBehavior: Clip.hardEdge,
                                    height: getProportionateScreenHeight(48),
                                    width: getProportionateScreenWidth(48),
                                    decoration: BoxDecoration(
                                      color: themeData.accentColor,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Image.asset(kBannerAsset,
                                        fit: BoxFit.cover),
                                  ),
                                  SizedBox(
                                      width: getProportionateScreenWidth(8)),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Quabynah Bilson",
                                        maxLines: 1,
                                        style: themeData.textTheme.headline6
                                            .copyWith(
                                          fontSize: themeData
                                              .textTheme.bodyText1.fontSize,
                                        ),
                                      ),
                                      SizedBox(
                                          height:
                                              getProportionateScreenHeight(4)),
                                      Text("Ali Connors AC Repairs",
                                          maxLines: 2,
                                          overflow: TextOverflow.fade,
                                          style: themeData.textTheme.caption),
                                    ],
                                  ),
                                  Spacer(),
                                  Text(
                                    "\$23.99",
                                    style:
                                        themeData.textTheme.headline6.copyWith(
                                      color: themeData.primaryColor,
                                      fontFamily: themeData
                                          .textTheme.bodyText1.fontFamily,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      separatorBuilder: (_, __) =>
                          SizedBox(height: getProportionateScreenHeight(2)),
                      itemCount: Random().nextInt(12),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  // TODO: Get providers for this category
  void _fetchProviderForCategory() async {}
}
