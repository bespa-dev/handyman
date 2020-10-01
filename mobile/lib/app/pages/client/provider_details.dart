import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:handyman/app/model/prefs_provider.dart';
import 'package:handyman/app/pages/client/search.dart';
import 'package:handyman/app/routes/route.gr.dart';
import 'package:handyman/app/widget/user_avatar.dart';
import 'package:handyman/core/constants.dart';
import 'package:handyman/core/service_locator.dart';
import 'package:handyman/core/size_config.dart';
import 'package:handyman/data/local_database.dart';
import 'package:handyman/data/provider/artisan_api_provider.dart';
import 'package:handyman/domain/models/user.dart';
import 'package:provider/provider.dart';
import 'package:random_color/random_color.dart';
import 'package:intl/intl.dart';

class ServiceProviderDetails extends StatefulWidget {
  final Artisan artisan;

  const ServiceProviderDetails({Key key, this.artisan}) : super(key: key);

  @override
  _ServiceProviderDetailsState createState() => _ServiceProviderDetailsState();
}

class _ServiceProviderDetailsState extends State<ServiceProviderDetails> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isBooked = false;
  ThemeData _themeData;
  final _apiService = sl.get<ApiProviderService>();

  final _ringColor =
      RandomColor().randomColor(colorBrightness: ColorBrightness.dark);

  @override
  Widget build(BuildContext context) {
    _themeData = Theme.of(context);
    final kHeight = MediaQuery.of(context).size.height;
    final kWidth = MediaQuery.of(context).size.width;

    return Consumer<PrefsProvider>(
      builder: (_, provider, __) => Scaffold(
        key: _scaffoldKey,
        floatingActionButton: FloatingActionButton(
          onPressed: () => context.navigator.push(
            Routes.conversationPage,
            arguments: ConversationPageArguments(
              isCustomer: false,
              recipient: widget.artisan.id,
            ),
          ),
          child: Icon(Icons.message_outlined),
        ),
        body: Stack(
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
              child: SingleChildScrollView(
                child: Container(
                  height: kHeight,
                  width: kWidth,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Stack(
                        children: [
                          Container(
                            height: kHeight * 0.4,
                            width: kWidth,
                            child: CachedNetworkImage(
                              imageUrl: widget.artisan.avatar,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            right: getProportionateScreenWidth(kSpacingNone),
                            bottom: getProportionateScreenHeight(kSpacingX24),
                            child: Container(
                              alignment: Alignment.center,
                              height: getProportionateScreenHeight(kSpacingX48),
                              width: getProportionateScreenWidth(kSpacingX72),
                              decoration: BoxDecoration(
                                color: _themeData.scaffoldBackgroundColor
                                    .withOpacity(kOpacityX70),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(kSpacingX16),
                                  bottomLeft: Radius.circular(kSpacingX16),
                                ),
                              ),
                              child: IconButton(
                                icon: Icon(_isBooked
                                    ? Entypo.heart
                                    : Entypo.heart_outlined),
                                iconSize: kSpacingX36,
                                color: _isBooked
                                    ? _themeData.errorColor
                                    : _themeData.iconTheme.color,
                                onPressed: () {
                                  _isBooked = !_isBooked;
                                  setState(() {});
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: _buildProfileTab(),
                      ),
                      // Expanded(
                      //   child: _buildPhotoTab(provider.userId),
                      // ),
                      // Expanded(
                      //   child: _buildReviewTab(),
                      // ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: kSpacingNone,
              width: kWidth,
              child: SafeArea(
                child: Container(
                  width: kWidth,
                  height: kToolbarHeight,
                  color: _themeData.scaffoldBackgroundColor
                      .withOpacity(kOpacityX70),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: Icon(Feather.x),
                        onPressed: () => context.navigator.pop(),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            tooltip: "Search",
                            icon: Icon(Feather.search),
                            onPressed: () => showSearch(
                              context: context,
                              delegate: SearchPage(),
                            ),
                          ),
                          IconButton(
                            tooltip: "Toggle theme",
                            icon: Icon(provider.isLightTheme
                                ? Feather.moon
                                : Feather.sun),
                            onPressed: () => provider.toggleTheme(),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPhotoTab(userId) => Container(
        clipBehavior: Clip.hardEdge,
        padding: EdgeInsets.symmetric(
          vertical: getProportionateScreenHeight(kSpacingX24),
          horizontal: getProportionateScreenWidth(kSpacingX8),
        ),
        decoration: BoxDecoration(
          color: _themeData.cardColor,
        ),
        child: StreamBuilder<List<Gallery>>(
            stream: _apiService.getPhotosForUser(userId),
            builder: (context, snapshot) {
              if (snapshot.hasError || snapshot.data.isEmpty)
                return Container(
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Entypo.images,
                        size: getProportionateScreenHeight(kSpacingX64),
                      ),
                      SizedBox(
                          height: getProportionateScreenHeight(kSpacingX16)),
                      Text(
                        "No photos found",
                        style: _themeData.textTheme.bodyText1,
                      ),
                    ],
                  ),
                );
              return AnimationLimiter(
                child: GridView.builder(
                  scrollDirection: Axis.horizontal,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    mainAxisSpacing: getProportionateScreenHeight(kSpacingX8),
                    crossAxisSpacing: getProportionateScreenWidth(kSpacingX8),
                  ),
                  physics: kScrollPhysics,
                  itemCount: snapshot.data.length,
                  itemBuilder: (_, index) {
                    final photo = snapshot.data[index];

                    return AnimationConfiguration.staggeredGrid(
                      position: index,
                      columnCount: 1,
                      duration: kScaleDuration,
                      child: ScaleAnimation(
                        child: FadeInAnimation(
                          child: Container(
                            clipBehavior: Clip.hardEdge,
                            width: MediaQuery.of(context).size.width * 0.3,
                            decoration: BoxDecoration(
                              color: RandomColor()
                                  .randomColor(
                                      colorBrightness:
                                          ColorBrightness.veryLight)
                                  .withOpacity(kOpacityX70),
                              borderRadius: BorderRadius.circular(kSpacingX16),
                            ),
                            child: CachedNetworkImage(
                              imageUrl: photo.imageUrl,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            }),
      );

  Widget _buildReviewTab() => Consumer<PrefsProvider>(
        builder: (_, prefs, __) => StreamBuilder<List<CustomerReview>>(
            stream: _apiService.getReviews(widget.artisan.id),
            builder: (context, snapshot) {
              return Material(
                type: MaterialType.card,
                elevation: 2,
                clipBehavior: Clip.hardEdge,
                child: Container(
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    color: _themeData.cardColor,
                  ),
                ),
              );
            }),
      );

  Widget _buildProfileTab() => Consumer<PrefsProvider>(
        builder: (_, prefs, __) => StreamBuilder<BaseUser>(
            stream: _apiService.getArtisanById(id: widget.artisan.id),
            builder: (context, snapshot) {
              return Material(
                type: MaterialType.card,
                elevation: 2,
                clipBehavior: Clip.hardEdge,
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: getProportionateScreenWidth(kSpacingX16),
                          vertical: getProportionateScreenHeight(kSpacingX12)),
                      decoration: BoxDecoration(color: _themeData.cardColor),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.artisan.name,
                                    style: _themeData.textTheme.headline4,
                                  ),
                                  SizedBox(
                                    height: getProportionateScreenHeight(
                                        kSpacingX4),
                                  ),
                                  Text(
                                    widget.artisan.business,
                                    style: _themeData.textTheme.bodyText2,
                                  ),
                                  SizedBox(
                                    height: getProportionateScreenHeight(
                                        kSpacingX8),
                                  ),
                                  RichText(
                                    textAlign: TextAlign.start,
                                    text: TextSpan(
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: "Available: ",
                                          style: _themeData.textTheme.bodyText1
                                              .copyWith(
                                            color: _themeData.primaryColor,
                                          ),
                                        ),
                                        TextSpan(
                                          text:
                                              "${DateFormat.jm().format(DateTime.fromMillisecondsSinceEpoch(widget.artisan.startWorkingHours))} - ",
                                          style: _themeData.textTheme.bodyText2,
                                        ),
                                        TextSpan(
                                          text: DateFormat.jm().format(DateTime
                                              .fromMillisecondsSinceEpoch(widget
                                                  .artisan.endWorkingHours)),
                                          style: _themeData.textTheme.bodyText2,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(kSpacingX8),
                                    decoration: BoxDecoration(
                                      color: _themeData.primaryColor
                                          .withOpacity(kOpacityX90),
                                      borderRadius:
                                          BorderRadius.circular(kSpacingX8),
                                    ),
                                    child: Text(
                                      widget.artisan.rating.toString(),
                                      style: _themeData.textTheme.bodyText1
                                          .copyWith(
                                        color: _themeData.colorScheme.onPrimary,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: getProportionateScreenHeight(
                                        kSpacingX4),
                                  ),
                                  RatingBarIndicator(
                                    rating: widget.artisan.rating,
                                    itemBuilder: (_, index) => Icon(
                                      Icons.star,
                                      color: kAmberColor,
                                    ),
                                    itemCount: 5,
                                    itemSize: kSpacingX16,
                                    direction: Axis.horizontal,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                              height: getProportionateScreenHeight(kSpacingX8)),
                          Divider(height: kSpacingX12, endIndent: kSpacingX24),
                          SizedBox(
                              height: getProportionateScreenHeight(kSpacingX8)),
                          // SizedBox(height: getProportionateScreenHeight(kSpacingX16)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    widget.artisan.completedBookingsCount
                                        .toString(),
                                    style:
                                        _themeData.textTheme.headline5.copyWith(
                                      color: _themeData.primaryColor,
                                    ),
                                  ),
                                  SizedBox(
                                    height: getProportionateScreenHeight(
                                        kSpacingX4),
                                  ),
                                  Text(
                                    "Ongoing",
                                    style: _themeData.textTheme.bodyText2,
                                  ),
                                ],
                              ),
                              Container(
                                height:
                                    getProportionateScreenHeight(kSpacingX8),
                                width: getProportionateScreenWidth(kSpacingX8),
                                decoration: BoxDecoration(
                                  color: _themeData.primaryColor,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    widget.artisan.ongoingBookingsCount
                                        .toString(),
                                    style: _themeData.textTheme.headline5
                                        .copyWith(color: kGreenColor),
                                  ),
                                  SizedBox(
                                    height: getProportionateScreenHeight(
                                        kSpacingX4),
                                  ),
                                  Text(
                                    "Completed",
                                    style: _themeData.textTheme.bodyText2,
                                  ),
                                ],
                              ),
                              Container(
                                height:
                                    getProportionateScreenHeight(kSpacingX8),
                                width: getProportionateScreenWidth(kSpacingX8),
                                decoration: BoxDecoration(
                                  color: _themeData.primaryColor,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    widget.artisan.cancelledBookingsCount
                                        .toString(),
                                    style:
                                        _themeData.textTheme.headline5.copyWith(
                                      color: _themeData.errorColor
                                          .withOpacity(kOpacityX70),
                                    ),
                                  ),
                                  SizedBox(
                                    height: getProportionateScreenHeight(
                                        kSpacingX4),
                                  ),
                                  Text(
                                    "Cancelled",
                                    style: _themeData.textTheme.bodyText2,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        vertical: getProportionateScreenHeight(kSpacingX16),
                        horizontal: getProportionateScreenWidth(kSpacingX24),
                      ),
                      decoration: BoxDecoration(
                        color: _themeData.primaryColor.withOpacity(kOpacityX90),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          RotatedBox(
                            quarterTurns: 2,
                            child: Container(
                              alignment: Alignment.topCenter,
                              child: Icon(
                                Icons.format_quote_outlined,
                                size: _themeData.textTheme.headline4.fontSize,
                                color: _themeData.colorScheme.onPrimary,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              kLoremText,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: _themeData.colorScheme.onPrimary,
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.topCenter,
                            child: Icon(
                              Icons.format_quote_outlined,
                              size: _themeData.textTheme.headline4.fontSize,
                              color: _themeData.colorScheme.onPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
      );
}
