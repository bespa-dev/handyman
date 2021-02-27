/*
 * Copyright (c) 2021.
 * This application is owned by HandyMan LLC,
 * developed & designed by Quabynah Codelabs LLC.
 *
 *
 * author: codelbas.quabynah@gmail.com
 */

import 'package:flutter/material.dart';
import 'package:lite/app/bloc/bloc.dart';
import 'package:lite/app/widgets/widgets.dart';
import 'package:lite/domain/models/models.dart';
import 'package:lite/shared/shared.dart';

class ListCategoryCardItem extends StatefulWidget {
  const ListCategoryCardItem({@required this.category});

  final BaseServiceCategory category;

  @override
  _ListCategoryCardItemState createState() => _ListCategoryCardItemState();
}

class _ListCategoryCardItemState extends State<ListCategoryCardItem> {
  final _servicesBloc = ArtisanServiceBloc(repo: Injection.get());
  List<BaseArtisanService> _services = const <BaseArtisanService>[];

  @override
  void dispose() {
    _servicesBloc.close();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    if (mounted) {
      var category = widget.category;
      if (category.hasParent) {
        _servicesBloc.add(ArtisanServiceEvent.getCategoryServices(
            categoryId: category.parent));
      } else if (category.hasServices) {
        _servicesBloc.add(
            ArtisanServiceEvent.getCategoryServices(categoryId: category.id));
      }

      _servicesBloc.listen((state) {
        if (state is SuccessState<List<BaseArtisanService>>) {
          _services = state.data;
          if (mounted) setState(() {});
        }
      });
    }
  }

  void _navToDetails() =>
      context.navigator.pushCategoryDetailsPage(category: widget.category);

  @override
  Widget build(BuildContext context) {
    final kTheme = Theme.of(context);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: kSpacingX6),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            getProportionateScreenWidth(kSpacingX12),
          ),
        ),
        color: kTheme.cardColor,
        clipBehavior: Clip.hardEdge,
        child: InkWell(
          borderRadius: BorderRadius.circular(kSpacingX12),
          onTap: _navToDetails,
          child: Padding(
            padding: const EdgeInsets.all(kSpacingX8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ImageView(
                  imageUrl: widget.category.avatar,
                  height: kSpacingX96,
                  width: kSpacingX96,
                  radius: kSpacingX12,
                ),
                SizedBox(width: kSpacingX16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        widget.category.name,
                        style: kTheme.textTheme.headline6.copyWith(
                          fontSize: kTheme.textTheme.bodyText2.fontSize,
                        ),
                      ),
                      SizedBox(height: kSpacingX2),
                      Text(
                        widget.category.groupName,
                        style: kTheme.textTheme.bodyText1.copyWith(
                          color: kTheme.textTheme.bodyText1.color
                              .withOpacity(kEmphasisLow),
                        ),
                      ),
                      if (_services.isNotEmpty) ...{
                        SizedBox(height: kSpacingX8),
                        Text(
                          '${_services.length} services',
                          style: kTheme.textTheme.bodyText1.copyWith(
                            color: kTheme.textTheme.bodyText1.color
                                .withOpacity(kEmphasisMedium),
                          ),
                        ),
                      }
                    ],
                  ),
                ),
                Center(
                  child: IconButton(
                    icon: Icon(kArrowIcon),
                    onPressed: _navToDetails,
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
          context.navigator.pushCategoryDetailsPage(category: widget.category);
        },
        child: Stack(
          children: [
            Hero(
              tag: widget.category.avatar,
              child: ImageView(
                imageUrl: widget.category.avatar,
                height: getProportionateScreenHeight(kSpacingX250),
                width: double.infinity,
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
                  color: widget.isSelected ? selectedColor : unselectedColor,
                ),
                alignment: Alignment.center,
                child: Text(
                  widget.category.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: kTheme.textTheme.button.copyWith(
                    color: widget.isSelected
                        ? selectedTextColor
                        : unselectedTextColor,
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

class SelectableGridCategory extends StatefulWidget {
  const SelectableGridCategory({
    Key key,
    @required this.categories,
    @required this.onSelected,
    @required this.selected,
  }) : super(key: key);

  final List<BaseServiceCategory> categories;
  final Function(BaseServiceCategory) onSelected;
  final String selected;

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
