import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:handyman/app/model/prefs_provider.dart';
import 'package:handyman/app/routes/route.gr.dart';
import 'package:handyman/app/widget/user_avatar.dart';
import 'package:handyman/core/constants.dart';
import 'package:handyman/core/service_locator.dart';
import 'package:handyman/core/size_config.dart';
import 'package:handyman/data/local_database.dart';
import 'package:handyman/domain/models/user.dart';
import 'package:handyman/domain/services/auth.dart';
import 'package:handyman/domain/services/data.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  double _kWidth, _kHeight;
  ThemeData _themeData;
  final _dataService = sl.get<DataService>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _themeData = Theme.of(context);
    final size = MediaQuery.of(context).size;
    _kWidth = size.width;
    _kHeight = size.height;
  }

  @override
  Widget build(BuildContext context) => Consumer<PrefsProvider>(
        builder: (_, provider, __) => StreamBuilder(
          builder: (_, snapshot) => Scaffold(
            key: _scaffoldKey,
            extendBodyBehindAppBar: true,
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
                Positioned(
                    top: kSpacingNone,
                    width: _kWidth,
                    child: _buildAppbar(provider)),
                Positioned(
                    top: getProportionateScreenHeight(kToolbarHeight),
                    width: _kWidth,
                    child: _buildProfileHeader(provider)),
              ],
            ),
          ),
        ),
      );

  Widget _buildAppbar(PrefsProvider provider) => SafeArea(
          child: Container(
        height: kToolbarHeight,
        width: _kWidth,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(kSpacingX8),
          ),
          color: _themeData.scaffoldBackgroundColor.withOpacity(kEmphasisLow),
          shape: BoxShape.rectangle,
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
              icon: Icon(provider.isLightTheme ? Feather.moon : Feather.sun),
              onPressed: () => provider.toggleTheme(),
            ),
          ],
        ),
      ));

  Widget _buildProfileHeader(PrefsProvider provider) => SafeArea(
        child: Container(
          child: Consumer<AuthService>(
            builder: (_, authService, __) => StreamBuilder<BaseUser>(
                stream: authService.currentUser(),
                builder: (context, snapshot) {
                  final user = snapshot.data?.user;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      UserAvatar(
                        url: user?.avatar,
                        radius: kSpacingX120,
                        onTap: () => context.navigator.push(Routes.profilePage),
                        ringColor: kTransparent,
                      ),
                      SizedBox(
                          height: getProportionateScreenHeight(kSpacingX16)),
                      Text(
                        user?.name,
                        style: _themeData.textTheme.headline5.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                          height: getProportionateScreenHeight(kSpacingX8)),
                      Text(
                        user?.email,
                        style: _themeData.textTheme.bodyText2,
                      ),
                      StreamBuilder<List<Booking>>(
                        initialData: [],
                        stream: _dataService
                            .getBookingsForCustomer(provider.userId),
                        builder: (_, bookingsSnapshot) {
                          final bookings = bookingsSnapshot.data;
                          debugPrint("Bookings -> ${bookings.length}");
                          return StreamBuilder<List<CustomerReview>>(
                            stream: _dataService.getReviewsByCustomer(provider.userId),
                            initialData: [],
                            builder: (_, reviewsSnapshot) {
                              final reviews = reviewsSnapshot.data;
                              debugPrint("Reviews -> ${reviews.length}");
                              return Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Column(
                                    children: [
                                      Container(

                                      ),
                                    ],
                                  ),
                                ],
                              );
                            }
                          );
                        },
                      ),
                    ],
                  );
                }),
          ),
        ),
      );
}
