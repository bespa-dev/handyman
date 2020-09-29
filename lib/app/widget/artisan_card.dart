import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:handyman/app/routes/route.gr.dart';
import 'package:handyman/app/widget/user_avatar.dart';
import 'package:handyman/core/constants.dart';
import 'package:handyman/core/size_config.dart';
import 'package:handyman/data/local_database.dart';

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
          getProportionateScreenWidth(8),
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
          height: getProportionateScreenHeight(300),
          width: double.infinity,
          child: Stack(
            children: [
              Center(
                  child: Image.network(widget.artisan.avatar,
                      errorBuilder: (_, __, chunk) => Container(
                            color: themeData.errorColor.withOpacity(0.14),
                          ),
                      fit: BoxFit.cover)),
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
                      horizontal: getProportionateScreenWidth(8)),
                  decoration: BoxDecoration(
                    color: themeData.scaffoldBackgroundColor.withOpacity(0.9),
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(8),
                      topLeft: Radius.circular(8),
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
                      SizedBox(height: getProportionateScreenHeight(4)),
                      Text(
                        widget.artisan.business,
                        style: themeData.textTheme.caption,
                        overflow: TextOverflow.fade,
                        maxLines: 2,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: getProportionateScreenHeight(8)),
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
      margin: EdgeInsets.only(bottom: getProportionateScreenHeight(4)),
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
            Routes.serviceProviderDetails,
            arguments: ServiceProviderDetailsArguments(
              artisan: widget.artisan,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(getProportionateScreenHeight(8)),
            child: Row(
              children: [
                UserAvatar(url: widget.artisan.avatar),
                SizedBox(width: getProportionateScreenWidth(8)),
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
                    SizedBox(height: getProportionateScreenHeight(4)),
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
