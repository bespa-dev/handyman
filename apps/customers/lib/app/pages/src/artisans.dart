/*
 * Copyright (c) 2021.
 * This application is owned by HandyMan LLC,
 * developed & designed by Quabynah Codelabs LLC.
 *
 *
 * author: codelbas.quabynah@gmail.com
 */

import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:lite/app/bloc/bloc.dart';
import 'package:lite/app/widgets/widgets.dart';
import 'package:lite/domain/models/models.dart';
import 'package:lite/shared/shared.dart';

class ArtisansPage extends StatefulWidget {
  @override
  _ArtisansPageState createState() => _ArtisansPageState();
}

class _ArtisansPageState extends State<ArtisansPage> {
  final _artisansBloc = UserBloc(repo: Injection.get());
  final _categoryBloc = CategoryBloc(repo: Injection.get());

  @override
  void dispose() {
    _artisansBloc.close();
    _categoryBloc.close();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    if (mounted) {
      /// fetch all featured artisans
      _artisansBloc.add(UserEvent.observeArtisansEvent(
          category: ServiceCategoryGroup.featured().name()));

      /// fetch all categories
      _categoryBloc.add(
        CategoryEvent.observeAllCategories(
            group: ServiceCategoryGroup.featured()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final kTheme = Theme.of(context);

    final cardWidth = kSpacingX230;

    return BlocBuilder<CategoryBloc, BlocState>(
      cubit: _categoryBloc,
      builder: (_, categoryState) => StreamBuilder<List<BaseServiceCategory>>(
          initialData: [],
          stream:
              categoryState is SuccessState<Stream<List<BaseServiceCategory>>>
                  ? categoryState.data
                  : Stream.empty(),
          builder: (_, categoriesSnapshot) {
            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  // centerTitle: true,
                  toolbarHeight: kToolbarHeight,
                  toolbarTextStyle: kTheme.appBarTheme.textTheme.headline6,
                  textTheme: kTheme.appBarTheme.textTheme,
                  leading: Image(
                    image: Svg(kLogoAsset),
                    height: kSpacingX36,
                    width: kSpacingX36,
                  ),
                  title: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(text: "$kAppName\n"),
                        TextSpan(
                          text: kAppVersion,
                          style: kTheme.textTheme.caption,
                        ),
                      ],
                    ),
                  ),
                  centerTitle: false,
                  pinned: true,
                  backgroundColor: kTheme.colorScheme.background,
                  expandedHeight: SizeConfig.screenHeight * 0.2,
                  flexibleSpace: FlexibleSpaceBar(
                    collapseMode: CollapseMode.parallax,
                    stretchModes: [
                      StretchMode.blurBackground,
                      StretchMode.fadeTitle,
                    ],
                    background: Stack(
                      fit: StackFit.expand,
                      children: [
                        Positioned.fill(
                          child: CachedNetworkImage(
                            imageUrl: kBackgroundAsset,
                            fit: BoxFit.cover,
                            placeholder: (_, __) => Container(
                              color: kTheme.colorScheme.background,
                            ),
                          ),
                        ),
                        Positioned.fill(
                          child: Container(
                            color: kTheme.colorScheme.background
                                .withOpacity(kEmphasisLow),
                          ),
                        ),
                      ],
                    ),
                    titlePadding: EdgeInsets.zero,
                  ),
                ),

                /// artisans' list
                SliverList(
                  delegate: SliverChildListDelegate.fixed(
                    <Widget>[
                      /// artisans header
                      Padding(
                        padding: EdgeInsets.only(
                          left: kSpacingX16,
                          top: kSpacingX12,
                        ),
                        child: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                  text: "Most Popular\n",
                                  style: kTheme.textTheme.headline5),
                              TextSpan(
                                  text: "Artisans available",
                                  style: kTheme.textTheme.bodyText2.copyWith(
                                    color: kTheme.colorScheme.onBackground
                                        .withOpacity(kEmphasisLow),
                                  )),
                            ],
                          ),
                        ),
                      ),

                      /// artisans
                      BlocBuilder<UserBloc, BlocState>(
                        cubit: _artisansBloc,
                        builder: (_, state) => state
                                is SuccessState<Stream<List<BaseArtisan>>>
                            ? StreamBuilder(
                                initialData: [],
                                stream: state.data,
                                builder: (_, snapshot) {
                                  return snapshot.connectionState ==
                                          ConnectionState.waiting
                                      ? Loading()
                                      : snapshot.hasData
                                          ? Container(
                                              margin: EdgeInsets.only(
                                                top: kSpacingX12,
                                              ),
                                              height:
                                                  SizeConfig.screenHeight * 0.3,
                                              width: SizeConfig.screenWidth,
                                              color:
                                                  kTheme.colorScheme.background,
                                              child: ListView.separated(
                                                addAutomaticKeepAlives: true,
                                                clipBehavior: Clip.hardEdge,
                                                shrinkWrap: true,
                                                cacheExtent: 200,
                                                itemBuilder: (_, index) {
                                                  return InkWell(
                                                    onTap: () {
                                                      /// fixme -> nav to artisan's profile page
                                                    },
                                                    splashColor:
                                                        kTheme.splashColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            kSpacingX12),
                                                    child: Container(
                                                      height: SizeConfig
                                                              .screenHeight *
                                                          0.3,
                                                      width: cardWidth,
                                                      decoration: BoxDecoration(
                                                        color: Colors.primaries[
                                                            Random()
                                                                .nextInt(12)],
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    kSpacingX12),
                                                      ),
                                                      clipBehavior:
                                                          Clip.hardEdge,
                                                      padding: EdgeInsets.only(
                                                        bottom: kSpacingX8,
                                                        right: kSpacingX12,
                                                      ),
                                                      child: Stack(
                                                        children: [
                                                          Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .end,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .end,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  ButtonIconOnly(
                                                                    icon: Entypo
                                                                        .message,
                                                                    onPressed:
                                                                        () {},
                                                                  ),
                                                                  SizedBox(
                                                                      width:
                                                                          kSpacingX8),
                                                                  ButtonIconOnly(
                                                                    icon: Feather
                                                                        .user_plus,
                                                                    onPressed:
                                                                        () {},
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                },
                                                itemCount: /*snapshot.data.length*/ 10,
                                                scrollDirection:
                                                    Axis.horizontal,
                                                padding: EdgeInsets.only(
                                                  left: kSpacingX12,
                                                  right: kSpacingX36,
                                                ),
                                                separatorBuilder: (_, __) =>
                                                    SizedBox(
                                                        width: kSpacingX16),
                                              ),
                                            )
                                          : SizedBox.shrink();
                                },
                              )
                            : SizedBox.shrink(),
                      ),
                    ],
                    addAutomaticKeepAlives: true,
                  ),
                ),

                SliverList(
                  delegate: SliverChildListDelegate.fixed(
                    [
                      /// header
                      Padding(
                        padding: EdgeInsets.only(
                          top: kSpacingX24,
                          left: kSpacingX16,
                          bottom: kSpacingX16,
                        ),
                        child: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                  text: "Services available\n",
                                  style: kTheme.textTheme.headline5),
                              TextSpan(
                                  text: kAppSloganDesc,
                                  style: kTheme.textTheme.bodyText2.copyWith(
                                    color: kTheme.colorScheme.onBackground
                                        .withOpacity(kEmphasisLow),
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                /// categories
                SliverGrid.count(
                  crossAxisCount: 2,
                  children: [
                    ...categoriesSnapshot.data
                        .map(
                          (e) => GridCategoryCardItem(category: e),
                        )
                        .toList()
                  ],
                ),
              ],
            );
          }),
    );
  }
}
