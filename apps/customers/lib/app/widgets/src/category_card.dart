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
import 'package:lite/app/routes/routes.gr.dart';
import 'package:lite/domain/models/models.dart';
import 'package:lite/shared/shared.dart';

class GridCategoryCardItem extends StatefulWidget {

  const GridCategoryCardItem({
    Key key,
    @required this.category,
    this.isSelectable = false,
    this.isSelected = false,
    this.onSelected,
  }) : super(key: key);

  final BaseServiceCategory category;
  final bool isSelectable;
  final bool isSelected;
  final Function(BaseServiceCategory) onSelected;

  @override
  _GridCategoryCardItemState createState() => _GridCategoryCardItemState();
}

class _GridCategoryCardItemState extends State<GridCategoryCardItem> {
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
            if (widget.onSelected != null) {
              widget.onSelected(widget.category);
            }
          } else {
            context.navigator
                .pushCategoryDetailsPage(category: widget.category);
          }
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

          ],
        ),
      ),
    );
  }
}

class SelectableGridCategory extends StatefulWidget {
  final List<BaseServiceCategory> categories;
  final Function(BaseServiceCategory) onSelected;
  final String selected;

  const SelectableGridCategory({
    Key key,
    @required this.categories,
    @required this.onSelected,
    @required this.selected,
  }) : super(key: key);

  @override
  _SelectableGridCategoryState createState() => _SelectableGridCategoryState();
}

class _SelectableGridCategoryState extends State<SelectableGridCategory> {
  @override
  Widget build(BuildContext context) => GridView.builder(
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemCount: widget.categories.length,
        itemBuilder: (_, index) {
          final category = widget.categories[index];
          return GridCategoryCardItem(
            category: category,
            isSelectable: true,
            isSelected: widget.selected == category.id,
            onSelected: (item) {
              widget.onSelected(item);
              setState(() {});
            },
          );
        },
        padding: EdgeInsets.only(bottom: kSpacingX36),
        addAutomaticKeepAlives: false,
        cacheExtent: 100,
      );
}
