import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:handyman/app/model/prefs_provider.dart';
import 'package:handyman/core/constants.dart';
import 'package:handyman/core/size_config.dart';
import 'package:handyman/data/local_database.dart';
import 'package:handyman/domain/models/user.dart';
import 'package:handyman/domain/services/auth.dart';
import 'package:handyman/domain/services/messaging.dart';
import 'package:provider/provider.dart';

/// Notifications Page: Shows notifications of
/// 1. Bookings
/// 2. Conversations
/// 3. and more
class NotificationPage extends StatefulWidget {
  final NotificationPayload payload;

  const NotificationPage({Key key, this.payload}) : super(key: key);

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  double _kWidth = SizeConfig.screenWidth, _kHeight = SizeConfig.screenHeight;
  ThemeData _themeData;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _themeData = Theme.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthService>(
      builder: (_, authService, __) => Consumer<PrefsProvider>(
        builder: (_, provider, __) => StreamBuilder<BaseUser>(
            stream: authService.currentUser(),
            builder: (context, snapshot) {
              final currentUser = snapshot.data?.user;
              return Scaffold(
                body: ListView(
                  padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(kSpacingX24),
                    vertical: getProportionateScreenHeight(kSpacingX16),
                  ),
                  children: [
                    _buildAppBar(provider),
                    widget.payload.payloadType == PayloadType.NONE ||
                            (!snapshot.data.isCustomer &&
                                !snapshot.data.user.isApproved)
                        ? _buildWaitingApprovalHeader(currentUser)
                        : SizedBox.shrink(),
                  ],
                ),
              );
            }),
      ),
    );
  }

  Widget _buildWaitingApprovalHeader(Artisan artisan) => Padding(
        padding: EdgeInsets.only(
          bottom: getProportionateScreenHeight(kSpacingX16),
        ),
        child: Column(
          children: [
            Divider(),
            Container(
              height: _kHeight * 0.15,
              width: _kWidth,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(artisan?.name ?? "No name"),
                ],
              ),
            ),
            Divider(),
          ],
        ),
      );

  _buildAppBar(PrefsProvider provider) => Container(
        width: SizeConfig.screenWidth,
        height: getProportionateScreenHeight(kToolbarHeight),
        color: _themeData.scaffoldBackgroundColor.withOpacity(kOpacityX90),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // IconButton(
            //   icon: Icon(Feather.x),
            //   onPressed: () =>
            //       context.navigator.pop(),
            // ),
            IconButton(
              tooltip: "Toggle theme",
              icon: Icon(provider.isLightTheme ? Feather.moon : Feather.sun),
              onPressed: () => provider.toggleTheme(),
            )
          ],
        ),
      );
}
