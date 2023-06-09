/*
 * Copyright (c) 2021.
 * This application is owned by HandyMan LLC,
 * developed & designed by Quabynah Codelabs LLC.
 *
 *
 * author: codelbas.quabynah@gmail.com
 */

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:lite/app/bloc/bloc.dart';
import 'package:lite/app/widgets/widgets.dart';
import 'package:lite/domain/models/models.dart';
import 'package:lite/shared/shared.dart';
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
  final _businessBloc = BusinessBloc(repo: Injection.get());
  final _reviewBloc = ReviewBloc(repo: Injection.get());

  /// UI
  ThemeData kTheme;
  BaseArtisan _artisan;

  @override
  void dispose() {
    _userBloc.close();
    _businessBloc.close();
    _reviewBloc.close();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    if (mounted) {
      /// get businesses for artisan
      _businessBloc.add(
          BusinessEvent.getBusinessesForArtisan(artisanId: widget.artisan.id));

      /// observe artisan's profile
      _userBloc
        ..add(UserEvent.observeArtisanByIdEvent(id: widget.artisan.id))
        ..listen((state) {
          if (state is SuccessState<Stream<BaseArtisan>>) {
            state.data.listen((event) {
              _artisan = event;
              if (mounted) setState(() {});
            });
          }
        });

      _reviewBloc
          .add(ReviewEvent.observeReviewsForArtisan(id: widget.artisan.id));
    }
  }

  @override
  Widget build(BuildContext context) {
    kTheme = Theme.of(context);

    return Scaffold(
      body: _artisan == null
          ? Loading()
          : BlocBuilder<ReviewBloc, BlocState>(
              cubit: _reviewBloc,
              builder: (_, reviewState) => StreamBuilder<List<BaseReview>>(
                  initialData: [],
                  stream: reviewState is SuccessState<Stream<List<BaseReview>>>
                      ? reviewState.data
                      : Stream.empty(),
                  builder: (_, reviewSnap) {
                    final reviews = reviewSnap.data;

                    return Stack(
                      fit: StackFit.expand,
                      children: [
                        /// main content
                        Positioned.fill(
                          child: Stack(
                            children: [
                              Container(
                                height: SizeConfig.screenHeight * 0.45,
                                width: SizeConfig.screenWidth,
                                child: ImageView(
                                  imageUrl: _artisan.avatar,
                                  tag: _artisan.avatar,
                                  onTap: () => context.navigator
                                      .pushImagePreviewPage(
                                          url: _artisan.avatar),
                                ),
                              ),

                              /// back
                              Positioned(
                                top: kSpacingX36,
                                left: kSpacingX16,
                                child: IconButton(
                                  icon: Icon(kBackIcon),
                                  onPressed: () => context.navigator.pop(),
                                ),
                              ),

                              /// options
                              Positioned(
                                top: kSpacingX36,
                                right: kSpacingX16,
                                child: IconButton(
                                  icon: Icon(kOptionsIcon),
                                  onPressed: _showOptionsBottomSheet,
                                ),
                              ),
                            ],
                          ),
                        ),

                        /// body
                        Positioned.fill(
                          top: SizeConfig.screenHeight * 0.4,
                          child: Container(
                            height: SizeConfig.screenHeight,
                            width: SizeConfig.screenWidth,
                            decoration: BoxDecoration(
                              color: kTheme.colorScheme.background,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(kSpacingX16),
                                topRight: Radius.circular(kSpacingX16),
                              ),
                            ),
                            clipBehavior: Clip.hardEdge,
                            child: SingleChildScrollView(
                              padding: EdgeInsets.fromLTRB(
                                kSpacingX16,
                                kSpacingX36,
                                kSpacingX16,
                                kSpacingNone,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (_artisan.name != null) ...{
                                    Text(
                                      _artisan.name,
                                      style: kTheme.textTheme.headline5,
                                    ),
                                  },

                                  /// category & ratings
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      BlocBuilder<CategoryBloc, BlocState>(
                                        cubit: CategoryBloc(
                                            repo: Injection.get())
                                          ..add(
                                            CategoryEvent.observeCategoryById(
                                                id: _artisan.category),
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
                                                    __.hasData
                                                        ? __.data.name
                                                        : '...',
                                                    style: kTheme
                                                        .textTheme.bodyText2,
                                                  );
                                                }),
                                      ),
                                      RatingBarIndicator(
                                        itemBuilder: (_, index) => Icon(
                                          kRatingStar,
                                          color: kAmberColor,
                                        ),
                                        itemCount: 5,
                                        itemSize: kSpacingX16,
                                        rating: _artisan.rating,
                                      ),
                                    ],
                                  ),

                                  SizedBox(height: kSpacingX24),

                                  /// metadata & chat option
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      vertical: kSpacingX16,
                                      horizontal: kSpacingX4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: kTheme.cardColor,
                                      borderRadius:
                                          BorderRadius.circular(kSpacingX4),
                                    ),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        /// records
                                        _buildArtisanMetaInfo(
                                            _artisan.bookingsCount, 'Bookings'),
                                        _buildArtisanMetaInfo(
                                            _artisan.reportsCount, 'Reports'),

                                        /// fixme -> artisan services
                                        _buildArtisanMetaInfo(0, 'Services'),
                                      ],
                                    ),
                                  ),

                                  /// business profile
                                  BlocBuilder<BusinessBloc, BlocState>(
                                    cubit: _businessBloc,
                                    builder: (_, businessState) => businessState
                                                is SuccessState<
                                                    List<BaseBusiness>> &&
                                            businessState.data.isNotEmpty
                                        ? _buildBusinessList(
                                            businessState.data, _artisan)
                                        : SizedBox.shrink(),
                                  ),

                                  /// reviews
                                  if (reviews.isNotEmpty) ...{
                                    Padding(
                                      padding: EdgeInsets.only(
                                        top: kSpacingX12,
                                        left: kSpacingX16,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Recent Reviews',
                                            style: kTheme.textTheme.headline6
                                                .copyWith(
                                              color: kTheme
                                                  .colorScheme.onBackground
                                                  .withOpacity(kEmphasisMedium),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: kSpacingX12),
                                    ...reviews
                                        .map((e) => _buildReviewItem(e))
                                        .toList(),
                                  }
                                ],
                              ),
                            ),
                          ),
                        ),

                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: kSpacingX16,
                              vertical: kSpacingX4,
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: ButtonPrimary(
                                    color: kTheme.colorScheme.secondary,
                                    textColor: kTheme.colorScheme.onSecondary,
                                    width: SizeConfig.screenWidth,
                                    onTap: () => context.navigator
                                        .pushRequestPage(artisan: _artisan),
                                    label: 'Request service',
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: kSpacingX12),
                                  child: ButtonIconOnly(
                                    color: kTheme.colorScheme.secondary,
                                    iconColor: kTheme.colorScheme.secondary,
                                    icon: kChatIcon,
                                    onPressed: () =>
                                        context.navigator.pushConversationPage(
                                      recipientId: _artisan.id,
                                      recipient: _artisan,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  }),
            ),
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
      showSnackBarMessage(context,
          message: "${widget.artisan.name ?? "Artisan"} reported");
    }

    /// todo -> send report to server
  }

  /// messages to be used for reporting an artisan
  final _reportMessages = const <String>[
    'Inappropriate account activities',
    'Impersonation and Identity theft',
    'It\'s a spam'
  ];

  /// metadata info
  Widget _buildArtisanMetaInfo(int value, String title) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '$value',
            style: kTheme.textTheme.headline5.copyWith(
              fontFamily: kTheme.textTheme.bodyText1.fontFamily,
            ),
          ),
          SizedBox(height: kSpacingX8),
          Text(
            title,
            style: kTheme.textTheme.caption,
          ),
        ],
      );

  /// review list item
  Widget _buildReviewItem(BaseReview review) => ReviewListItem(review: review);

  /// business list
  Widget _buildBusinessList(List<BaseBusiness> data, BaseArtisan artisan) =>
      Container(
        constraints: BoxConstraints(
          minWidth: SizeConfig.screenWidth,
          minHeight: SizeConfig.screenHeight * 0.1,
          maxHeight: SizeConfig.screenHeight * 0.2,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: kSpacingX12,
                left: kSpacingX16,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Business profile',
                    style: kTheme.textTheme.headline6.copyWith(
                      color: kTheme.colorScheme.onBackground
                          .withOpacity(kEmphasisMedium),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.only(
                  top: kSpacingX12,
                  left: kSpacingNone,
                  right: kSpacingX8,
                ),
                scrollDirection: Axis.horizontal,
                itemBuilder: (_, index) {
                  final model = data[index];
                  return BusinessListItem(
                    business: model,
                    artisan: artisan,
                  );
                },
                separatorBuilder: (_, __) => SizedBox(width: kSpacingX8),
                itemCount: data.length,
              ),
            ),
          ],
        ),
      );
}
