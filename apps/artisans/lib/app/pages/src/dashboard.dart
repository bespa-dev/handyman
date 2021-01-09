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
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:handyman/app/bloc/bloc.dart';
import 'package:handyman/app/widgets/src/booking_list_item.dart';
import 'package:handyman/app/widgets/widgets.dart';
import 'package:handyman/domain/models/models.dart';
import 'package:handyman/shared/shared.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  /// blocs
  final _userBloc = UserBloc(repo: Injection.get());
  final _categoryBloc = CategoryBloc(repo: Injection.get());
  final _businessBloc = BusinessBloc(repo: Injection.get());
  final _prefsBloc = PrefsBloc(repo: Injection.get());
  final _locationBloc = LocationBloc(repo: Injection.get());
  final _bookingBloc = BookingBloc(repo: Injection.get());

  /// UI
  ThemeData kTheme;

  /// Artisan
  BaseArtisan _currentUser;

  @override
  void dispose() {
    _userBloc.close();
    _categoryBloc.close();
    _businessBloc.close();
    _prefsBloc.close();
    _locationBloc.close();
    _bookingBloc.close();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    if (mounted) {
      /// observe current user
      _userBloc.listen((state) {
        if (state is SuccessState<BaseArtisan>) {
          _currentUser = state.data;
          if (mounted) setState(() {});
        }
      });

      /// get user id
      _prefsBloc
        ..add(PrefsEvent.getUserIdEvent())
        ..listen((state) {
          if (state is SuccessState<String>) {
            if (state.data != null) {
              /// fetch current user info
              _userBloc.add(UserEvent.getArtisanByIdEvent(id: state.data));

              /// fetch business profile
              _businessBloc
                ..add(BusinessEvent.getBusinessesForArtisan(
                    artisanId: state.data));

              /// fetch bookings for artisan
              _bookingBloc
                  .add(BookingEvent.observeBookingForArtisan(id: state.data));
            }
          }
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    kTheme = Theme.of(context);
    return BlocBuilder<BookingBloc, BlocState>(
      cubit: _bookingBloc,
      builder: (_, bookingState) => BlocBuilder<BusinessBloc, BlocState>(
        cubit: _businessBloc,
        builder: (__, businessState) => StreamBuilder<List<BaseBooking>>(
            stream: bookingState is SuccessState<Stream<List<BaseBooking>>>
                ? bookingState.data
                : Stream.empty(),
            initialData: [],
            builder: (_, snapshot) {
              final bookings = snapshot.data;

              return CustomScrollView(
                slivers: [
                  /// app bar
                  SliverAppBar(
                    toolbarHeight: kToolbarHeight,
                    toolbarTextStyle: kTheme.appBarTheme.textTheme.headline6,
                    textTheme: kTheme.appBarTheme.textTheme,
                    leading: GestureDetector(
                      onTap: () {
                        /// todo -> add action to logo
                      },
                      child: Image(
                        image: Svg(kLogoAsset),
                        height: kSpacingX36,
                        width: kSpacingX36,
                      ),
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
                      style: kTheme.textTheme.headline6.copyWith(
                        color: kTheme.colorScheme.onBackground,
                      ),
                    ),
                    centerTitle: false,
                    pinned: true,
                    backgroundColor: kTheme.colorScheme.background,
                    expandedHeight: SizeConfig.screenHeight * 0.15,
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

                  SliverList(
                    delegate: SliverChildListDelegate.fixed(
                      [
                        /// income
                        Padding(
                          padding: EdgeInsets.only(
                            top: kSpacingX16,
                            left: kSpacingX8,
                            right: kSpacingX8,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: kSpacingX4),
                                child: Text(
                                  "Progress",
                                  style: kTheme.textTheme.headline6.copyWith(
                                    color: kTheme.colorScheme.onBackground
                                        .withOpacity(kEmphasisMedium),
                                  ),
                                ),
                              ),
                              SizedBox(height: kSpacingX12),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  /// earnings
                                  Expanded(
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(kSpacingX4),
                                      ),
                                      child: Container(
                                        constraints: BoxConstraints.tightFor(
                                          height:
                                              SizeConfig.screenHeight * 0.23,
                                        ),
                                        padding: EdgeInsets.symmetric(
                                          horizontal: kSpacingX12,
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              padding:
                                                  EdgeInsets.all(kSpacingX16),
                                              decoration: BoxDecoration(
                                                color: kTheme
                                                    .colorScheme.secondary,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        kSpacingX8),
                                              ),
                                              child: Icon(
                                                Entypo.wallet,
                                                size: kSpacingX24,
                                                color: kTheme
                                                    .colorScheme.onSecondary,
                                              ),
                                            ),
                                            SizedBox(height: kSpacingX12),
                                            Text(
                                              "Weekly Earnings",
                                              style: kTheme.textTheme.bodyText1
                                                  .copyWith(
                                                fontWeight: FontWeight.w600,
                                                color: kTheme
                                                    .colorScheme.onBackground
                                                    .withOpacity(
                                                        kEmphasisMedium),
                                              ),
                                            ),
                                            SizedBox(height: kSpacingX2),
                                            Text(
                                              "This is how much you earned during the week",
                                              textAlign: TextAlign.center,
                                              style: kTheme.textTheme.caption
                                                  .copyWith(
                                                color: kTheme
                                                    .colorScheme.onBackground
                                                    .withOpacity(kEmphasisLow),
                                              ),
                                            ),
                                            SizedBox(height: kSpacingX4),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: kSpacingX16),
                                              child: Text(
                                                /// todo -> show earnings here
                                                formatCurrency(0.99),
                                                style: kTheme
                                                    .textTheme.headline6
                                                    .copyWith(
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),

                                  /// ratings
                                  Expanded(
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(kSpacingX4),
                                      ),
                                      child: Container(
                                        constraints: BoxConstraints.tightFor(
                                          height:
                                              SizeConfig.screenHeight * 0.23,
                                        ),
                                        padding: EdgeInsets.symmetric(
                                          horizontal: kSpacingX12,
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              padding:
                                                  EdgeInsets.all(kSpacingX16),
                                              decoration: BoxDecoration(
                                                color: kTheme
                                                    .colorScheme.secondary,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        kSpacingX8),
                                              ),
                                              child: Icon(
                                                kRatingStar,
                                                size: kSpacingX24,
                                                color: kTheme
                                                    .colorScheme.onSecondary,
                                              ),
                                            ),
                                            SizedBox(height: kSpacingX12),
                                            Text(
                                              "Ratings",
                                              style: kTheme.textTheme.bodyText1
                                                  .copyWith(
                                                fontWeight: FontWeight.w600,
                                                color: kTheme
                                                    .colorScheme.onBackground
                                                    .withOpacity(
                                                        kEmphasisMedium),
                                              ),
                                            ),
                                            SizedBox(height: kSpacingX2),
                                            Text(
                                              "Based on reviews made by customers served",
                                              textAlign: TextAlign.center,
                                              style: kTheme.textTheme.caption
                                                  .copyWith(
                                                color: kTheme
                                                    .colorScheme.onBackground
                                                    .withOpacity(kEmphasisLow),
                                              ),
                                            ),
                                            SizedBox(height: kSpacingX4),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: kSpacingX16),
                                              child: Text(
                                                "${_currentUser?.rating ?? "2.5"}",
                                                style: kTheme
                                                    .textTheme.headline6
                                                    .copyWith(
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        /// business
                        if (businessState
                            is SuccessState<List<BaseBusiness>>) ...{
                          Padding(
                            padding: EdgeInsets.only(
                              top: kSpacingX12,
                              left: kSpacingX16,
                            ),
                            child: Text(
                              "My Business profile",
                              style: kTheme.textTheme.headline6.copyWith(
                                color: kTheme.colorScheme.onBackground
                                    .withOpacity(kEmphasisMedium),
                              ),
                            ),
                          ),
                          Container(
                            constraints: BoxConstraints(
                              minWidth: SizeConfig.screenWidth,
                              minHeight: SizeConfig.screenHeight * 0.1,
                              maxHeight: SizeConfig.screenHeight * 0.15,
                            ),
                            child: ListView.separated(
                              padding: EdgeInsets.only(
                                top: kSpacingX12,
                                left: kSpacingX8,
                                right: kSpacingX8,
                              ),
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (_, index) {
                                final model = businessState.data[index];
                                return BusinessListItem(business: model);
                              },
                              separatorBuilder: (_, __) =>
                                  SizedBox(width: kSpacingX8),
                              itemCount: businessState.data.length,
                            ),
                          ),
                        },

                        if (bookingState
                            is SuccessState<Stream<List<BaseBooking>>>) ...{
                          /// bookings
                          Padding(
                            padding: EdgeInsets.only(
                              top: kSpacingX24,
                              left: kSpacingX16,
                              bottom: kSpacingX16,
                            ),
                            child: Text(
                              "Recent Bookings",
                              style: kTheme.textTheme.headline6.copyWith(
                                color: kTheme.colorScheme.onBackground
                                    .withOpacity(kEmphasisMedium),
                              ),
                            ),
                          ),

                          /// bookings list
                          ...bookings
                              .map((item) => BookingListItem(booking: item))
                              .toList(),
                        },
                      ],
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }
}
