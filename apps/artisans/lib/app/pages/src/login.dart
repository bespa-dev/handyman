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
import 'package:handyman/app/bloc/bloc.dart';
import 'package:handyman/app/routes/routes.gr.dart';
import 'package:handyman/app/widgets/widgets.dart';
import 'package:handyman/domain/repositories/repositories.dart';
import 'package:handyman/shared/shared.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  /// blocs
  final _authBloc = AuthBloc(repo: Injection.get());
  final _userBloc = UserBloc(repo: Injection.get());

  /// UI
  ThemeData kTheme;
  bool _isLoading = false;

  /// form
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController(),
      _passwordController = TextEditingController();

  @override
  void dispose() {
    _userBloc.close();
    _authBloc.close();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    /// observe auth state
    _authBloc
      ..add(AuthEvent.observeAuthStatetEvent())
      ..add(AuthEvent.observeMessageEvent())
      ..listen((state) {
        if (state is SuccessState<Stream<AuthState>>) {
          /// stream auth state
          state.data.listen((event) async {
            if (event is AuthLoadingState) {
              _isLoading = true;
              if (mounted) setState(() {});
            } else if (event is AuthFailedState) {
              _isLoading = false;
              if (mounted) {
                setState(() {});
                await showCustomDialog(
                  context: context,
                  builder: (_) => InfoDialog(
                    message: Text(event.message ?? 'Authentication failed'),
                  ),
                );
              }
            } else if (event is AuthenticatedState) {
              _isLoading = false;
              if (mounted) {
                setState(() {});
                await context.navigator
                    .pushAndRemoveUntil(Routes.homePage, (route) => false);
              }
            }
          });
        } else if (state is SuccessState<Stream<String>>) {
          /// stream messages
          state.data.listen((message) async {
            if (mounted) {
              await showCustomDialog(
                context: context,
                builder: (_) => InfoDialog(
                  message: Text(message),
                ),
              );
            }
          });
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    final kTheme = Theme.of(context);
    final lightTheme = kTheme.brightness == Brightness.light;

    return Scaffold(
      body: Stack(
        children: [
          /// base
          Positioned.fill(
            child: Container(
              color: kTheme.colorScheme.primary,
              padding: EdgeInsets.fromLTRB(
                kSpacingX24,
                kSpacingX36,
                kSpacingX24,
                kSpacingX48,
              ),
              child: SingleChildScrollView(
                padding: EdgeInsets.only(top: kSpacingX36),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Image.asset(
                      kLoginAsset,
                      height: SizeConfig.screenHeight * 0.25,
                      fit: BoxFit.cover,
                      width: SizeConfig.screenWidth,
                    ),
                    SizedBox(height: kSpacingX36),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Let\'s sign you in",
                            style: kTheme.textTheme.headline5.copyWith(
                              color: kTheme.colorScheme.onPrimary,
                            ),
                          ),
                          SizedBox(height: kSpacingX8),
                          Text(
                            'You have been missed!',
                            style: kTheme.textTheme.headline6.copyWith(
                              color: kTheme.colorScheme.onPrimary
                                  .withOpacity(kEmphasisMedium),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: kSpacingX24),
                    Align(
                      alignment: Alignment.center,
                      child: ButtonPrimary(
                        width: SizeConfig.screenWidth * 0.9,
                        onTap: () =>
                            _authBloc.add(AuthEvent.federatedOAuthEvent()),
                        label: 'Sign in with Google',
                        color: kTheme.colorScheme.onBackground,
                        textColor: kTheme.colorScheme.background,
                        icon: kGoogleIcon,
                        gravity: ButtonIconGravity.START,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: kSpacingX12,
                        vertical: kSpacingX16,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Divider(
                              color: kTheme.colorScheme.onPrimary
                                  .withOpacity(kEmphasisLow),
                              thickness: 1,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: kSpacingX6,
                            ),
                            child: Text(
                              'Or',
                              style: kTheme.textTheme.headline6.copyWith(
                                color: kTheme.colorScheme.onPrimary
                                    .withOpacity(kEmphasisMedium),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Divider(
                              color: kTheme.colorScheme.onPrimary
                                  .withOpacity(kEmphasisLow),
                              thickness: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          TextFormInput(
                            labelText: 'Email address',
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            enabled: !_isLoading,
                            cursorColor: kTheme.colorScheme.onPrimary,
                            color: kTheme.colorScheme.onPrimary,
                            validator: (_) => _.isEmpty ? 'Required' : null,
                          ),
                          PasswordInput(
                            labelText: 'Password',
                            controller: _passwordController,
                            textInputAction: TextInputAction.done,
                            cursorColor: kTheme.colorScheme.onPrimary,
                            enabled: !_isLoading,
                            color: kTheme.colorScheme.onPrimary,
                            validator: (_) => _.isEmpty ? 'Required' : null,
                            onFieldSubmitted: (_) => _validateAndLogin(),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: kSpacingX8),
                    if (_isLoading) ...{
                      Loading(color: kTheme.colorScheme.secondary),
                    } else ...{
                      Center(
                        child: ButtonPrimary(
                          width: SizeConfig.screenWidth * 0.9,
                          onTap: () => _validateAndLogin(),
                          label: 'Sign in',
                          gravity: ButtonIconGravity.END,
                          icon: kArrowIcon,
                          color: lightTheme
                              ? kTheme.colorScheme.background
                                  .withOpacity(kEmphasisHigh)
                              : kTheme.colorScheme.secondary,
                          textColor: lightTheme
                              ? kTheme.colorScheme.onBackground
                              : kTheme.colorScheme.onSecondary,
                        ),
                      )
                    }
                  ],
                ),
              ),
            ),
          ),

          /// action button
          Align(
            alignment: Alignment.bottomCenter,
            child: GestureDetector(
              onTap: () => context.navigator.pushRegisterPage(),
              child: Container(
                margin: EdgeInsets.only(bottom: kSpacingX16),
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(text: "Don\'t have an account?\t"),
                      TextSpan(
                        text: 'Sign up here',
                        style: kTheme.textTheme.button.copyWith(
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

          /// back button
          Positioned(
            top: kSpacingX36,
            left: kSpacingX16,
            child: IconButton(
              icon: Icon(kBackIcon),
              color: kTheme.colorScheme.onPrimary,
              onPressed: () => context.navigator.pop(),
            ),
          ),
        ],
      ),
    );
  }

  /// validate and perform login
  void _validateAndLogin() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      _authBloc.add(
        AuthEvent.emailSignInEvent(
          email: _emailController.text?.trim(),
          password: _passwordController.text?.trim(),
        ),
      );
    }
  }
}
