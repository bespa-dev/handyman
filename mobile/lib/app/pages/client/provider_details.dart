import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:handyman/app/model/prefs_provider.dart';
import 'package:handyman/app/model/theme_provider.dart';
import 'package:handyman/app/pages/client/search.dart';
import 'package:handyman/app/routes/route.gr.dart';
import 'package:handyman/app/widget/user_avatar.dart';
import 'package:handyman/core/constants.dart';
import 'package:handyman/core/service_locator.dart';
import 'package:handyman/core/size_config.dart';
import 'package:handyman/data/local_database.dart';
import 'package:handyman/data/provider/artisan_api_provider.dart';
import 'package:provider/provider.dart';
import 'package:random_color/random_color.dart';

class ServiceProviderDetails extends StatefulWidget {
  final Artisan artisan;

  const ServiceProviderDetails({Key key, this.artisan}) : super(key: key);

  @override
  _ServiceProviderDetailsState createState() => _ServiceProviderDetailsState();
}

class _ServiceProviderDetailsState extends State<ServiceProviderDetails> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  int _currentIndex = 0;
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
      builder: (_, prefsProvider, __) => Consumer<ThemeProvider>(
        builder: (_, themeProvider, __) => Scaffold(
          key: _scaffoldKey,
          extendBodyBehindAppBar: true,
          extendBody: true,
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
              IconButton(
                tooltip: "Toggle theme",
                icon: Icon(
                    themeProvider.isLightTheme ? Feather.moon : Feather.sun),
                onPressed: () => themeProvider.toggleTheme(),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => context.navigator.push(
              Routes.conversationPage,
              arguments: ConversationPageArguments(
                sender: prefsProvider.userId,
                recipient: widget.artisan.id,
              ),
            ),
            child: Icon(Icons.chat_bubble_outline_outlined),
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
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        SizedBox(
                            height: getProportionateScreenHeight(kSpacingX8)),
                        UserAvatar(
                          url: widget.artisan.avatar,
                          onTap: () {},
                          radius: getProportionateScreenHeight(kSpacingX120),
                          ringColor: _ringColor,
                        ),
                        SizedBox(
                            height: getProportionateScreenHeight(kSpacingX16)),
                        Text(
                          widget.artisan.name,
                          style: _themeData.textTheme.headline4,
                        ),
                        SizedBox(
                            height: getProportionateScreenHeight(kSpacingX4)),
                        Text(
                          widget.artisan.business,
                          style: _themeData.textTheme.caption,
                        ),
                        SizedBox(
                            height: getProportionateScreenHeight(kSpacingX16)),
                        Expanded(
                          child: _currentIndex == 0
                              ? _buildPhotoTab()
                              : _currentIndex == 1
                                  ? _buildReviewTab()
                                  : _buildBookingsTab(),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
              onTap: (newIndex) {
                setState(() {
                  _currentIndex = newIndex;
                });
              },
              currentIndex: _currentIndex,
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Feather.image),
                  label: "Photos",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Feather.users),
                  label: "Reviews",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Feather.bookmark),
                  label: "Bookings",
                ),
              ]),
          // floatingActionButton: FloatingActionButton(
          //   onPressed: () {
          //     _isBooked = !_isBooked;
          //     setState(() {});
          //   },
          //   child: Icon(_isBooked ? Feather.user_check : Feather.user_plus),
          // ),
        ),
      ),
    );
  }

  Widget _buildPhotoTab() => Material(
        type: MaterialType.card,
        elevation: 2,
        clipBehavior: Clip.hardEdge,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(kSpacingX16),
          topRight: Radius.circular(kSpacingX16),
        ),
        child: Container(
          clipBehavior: Clip.hardEdge,
          padding: EdgeInsets.symmetric(
            vertical: getProportionateScreenHeight(kSpacingX24),
            horizontal: getProportionateScreenWidth(kSpacingX8),
          ),
          decoration: BoxDecoration(
            color: _themeData.cardColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(kSpacingX16),
              topRight: Radius.circular(kSpacingX16),
            ),
          ),
          child: AnimationLimiter(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: getProportionateScreenHeight(kSpacingX8),
                crossAxisSpacing: getProportionateScreenWidth(kSpacingX8),
                childAspectRatio: 4 / 3,
              ),
              physics: kScrollPhysics,
              itemCount: 5 /*FIXME: Add gallery size here*/,
              itemBuilder: (_, index) {
                // final photo = _galleryImages[index];

                return AnimationConfiguration.staggeredGrid(
                  position: index,
                  columnCount: 2,
                  duration: kScaleDuration,
                  child: ScaleAnimation(
                    child: FadeInAnimation(
                      child: Container(
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          color: RandomColor()
                              .randomColor(
                                  colorBrightness: ColorBrightness.veryLight)
                              .withOpacity(kOpacityX70),
                          borderRadius: BorderRadius.circular(kSpacingX16),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      );

  Widget _buildReviewTab() => Consumer<PrefsProvider>(
        builder: (_, prefs, __) => StreamBuilder<List<CustomerReview>>(
            stream: _apiService.getReviews(widget.artisan.id),
            builder: (context, snapshot) {
              return Material(
                type: MaterialType.card,
                elevation: 2,
                clipBehavior: Clip.hardEdge,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(kSpacingX16),
                  topRight: Radius.circular(kSpacingX16),
                ),
                child: Container(
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    color: _themeData.cardColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(kSpacingX16),
                      topRight: Radius.circular(kSpacingX16),
                    ),
                  ),
                ),
              );
            }),
      );

  Widget _buildBookingsTab() => Consumer<PrefsProvider>(
        builder: (_, prefs, __) => StreamBuilder<List<Booking>>(
            stream: _apiService.getMyBookingsForProvider(
                prefs.userId, widget.artisan.id),
            builder: (context, snapshot) {
              return Material(
                type: MaterialType.card,
                elevation: 2,
                clipBehavior: Clip.hardEdge,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(kSpacingX16),
                  topRight: Radius.circular(kSpacingX16),
                ),
                child: Container(
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    color: _themeData.cardColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(kSpacingX16),
                      topRight: Radius.circular(kSpacingX16),
                    ),
                  ),
                ),
              );
            }),
      );
}
