import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:handyman/app/model/prefs_provider.dart';
import 'package:handyman/core/constants.dart';
import 'package:handyman/core/service_locator.dart';
import 'package:handyman/core/size_config.dart';
import 'package:handyman/data/local_database.dart';
import 'package:meta/meta.dart';
import 'package:provider/provider.dart';

class UserInfoPage extends StatefulWidget {
  final Customer customer;

  const UserInfoPage({
    Key key,
    @required this.customer,
  }) : super(key: key);

  @override
  _UserInfoPageState createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> {
  bool _isCurrentUser = false;
  double _kWidth, _kHeight;
  ThemeData _themeData;

  @override
  void initState() {
    super.initState();

    // Update current user state
    if (mounted) {
      _isCurrentUser =
          PrefsProvider.create().userId == widget.customer.id;
      setState(() {});
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _themeData = Theme.of(context);
    final size = MediaQuery.of(context).size;
    _kWidth = size.width;
    _kHeight = size.height;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PrefsProvider>(
      builder: (_, provider, __) => Scaffold(
        extendBody: true,
        body: Stack(
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
          ],
        ),
      ),
    );
  }

  Widget _buildAppbar(PrefsProvider provider) => Container(
        width: _kWidth,
        decoration: BoxDecoration(
          color: _themeData.scaffoldBackgroundColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
              tooltip: "Go back",
              icon: Icon(Feather.x),
              onPressed: () => context.navigator.pop(),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  tooltip: "Toggle theme",
                  icon: Icon(
                    provider.isLightTheme ? Feather.moon : Feather.sun,
                  ),
                  onPressed: () => provider.toggleTheme(),
                ),
                IconButton(
                  icon: Icon(Entypo.info),
                  onPressed: () => showAboutDialog(
                    context: context,
                    applicationVersion: kAppVersion,
                    applicationName: kAppName,
                    applicationLegalese: kAppSloganDesc,
                    applicationIcon: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: getProportionateScreenHeight(kSpacingX16),
                      ),
                      child: Image(
                        image: Svg(kLogoAsset),
                        height: getProportionateScreenHeight(kSpacingX48),
                        width: getProportionateScreenHeight(kSpacingX48),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
}
