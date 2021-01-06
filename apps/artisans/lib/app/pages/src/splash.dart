/*
 * Copyright (c) 2021.
 * This application is owned by HandyMan LLC,
 * developed & designed by Quabynah Codelabs LLC.
 *
 *
 * author: codelbas.quabynah@gmail.com
 */

import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:circular_reveal_animation/circular_reveal_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:handyman/app/bloc/bloc.dart';
import 'package:handyman/app/routes/routes.gr.dart';
import 'package:handyman/app/widgets/widgets.dart';
import 'package:handyman/domain/models/models.dart';
import 'package:handyman/shared/shared.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  /// blocs
  final _prefsBloc = PrefsBloc(repo: Injection.get());
  final _authBloc = AuthBloc(repo: Injection.get());
  final _userBloc = UserBloc(repo: Injection.get());
  final _categoryBloc = CategoryBloc(repo: Injection.get());

  /// UI
  AnimationController _animationController;
  Animation<double> _animation;
  bool _showPageContent = false;

  @override
  void dispose() {
    _prefsBloc.close();
    _authBloc.close();
    _userBloc.close();
    _categoryBloc.close();
    _animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    if (mounted) {
      /// setup animation
      _animationController = AnimationController(
        vsync: this,
        duration: kSheetDuration,
      );
      _animation = CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeIn,
      );

      /// get current user's login state
      _prefsBloc.add(PrefsEvent.getUserIdEvent());

      /// animate UI entry
      _animateEntry();
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final kTheme = Theme.of(context);
    final lightTheme = kTheme.brightness == Brightness.light;

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          /// base
          Positioned.fill(
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                kSpacingX24,
                kSpacingX36,
                kSpacingX24,
                kSpacingX24,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    kAppName,
                    textAlign: TextAlign.center,
                    style: kTheme.textTheme.headline4,
                  ),
                  SizedBox(height: kSpacingX8),
                  Text(
                    kAppSloganDesc,
                    textAlign: TextAlign.center,
                    style: kTheme.textTheme.subtitle1,
                  ),
                  SizedBox(height: kSpacingX64),
                  Loading(color: kTheme.colorScheme.primary),
                ],
              ),
            ),
          ),

          /// overlay
          if (_showPageContent) ...{
            Positioned.fill(
              child: BlocBuilder<PrefsBloc, BlocState>(
                cubit: _prefsBloc,
                builder: (_, state) => CircularRevealAnimation(
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(
                      horizontal: kSpacingX24,
                      vertical: kSpacingX42,
                    ),
                    color: kTheme.colorScheme.primary,
                    child: Column(
                      children: [
                        Image.asset(
                          kWelcomeAsset,
                          width: SizeConfig.screenWidth,
                          height: SizeConfig.screenHeight * 0.35,
                        ),
                        SizedBox(height: kSpacingX64),
                        Text.rich(
                          TextSpan(children: [
                            TextSpan(text: "Growing your business is "),
                            TextSpan(
                              text: "easier ",
                              style: kTheme.textTheme.headline4.copyWith(
                                color: kTheme.colorScheme.secondary,
                              ),
                            ),
                            TextSpan(text: "than you think!"),
                          ]),
                          style: kTheme.textTheme.headline4.copyWith(
                            color: kTheme.colorScheme.onPrimary,
                          ),
                        ),
                        if (state is SuccessState<String> &&
                            state.data == null) ...{
                          SizedBox(height: kSpacingX8),
                          Text(
                            "Sign up takes only 2 minutes",
                            textAlign: TextAlign.center,
                            style: kTheme.textTheme.bodyText2.copyWith(
                              color: kTheme.colorScheme.onPrimary
                                  .withOpacity(kEmphasisMedium),
                            ),
                          ),
                        },
                        Spacer(),
                        if (state is SuccessState<String> &&
                            state.data != null) ...{
                          Align(
                            alignment: Alignment.center,
                            child: ButtonPrimary(
                              width: SizeConfig.screenWidth * 0.85,
                              onTap: () => context.navigator.pushAndRemoveUntil(
                                Routes.homePage,
                                (route) => false,
                              ),
                              label: "Explore",
                              color: kTheme.colorScheme.onBackground,
                              textColor: kTheme.colorScheme.background,
                            ),
                          )
                        } else ...{
                          Align(
                            alignment: Alignment.center,
                            child: ButtonPrimary(
                              width: SizeConfig.screenWidth * 0.85,
                              onTap: () => context.navigator.pushRegisterPage(),
                              label: "Get Started",
                              color: kTheme.colorScheme.onBackground,
                              textColor: kTheme.colorScheme.background,
                            ),
                          ),
                          SizedBox(height: kSpacingX16),
                          Align(
                            alignment: Alignment.center,
                            child: ButtonPrimary(
                              width: SizeConfig.screenWidth * 0.85,
                              onTap: () => context.navigator.pushLoginPage(),
                              label: "Sign in",
                              color: lightTheme
                                  ? kTheme.colorScheme.background
                                      .withOpacity(kEmphasisHigh)
                                  : kTheme.colorScheme.secondary,
                              textColor: lightTheme
                                  ? kTheme.colorScheme.onBackground
                                  : kTheme.colorScheme.onSecondary,
                            ),
                          ),
                        }
                      ],
                    ),
                  ),
                  animation: _animation,
                  centerAlignment: Alignment.center,
                ),
              ),
            ),
          }
        ],
      ),
    );
  }

  void _animateEntry() async {
    /// get all featured artisans
    _userBloc.add(UserEvent.observeArtisansEvent(
        category: ServiceCategoryGroup.featured().name()));

    /// cache all category images for faster load times
    _categoryBloc
      ..add(CategoryEvent.observeAllCategories(
          group: ServiceCategoryGroup.featured()))
      ..listen((state) async {
        if (state is SuccessState<Stream<List<BaseServiceCategory>>>) {
          var list = await state.data.single;
          list.forEach((element) async {
            await precacheImage(
                CachedNetworkImageProvider(element.avatar), context);
          });

          await Future.delayed(kSplashDuration);
          if (_animationController.status == AnimationStatus.forward ||
              _animationController.status == AnimationStatus.completed) {
            _animationController.reverse();
          } else
            _animationController.forward();

          if (mounted)
            setState(() {
              _showPageContent = !_showPageContent;
            });
        }
      });
  }
}
