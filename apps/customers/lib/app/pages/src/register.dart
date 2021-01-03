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
import 'package:lite/domain/repositories/repositories.dart';
import 'package:lite/shared/shared.dart';

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
              if (mounted) setState(() {});
              showSnackBarMessage(context,
                  message: event.message ?? "Authentication failed");
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
            showSnackBarMessage(context, message: message);
          });
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    kTheme = Theme.of(context);

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              color: kTheme.colorScheme.secondary,
              padding: EdgeInsets.fromLTRB(
                kSpacingX24,
                kSpacingX36,
                kSpacingX24,
                kSpacingX48,
              ),
              // child: ,
            ),
          ),

          /// back button
          Positioned(
            top: kSpacingX36,
            left: kSpacingX16,
            child: IconButton(
              icon: Icon(kBackIcon),
              color: kTheme.colorScheme.onSecondary,
              onPressed: () => context.navigator.pop(),
            ),
          ),
        ],
      ),
    );
  }
}
