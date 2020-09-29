import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:handyman/app/model/theme_provider.dart';
import 'package:handyman/app/routes/route.gr.dart';
import 'package:handyman/app/widget/buttons.dart';
import 'package:handyman/app/widget/user_profile_card.dart';
import 'package:handyman/core/constants.dart';
import 'package:handyman/core/size_config.dart';
import 'package:provider/provider.dart';

class AccountSelectionPage extends StatefulWidget {
  @override
  _AccountSelectionPageState createState() => _AccountSelectionPageState();
}

class _AccountSelectionPageState extends State<AccountSelectionPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String _currentProfile = "Customer";
  bool _hasSelection = false;
  final _profiles = const <String>[
    "Customer",
    "Artisan",
  ];
  final _desc = const <String>[
    "Allows you to book services at anytime",
    "Work with us and get more bucks for your business",
  ];

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Feather.x),
            onPressed: () => SystemNavigator.pop(animated: true)),
      ),
      extendBodyBehindAppBar: true,
      extendBody: true,
      body: Consumer<ThemeProvider>(
        builder: (_, provider, __) => Stack(
          fit: StackFit.expand,
          children: [
            provider.isLightTheme
                ? Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(kBackgroundAsset),
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                : SizedBox.shrink(),
            SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Sign in as...",
                    style: themeData.textTheme.headline4,
                  ),
                  SizedBox(height: getProportionateScreenHeight(24)),
                  UserProfileCard(
                    profiles: _profiles,
                    description: _desc,
                    activeIndex: _profiles.indexOf(_currentProfile),
                    hasSelection: (isProfileSelected) {
                      setState(() {
                        _hasSelection = isProfileSelected;
                      });
                    },
                    onTap: (index) {
                      setState(() {
                        _currentProfile = _profiles[index];
                      });
                    },
                  ),
                  SizedBox(height: getProportionateScreenHeight(48)),
                  ButtonPrimary(
                    width: getProportionateScreenWidth(200),
                    themeData: themeData,
                    onTap: () => context.navigator.popAndPush(
                      _currentProfile == _profiles[0]
                          ? Routes.homePage
                          : Routes.dashboardPage,
                    ),
                    icon: _hasSelection ? Icons.arrow_right_alt : null,
                    label: _hasSelection ? "Continue" : "Waiting...",
                    enabled: _hasSelection,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
