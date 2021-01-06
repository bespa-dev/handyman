/*
 * Copyright (c) 2021.
 * This application is owned by HandyMan LLC,
 * developed & designed by Quabynah Codelabs LLC.
 *
 *
 * author: codelbas.quabynah@gmail.com
 */

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:handyman/app/bloc/bloc.dart';
import 'package:handyman/app/routes/routes.gr.dart';
import 'package:handyman/app/widgets/widgets.dart';
import 'package:handyman/domain/models/models.dart';
import 'package:handyman/shared/shared.dart';

class GridArtisanCardItem extends StatefulWidget {
  final BaseArtisan artisan;

  const GridArtisanCardItem({
    Key key,
    @required this.artisan,
  }) : super(key: key);

  @override
  _GridArtisanCardItemState createState() => _GridArtisanCardItemState();
}

class _GridArtisanCardItemState extends State<GridArtisanCardItem> {
  @override
  Widget build(BuildContext context) {
    final kTheme = Theme.of(context);

    return Card(
      key: ValueKey<String>(widget.artisan?.id),
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          getProportionateScreenWidth(kSpacingX8),
        ),
      ),
      child: GestureDetector(
        onTap: () =>
            context.navigator.pushArtisanInfoPage(artisan: widget.artisan),
        child: Container(
          height: getProportionateScreenHeight(kSpacingX300),
          width: double.infinity,
          child: Stack(
            children: [
              ImageView(imageUrl: widget.artisan.avatar),
              Positioned(
                top: getProportionateScreenHeight(kSpacingX96),
                left: kSpacingNone,
                right: kSpacingNone,
                bottom: kSpacingNone,
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(kSpacingX8)),
                  decoration: BoxDecoration(
                    color: kTheme.scaffoldBackgroundColor
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
                        widget.artisan?.name ?? "No username",
                        style: kTheme.textTheme.headline6,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                          height: getProportionateScreenHeight(kSpacingX4)),
                      BlocBuilder<CategoryBloc, BlocState>(
                        cubit: CategoryBloc(repo: Injection.get())
                          ..add(
                            CategoryEvent.observeCategoryById(
                                id: widget.artisan.category),
                          ),
                        builder: (_, userCategoryState) =>
                            StreamBuilder<BaseServiceCategory>(
                                stream: userCategoryState is SuccessState<
                                    Stream<BaseServiceCategory>>
                                    ? userCategoryState.data
                                    : Stream.empty(),
                                builder: (_, __) {
                                  return Text(
                                    __.hasData ? __.data.name : "...",
                                    overflow: TextOverflow.fade,
                                    style: kTheme.textTheme.caption,
                                  );
                                }),
                      ),
                      SizedBox(
                          height: getProportionateScreenHeight(kSpacingX8)),
                      RatingBarIndicator(
                        rating: widget.artisan?.rating ?? 0,
                        itemBuilder: (_, index) => Icon(
                          kRatingStar,
                          color: kAmberColor,
                        ),
                        itemCount: 5,
                        itemSize: kSpacingX16,
                        direction: Axis.horizontal,
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
