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
import 'package:lite/app/bloc/bloc.dart';
import 'package:lite/app/widgets/widgets.dart';
import 'package:lite/domain/models/models.dart';
import 'package:lite/shared/shared.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  /// blocs
  final _authBloc = AuthBloc(repo: Injection.get());
  final _prefsBloc = PrefsBloc(repo: Injection.get());
  final _userBloc = UserBloc(repo: Injection.get());

  /// UI

  /// User
  BaseUser _currentUser;

  @override
  void dispose() {
    _authBloc.close();
    _prefsBloc.close();
    _userBloc.close();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    if (mounted) {
      /// observe current user info
      _userBloc.add(UserEvent.currentUserEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    final kTheme = Theme.of(context);
    return BlocBuilder<UserBloc, BlocState>(
      cubit: _userBloc,
      builder: (_, state) => state is SuccessState<Stream<BaseUser>>
          ? StreamBuilder<BaseUser>(
              stream: state.data,
              builder: (_, snapshot) {
                if (_currentUser == null) _currentUser = snapshot.data;
                return Center(
                  child: Text(
                    _currentUser?.name ?? "No username",
                    style: kTheme.textTheme.headline5,
                  ),
                );
              })
          : Loading(),
    );
  }
}
