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

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  /// blocs
  final _authBloc = AuthBloc(repo: Injection.get());
  final _userBloc = UserBloc(repo: Injection.get());

  /// UI
  ThemeData kTheme;
  bool _isLoading = false;

  /// form
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController(),
      _nameController = TextEditingController(),
      _passwordConfirmationController = TextEditingController(),
      _passwordController = TextEditingController();
  final _passwordFocusNode = FocusNode();

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
              if (mounted) {
                setState(() {});
                context.navigator.pushAndRemoveUntil(
                    Routes.categoryPickerPage, (route) => false);
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
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(
                  kSpacingX24,
                  kSpacingX64,
                  kSpacingX24,
                  kSpacingX16,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Image.asset(
                      kRegisterAsset,
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
                            "Let\'s create your new account",
                            style: kTheme.textTheme.headline4.copyWith(
                              color: kTheme.colorScheme.onPrimary,
                            ),
                          ),
                          SizedBox(height: kSpacingX8),
                          Text(
                            "Enter your details below to get started",
                            style: kTheme.textTheme.headline6.copyWith(
                              color: kTheme.colorScheme.onPrimary
                                  .withOpacity(kEmphasisMedium),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: kSpacingX24),
                    Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          TextFormInput(
                            labelText: 'Full Name',
                            controller: _nameController,
                            keyboardType: TextInputType.name,
                            textInputAction: TextInputAction.next,
                            enabled: !_isLoading,
                            cursorColor: kTheme.colorScheme.onBackground,
                            textCapitalization: TextCapitalization.words,
                            color: kTheme.colorScheme.onPrimary,
                            validator: (_) =>
                                _.isEmpty ? 'Name is required' : null,
                          ),
                          TextFormInput(
                            labelText: 'Email address',
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            color: kTheme.colorScheme.onPrimary,
                            cursorColor: kTheme.colorScheme.onBackground,
                            enabled: !_isLoading,
                            validator: (_) =>
                                _.isEmpty ? 'Email is required' : null,
                          ),
                          PasswordInput(
                            labelText: 'Password',
                            controller: _passwordController,
                            textInputAction: TextInputAction.next,
                            enabled: !_isLoading,
                            color: kTheme.colorScheme.onPrimary,
                            cursorColor: kTheme.colorScheme.onBackground,
                            validator: (_) =>
                                _.isEmpty ? 'Password is required' : null,
                            onFieldSubmitted: (_) =>
                                _passwordFocusNode.requestFocus(),
                          ),
                          PasswordInput(
                            labelText: 'Confirm your password',
                            controller: _passwordConfirmationController,
                            focusNode: _passwordFocusNode,
                            textInputAction: TextInputAction.go,
                            enabled: !_isLoading,
                            color: kTheme.colorScheme.onPrimary,
                            cursorColor: kTheme.colorScheme.onBackground,
                            validator: (_) => _passwordController.text != _
                                ? 'Passwords do not match'
                                : null,
                            onFieldSubmitted: (_) => _validateAndSignUp(),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: kSpacingX24),
                    if (_isLoading) ...{
                      Loading(color: kTheme.colorScheme.secondary),
                    } else ...{
                      Center(
                        child: ButtonPrimary(
                          width: SizeConfig.screenWidth * 0.85,
                          onTap: () => _validateAndSignUp(),
                          label: 'Sign up',
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
  void _validateAndSignUp() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      _authBloc.add(
        AuthEvent.emailSignUpEvent(
          username: _nameController.text?.trim(),
          email: _emailController.text?.trim(),
          password: _passwordController.text?.trim(),
        ),
      );
    }
  }
}
