/*
 * Copyright (c) 2021.
 * This application is owned by HandyMan LLC,
 * developed & designed by Quabynah Codelabs LLC.
 *
 *
 * author: codelbas.quabynah@gmail.com
 */

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:handyman/domain/models/models.dart';
import 'package:handyman/shared/shared.dart';

class GridCategoryCardItem extends StatefulWidget {
  final BaseServiceCategory category;

  const GridCategoryCardItem({Key key, @required this.category})
      : super(key: key);

  @override
  _GridCategoryCardItemState createState() => _GridCategoryCardItemState();
}

class _GridCategoryCardItemState extends State<GridCategoryCardItem> {
  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          getProportionateScreenWidth(kSpacingX12),
        ),
      ),
      color: themeData.cardColor,
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        borderRadius:
            BorderRadius.circular(getProportionateScreenWidth(kSpacingX12)),
        onTap: () {
          /// fixme -> nav to category details page
        },
        child: Stack(
          children: [
            Hero(
              tag: widget.category.avatar,
              child: CachedNetworkImage(
                imageUrl: widget.category.avatar,
                height: getProportionateScreenHeight(kSpacingX250),
                width: double.infinity,
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    Center(
                  child: CircularProgressIndicator(
                      value: downloadProgress.progress),
                ),
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: getProportionateScreenHeight(kSpacingX250) / 2,
              right: kSpacingNone,
              left: kSpacingNone,
              bottom: kSpacingNone,
              child: Container(
                decoration: BoxDecoration(
                  color: themeData.scaffoldBackgroundColor
                      .withOpacity(kOpacityX70),
                ),
                alignment: Alignment.center,
                child: Text(
                  widget.category.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: themeData.textTheme.button.copyWith(
                    color: themeData.textTheme.bodyText1.color,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
