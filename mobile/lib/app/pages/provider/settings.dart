import 'package:flutter/material.dart';
import 'package:handyman/app/model/prefs_provider.dart';
import 'package:handyman/core/constants.dart';
import 'package:handyman/core/service_locator.dart';
import 'package:handyman/data/provider/artisan_api_provider.dart';
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
  final _apiService = sl.get<ApiProviderService>();
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
            SafeArea(
              child: Positioned.fill(
                child: Center(
                  child: Text(
                    widget.activeTabIndex.toString(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
