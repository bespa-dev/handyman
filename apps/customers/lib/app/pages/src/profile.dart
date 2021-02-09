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
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:lite/app/bloc/bloc.dart';
import 'package:lite/app/widgets/widgets.dart';
import 'package:lite/domain/models/models.dart';
import 'package:lite/shared/shared.dart';

/// design inspiration from:
/// https://dribbble.com/shots/11357800-Profile-Page-UI?utm_source=Clipboard_Shot&utm_campaign=jameelsocorro&utm_content=Profile%20Page%20UI&utm_medium=Social_Share
///
/// User profile page
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
  ThemeData _kTheme;

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
    _kTheme = Theme.of(context);

    var profileInfo = Expanded(
      child: Column(
        children: <Widget>[
          Container(
            height: kSpacingX12,
            width: kSpacingX12,
            margin: EdgeInsets.only(top: kSpacingX28),
            child: Stack(
              children: <Widget>[
                UserAvatar(url: _currentUser?.avatar, radius: kSpacingX64),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    height: kSpacingX24,
                    width: kSpacingX24,
                    decoration: BoxDecoration(
                      color: _kTheme.colorScheme.secondary,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      heightFactor: kSpacingX16,
                      widthFactor: kSpacingX16,
                      child: Icon(
                        LineAwesomeIcons.pen,
                        color: _kTheme.colorScheme.onSecondary,
                        size: kSpacingX16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: kSpacingX20),
          Text(
            'Nicolas Adams',
            style: _kTheme.textTheme.headline6,
          ),
          SizedBox(height: kSpacingX48),
          Text(
            'nicolasadams@gmail.com',
            style: _kTheme.textTheme.caption,
          ),
          SizedBox(height: kSpacingX20),
          Container(
            height: kSpacingX42,
            width: SizeConfig.screenWidth * 0.3,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(kSpacingX28),
              color: _kTheme.colorScheme.secondary,
            ),
            child: Center(
              child: Text(
                'Upgrade to PRO',
                style: _kTheme.textTheme.button,
              ),
            ),
          ),
        ],
      ),
    );

    var themeSwitcher = AnimatedCrossFade(
      duration: kScaleDuration,
      crossFadeState: _kTheme.brightness == Brightness.light
          ? CrossFadeState.showFirst
          : CrossFadeState.showSecond,
      firstChild: GestureDetector(
        onTap: () {},
        child: Icon(
          LineAwesomeIcons.sun,
          size: kSpacingX28,
        ),
      ),
      secondChild: GestureDetector(
        onTap: () {},
        child: Icon(
          LineAwesomeIcons.moon,
          size: kSpacingX28,
        ),
      ),
    );

    var header = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(width: kSpacingX28),
        Icon(
          LineAwesomeIcons.arrow_left,
          size: kSpacingX28,
        ),
        profileInfo,
        themeSwitcher,
        SizedBox(width: kSpacingX28),
      ],
    );

    return BlocBuilder<UserBloc, BlocState>(
      cubit: _userBloc,
      builder: (_, state) => state is SuccessState<Stream<BaseUser>>
          ? StreamBuilder<BaseUser>(
              stream: state.data,
              builder: (_, snapshot) {
                _currentUser ??= snapshot.data;
                return SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: kSpacingX12,
                        width: kSpacingX12,
                        margin: EdgeInsets.only(top: kSpacingX28),
                        child: Stack(
                          children: <Widget>[
                            UserAvatar(
                                url: _currentUser?.avatar, radius: kSpacingX64),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Container(
                                height: kSpacingX24,
                                width: kSpacingX24,
                                decoration: BoxDecoration(
                                  color: _kTheme.colorScheme.secondary,
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  heightFactor: kSpacingX16,
                                  widthFactor: kSpacingX16,
                                  child: Icon(
                                    LineAwesomeIcons.pen,
                                    color: _kTheme.colorScheme.onSecondary,
                                    size: kSpacingX16,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: kSpacingX20),
                      Text(
                        'Nicolas Adams',
                        style: _kTheme.textTheme.headline6,
                      ),
                      SizedBox(height: kSpacingX48),
                      Text(
                        'nicolasadams@gmail.com',
                        style: _kTheme.textTheme.caption,
                      ),
                      SizedBox(height: kSpacingX20),
                      Container(
                        height: kSpacingX42,
                        width: SizeConfig.screenWidth * 0.3,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(kSpacingX28),
                          color: _kTheme.colorScheme.secondary,
                        ),
                        child: Center(
                          child: Text(
                            'Upgrade to PRO',
                            style: _kTheme.textTheme.button,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              })
          : Loading(),
    );
  }
}

/*
* Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _currentUser?.name ?? 'No username',
                      style: _kTheme.textTheme.headline4,
                    ),
                    SizedBox(height: kSpacingX64),
                    ButtonPrimary(
                      width: SizeConfig.screenWidth * 0.85,
                      color: _kTheme.colorScheme.onBackground,
                      textColor: _kTheme.colorScheme.background,
                      onTap: () {
                        showCustomDialog(
                          context: context,
                          builder: (_) => BasicDialog(
                            message: kSignOutText,
                            onComplete: () {
                              _authBloc.add(AuthEvent.authSignOutEvent());
                              context.navigator
                                ..popUntilRoot()
                                ..pushSplashPage();
                            },
                          ),
                        );
                      },
                      label: 'Sign out',
                    ),
                  ],
                );
* */
