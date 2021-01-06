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
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:handyman/app/bloc/bloc.dart';
import 'package:handyman/app/pages/pages.dart';
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

      _prefsBloc
        ..add(PrefsEvent.getUserIdEvent())
        ..listen((state) {
          if (state is SuccessState<String>) {
            /// fetch business profile
            if (state.data != null)
              _businessBloc
                ..add(BusinessEvent.getBusinessesForArtisan(
                    artisanId: state.data));
          }
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    kTheme = Theme.of(context);
    return BlocBuilder<BusinessBloc, BlocState>(
      cubit: _businessBloc,
      builder: (_, businessState) => CustomScrollView(
        slivers: [
          /// app bar
          SliverAppBar(
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

          /// business
          SliverList(
            delegate: SliverChildListDelegate.fixed(
              [
                if (businessState is SuccessState<List<BaseBusiness>>) ...{
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
                        return Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(kSpacingX4),
                          ),
                          clipBehavior: Clip.hardEdge,
                          child: Container(
                            width: SizeConfig.screenWidth * 0.85,
                            padding: EdgeInsets.symmetric(
                              horizontal: kSpacingX12,
                              vertical: kSpacingX8,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(kSpacingX4),
                            ),
                            clipBehavior: Clip.hardEdge,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Business Details",
                                  style: kTheme.textTheme.caption.copyWith(
                                    color: kTheme.colorScheme.onBackground
                                        .withOpacity(kEmphasisLow),
                                  ),
                                ),
                                SizedBox(height: kSpacingX12),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          model.name,
                                          style: kTheme.textTheme.headline6,
                                        ),
                                        SizedBox(height: kSpacingX4),
                                        Text(
                                          model.location,
                                          style: kTheme.textTheme.bodyText1
                                              .copyWith(
                                            color: kTheme
                                                .colorScheme.onBackground
                                                .withOpacity(kEmphasisMedium),
                                          ),
                                        ),
                                      ],
                                    ),

                                    /// fixme -> find a workaround for nested routes
                                    IconButton(
                                      icon: Icon(kEditIcon),
                                      iconSize: kSpacingX16,
                                      onPressed: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => BusinessProfilePage(
                                            business: model,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (_, __) => SizedBox(width: kSpacingX8),
                      itemCount: businessState.data.length,
                    ),
                  ),
                } else ...{
                  Loading(),
                },
              ],
            ),
          ),
        ],
      ),
    );
  }
}
