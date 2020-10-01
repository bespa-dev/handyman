import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:handyman/app/model/prefs_provider.dart';
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
  String _currentProfile = kClientString;
  bool _hasSelection = false;
  final _profiles = const <String>[
    kClientString,
    kProviderString,
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
      body: Consumer<PrefsProvider>(
        builder: (_, prefs, __) => Consumer<ThemeProvider>(
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
                    SizedBox(height: getProportionateScreenHeight(kSpacingX24)),
                    UserProfileCard(
                      profiles: _profiles,
                      description: _desc,
                      hasSelection: (isProfileSelected, activeIndex) {
                        _hasSelection = isProfileSelected;
                        _currentProfile = _profiles[activeIndex];
                        prefs.saveUserType(
                            _currentProfile == _profiles[activeIndex]
                                ? kClientString
                                : kProviderString);
                        debugPrint(_currentProfile);
                        setState(() {});
                      },
                    ),
                    SizedBox(height: getProportionateScreenHeight(kSpacingX48)),
                    ButtonPrimary(
                      width: getProportionateScreenWidth(kSpacingX200),
                      themeData: themeData,
                      onTap: () => context.navigator
                          .popAndPush(Routes.accountCompletionPage),
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
      ),
    );
  }
}
