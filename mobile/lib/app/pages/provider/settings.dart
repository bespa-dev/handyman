import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:handyman/app/model/prefs_provider.dart';
import 'package:handyman/app/widget/buttons.dart';
import 'package:handyman/core/constants.dart';
import 'package:handyman/core/service_locator.dart';
import 'package:handyman/core/size_config.dart';
import 'package:handyman/data/entities/artisan_model.dart';
import 'package:handyman/data/local_database.dart';
import 'package:handyman/domain/models/user.dart';
import 'package:handyman/domain/services/auth.dart';
import 'package:handyman/domain/services/data.dart';
import 'package:handyman/domain/services/messaging.dart';
import 'package:provider/provider.dart';

/// activeTabIndex legend:
/// 0 => calendar
/// 1 => profile
/// 2 => history
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
  DataService _dataService = sl.get<DataService>();
  double _kWidth, _kHeight;
  ThemeData _themeData;
  Artisan _currentUser;

  @override
  void initState() {
    super.initState();

    if (mounted)
      sl.get<MessagingService>().showNotification(
            title: "Hello world",
            body: kLoremText,
            payload: _currentUser,
          );
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
  void dispose() {
    _dataService.updateUser(ArtisanModel(artisan: _currentUser), sync: true);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthService>(
      builder: (_, service, __) {
        return StreamBuilder<BaseUser>(
            stream: service.currentUser(),
            builder: (context, snapshot) {
              _currentUser = snapshot.data?.user;
              return Scaffold(
                key: _scaffoldKey,
                extendBody: true,
                body: Consumer<PrefsProvider>(
                  builder: (_, provider, __) => SafeArea(
                    child: Stack(
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
                        Positioned(
                          top: kSpacingNone,
                          width: _kWidth,
                          child: _buildAppBar(provider),
                        ),
                        Positioned(
                          width: _kWidth,
                          top: getProportionateScreenHeight(
                              kToolbarHeight + kSpacingX24),
                          bottom: kSpacingNone,
                          child: ListView(
                            padding: EdgeInsets.only(
                              bottom:
                                  getProportionateScreenHeight(kSpacingX250),
                            ),
                            children: [
                              Container(
                                height: _kHeight,
                                width: _kWidth,
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          width: _kWidth,
                          bottom: kSpacingNone,
                          child: _buildBottomBar(),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            });
      },
    );
  }

  Widget _buildAppBar(PrefsProvider provider) => Padding(
        padding: EdgeInsets.symmetric(
          vertical: getProportionateScreenHeight(kSpacingX16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: _kWidth,
              padding: EdgeInsets.only(
                right: getProportionateScreenWidth(kSpacingX12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    tooltip: "Go back",
                    icon: Icon(Feather.x),
                    onPressed: () => context.navigator.pop(),
                  ),
                  IconButton(
                    tooltip: "Toggle theme",
                    icon: Icon(
                      provider.isLightTheme ? Feather.moon : Feather.sun,
                    ),
                    onPressed: () => provider.toggleTheme(),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: getProportionateScreenHeight(kSpacingX12),
            ),
          ],
        ),
      );

  Widget _buildBottomBar() => Container(
        width: _kWidth,
        height: getProportionateScreenHeight(kSpacingX250),
        child: Material(
          clipBehavior: Clip.hardEdge,
          type: MaterialType.card,
          elevation: kSpacingX4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(kSpacingX24),
              topRight: Radius.circular(kSpacingX24),
            ),
          ),
          child: Stack(
            fit: StackFit.loose,
            children: [
              Positioned(
                bottom: kSpacingNone,
                width: _kWidth,
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(
                    left: getProportionateScreenWidth(kSpacingX16),
                    right: getProportionateScreenWidth(kSpacingX16),
                    bottom: kSpacingNone,
                  ),
                  height: getProportionateScreenHeight(kSpacingX360),
                  width: _kWidth,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                      color: _themeData.colorScheme.secondary,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(kSpacingX24),
                        topRight: Radius.circular(kSpacingX24),
                      )),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Earn Skill Badge",
                            style: _themeData.textTheme.headline6.copyWith(
                              color: _themeData.colorScheme.onSecondary,
                            ),
                          ),
                          SizedBox(
                              height: getProportionateScreenHeight(kSpacingX8)),
                          // Allow prospective customers to book your services. Turning this off will make you invisible
                          ConstrainedBox(
                            constraints: BoxConstraints.tightFor(
                              width: _kWidth * 0.7,
                            ),
                            child: RichText(
                              textAlign: TextAlign.left,
                              text: TextSpan(
                                text:
                                    "Skills assessment helps you to stand out to customers",
                                style: _themeData.textTheme.bodyText2.copyWith(
                                  color: _themeData.colorScheme.onSecondary,
                                ),
                              ),
                              softWrap: true,
                            ),
                          ),
                        ],
                      ),
                      ButtonIconOnly(
                        icon: Icons.arrow_right_alt_outlined,
                        color: _themeData.colorScheme.onSecondary,
                        iconColor: _themeData.colorScheme.onSecondary,
                        onPressed: () => showNotAvailableDialog(context),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: kSpacingNone,
                width: _kWidth,
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(kSpacingX16),
                  ),
                  height: getProportionateScreenHeight(kSpacingX120),
                  width: _kWidth,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                      color: _themeData.cardColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(kSpacingX24),
                        topRight: Radius.circular(kSpacingX24),
                      )),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Toggle Visibility",
                            style: _themeData.textTheme.headline6,
                          ),
                          SizedBox(
                              height: getProportionateScreenHeight(kSpacingX8)),
                          // Allow prospective customers to book your services. Turning this off will make you invisible
                          ConstrainedBox(
                            constraints: BoxConstraints.tightFor(
                              width: _kWidth * 0.7,
                            ),
                            child: RichText(
                              textAlign: TextAlign.left,
                              text: TextSpan(
                                text:
                                    "Allow prospective customers to book your services. Turning this off will make you invisible",
                                style: _themeData.textTheme.bodyText2,
                              ),
                              softWrap: true,
                            ),
                          ),
                        ],
                      ),
                      Switch.adaptive(
                        value: _currentUser?.isAvailable ?? false,
                        onChanged: (visibility) {
                          _currentUser =
                              _currentUser.copyWith(isAvailable: visibility);
                          _dataService.updateUser(
                            ArtisanModel(artisan: _currentUser),
                            sync: false,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
