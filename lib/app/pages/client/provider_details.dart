import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:handyman/app/model/theme_provider.dart';
import 'package:handyman/app/pages/client/search.dart';
import 'package:handyman/app/widget/user_avatar.dart';
import 'package:handyman/core/constants.dart';
import 'package:handyman/core/size_config.dart';
import 'package:handyman/data/local_database.dart';
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
  final _galleryImages = <String>[
    kBannerAsset,
    kBannerAsset,
    kBannerAsset,
    kBannerAsset,
    kBannerAsset,
  ];

  final _ringColor =
      RandomColor().randomColor(colorBrightness: ColorBrightness.dark);

  @override
  Widget build(BuildContext context) {
    _themeData = Theme.of(context);
    final kHeight = MediaQuery.of(context).size.height;
    final kWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      key: _scaffoldKey,
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Feather.x),
          color: _themeData.iconTheme.color,
          onPressed: () => context.navigator.pop(),
        ),
        actions: [
          IconButton(
            tooltip: "Search",
            icon: Icon(Feather.search),
            color: _themeData.iconTheme.color,
            onPressed: () => showSearch(
              context: context,
              delegate: SearchPage(),
            ),
          ),
          IconButton(
            tooltip: "Call",
            icon: Icon(Feather.phone),
            color: _themeData.iconTheme.color,
            onPressed: null, // TODO: Add call option
          ),
          IconButton(
            tooltip: "Chat",
            icon: Icon(Icons.chat_bubble_outline_outlined),
            color: _themeData.iconTheme.color,
            onPressed: null, // TODO: Add chat option
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
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    SizedBox(height: getProportionateScreenHeight(8)),
                    UserAvatar(
                      url: widget.artisan.avatar,
                      onTap: () {},
                      radius: getProportionateScreenHeight(120),
                      ringColor: _ringColor,
                    ),
                    SizedBox(height: getProportionateScreenHeight(16)),
                    Text(
                      widget.artisan.name,
                      style: _themeData.textTheme.headline4,
                    ),
                    SizedBox(height: getProportionateScreenHeight(4)),
                    Text(
                      widget.artisan.business,
                      style: _themeData.textTheme.caption,
                    ),
                    SizedBox(height: getProportionateScreenHeight(16)),
                    Expanded(
                      child: _currentIndex == 0
                          ? _buildPhotoTab()
                          : _buildReviewTab(),
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
          ]),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     _isBooked = !_isBooked;
      //     setState(() {});
      //   },
      //   child: Icon(_isBooked ? Feather.user_check : Feather.user_plus),
      // ),
    );
  }

  Widget _buildPhotoTab() => Container(
        clipBehavior: Clip.hardEdge,
        padding: EdgeInsets.symmetric(
          vertical: getProportionateScreenHeight(24),
          horizontal: getProportionateScreenWidth(8),
        ),
        decoration: BoxDecoration(
          color: _themeData.scaffoldBackgroundColor.withOpacity(0.75),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(48),
            topRight: Radius.circular(48),
          ),
        ),
        child: AnimationLimiter(
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: getProportionateScreenHeight(8),
              crossAxisSpacing: getProportionateScreenWidth(8),
              childAspectRatio: 4 / 3,
            ),
            physics: kScrollPhysics,
            itemCount: _galleryImages.length,
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
                            .withOpacity(0.75),
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      );

  Widget _buildReviewTab() => Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: _themeData.scaffoldBackgroundColor.withOpacity(0.75),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(48),
            topRight: Radius.circular(48),
          ),
        ),
      );
}
