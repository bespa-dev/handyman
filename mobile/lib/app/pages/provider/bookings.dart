import 'package:flutter/material.dart';
import 'package:handyman/app/model/prefs_provider.dart';
import 'package:handyman/core/constants.dart';
import 'package:handyman/core/service_locator.dart';
import 'package:handyman/data/local_database.dart';
import 'package:handyman/domain/services/auth.dart';
import 'package:handyman/domain/services/data.dart';
import 'package:provider/provider.dart';
import 'package:meta/meta.dart';

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
                  ],
                );
              }),
        ),
      ),
    );
  }
}
