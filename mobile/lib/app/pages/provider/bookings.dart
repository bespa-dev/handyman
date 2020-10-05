import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:handyman/app/model/prefs_provider.dart';
import 'package:handyman/core/constants.dart';
import 'package:handyman/core/service_locator.dart';
import 'package:handyman/core/size_config.dart';
import 'package:handyman/data/local_database.dart';
import 'package:handyman/domain/services/auth.dart';
import 'package:handyman/domain/services/data.dart';
import 'package:provider/provider.dart';
import 'package:meta/meta.dart';
import 'package:auto_route/auto_route.dart';

class BookingsDetailsPage extends StatefulWidget {
  final Booking booking;

  const BookingsDetailsPage({Key key, @required this.booking})
      : super(key: key);
  @override
  _BookingsDetailsPageState createState() => _BookingsDetailsPageState();
}

class _BookingsDetailsPageState extends State<BookingsDetailsPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  DataService _dataService = sl.get<DataService>();
  double _kWidth, _kHeight;
  ThemeData _themeData;
  Artisan _currentUser;

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
    return Scaffold(
      key: _scaffoldKey,
      extendBody: true,
      body: Consumer<AuthService>(
        builder: (_, service, __) => Consumer<PrefsProvider>(
          builder: (_, provider, __) => StreamBuilder<Booking>(
              initialData: widget.booking,
              stream: _dataService.getBookingById(id: widget.booking.id),
              builder: (_, bs) {
                final booking = bs.data;
                return Stack(
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
                        children: [],
                      ),
                    ),
                  ],
                );
              }),
        ),
      ),
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
}
