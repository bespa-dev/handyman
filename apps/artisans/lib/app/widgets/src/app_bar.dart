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
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:get_version/get_version.dart';
import 'package:handyman/app/widgets/widgets.dart';
import 'package:handyman/shared/shared.dart';
import 'package:uuid/uuid.dart';

class ExpandedAppBarContainer extends StatelessWidget {
  const ExpandedAppBarContainer({
    Key key,
    @required this.title,
    @required this.child,
    this.showNavIcon = false,
    this.actionButton,
  }) : super(key: key);

  final String title;
  final Widget child;
  final Widget actionButton;
  final bool showNavIcon;

  @override
  Widget build(BuildContext context) {
    final kTheme = Theme.of(context);
    return SafeArea(
      child: Column(
        children: [
          Material(
            type: MaterialType.card,
            elevation: kSpacingX2,
            child: Container(
              width: SizeConfig.screenWidth,
              padding: EdgeInsets.only(
                top: kSpacingX24,
                bottom: kSpacingX16,
                left: kSpacingX4,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (showNavIcon) ...{
                    IconButton(
                      icon: Icon(kBackIcon),
                      onPressed: () {
                        context.navigator.pop();
                      },
                    )
                  } else ...{
                    SizedBox(height: kSpacingX24, width: kSpacingX24),
                  },
                  Container(
                    margin: EdgeInsets.only(left: kSpacingX12),
                    alignment: Alignment.bottomLeft,
                    child: Text(title,
                        style: kTheme.textTheme.headline6.copyWith(
                          fontWeight: FontWeight.w600,
                        )),
                  ),
                  if (actionButton != null) ...{
                    actionButton,
                  } else ...{
                    SizedBox(height: kSpacingX24, width: kSpacingX24),
                  },
                ],
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(child: child),
          ),
        ],
      ),
    );
  }
}

/// sliver app bar
class CustomAppBar extends StatefulWidget {
  const CustomAppBar({
    Key key,
    this.title = kAppName,
    this.backgroundImage = kBackgroundAsset,
  }) : super(key: key);

  final String title;
  final String backgroundImage;

  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  String _appVersion = '...';

  /// gets the application's version
  void _getAppVersion() async {
    _appVersion = await GetVersion.projectVersion;
    if (mounted) setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _getAppVersion();
  }

  @override
  Widget build(BuildContext context) {
    final kTheme = Theme.of(context);
    return AppBar(
      toolbarHeight: kToolbarHeight,
      textTheme: kTheme.appBarTheme.textTheme,
      leading: GestureDetector(
        onTap: () {
          /// todo -> add action to logo
        },
        child: Image(
          image: Svg(kLogoAsset),
          height: kSpacingX36,
          width: kSpacingX36,
        ),
      ),
      title: Text.rich(
        TextSpan(
          children: [
            TextSpan(text: '${widget.title}\n'),
            TextSpan(
              text: _appVersion,
              style: kTheme.textTheme.caption,
            ),
          ],
        ),
        style: kTheme.textTheme.headline6.copyWith(
          color: kTheme.colorScheme.onBackground,
        ),
      ),
      centerTitle: false,
      backgroundColor: kTheme.colorScheme.background,
      flexibleSpace: SizedBox(
        height: SizeConfig.screenHeight * 0.2,
        width: SizeConfig.screenWidth,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Positioned.fill(
              child: ImageView(
                tag: Uuid().v4(),
                imageUrl: widget.backgroundImage,
                isAssetImage: widget.backgroundImage.startsWith('assets/'),
              ),
            ),
            Positioned.fill(
              child: Container(
                color:
                kTheme.colorScheme.background.withOpacity(kEmphasisLow),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
