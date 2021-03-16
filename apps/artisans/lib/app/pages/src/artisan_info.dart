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
import 'package:handyman/app/widgets/widgets.dart';
import 'package:handyman/domain/models/models.dart';
import 'package:handyman/shared/shared.dart';
import 'package:share/share.dart';
import 'package:sliding_sheet/sliding_sheet.dart';

class ArtisanInfoPage extends StatefulWidget {
  const ArtisanInfoPage({Key key, @required this.artisan}) : super(key: key);
  final BaseArtisan artisan;

  @override
  _ArtisanInfoPageState createState() => _ArtisanInfoPageState();
}

class _ArtisanInfoPageState extends State<ArtisanInfoPage> {
  /// blocs
  final _userBloc = UserBloc(repo: Injection.get());

  /// UI
  ThemeData kTheme;

  @override
  void dispose() {
    _userBloc.close();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    if (mounted) {
      /// observe artisan's profile
      _userBloc.add(UserEvent.observeArtisanByIdEvent(id: widget.artisan.id));
    }
  }

  @override
  Widget build(BuildContext context) {
    kTheme = Theme.of(context);

    return BlocBuilder<UserBloc, BlocState>(
      cubit: _userBloc,
      builder: (_, userState) => StreamBuilder<BaseArtisan>(
          initialData: widget.artisan,
          stream: userState is SuccessState<Stream<BaseArtisan>>
              ? userState.data
              : Stream.value(widget.artisan),
          builder: (_, userSnap) {
            final artisan = userSnap.data;

            return CustomScrollView(
              slivers: [
                /// header
                SliverAppBar(
                  toolbarHeight: kToolbarHeight,
                  textTheme: kTheme.textTheme,
                  leading: IconButton(
                    icon: Icon(kBackIcon),
                    onPressed: () => context.navigator.pop(),
                  ),
                  pinned: true,
                  backgroundColor: kTheme.colorScheme.background,
                  expandedHeight: SizeConfig.screenHeight * 0.35,
                  actions: [
                    IconButton(
                      icon: Icon(kOptionsIcon),
                      onPressed: _showOptionsBottomSheet,
                    ),
                  ],
                  flexibleSpace: FlexibleSpaceBar(
                    collapseMode: CollapseMode.parallax,
                    background: Stack(
                      fit: StackFit.expand,
                      children: [
                        Positioned.fill(
                          child: ImageView(imageUrl: artisan.avatar),
                        ),
                      ],
                    ),
                    titlePadding: EdgeInsets.zero,
                  ),
                ),

                /// profile details
                SliverList(
                  delegate: SliverChildListDelegate.fixed(
                    [
                      Padding(
                        padding: const EdgeInsets.all(kSpacingX8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  artisan.name,
                                  style: kTheme.textTheme.headline5,
                                ),
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
                                              style: kTheme.textTheme.bodyText2,
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
                                  itemSize: kSpacingX24,
                                  rating: artisan.rating,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                    addAutomaticKeepAlives: true,
                  ),
                ),
              ],
            );
          }),
    );
  }

  /// artisan option sheet
  void _showOptionsBottomSheet() async {
    await showSlidingBottomSheet(context, builder: (context) {
      return SlidingSheetDialog(
        elevation: kSpacingX8,
        cornerRadius: kSpacingX16,
        snapSpec: const SnapSpec(
          snap: true,
          snappings: [0.4, 0.7, 1.0],
          positioning: SnapPositioning.relativeToAvailableSpace,
        ),
        duration: kSheetDuration,
        builder: (context, state) {
          return Container(
            height: SizeConfig.screenHeight * 0.2,
            width: SizeConfig.screenWidth,
            child: Center(
              child: Material(
                type: MaterialType.transparency,
                child: ListView(
                  children: [
                    ListTile(
                      title: Text('Report'),
                      onTap: () {
                        context.navigator.pop();
                        _showReportBottomSheet();
                      },
                    ),
                    ListTile(
                      title: Text('Share this Profile'),
                      onTap: () {
                        context.navigator.pop();
                        Share.share(
                            "View ${widget.artisan.name}\'s profile on $kAppNameShort\n\n${_generateProfileUrl()}");
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    });
  }

  /// generate profile url
  String _generateProfileUrl() =>
      "handyman.me/@${widget.artisan.email.substring(0, widget.artisan.email.indexOf("@"))}";

  /// report artisan sheet
  void _showReportBottomSheet() async {
    final report = await showSlidingBottomSheet(context, builder: (context) {
      return SlidingSheetDialog(
        elevation: kSpacingX8,
        cornerRadius: kSpacingX16,
        snapSpec: const SnapSpec(
          snap: true,
          snappings: [0.4, 0.7, 1.0],
          positioning: SnapPositioning.relativeToAvailableSpace,
        ),
        duration: kSheetDuration,
        headerBuilder: (context, state) {
          return Container(
            height: kSpacingX56,
            width: SizeConfig.screenWidth,
            color: kTheme.colorScheme.secondary,
            alignment: Alignment.center,
            child: Text(
              'Report ${widget.artisan.name}',
              style: kTheme.textTheme.headline6
                  .copyWith(color: kTheme.colorScheme.onSecondary),
            ),
          );
        },
        builder: (context, state) {
          return Material(
            type: MaterialType.transparency,
            color: kTheme.colorScheme.background,
            child: Container(
              height: SizeConfig.screenHeight * 0.45,
              width: SizeConfig.screenWidth,
              child: ListView(
                children: [
                  ListTile(
                    title: Text('State your reason for this action...'),
                  ),
                  ..._reportMessages
                      .map((reason) => ListTile(
                            title: Text(reason),
                            onTap: () {
                              context.navigator.pop(reason);
                            },
                          ))
                      .toList(),
                ],
              ),
            ),
          );
        },
      );
    });

    logger.d('Report -> $report');
    if (mounted && report != null) {
      await showCustomDialog(
        context: context,
        builder: (_) => InfoDialog(
          message: Text('${widget.artisan.name} reported'),
        ),
      );
    }

    /// todo -> send report to server
  }

  /// messages to be used for reporting an artisan
  final _reportMessages = const <String>[
    'Inappropriate account activities',
    'Impersonation and Identity theft',
    'It\'s a spam'
  ];
}
