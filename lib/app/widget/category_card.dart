import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:handyman/app/routes/route.gr.dart';
import 'package:handyman/app/widget/user_avatar.dart';
import 'package:handyman/core/constants.dart';
import 'package:handyman/core/size_config.dart';
import 'package:handyman/data/local_database.dart';

class GridCategoryCardItem extends StatefulWidget {
  final List<ServiceCategory> categories;

  const GridCategoryCardItem({Key key, this.categories}) : super(key: key);

  @override
  _GridCategoryCardItemState createState() => _GridCategoryCardItemState();
}

class _GridCategoryCardItemState extends State<GridCategoryCardItem> {
  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return AnimationLimiter(
      child: GridView.builder(
        itemCount: widget.categories.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 4 / 3,
          crossAxisSpacing: getProportionateScreenWidth(8),
          mainAxisSpacing: getProportionateScreenHeight(4),
        ),
        clipBehavior: Clip.hardEdge,
        itemBuilder: (_, index) {
          final category = widget.categories[index];
          return AnimationConfiguration.staggeredGrid(
            position: index,
            duration: kScaleDuration,
            columnCount: 2,
            child: ScaleAnimation(
              child: FadeInAnimation(
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      getProportionateScreenWidth(12),
                    ),
                  ),
                  color: themeData.cardColor,
                  clipBehavior: Clip.hardEdge,
                  child: InkWell(
                    borderRadius:
                        BorderRadius.circular(getProportionateScreenWidth(12)),
                    onTap: () => context.navigator.push(
                      Routes.categoryProvidersPage,
                      arguments:
                          CategoryProvidersPageArguments(category: category),
                    ),
                    child: Stack(
                      children: [
                        Image.network(
                          category.avatar,
                          fit: BoxFit.cover,
                        ),
                        Positioned(
                          top: 80,
                          right: 0,
                          left: 0,
                          bottom: 0,
                          child: Container(
                            decoration: BoxDecoration(
                              color: themeData.primaryColor.withOpacity(0.14),
                            ),
                            alignment: Alignment.center,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  category.name,
                                  style: themeData.textTheme.headline6.copyWith(
                                    fontFamily: themeData
                                        .textTheme.bodyText1.fontFamily,
                                  ),
                                ),
                                SizedBox(
                                    height: getProportionateScreenHeight(4)),
                                Text(
                                  "127 available",
                                  // FIXME: Added # of registered artisans here
                                  style: themeData.textTheme.bodyText1.copyWith(
                                    color: themeData.primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
        physics: kScrollPhysics,
      ),
    );
  }
}

class ListCategoryCardItem extends StatefulWidget {
  final List<ServiceCategory> categories;

  const ListCategoryCardItem({Key key, this.categories}) : super(key: key);

  @override
  _ListCategoryCardItemState createState() => _ListCategoryCardItemState();
}

class _ListCategoryCardItemState extends State<ListCategoryCardItem> {
  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return AnimationLimiter(
      child: ListView.builder(
        physics: kScrollPhysics,
        itemBuilder: (_, index) {
          final category = widget.categories[index];
          return AnimationConfiguration.staggeredList(
            position: index,
            duration: const Duration(milliseconds: 350),
            child: SlideAnimation(
              verticalOffset: 50.0,
              child: FadeInAnimation(
                child: Card(
                  child: ListTile(
                    onTap: () => context.navigator.push(
                      Routes.categoryProvidersPage,
                      arguments:
                          CategoryProvidersPageArguments(category: category),
                    ),
                    leading: UserAvatar(
                      url: category.avatar,
                      ringColor: themeData.scaffoldBackgroundColor,
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.arrow_right_alt),
                      onPressed: () => context.navigator.push(
                        Routes.categoryProvidersPage,
                        arguments: CategoryProvidersPageArguments(
                            category: category.name),
                      ),
                    ),
                    subtitle: Text(
                      "127 available",
                      // FIXME: Added # of registered artisans here
                      style: themeData.textTheme.bodyText1.copyWith(
                        color: themeData.primaryColor,
                      ),
                    ),
                    onLongPress: () {},
                    title: Text(category.name),
                  ),
                ),
              ),
            ),
          );
        },
        itemCount: widget.categories.length,
      ),
    );
  }
}
