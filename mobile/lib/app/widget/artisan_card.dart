import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:handyman/app/routes/route.gr.dart';
import 'package:handyman/app/widget/user_avatar.dart';
import 'package:handyman/core/constants.dart';
import 'package:handyman/core/size_config.dart';
import 'package:handyman/data/local_database.dart';
import 'package:random_color/random_color.dart';

class GridArtisanCardItem extends StatefulWidget {
  final Artisan artisan;

  const GridArtisanCardItem({Key key, this.artisan}) : super(key: key);

  @override
  _GridArtisanCardItemState createState() => _GridArtisanCardItemState();
}

class _GridArtisanCardItemState extends State<GridArtisanCardItem> {
  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return Card(
      key: ValueKey<String>(widget.artisan.id),
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          getProportionateScreenWidth(kSpacingX8),
        ),
      ),
      child: GestureDetector(
        onTap: () => context.navigator.push(
          Routes.serviceProviderDetails,
          arguments: ServiceProviderDetailsArguments(
            artisan: widget.artisan,
          ),
        ),
        child: Container(
          height: getProportionateScreenHeight(kSpacingX300),
          width: double.infinity,
          child: Stack(
            children: [
              Hero(
                tag: widget.artisan.avatar,
                child: CachedNetworkImage(
                    imageUrl: widget.artisan.avatar,
                    height: getProportionateScreenHeight(kSpacingX300),
                    width: double.infinity,
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) => Center(
                            child: CircularProgressIndicator(
                                value: downloadProgress.progress)),
                    errorWidget: (_, __, chunk) => Container(
                          color: RandomColor()
                              .randomColor(
                                colorBrightness: ColorBrightness.dark,
                              )
                              .withOpacity(kOpacityX14),
                        ),
                    fit: BoxFit.cover),
              ),
              Positioned(
                top: kSpacingNone,
                right: kSpacingNone,
                child: Container(
                  height: getProportionateScreenHeight(kSpacingX48),
                  width: getProportionateScreenWidth(kSpacingX48),
                  decoration: BoxDecoration(
                    color: kGreenColor,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(kSpacingX24),
                    ),
                  ),
                  child: Icon(
                    Feather.award,
                    color: kWhiteColor,
                  ),
                ),
              ),
              Positioned(
                top: getProportionateScreenHeight(kSpacingX72),
                left: kSpacingNone,
                right: kSpacingNone,
                bottom: kSpacingNone,
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(kSpacingX8)),
                  decoration: BoxDecoration(
                    color: themeData.scaffoldBackgroundColor
                        .withOpacity(kOpacityX90),
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(kSpacingX8),
                      topLeft: Radius.circular(kSpacingX8),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.artisan.name,
                        style: themeData.textTheme.headline6,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                          height: getProportionateScreenHeight(kSpacingX4)),
                      Text(
                        widget.artisan.business,
                        style: themeData.textTheme.caption,
                        overflow: TextOverflow.fade,
                        maxLines: 2,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                          height: getProportionateScreenHeight(kSpacingX8)),
                      Text(
                        "\$${widget.artisan.price}",
                        style: themeData.textTheme.headline6.copyWith(
                          color: themeData.primaryColor,
                          fontFamily: themeData.textTheme.bodyText1.fontFamily,
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
    );
  }
}

class ListArtisanCardItem extends StatefulWidget {
  final Artisan artisan;

  const ListArtisanCardItem({Key key, this.artisan}) : super(key: key);

  @override
  _ListArtisanCardItemState createState() => _ListArtisanCardItemState();
}

class _ListArtisanCardItemState extends State<ListArtisanCardItem> {
  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    // final kHeight = MediaQuery.of(context).size.height;
    final kWidth = MediaQuery.of(context).size.width;

    return Container(
      margin: EdgeInsets.only(bottom: getProportionateScreenHeight(kSpacingX4)),
      width: kWidth,
      child: Card(
        clipBehavior: Clip.hardEdge,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            getProportionateScreenWidth(kSpacingX8),
          ),
        ),
        child: GestureDetector(
          onTap: () => context.navigator.push(
            Routes.serviceProviderDetails,
            arguments: ServiceProviderDetailsArguments(
              artisan: widget.artisan,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(getProportionateScreenHeight(kSpacingX8)),
            child: Row(
              children: [
                UserAvatar(
                  url: widget.artisan.avatar,
                  ringColor: RandomColor()
                      .randomColor(colorBrightness: ColorBrightness.dark),
                ),
                SizedBox(width: getProportionateScreenWidth(kSpacingX8)),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.artisan.name,
                      maxLines: 1,
                      style: themeData.textTheme.headline6.copyWith(
                        fontSize: themeData.textTheme.bodyText1.fontSize,
                      ),
                    ),
                    SizedBox(height: getProportionateScreenHeight(kSpacingX4)),
                    Text(
                      widget.artisan.business,
                      maxLines: 2,
                      overflow: TextOverflow.fade,
                      style: themeData.textTheme.caption,
                    ),
                  ],
                ),
                Spacer(),
                Text(
                  "\$${widget.artisan.price}",
                  style: themeData.textTheme.headline6.copyWith(
                    color: themeData.primaryColor,
                    fontFamily: themeData.textTheme.bodyText1.fontFamily,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
