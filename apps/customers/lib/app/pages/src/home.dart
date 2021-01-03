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
import 'package:flutter_icons/flutter_icons.dart';
import 'package:lite/app/bloc/bloc.dart';
import 'package:lite/app/routes/routes.gr.dart';
import 'package:lite/app/widgets/src/loaders.dart';
import 'package:lite/app/widgets/src/user_avatar.dart';
import 'package:lite/domain/models/models.dart';
import 'package:lite/domain/repositories/repositories.dart';
import 'package:lite/shared/shared.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  /// UI
  ThemeData _kTheme;
  bool _isLoggedIn = false;
  final _categoryFilterMenu = [
    ServiceCategoryGroup.featured().name(),
    ServiceCategoryGroup.popular().name(),
    ServiceCategoryGroup.recent().name(),
    ServiceCategoryGroup.mostRated().name(),
    ServiceCategoryGroup.recommended().name(),
  ];
  String _categoryFilter = ServiceCategoryGroup.featured().name();
  bool _preferGridFormat = true;
  Stream<List<BaseServiceCategory>> _categoriesStream = Stream.empty();

  /// blocs
  final _authBloc = AuthBloc(repo: Injection.get());
  final _prefsBloc = PrefsBloc(repo: Injection.get());
  final _userBloc = UserBloc(repo: Injection.get());

  final _categoryBloc = /*CategoryBloc(repo: Injection.get());*/ Injection
      .get<BaseCategoryRepository>();

  @override
  void dispose() {
    _authBloc.close();
    _userBloc.close();
    _prefsBloc.close();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    if (mounted) {
      /// observe current user id
      _prefsBloc
        ..add(PrefsEvent.getUserIdEvent())
        ..listen((state) {
          if (state is SuccessState<String>) {
            _isLoggedIn = state.data != null && state.data.isNotEmpty;
            if (mounted) setState(() {});
          }
        });

      /// observe current user
      _userBloc.add(UserEvent.currentUserEvent());

      // _categoryBloc
      _categoriesStream = _categoryBloc.observeCategories(
          categoryGroup: ServiceCategoryGroup.featured());
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    _kTheme = Theme.of(context);

    return BlocBuilder<UserBloc, BlocState>(
      cubit: _userBloc,
      builder: (_, state) => Scaffold(
        body: state is SuccessState<Stream<BaseUser>>
            ? StreamBuilder<BaseUser>(
                stream: state.data,
                builder: (context, userSnapshot) {
                  return SafeArea(
                    top: true,
                    child: Column(
                      children: [
                        Expanded(
                          child: StreamBuilder<List<BaseServiceCategory>>(
                              stream: _categoriesStream,
                              builder: (_, snapshot) {
                                return Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: getProportionateScreenWidth(
                                          kSpacingX16)),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          DropdownButton(
                                            value: _categoryFilter,
                                            items: _categoryFilterMenu
                                                .map<DropdownMenuItem<String>>(
                                                  (value) =>
                                                      DropdownMenuItem<String>(
                                                    value: value,
                                                    child: Text(value),
                                                  ),
                                                )
                                                .toList(),
                                            onChanged: (String newItem) {
                                              _categoryFilter = newItem;
                                              setState(() {});
                                              _getCategoriesWithFilter();
                                            },
                                            icon: Icon(Feather.chevron_down),
                                            underline: Container(
                                              color: kTransparent,
                                              height: 2,
                                            ),
                                          ),
                                          IconButton(
                                            tooltip: "Toggle view",
                                            icon: Icon(_preferGridFormat
                                                ? Icons.sort
                                                : Feather.grid),
                                            onPressed: () => setState(() {
                                              _preferGridFormat =
                                                  !_preferGridFormat;
                                            }),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                          height: getProportionateScreenHeight(
                                              kSpacingX16)),
                                      snapshot.hasData &&
                                              snapshot.data.isNotEmpty
                                          ? Expanded(
                                              child:
                                                  /*_preferGridFormat
                                                  ? GridCategoryCardItem(
                                                      categories: snapshot.data)
                                                  : ListCategoryCardItem(
                                                      categories: snapshot.data)*/
                                                  Container(color: kGreenColor),
                                            )
                                          : Container(
                                              height:
                                                  getProportionateScreenHeight(
                                                      kSpacingX320),
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Entypo.bucket,
                                                    size:
                                                        getProportionateScreenHeight(
                                                            kSpacingX96),
                                                    color: _kTheme.colorScheme
                                                        .onBackground,
                                                  ),
                                                  SizedBox(
                                                    height:
                                                        getProportionateScreenHeight(
                                                            kSpacingX16),
                                                  ),
                                                  Text(
                                                    "No categories available for this filter",
                                                    style: _kTheme
                                                        .textTheme.bodyText2
                                                        .copyWith(
                                                      color: _kTheme.colorScheme
                                                          .onBackground,
                                                    ),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ],
                                              ),
                                            ),
                                    ],
                                  ),
                                );
                              }),
                        ),
                      ],
                    ),
                  );
                })
            : Loading(),
        bottomNavigationBar: Container(
          height: getProportionateScreenHeight(kSpacingX56),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(Feather.home),
                onPressed: () {
                  /// todo -> nav to home
                },
              ),
              IconButton(
                icon: Icon(Feather.bell),
                onPressed: () {
                  /// todo -> nav to notifications
                },
              ),
              if (state is SuccessState<Stream<BaseUser>>) ...{
                StreamBuilder<BaseUser>(
                    stream: state.data,
                    builder: (_, snapshot) {
                      final user = snapshot.data;
                      return GestureDetector(
                        onTap: () {
                          /// fixme -> nav to user profile page
                          _authBloc.add(AuthEvent.authSignOutEvent());
                          context.navigator
                            ..popUntilRoot()
                            ..pushSplashPage();
                        },
                        child: SizedBox(
                          height: kSpacingX36,
                          width: kSpacingX36,
                          child: UserAvatar(
                            url: user?.avatar,
                            isCircular: true,
                          ),
                        ),
                      );
                    }),
              },
            ],
          ),
        ),
      ),
    );
  }

  void _getCategoriesWithFilter() {
    ServiceCategoryGroup group = ServiceCategoryGroup.featured();

    if (_categoryFilter.contains(ServiceCategoryGroup.featured().name())) {
      group = ServiceCategoryGroup.featured();
    } else if (_categoryFilter.contains(ServiceCategoryGroup.recent().name())) {
      group = ServiceCategoryGroup.recent();
    } else if (_categoryFilter
        .contains(ServiceCategoryGroup.popular().name())) {
      group = ServiceCategoryGroup.popular();
    } else if (_categoryFilter
        .contains(ServiceCategoryGroup.recommended().name())) {
      group = ServiceCategoryGroup.recommended();
    } else if (_categoryFilter
        .contains(ServiceCategoryGroup.mostRated().name())) {
      group = ServiceCategoryGroup.mostRated();
    }

    _categoriesStream = _categoryBloc.observeCategories(categoryGroup: group);
    logger.d("group -> ${{group.name()}}");
  }
}
