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
import 'package:flutter_svg/svg.dart';
import 'package:lite/app/bloc/bloc.dart';
import 'package:lite/app/widgets/widgets.dart';
import 'package:lite/domain/models/models.dart';
import 'package:lite/shared/shared.dart';

class ArtisansPage extends StatefulWidget {
  @override
  _ArtisansPageState createState() => _ArtisansPageState();
}

class _ArtisansPageState extends State<ArtisansPage> {
  /// blocs
  final _artisansBloc = UserBloc(repo: Injection.get());
  final _categoryBloc = CategoryBloc(repo: Injection.get());

  /// UI
  ThemeData kTheme;
  Stream<List<BaseArtisan>> _artisanStream = Stream.empty();

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
      _artisansBloc
        ..add(UserEvent.observeArtisansEvent(
            category: ServiceCategoryGroup.featured().name()))
        ..listen((state) {
          if (state is SuccessState<Stream<List<BaseArtisan>>>) {
            _artisanStream = state.data;
            if (mounted) setState(() {});
          }
        });

      /// fetch all categories
      _categoryBloc.add(
        CategoryEvent.observeAllCategories(
            group: ServiceCategoryGroup.featured()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    kTheme = Theme.of(context);
    return BlocBuilder<CategoryBloc, BlocState>(
      bloc: _categoryBloc,
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
                  toolbarHeight: kToolbarHeight,
                  toolbarTextStyle: kTheme.appBarTheme.textTheme.headline6,
                  textTheme: kTheme.appBarTheme.textTheme,
                  leading: SvgPicture.asset(
                    kLogoAsset,
                    height: kSpacingX36,
                    width: kSpacingX36,
                  ),
                  title: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(text: '$kAppName\n'),
                        TextSpan(
                          text: kAppVersion,
                          style: kTheme.textTheme.caption,
                        ),
                      ],
                    ),
                    style: kTheme.textTheme.headline6.copyWith(
                      color: kTheme.colorScheme.onBackground,
                    ),
                  ),
                  centerTitle: false,
                  pinned: true,
                  backgroundColor: kTheme.colorScheme.background,
                  expandedHeight: SizeConfig.screenHeight * 0.25,
                  flexibleSpace: FlexibleSpaceBar(
                    collapseMode: CollapseMode.parallax,
                    background: Stack(
                      fit: StackFit.expand,
                      children: [
                        Positioned.fill(
                          child: ImageView(imageUrl: kBackgroundAsset),
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
                      StreamBuilder<List<BaseArtisan>>(
                        initialData: [],
                        stream: _artisanStream,
                        builder: (_, snapshot) {
                          return snapshot.connectionState ==
                                  ConnectionState.waiting
                              ? Loading()
                              : snapshot.hasData
                                  ? _buildArtisanCard(snapshot.data)
                                  : SizedBox.shrink();
                        },
                      ),
                    ],
                    addAutomaticKeepAlives: true,
                  ),
                ),

                /// categories' list header
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

                /// categories' list content
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

  Widget _buildArtisanCard(List<BaseArtisan> data) {
    final cardWidth = kSpacingX230;
    final cardHeight = SizeConfig.screenHeight * 0.3;

    return Container(
      margin: EdgeInsets.only(top: kSpacingX12),
      height: SizeConfig.screenHeight * 0.3,
      width: SizeConfig.screenWidth,
      child: ListView.separated(
        addAutomaticKeepAlives: true,
        clipBehavior: Clip.hardEdge,
        cacheExtent: 200,
        itemBuilder: (_, index) {
          final artisan = data[index];
          return Card(
            clipBehavior: Clip.hardEdge,
            elevation: kSpacingNone,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(kSpacingX12),
            ),
            child: InkWell(
              onTap: () =>
                  context.navigator.pushArtisanInfoPage(artisan: artisan),
              splashColor: kTheme.splashColor,
              borderRadius: BorderRadius.circular(kSpacingX12),
              child: Container(
                height: cardHeight,
                width: cardWidth,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(kSpacingX12),
                ),
                child: Stack(
                  children: [
                    /// background
                    Column(
                      children: [
                        Flexible(
                          flex: 2,
                          child: Stack(
                            children: [
                              /// background
                              Positioned.fill(
                                child: ImageView(
                                  imageUrl: artisan.avatar,
                                  showErrorIcon: false,
                                ),
                              ),

                              /// foreground
                              Positioned.fill(
                                child: Container(
                                  color: kTheme.colorScheme.background
                                      .withOpacity(kEmphasisMedium),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Flexible(
                          flex: 3,
                          child: Container(
                            color: kTheme.cardColor,
                            width: cardWidth,
                            padding: EdgeInsets.only(
                              left: kSpacingX8,
                              top: kSpacingX12,
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  height: kSpacingX8,
                                  width: kSpacingX8,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: artisan.isAvailable
                                        ? kGreenColor
                                        : kTheme.colorScheme.error,
                                  ),
                                ),
                                SizedBox(width: kSpacingX4),
                                Text(
                                  artisan.isAvailable ? "Online" : "Offline",
                                  style: kTheme.textTheme.caption,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),

                    /// content
                    Positioned(
                      top: cardHeight * 0.25,
                      bottom: kSpacingX12,
                      left: kSpacingNone,
                      right: kSpacingNone,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          UserAvatar(
                            url: artisan.avatar,
                            radius: kSpacingX56,
                          ),
                          SizedBox(height: kSpacingX16),
                          Text(
                            artisan.name ?? "No username",
                            style: kTheme.textTheme.headline6,
                          ),
                          SizedBox(height: kSpacingX6),
                          BlocBuilder<CategoryBloc, BlocState>(
                            bloc: CategoryBloc(repo: Injection.get())
                              ..add(
                                CategoryEvent.observeCategoryById(
                                    id: artisan.category),
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
                                        style: kTheme.textTheme.bodyText1,
                                      );
                                    }),
                          ),
                          SizedBox(width: kSpacingX8),
                          RatingBarIndicator(
                            itemBuilder: (_, index) => Icon(
                              kRatingStar,
                              color: kAmberColor,
                            ),
                            itemCount: 5,
                            itemSize: kSpacingX16,
                            rating: artisan.rating,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        itemCount: data.length,
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.only(
          left: kSpacingX12,
          right: kSpacingX36,
        ),
        separatorBuilder: (_, __) => SizedBox(width: kSpacingX8),
      ),
    );
  }
}
