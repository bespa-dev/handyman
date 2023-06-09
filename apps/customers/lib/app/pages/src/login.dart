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
import 'package:lite/app/bloc/bloc.dart';
import 'package:lite/app/routes/routes.gr.dart';
import 'package:lite/app/widgets/widgets.dart';
import 'package:lite/domain/repositories/repositories.dart';
import 'package:lite/shared/shared.dart';

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
      ..add(AuthEvent.observeAuthStateEvent())
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
                    message: event.message ?? 'Authentication failed');
              }
            } else if (event is AuthenticatedState) {
              _isLoading = false;
              if (mounted) {
                setState(() {});
                context.navigator
                    .pushAndRemoveUntil(Routes.homePage, (route) => false);
              }
            }
          });
        } else if (state is SuccessState<Stream<String>>) {
          /// stream messages
          state.data.listen((message) {
            if (mounted) showSnackBarMessage(context, message: message);
          });
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    final kTheme = Theme.of(context);

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
                padding: EdgeInsets.only(top: SizeConfig.screenHeight * 0.4),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Let\'s sign you in",
                            style: kTheme.textTheme.headline4.copyWith(
                              color: kTheme.colorScheme.onPrimary,
                            ),
                          ),
                          SizedBox(height: kSpacingX8),
                          Text(
                            'You have been missed!',
                            style: kTheme.textTheme.headline5.copyWith(
                              color: kTheme.colorScheme.onPrimary
                                  .withOpacity(kEmphasisMedium),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: kSpacingX64),
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
                            color: kTheme.colorScheme.onPrimary,
                            cursorColor: kTheme.colorScheme.onBackground,
                            validator: (_) => _.isEmpty ? 'Required' : null,
                          ),
                          PasswordInput(
                            labelText: 'Password',
                            controller: _passwordController,
                            textInputAction: TextInputAction.done,
                            enabled: !_isLoading,
                            cursorColor: kTheme.colorScheme.onBackground,
                            color: kTheme.colorScheme.onPrimary,
                            validator: (_) => _.isEmpty ? 'Required' : null,
                            onFieldSubmitted: (_) => _validateAndLogin(),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: kSpacingX36),
                    if (_isLoading) ...{
                      Loading(),
                    } else ...{
                      Center(
                        child: ButtonPrimary(
                          width: SizeConfig.screenWidth * 0.85,
                          onTap: () => _validateAndLogin(),
                          label: 'Sign in',
                          gravity: ButtonIconGravity.END,
                          icon: kArrowIcon,
                          color: kTheme.colorScheme.onBackground,
                          textColor: kTheme.colorScheme.background,
                        ),
                      )
                    }
                  ],
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
