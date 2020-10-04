import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:handyman/app/model/prefs_provider.dart';
import 'package:handyman/core/constants.dart';
import 'package:handyman/core/size_config.dart';
import 'package:handyman/data/services/data.dart';
import 'package:handyman/domain/models/user.dart';
import 'package:handyman/domain/services/auth.dart';
import 'package:handyman/domain/services/data.dart';
import 'package:provider/provider.dart';

/// activeTabIndex legend:
/// 0 => calendar
/// 1 => profile
/// 2 => history
/// 3 => bookings
class ProviderSettingsPage extends StatefulWidget {
  final int activeTabIndex;

  const ProviderSettingsPage({
    Key key,
    this.activeTabIndex = 1,
  }) : super(key: key);

  @override
  _ProviderSettingsPageState createState() => _ProviderSettingsPageState();
}

class _ProviderSettingsPageState extends State<ProviderSettingsPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  DataService _dataService = DataServiceImpl.instance;
  double _kWidth, _kHeight;
  ThemeData _themeData;

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
    return Consumer<AuthService>(
      builder: (_, service, __) {
        return StreamBuilder<BaseUser>(
            stream: service.currentUser(),
            builder: (context, snapshot) {
              final artisan = snapshot.data?.user;
              return Scaffold(
                key: _scaffoldKey,
                extendBody: true,
                body: Consumer<PrefsProvider>(
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
                      Positioned.fill(
                        child: SafeArea(
                          child: Container(
                            width: _kWidth,
                            height: getProportionateScreenHeight(kSpacingX250),
                            child: artisan == null || artisan.avatar == null
                                ? Container()
                                : CachedNetworkImage(
                                    imageUrl: artisan?.avatar,
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            });
      },
    );
  }
}
