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
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:lite/app/bloc/bloc.dart';
import 'package:lite/app/routes/routes.gr.dart';
import 'package:lite/app/widgets/widgets.dart';
import 'package:lite/domain/models/models.dart';
import 'package:lite/domain/repositories/repositories.dart';
import 'package:lite/shared/shared.dart';

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
  bool _showPageContent = false, _isLoading = false;

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

      /// observe auth state
      _authBloc
        ..add(AuthEvent.observeAuthStatetEvent())
        ..add(AuthEvent.observeMessageEvent())
        ..listen((state) {
          if (state is SuccessState<Stream<AuthState>>) {
            /// stream auth state
            state.data.listen((event) {
              if (event is AuthLoadingState) {
                _isLoading = true;
                if (mounted) setState(() {});
              } else if (event is AuthFailedState) {
                _isLoading = false;
                if (mounted) {
                  setState(() {});
                  showSnackBarMessage(context,
                      message: event.message ?? "Authentication failed");
                }
              } else if (event is AuthenticatedState) {
                _isLoading = false;
                if (mounted) setState(() {});
                context.navigator
                  ..popUntilRoot()
                  ..pushHomePage();
              }
            });
          } else if (state is SuccessState<Stream<String>>) {
            /// stream messages
            state.data.listen((message) {
              if (mounted) showSnackBarMessage(context, message: message);
            });
          }
        });

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
                  Image(
                    image: Svg(kLogoAsset),
                    height: kSpacingX120,
                    width: kSpacingX120,
                  ),
                  SizedBox(height: kSpacingX16),
                  Text(
                    kAppSloganDesc,
                    textAlign: TextAlign.center,
                    style: kTheme.textTheme.subtitle1,
                  ),
                  SizedBox(height: kSpacingX64),
                  AnimatedOpacity(
                    opacity: _isLoading ? 1 : 0,
                    duration: kSheetDuration,
                    child: Loading(),
                  ),
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
                      vertical: kSpacingX56,
                    ),
                    color: kTheme.colorScheme.primary,
                    child: SafeArea(
                      top: true,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Welcome back...',
                            style: kTheme.textTheme.headline6.copyWith(
                              color: kTheme.colorScheme.onPrimary,
                            ),
                          ),
                          SizedBox(height: kSpacingX8),
                          Text(
                            kAppSloganDesc,
                            style: kTheme.textTheme.headline4.copyWith(
                              color: kTheme.colorScheme.onPrimary,
                            ),
                          ),
                          SizedBox(height: kSpacingX96),
                          if (state is SuccessState<String> &&
                              state.data != null) ...{
                            Spacer(),
                            Align(
                              alignment: Alignment.center,
                              child: ButtonPrimary(
                                width: SizeConfig.screenWidth * 0.85,
                                onTap: () => context.navigator
                                    .pushAndRemoveUntil(
                                        Routes.homePage, (route) => false),
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
                                onTap: () {
                                  _authBloc
                                      .add(AuthEvent.federatedOAuthEvent());
                                },
                                icon: kGoogleIcon,
                                gravity: ButtonIconGravity.START,
                                label: "Continue with Google",
                                color: kTheme.colorScheme.onBackground,
                                textColor: kTheme.colorScheme.background,
                              ),
                            ),
                            SizedBox(height: kSpacingX12),
                            Align(
                              alignment: Alignment.center,
                              child: ButtonPrimary(
                                width: SizeConfig.screenWidth * 0.85,
                                onTap: () =>
                                    context.navigator.pushRegisterPage(),
                                icon: kMailIcon,
                                gravity: ButtonIconGravity.START,
                                label: "Sign up with email",
                                color: lightTheme
                                    ? kTheme.colorScheme.background
                                    : kTheme.colorScheme.secondary,
                                textColor: lightTheme
                                    ? kTheme.colorScheme.onBackground
                                    : kTheme.colorScheme.onSecondary,
                              ),
                            ),
                            if (_isLoading) ...{
                              SizedBox(height: kSpacingX36),
                              Loading(),
                            },
                            Spacer(),

                            /// bottom action button
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: GestureDetector(
                                onTap: () => context.navigator.pushLoginPage(),
                                child: Container(
                                  child: Text.rich(
                                    TextSpan(
                                      children: [
                                        TextSpan(
                                            text:
                                                "Already have an account?\t\t"),
                                        TextSpan(
                                          text: "Log in",
                                          style:
                                              kTheme.textTheme.button.copyWith(
                                            color: kTheme.colorScheme.secondary,
                                          ),
                                        ),
                                      ],
                                    ),
                                    style: kTheme.textTheme.button.copyWith(
                                      color: kTheme.colorScheme.onPrimary,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          }
                        ],
                      ),
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
    if (mounted) {
      _isLoading = !_isLoading;
      setState(() {});
    }

    /// get user id
    _prefsBloc
      ..add(PrefsEvent.getUserIdEvent())
      ..listen((state) async {
        if (state is SuccessState<String>) {
          if (state.data == null) {
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

                  _userBloc.add(UserEvent.observeArtisansEvent(
                      category: ServiceCategoryGroup.featured().name()));
                }
              });
          } else {
            await Future.delayed(kSplashDuration);
            if (mounted) {
              // if (_animationController.status == AnimationStatus.forward ||
              //     _animationController.status == AnimationStatus.completed) {
              //   await _animationController.reverse();
              // } else {
              await _animationController.forward();
              // }
              _isLoading = !_isLoading;
              _showPageContent = true;
              setState(() {});
            }
          }
        }
      });

    /// observe users state
    _userBloc.listen((state) async {
      if (state is SuccessState) {
        await _animationController.forward();
        if (mounted) {
          _isLoading = !_isLoading;
          _showPageContent = true;
          setState(() {});
        }
      }
    });
  }
}
