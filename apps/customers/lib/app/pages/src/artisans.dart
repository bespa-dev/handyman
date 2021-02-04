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
import 'package:lite/app/bloc/bloc.dart';
import 'package:lite/app/routes/routes.gr.dart';
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
            _artisanStream = state.data.map((event) =>
                event.where((element) => element.hasHighRatings).toList());
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
      cubit: _categoryBloc,
      builder: (_, categoryState) => StreamBuilder<List<BaseServiceCategory>>(
        initialData: [],
        stream: categoryState is SuccessState<Stream<List<BaseServiceCategory>>>
            ? categoryState.data
            : Stream.empty(),
        builder: (_, categoriesSnapshot) => Container(
          height: SizeConfig.screenHeight,
          width: SizeConfig.screenWidth,
          child: StreamBuilder<List<BaseArtisan>>(
              initialData: [],
              stream: _artisanStream,
              builder: (_, snapshot) {
                return CustomScrollView(
                  slivers: [
                    /// featured artisans
                    if (snapshot.hasData && snapshot.data.isNotEmpty) ...{
                      _buildArtisanCard(snapshot.data),
                    },

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
                                      text: 'Services available\n',
                                      style: kTheme.textTheme.headline5),
                                  TextSpan(
                                      text: kAppSloganDesc,
                                      style:
                                          kTheme.textTheme.bodyText2.copyWith(
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
                        for (int position = 0;
                            position < categoriesSnapshot.data.length;
                            position++) ...{
                          GridCategoryCardItem(
                            category: categoriesSnapshot.data[position],
                          ),
                        },
                      ],
                    ),
                  ],
                );
              }),
        ),
      ),
    );
  }

  Widget _buildArtisanCard(List<BaseArtisan> data) {
    final cardWidth = kSpacingX230;
    final cardHeight = SizeConfig.screenHeight / 3.2;

    return SliverList(
      delegate: SliverChildListDelegate.fixed(
        [
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
                      text: 'Most Popular\n',
                      style: kTheme.textTheme.headline5),
                  TextSpan(
                    text:
                        'Artisans with higher ratings based on customer reviews',
                    style: kTheme.textTheme.bodyText2.copyWith(
                      color: kTheme.colorScheme.onBackground
                          .withOpacity(kEmphasisLow),
                    ),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(
            width: cardWidth,
            height: cardHeight,
            child: ListView.separated(
              addAutomaticKeepAlives: true,
              clipBehavior: Clip.hardEdge,
              cacheExtent: 200,
              itemBuilder: (_, position) {
                final artisan = data[position];
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
                              /// top half
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

                              /// bottom half
                              Flexible(
                                flex: 3,
                                child: Container(
                                    color: kTheme.cardColor, width: cardWidth),
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
                                  artisan.name ?? 'No username',
                                  style: kTheme.textTheme.headline6,
                                ),
                                SizedBox(height: kSpacingX6),
                                BlocBuilder<CategoryBloc, BlocState>(
                                  cubit: CategoryBloc(repo: Injection.get())
                                    ..add(
                                      CategoryEvent.observeCategoryById(
                                          id: artisan.category),
                                    ),
                                  builder: (_, userCategoryState) =>
                                      StreamBuilder<BaseServiceCategory>(
                                          stream: userCategoryState
                                                  is SuccessState<
                                                      Stream<
                                                          BaseServiceCategory>>
                                              ? userCategoryState.data
                                              : Stream.empty(),
                                          builder: (_, __) {
                                            return Text(
                                              __.hasData ? __.data.name : '...',
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
                top: kSpacingX16,
              ),
              separatorBuilder: (_, __) => SizedBox(width: kSpacingX8),
            ),
          ),
        ],
      ),
    );
  }
}
