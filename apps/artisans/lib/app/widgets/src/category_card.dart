/*
 * Copyright (c) 2021.
 * This application is owned by HandyMan LLC,
 * developed & designed by Quabynah Codelabs LLC.
 *
 *
 * author: codelbas.quabynah@gmail.com
 */

import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:handyman/app/routes/routes.gr.dart';
import 'package:handyman/domain/models/models.dart';
import 'package:handyman/shared/shared.dart';

class GridCategoryCardItem extends StatefulWidget {
  final BaseServiceCategory category;
  final bool isSelectable;
  final Function(String) onSelected;

  const GridCategoryCardItem({
    Key key,
    @required this.category,
    this.isSelectable = false,
    this.onSelected,
  }) : super(key: key);

  @override
  _GridCategoryCardItemState createState() => _GridCategoryCardItemState();
}

class _GridCategoryCardItemState extends State<GridCategoryCardItem> {
  bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
    final kTheme = Theme.of(context);
    final selectedColor = kGreenColor.withOpacity(kEmphasisHigh);
    final selectedTextColor =
        kTheme.colorScheme.onPrimary.withOpacity(kEmphasisHigh);
    final unselectedColor =
        kTheme.colorScheme.background.withOpacity(kEmphasisMedium);
    final unselectedTextColor =
        kTheme.colorScheme.onBackground.withOpacity(kEmphasisMedium);

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          getProportionateScreenWidth(kSpacingX12),
        ),
      ),
      color: kTheme.cardColor,
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        borderRadius:
            BorderRadius.circular(getProportionateScreenWidth(kSpacingX12)),
        onTap: () {
          if (widget.isSelectable) {
            setState(() {
              _isSelected = !_isSelected;
            });
            if (widget.onSelected != null) {
              widget.onSelected(widget.category.id);
            }
          } else {
            context.navigator
                .pushCategoryDetailsPage(category: widget.category);
          }
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
                  color: _isSelected ? selectedColor : unselectedColor,
                ),
                alignment: Alignment.center,
                child: Text(
                  widget.category.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: kTheme.textTheme.button.copyWith(
                    color:
                        _isSelected ? selectedTextColor : unselectedTextColor,
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
