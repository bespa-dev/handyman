import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:handyman/app/model/theme_provider.dart';
import 'package:handyman/app/pages/client/search.dart';
import 'package:handyman/app/widget/buttons.dart';
import 'package:handyman/app/widget/review_card.dart';
import 'package:handyman/app/widget/user_avatar.dart';
import 'package:handyman/core/constants.dart';
import 'package:handyman/core/size_config.dart';
import 'package:handyman/data/local_database.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class ServiceProviderDetails extends StatefulWidget {
  final Artisan artisan;

  const ServiceProviderDetails({Key key, this.artisan}) : super(key: key);

  @override
  _ServiceProviderDetailsState createState() => _ServiceProviderDetailsState();
}

class _ServiceProviderDetailsState extends State<ServiceProviderDetails> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  int _currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final kHeight = MediaQuery.of(context).size.height;
    final kWidth = MediaQuery.of(context).size.width;

    return DefaultTabController(
      length: 3,
      initialIndex: _currentIndex,
      child: Scaffold(
        key: _scaffoldKey,
        extendBodyBehindAppBar: true,
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
                  height: kHeight,
                  width: kWidth,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        SizedBox(height: getProportionateScreenHeight(8)),
                        UserAvatar(
                          url: widget.artisan.avatar,
                          onTap: () {},
                          radius: getProportionateScreenHeight(120),
                        ),
                        SizedBox(height: getProportionateScreenHeight(16)),
                        Text(
                          widget.artisan.name,
                          style: themeData.textTheme.headline4,
                        ),
                        SizedBox(height: getProportionateScreenHeight(4)),
                        Text(
                          widget.artisan.business,
                          style: themeData.textTheme.caption,
                        ),
                        SizedBox(height: getProportionateScreenHeight(24)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GestureDetector(
                              onTap: () {},
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                      color:
                                          themeData.accentColor.withOpacity(0.75),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Feather.phone,
                                      color: themeData.iconTheme.color,
                                    ),
                                  ),
                                  SizedBox(
                                      height: getProportionateScreenHeight(4)),
                                  Text("Call"),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                      color:
                                          themeData.accentColor.withOpacity(0.75),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      SimpleLineIcons.bubble,
                                      color: themeData.iconTheme.color,
                                    ),
                                  ),
                                  SizedBox(
                                      height: getProportionateScreenHeight(4)),
                                  Text("Chat"),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                      color:
                                          themeData.accentColor.withOpacity(0.75),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Feather.bell,
                                      color: themeData.iconTheme.color,
                                    ),
                                  ),
                                  SizedBox(
                                      height: getProportionateScreenHeight(4)),
                                  Text("Mute"),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: getProportionateScreenHeight(36)),
                        Container(
                          margin: EdgeInsets.only(
                              left: getProportionateScreenWidth(12)),
                          padding: EdgeInsets.symmetric(
                              vertical: getProportionateScreenHeight(8)),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Reviews",
                            style: themeData.textTheme.headline6.copyWith(
                              fontFamily:
                                  themeData.textTheme.bodyText1.fontFamily,
                            ),
                          ),
                        ),
                        CustomerReviewCard(
                          review: CustomerReview(
                            customerId: Uuid().v4(),
                            providerId: widget.artisan.id,
                            review:
                                "This service provider is the best in town. He has a lot of products under his name. He is the best in the business at the moment and second to none, obviously!",
                            id: 1,
                            createdAt: DateTime.now(),
                          ),
                        ),
                        SizedBox(height: getProportionateScreenHeight(16)),
                        ButtonOutlined(
                          width: kWidth * 0.6,
                          themeData: themeData,
                          onTap: () {},
                          label: "View all reviews",
                          icon: Icons.arrow_right_alt,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
