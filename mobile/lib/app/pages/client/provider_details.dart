import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:handyman/app/model/prefs_provider.dart';
import 'package:handyman/app/pages/client/search.dart';
import 'package:handyman/app/routes/route.gr.dart';
import 'package:handyman/app/widget/artisan_profile_info.dart';
import 'package:handyman/core/constants.dart';
import 'package:handyman/core/service_locator.dart';
import 'package:handyman/core/size_config.dart';
import 'package:handyman/data/entities/artisan_model.dart';
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

  @override
  Widget build(BuildContext context) {
    _themeData = Theme.of(context);
    final kHeight = MediaQuery.of(context).size.height;
    final kWidth = MediaQuery.of(context).size.width;

    return Consumer<PrefsProvider>(
      builder: (_, provider, __) => StreamBuilder<BaseUser>(
          stream: _apiService.getArtisanById(id: widget.artisan.id),
          initialData: ArtisanModel(artisan: widget.artisan),
          builder: (context, snapshot) {
            final artisan = snapshot.data.user;

            return Scaffold(
              key: _scaffoldKey,
              // floatingActionButton: FloatingActionButton(
              //   onPressed: () => context.navigator.push(
              //     Routes.conversationPage,
              //     arguments: ConversationPageArguments(
              //       isCustomer: false,
              //       recipient: artisan.id,
              //     ),
              //   ),
              //   child: Icon(Icons.message_outlined),
              // ),
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
                    child: AnimatedContainer(
                      duration: kScaleDuration,
                      height: kHeight,
                      width: kWidth,
                      child: ListView(
                        children: [
                          Stack(
                            children: [
                              Container(
                                height: kHeight * 0.4,
                                width: kWidth,
                                child: CachedNetworkImage(
                                  imageUrl: artisan.avatar,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                right:
                                    getProportionateScreenWidth(kSpacingNone),
                                bottom:
                                    getProportionateScreenHeight(kSpacingX84),
                                child: Container(
                                  alignment: Alignment.center,
                                  height:
                                      getProportionateScreenHeight(kSpacingX48),
                                  width:
                                      getProportionateScreenWidth(kSpacingX72),
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
                              Positioned(
                                right:
                                    getProportionateScreenWidth(kSpacingNone),
                                bottom:
                                    getProportionateScreenHeight(kSpacingX24),
                                child: Container(
                                  alignment: Alignment.center,
                                  height:
                                      getProportionateScreenHeight(kSpacingX48),
                                  width:
                                      getProportionateScreenWidth(kSpacingX72),
                                  decoration: BoxDecoration(
                                    color: _themeData.scaffoldBackgroundColor
                                        .withOpacity(kOpacityX70),
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(kSpacingX16),
                                      bottomLeft: Radius.circular(kSpacingX16),
                                    ),
                                  ),
                                  child: IconButton(
                                    icon: Icon(Icons.message_outlined),
                                    color: _themeData.iconTheme.color,
                                    onPressed: () => context.navigator.push(
                                      Routes.conversationPage,
                                      arguments: ConversationPageArguments(
                                        isCustomer: false,
                                        recipient: artisan.id,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          _buildProfileTab(artisan),
                          _buildPhotoTab(provider.userId),
                          _buildReviewTab(artisan),
                        ],
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
                            .withOpacity(kOpacityX90),
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
            );
          }),
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
            initialData: [],
            builder: (context, snapshot) {
              if (snapshot.hasError || snapshot.data.isEmpty)
                return Container(
                  width: double.infinity,
                  height: getProportionateScreenHeight(kSpacingX230),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Entypo.images,
                        size: getProportionateScreenHeight(kSpacingX72),
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

  Widget _buildReviewTab(Artisan artisan) => Consumer<PrefsProvider>(
        builder: (_, prefs, __) => StreamBuilder<List<CustomerReview>>(
            stream: _apiService.getReviews(artisan.id),
            initialData: [],
            builder: (context, snapshot) {
              return snapshot.hasError || snapshot.data.isEmpty
                  ? SizedBox.shrink()
                  : AnimationLimiter(
                      child: ListView.separated(
                        physics: kScrollPhysics,
                        itemCount: snapshot.data.length,
                        separatorBuilder: (_, __) => SizedBox(
                            height: getProportionateScreenHeight(kSpacingX8)),
                        itemBuilder: (_, index) => Material(
                          type: MaterialType.card,
                          elevation: 2,
                          clipBehavior: Clip.hardEdge,
                          child: Container(
                            width: double.infinity,
                            height: getProportionateScreenHeight(kSpacingX320),
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                              color: _themeData.errorColor,
                            ),
                          ),
                        ),
                      ),
                    );
            }),
      );

  Widget _buildProfileTab(Artisan artisan) =>
      ArtisanProfileInfo(artisan: artisan, apiService: _apiService);
}
