import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:handyman/app/model/prefs_provider.dart';
import 'package:handyman/app/routes/route.gr.dart';
import 'package:handyman/core/constants.dart';
import 'package:handyman/core/service_locator.dart';
import 'package:handyman/core/size_config.dart';
import 'package:handyman/data/local_database.dart';
import 'package:handyman/domain/services/data.dart';
import 'package:provider/provider.dart';
import 'package:auto_route/auto_route.dart';

class RequestBookingPage extends StatefulWidget {
  final Artisan artisan;

  const RequestBookingPage({Key key, this.artisan}) : super(key: key);
  @override
  _RequestBookingPageState createState() => _RequestBookingPageState();
}

class _RequestBookingPageState extends State<RequestBookingPage> {
  final _apiService = sl.get<DataService>();
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
  Widget build(BuildContext context) => Consumer<PrefsProvider>(
        builder: (_, provider, __) => Scaffold(
          body: SafeArea(
            child: Container(
              height: _kHeight,
              width: _kWidth,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Positioned(
                    width: _kWidth,
                    bottom: kSpacingNone,
                    top: getProportionateScreenHeight(kToolbarHeight),
                    child: ListView(
                      children: [
                        _buildArtisanInfoSection(),
                        _buildRequestSection(),
                        _buildDatePickerSection(),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 0,
                    width: _kWidth,
                    child: Container(
                      width: _kWidth,
                      height: getProportionateScreenHeight(kToolbarHeight),
                      color: _themeData.scaffoldBackgroundColor
                          .withOpacity(kOpacityX90),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: Icon(Feather.x),
                            onPressed: () => context.navigator.pop(),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                tooltip: "Chat",
                                icon: Icon(Icons.message_outlined),
                                onPressed: () => context.navigator.push(
                                    Routes.conversationPage,
                                    arguments: ConversationPageArguments(
                                      isCustomer:
                                          provider.userType == kArtisanString,
                                      recipient: widget.artisan.id,
                                    )),
                              ),
                              IconButton(
                                tooltip: "Toggle theme",
                                icon: Icon(provider.isLightTheme
                                    ? Feather.moon
                                    : Feather.sun),
                                onPressed: () => provider.toggleTheme(),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

  Widget _buildDatePickerSection() => Column();

  Widget _buildRequestSection() => Column();

  Widget _buildArtisanInfoSection() => StreamBuilder<ServiceCategory>(
      stream: _apiService.getCategoryById(id: widget.artisan.category),
      builder: (context, snapshot) {
        final category = snapshot.data;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            category == null
                ? SizedBox.shrink()
                : Column(
                    children: [
                      Text(
                        "Service category",
                        style: _themeData.textTheme.headline6,
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(kSpacingX12),
                      ),
                      Text(
                        category.name,
                        style: _themeData.textTheme.headline6,
                      ),
                    ],
                  ),
          ],
        );
      });
}
